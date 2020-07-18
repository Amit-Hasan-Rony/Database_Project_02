create or replace trigger insert_into_display_table
before insert on stock_table
for each row 
	DECLARE
		item_id_v display_table.item_id%type;
		item_name display_table.item_name%type;
		selling_price display_table.selling_price%type;
		item_availability display_table.item_availability%type;
		
		begin
            DBMS_output.put_line('rony');
		
			declare 
				cursor ct is select item_id,item_name,selling_price,item_availability from stock_table;
				begin
					open ct;
                    
					LOOP
						fetch ct into item_id_v,item_name,selling_price,item_availability;
						exit when ct%notfound;
						delete from display_table where item_id=item_id_v;
						insert into display_table(item_id,item_name,selling_price,item_availability)values (item_id_v,item_name,selling_price,item_availability);
						commit;
					end loop;
				end;	
		end;
		/
				
			
	