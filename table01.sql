drop table business_table;
drop table trancection_table;
drop table display_table;
drop table new_order_table;
drop table stock_table;


create table stock_table(
						  id_no number(10),
						  item_id number(5),
						  item_name varchar(50),
						  quantity number(10),
						  parchage_price number(10),
						  selling_price number(20),
						  primary key(id_no)
						  );

						  
						  
create table new_order_table(
						item_id number(5),
						item_name varchar(50) not null,
						quantity number(10) not null,
						parchage_price number(20)not null,
						primary key(item_id)
						);
												
						  
create table display_table(
							item_id number(5),
							item_name varchar(50) not null,
							selling_price number(20) not null,
							item_availability number(10) not null,
							foreign key(item_id) references stock_table
							);
							
							
create table trancection_table(
								transection_id number(10),
								item_id number(10) not null,
								item_name varchar(50) not null,
								quantity number(10),
								selling_price number(10),
								primary key(transection_id),
								foreign key(item_id) references stock_table
								);
								
								
create table business_table(
							 item_id number(10),
							 item_name varchar(50),
							 total_sell number(10),
							 total_parchage_cost number(20),
							 total_selling_amount number(20),
							 total_profite number(20),
							 primary key(item_id)
							 );
							 
							 
commit;