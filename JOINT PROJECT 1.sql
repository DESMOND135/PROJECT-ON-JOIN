-- inner join
-- joining two tables from the same database
-- joining customer's and order table from sql_store database

use sql_store;

select *
from customers c 
join orders o 
    on c.customer_id = o.customer_id;
    
-- selecting customers names and address who has placed order 

select c.first_name, c.last_name, c.address, o.order_id
from customers c 
join orders o 
   on c.customer_id = order_id; 
   
-- join across database 
-- joining order_items vs. products from sql_store and sql_inventory database respectively

select *
from order_items oi
join sql_inventory.products ip 
   on oi.product_id = ip.product_id ;
   
-- self join, joining a table to itself
-- looking for the managers for each employee

use sql_hr;

select *
from employees e 
join employees  m 
     on e.employee_id = m.reports_to;
     
use sql_hr;

select
 m.first_name, 
 m.employee_id,
 e.first_name as manager
from employees e 
join employees  m 
     on e.employee_id = m.reports_to; 
     
-- joining more than two tables 

use sql_store;

select *
from customers s 
join orders   o 
   on s.customer_id = o.customer_id
join order_statuses os 
    on o.status = os.order_status_id ;
    
-- selecting few columns
    
    use sql_store;

select
 s.customer_id, 
 s.first_name, o.order_id,
 o.order_date,
 os.order_status_id,
 os.name as status
from customers s 
join orders   o 
   on s.customer_id = o.customer_id
join order_statuses os 
    on o.status = os.order_status_id;
    
-- joining multiple tables in the same database 
--  looking for clients who has place thier payment and thier payment methods on the sql_invoicing database 

use sql_invoicing; 

select
 p.client_id, 
 p.payment_id,
 p.date,
 pm.payment_method_id,
 pm.name as payment_method,
 c.name, 
 c.state
from payments p 
join payment_methods pm 
   on p.payment_id = pm.payment_method_id
join clients c 
 on p.client_id = c.client_id;

-- compound join , using more than one identifiers to identify a table 
-- tables having two primary keys ( composite primary key) considering the order items vs. order items note table from sql_store 

select * 
from order_items oi
join order_item_notes oin
     on oi.order_id = oin.order_Id
     and  oi.product_id = oin.product_id;

-- implicit join syntax using the where class

select *
from customers c 
join orders o 
    on c.customer_id = o.customer_id;
    
 -- implicit join   
    
select *
from customers c , orders o
where c.customer_id = o.customer_id;

-- outer join
-- left ouetr join
-- returning all customers who has placed thier order
      
select c.customer_id,
c.first_name,
o.status,
o.shipped_date,
o.order_id
from customers c 
left join orders o 
    on c.customer_id = o.customer_id;
    
-- right join
-- returning all orders placed by customers 

select c.customer_id,
c.first_name,
o.status,
o.shipped_date,
o.order_id
from customers c 
right join orders o 
    on c.customer_id = o.customer_id
order by customer_id;

-- joining multiple table 
-- returning customers who has placed thier order and it has been shipped using left join
select c.customer_id,
c.first_name,
o.status,
o.shipped_date,
o.order_id,
s.shipper_id,
s.name,
os.name
from customers c 
left join orders o 
    on c.customer_id = o.customer_id 
join shippers s 
 on o.shipper_id = s.shipper_id
join order_statuses os 
 on o.status =os.order_status_id;

-- right join with multiple tables to displced customers who has placed thier order and thier product has been shipped

select c.customer_id,
c.first_name,
o.status,
o.shipped_date,
o.order_id,
s.shipper_id,
s.name,
os.name
from customers c 
right join orders o 
    on c.customer_id = o.customer_id 
join shippers s 
 on o.shipper_id = s.shipper_id
join order_statuses os 
 on o.status =os.order_status_id;

 -- right join with multiple tables to displced customers who has placed thier order

select c.customer_id,
c.first_name,
o.status,
o.shipped_date,
o.order_id,
s.shipper_id,
s.name,
os.name as status
from customers c 
right join orders o 
    on c.customer_id = o.customer_id 
left join shippers s 
 on o.shipper_id = s.shipper_id
join order_statuses os 
 on o.status =os.order_status_id ;


 -- self outer join : looking for the manager with employee_id 37270
 
 use sql_hr;

select *
from employees e 
left join employees  m 
     on e.employee_id = m.reports_to; 
     
-- using clause: this is implimented when columns name are exactly the same across tables

use sql_store; 
create view customers1 as
select *
from customers c 
join orders o 
-- c.customer_id = o.customer_id
using (customer_id) 
join shippers s 
using (shipper_id); 

-- union clause used to combine two selects statement without returning any duplicates and the columns must be the same for each select statement 

select state, address
from customers
union
select name, unit_price
from products; 

-- union all clause used to combine two selects statement with duplicates records duplicates and the columns must be the same for each select statement 

select state, address
from customers
union all 
select name, unit_price
from products 

     

    
     







