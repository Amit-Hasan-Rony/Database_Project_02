create or update trigger trigger_for_stock_table
after insert on new_order_table
for each row
	declare
		id_no stock_table.id_no%type;
		item_id stock_table.item_id%type;
		item_id_initial stock_table.item_id%type;
		item_name stock_table.item_name%type;
		quantity stock_table.quantity%type;
		quantity_initial stock_table.quantity%type;
		parchage_price stock_table.parchage_price%type;
		selling_price stock_table.selling_price%type;
		
		BEGIN 
			select count(*) into id_no from stock_table;
			id_no:= id_no + 1;
			item_id:= old.item_id;
			item_name:= old.item_name;
			quantity:=old.quantity;
			parchage_price:=old.parchage_price;
			
			select count(*) into item_id_initial from stock_table where item_id=item_id;
			if item_id_initial>0 then
			begin
				select quantity into quantity_initial from stock_table where item_id=item_id;
				quantity:= quantity + quantity_initial;
				update stock_table set quantity=quantity where item_id=item_id;
			end if;
			
			if item_id_initial<1 then
			begin
				insert into stock_table(id_no,item_id,item_name,quantity,parchage_price)values(id_no,item_id,item_name,quantity,parchage_price);
			end if;
			
	end;
	/
			