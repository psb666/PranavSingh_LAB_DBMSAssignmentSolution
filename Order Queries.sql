-- 3)	Display the number of the customer group by their genders who have placed any order of amount greater than or equal to Rs.3000.
	
select cus_gender, COUNT(*)
from `order`
inner join
customer
on `order` .cus_id = customer.cus_id
where ord_amount >= 3000
group by customer.cus_gender;
    
-- 4)	Display all the orders along with the product name ordered by a customer having Customer_Id=2.
select *
from `order`
inner join
product_details
on `order` .prod_id = product_details.PROD_ID
inner join
product 
on product_details.pro_id = product.PRO_ID
where CUS_ID = 2;

-- 5)	Display the Supplier details who can supply more than one product.


select *
from supplier
where supp_id in (
select SUPP_ID
from product_details
group by SUPP_ID
having count(*) > 1
);

-- 6)	Find the category of the product whose order amount is minimum.

select *
from `order`
inner join product_details on product_details.PROD_ID = `order`.PROD_ID
inner join product on product_details.PRO_ID = product.PRO_ID
inner join category on product.cat_id = category.CAT_ID
order by ord_amount limit 1;

-- 7)	Display the Id and Name of the Product ordered after “2021-10-05”.

select ORD_ID, ORD_DATE, product.PRO_ID, PRO_NAME, PRO_DESC
from `order`
inner join product_details on `order`.PROD_ID = product_details.PROD_ID
inner join product on product_details.PRO_ID = product.PRO_ID
where ORD_DATE > "2021-10-05";


-- 8)	Print the top 3 supplier name and id and their rating on the basis of their rating along with the customer name who has given the rating.

select supplier.SUPP_ID, SUPP_NAME, CUS_NAME, rating.RAT_RATSTARS
from rating
inner join supplier on supplier.SUPP_ID = rating.SUPP_ID
inner join customer on customer.CUS_ID = rating.CUS_ID
order by rating.rat_ratstars desc limit 3;


-- 9)	Display customer name and gender whose names start or end with character 'A'.

select CUS_NAME, CUS_GENDER
from customer where CUS_NAME like '%A' or CUS_NAME like 'A%';

-- 10)	Display the total order amount of the male customers.

select CUS_GENDER, sum(ORD_AMOUNT)
from `order`
inner join customer on `order`.CUS_ID = customer.CUS_ID
where CUS_GENDER = 'M';

-- 11)	Display all the Customers left outer join with  the orders.

select *
from customer
left outer join `order` on `order`.CUS_ID = customer.CUS_ID;

-- 12)	 Create a stored procedure to display the Rating for a Supplier
-- if any along with the Verdict on that rating if any like 
-- if rating >4 then “Genuine Supplier”
-- if rating >2 “Average Supplier”
-- else “Supplier should not be considered”.

-- CREATED STORED PROCEDURE
-- CREATE DEFINER=`root`@`localhost` PROCEDURE `categorize_supplier`()
-- BEGIN
-- select supplier.supp_id, supp_name, rat_ratstars,
-- case 
--	when rat_ratstars > 4 then "Genuine Supplier"
--    when rat_ratstars > 2 then "Average Supplier"
--    else "Supplier should not be considered"
--   end as verdict
--	from rating inner join supplier on rating.supp_id = supplier.supp_id;
-- END

call categorize_supplier();