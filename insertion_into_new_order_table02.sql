drop table new_order_table;

create table new_order_table(
						item_id number(5),
						item_name varchar(50) not null,
						quantity number(10) not null,
						parchage_price number(20)not null,
						primary key(item_id)
						);



set serveroutput on
create or replace trigger trigger_for_stock_table
after insert on new_order_table
for each row
	declare
		id_no stock_table.id_no%type;
		item_id_v stock_table.item_id%type;
		item_id_initial stock_table.item_id%type;
		item_name stock_table.item_name%type;
		quantity stock_table.quantity%type;
		quantity_initial stock_table.quantity%type;
		parchage_price stock_table.parchage_price%type;
		
		BEGIN 
			select count(*) into id_no from stock_table;
			id_no:= id_no + 1;
			item_id_v:= :new.item_id;
			item_name:= :new.item_name;
			quantity:= :new.quantity;
			parchage_price:= :new.parchage_price;
			DBMS_OUTPUT.PUT_LINE('RONY item_id'||item_id_v);
			select count(*) into item_id_initial from stock_table where item_id=item_id_v;
			if item_id_initial>0 then
                DBMS_OUTPUT.PUT_LINE('RONY update'||item_id_initial);
				select quantity into quantity_initial from stock_table where item_id=item_id_v;
				quantity:= quantity + quantity_initial;
				update stock_table set quantity=quantity where item_id=item_id_v;
			end if;
			
			if item_id_initial<1 then
                DBMS_OUTPUT.PUT_LINE('RONY insert'||item_id_initial);
				insert into stock_table(id_no,item_id,item_name,quantity,parchage_price)values(id_no,item_id_v,item_name,quantity,parchage_price);
			end if;
			
	end;
	/

insert into new_order_table(item_id,item_name,quantity,parchage_price)values(1,'shart',5,300);
insert into new_order_table(item_id,item_name,quantity,parchage_price)values(2,'pant',7,400);
insert into new_order_table(item_id,item_name,quantity,parchage_price)values(3,'sharee',10,1000);
insert into new_order_table(item_id,item_name,quantity,parchage_price)values(4,'three_pieces',12,700);
insert into new_order_table(item_id,item_name,quantity,parchage_price)values(5,'t_shart',10,100);
						

						 
						 
						 
