drop table business_table;

create table business_table(
							 item_id number(10),
							 item_name varchar(50),
							 total_sell number(10),
							 total_parchage_cost number(20),
							 total_selling_amount number(20),
							 total_profite number(20),
							 primary key(item_id)
							 );



set serveroutput on;
declare
	 item_id_v business_table.item_id%type;
	 i_id_v business_table.item_id%type;
	 count_flag business_table.item_id%type;
	 count_flag1 business_table.item_id%type;
	 item_name business_table.item_name%type;
	 total_sell business_table.total_sell%type;
	 old_sell business_table.total_sell%type;
	 new_sell business_table.total_sell%type;
	 selling_price business_table.total_sell%type;
	 total_parchage_costv business_table.total_parchage_cost%type;
	 total_selling_amountv business_table.total_selling_amount%type;
	 total_profitev business_table.total_profite%type;
	 aa business_table.total_profite%type;
	 
	 begin
		declare 
			cursor ct is select * from trancection_table;
			begin
				open ct;
				LOOP
					fetch ct into i_id_v,item_id_v,item_name,total_sell,selling_price;
					exit when ct%notfound;
					select parchage_price into total_parchage_costv from stock_table where item_id=item_id_v;
					select parchage_price into aa from stock_table where item_id=item_id_v;
					total_parchage_costv:=total_parchage_costv * total_sell;
					total_selling_amountv:=total_sell * selling_price;
					
					select count(*) into count_flag from business_table where item_id=item_id_v;
					if count_flag<1 then 
						total_profitev:= total_selling_amountv - total_parchage_costv;
						insert into business_table(item_id,item_name,total_sell,total_parchage_cost,total_selling_amount,total_profite)
											values(item_id_v,item_name,total_sell,total_parchage_costv,total_selling_amountv,total_profitev);
					end if;

					if count_flag>0 then
					
                            select total_profite into  total_profitev from business_table where item_id=item_id_v;
                            total_profitev:=total_profitev+(total_selling_amountv - total_parchage_costv);
                            select total_sell into old_sell from business_table where item_id=item_id_v;
                            new_sell:=total_sell+old_sell;
                            total_selling_amountv:= new_sell * selling_price;
                            total_parchage_costv:= new_sell * aa;
                            update business_table set total_sell=new_sell,total_parchage_cost=total_parchage_costv,
                                             total_selling_amount=total_selling_amountv,total_profite=total_profitev where item_id=item_id_v;
					end if;
				end loop;
			end;
			
		select sum(total_sell) into total_sell from business_table;
		select sum(total_parchage_cost) into total_parchage_costv from business_table;
		select sum(total_selling_amount) into total_selling_amountv from business_table;
		
		total_profitev:=total_selling_amountv - total_parchage_costv;
		
		DBMS_output.put_line('total sell is '|| total_sell|| ' ; Total profit is '||total_profitev);
	end;
	/
					