
%let path=/folders/myfolders/Data_One/;
libname orion "/folders/myfolders/Data_One/";
*3.2;

proc print data=orion.country;run;
* Level 1 
a.	7 observations
	6 variables
	South Africa;
proc contents data=orion._all_ nods;run;
*b. US_SUPPLIERS
Level 2
a. just right click the property of orion.staff
b. The data set is sorted. And it is sorted by Employee_ID.
Challenge
1.sas autoexec file
2. It can be executed once SAS starts and set up some variables.  
3.use a sas text editor and save it
4.set the macro variable and to automatically sumbit a libname statementsas ;

*4.1
Level1
a;
proc print data=orion.order_fact;
run;
*b;
proc print data=orion.order_fact;
   sum Total_Retail_Price;
run;
*c;
proc print data=orion.order_fact;
	where Total_Retail_Price>500;
   sum Total_Retail_Price;
run;
*The numbers are not sequential. The original observation columns have changed.
Yes.
d;
proc print data=orion.order_fact noobs;
	where Total_Retail_Price>500;
   sum Total_Retail_Price;
run;
*Check the log.
e;
proc print data=orion.order_fact noobs;
	where Total_Retail_Price>500;
	id customer_id;
   sum Total_Retail_Price;
run;
*Customer_Id moves to the first column of the table. And is put for each line for one observation.
f;
proc print data=orion.order_fact noobs;
	where Total_Retail_Price>500;
	id customer_id;
	var Customer_ID Order_ID Order_Type Quantity Total_Retail_Price;*add a var statement here.;
   sum Total_Retail_Price;
run;
*There are two Customer_ID columns. 
g;
proc print data=orion.order_fact noobs;
	where Total_Retail_Price>500;
	id customer_id;
	var Order_ID Order_Type Quantity Total_Retail_Price;
   sum Total_Retail_Price;
run;
*remove Customer_ID from the var statement

Level 2;
*a;
proc print data=orion.customer_dim;
run;
*b;
proc print data=orion.customer_dim noobs;
	where Customer_Age between 30 and 40; *add a where statement;
run;
*c;
proc print data=orion.customer_dim noobs;
	where Customer_Age between 30 and 40;
	id Customer_ID; *just add id Customer_ID;
run;
*d;
proc print data=orion.customer_dim noobs;
	where Customer_Age between 30 and 40;
	id Customer_ID; 
	var Customer_Name Customer_Age Customer_Type;*add var statement to show these variables only.;
run;
*Challenge;
*3
a;
proc print data=orion.order_fact;
run;
*b;
options ls=max;
proc print data=orion.order_fact;
run;
*Minimum value for LINESIZE	=is 64 and the maximum size is MAX.;
options ls=96;*reset the line size to 96;
*c;
proc print data=orion.order_fact headings=v;
run;* column vertical headings;
proc print data=orion.order_fact headings=h;
run;* horizontal headings
*4;
*a;
proc print data=orion.product_dim;
run;
*b;
proc print data=orion.product_dim width=uniform;
run;
*Each column has the same width.;
*c
The procedure needs to run the data set twice.
d
Use a format  on every column to specify the fild width so that it can be read only once.;


*4.2
5
a;
proc sort data=orion.employee_payroll
			 out=work.sort_salary;
	by Salary;
run;
*b;
proc print data=work.sort_salary;
run;
*6
a;
proc sort data=orion.employee_payroll  
			 out=work.sort_salary2;* add sort step to sort orion.employee_payroll. And place the sorted observations into a temporary data set named sort_salary2.;
			 
	by Employee_Gender descending Salary;
run;
*b;
proc print data=work.sort_salary2;
	by Employee_Gender;
run;
*7;
*a;
proc sort data=orion.employee_payroll
			 out=work.sort_sal;
	by Employee_Gender descending Salary;*sort by descending salary;
run;
*b;
proc print data=work.sort_sal noobs;*print a subset of the sort_sal datat set.;
	by Employee_Gender;
	sum Salary;
	where Employee_Term_Date is missing and Salary>65000; *earn more than 650000;
	var Employee_ID Salary Marital_Status;
 run;

*8;

proc sort data=orion.orders out=work.custorders nodupkey 
          dupout=work.duplicates;
     by customer_id;
run;

title 'Unique Customers';
proc print data=work.custorders;
run;

title 'Duplicate Customer Observations';
proc print data=work.duplicates;
run;
	
title;
*9;
title1 'Australian Sales Employees';
title2 'Senior Sales Representatives';
footnote1 'Job_Title: Sales Rep. IV';

proc print data=orion.sales noobs;
	where Country='AU' and Job_Title contains 'Rep. IV';
	var Employee_ID First_Name Last_Name Gender Salary;
run;
title;
footnote;
*10;
title 'Entry-level Sales Representatives';
footnote 'Job_Title: Sales Rep. I';

proc print data=orion.sales noobs label;
	where Country='US' and Job_Title='Sales Rep. I';
	var Employee_ID First_Name Last_Name Gender Salary;
	label Employee_ID="Employee ID"
			First_Name="First Name"
			Last_Name="Last Name"
			Salary="Annual Salary";	
run;
*b;

title;
footnote;

title 'Entry-level Sales Representatives';
footnote 'Job_Title: Sales Rep. I';

proc print data=orion.sales noobs split=' ';
	where Country='US' and Job_Title='Sales Rep. I';
	var Employee_ID First_Name Last_Name Gender Salary;
	label Employee_ID="Employee ID"
			First_Name="First Name"
			Last_Name="Last Name"
			Salary="Annual Salary";	
*11;
proc sort data=orion.employee_addresses out=work.address;
	where Country='US';
	by State City Employee_Name;
run;

title "US Employees by State";
proc print data=work.address noobs split=' ';
	var Employee_ID Employee_Name City Postal_Code;
	label Employee_ID='Employee ID'
			Employee_Name='Name'
			Postal_Code='Zip Code';
	by State;
run;
*Sec 5.1
Level1;
*1.;
proc print data=orion.employee_payroll;
run;

proc print data=orion.employee_payroll;
	var Employee_ID Salary Birth_Date Employee_Hire_Date;
	format Salary dollar11.2 Birth_Date mmddyy10. 
		    Employee_Hire_Date date9.;
run;
*2;
title1 'US Sales Employees';
title2 'Earning Under $26,000';

proc print data=orion.sales label noobs;
	where Country='US' and Salary<26000;
	var Employee_ID First_Name Last_Name Job_Title Salary Hire_Date;
	label First_Name='First Name'
		   Last_Name='Last Name'
			Job_Title='Title'
			Hire_Date='Date Hired';
	format Salary dollar10. Hire_Date monyy7.;
run;
title;
footnote;
*3;
proc print data=orion.sales noobs;
	var Employee_ID First_Name Last_Name Job_Title;
	format First_Name Last_Name $upcase. Job_Title $quote.;
run;
*4;
data Q1Birthdays;
   set orion.employee_payroll;
   BirthMonth=month(Birth_Date);
   if BirthMonth le 3;
run;

proc format;
   value $gender
      'F'='Female'
      'M'='Male';
   value mname
       1='January'
       2='February'
       3='March';
run;

title 'Employees with Birthdays in Q1';
proc print data=Q1Birthdays;
	var Employee_ID Employee_Gender BirthMonth;
   format Employee_Gender $gender.
          BirthMonth mname.;
run;
title;
*5;
proc format;
   value $gender 'F'='Female'
                 'M'='Male'
               other='Invalid code';

   value salrange .='Missing salary'
      20000-<100000='Below $100,000'
      100000-500000='$100,000 or more'
              other='Invalid salary';
run;

title1 'Salary and Gender Values';
title2 'for Non-Sales Employees';

proc print data=orion.nonsales;
   var Employee_ID Job_Title Salary Gender;
   format Salary salrange. Gender $gender.;
run;

title;
*Charpter6;
data work.delays;
   set orion.orders;
   where Order_Date+4<Delivery_Date 
         and Employee_ID=99999999;
   Order_Month=month(Order_Date);
   if Order_Month=8;
	label Order_Date='Date Ordered'
	      Delivery_Date='Date Delivered'
			Order_Month='Month Ordered';
	format Order_Date Delivery_Date mmddyy10.;
	keep Employee_ID Customer_ID Order_Date Delivery_Date Order_Month;
run;

proc contents data=work.delays;
run;

proc print data=work.delays;
run;
*Charpter 9.1 Level 2;
 data work.birthday;
   set orion.customer;
   Bday2012=mdy(month(Birth_Date),day(Birth_Date),2012);
   BdayDOW2012=weekday(Bday2012);
   Age2012=(Bday2012-Birth_Date)/365.25;
   keep Customer_Name Birth_Date Bday2012 BdayDOW2012 Age2012;
   format Bday2012 date9. Age2012 3.;
run;

proc print data=work.birthday;
run;
*Charpter 9.2 Level 2;
data work.season;
   set orion.customer_dim;
   length Promo2 $ 6;
   Quarter=qtr(Customer_BirthDate);
   if Quarter=1 then Promo='Winter';
   else if Quarter=2 then Promo='Spring';
   else if Quarter=3 then Promo='Summer';
   else if Quarter=4 then Promo='Fall';
   if Customer_Age>=18 and Customer_Age<=25 then  Promo2='YA';
   else if Customer_Age>=65 then  Promo2='Senior';
   keep Customer_FirstName Customer_LastName Customer_BirthDate   
        Customer_Age Promo Promo2; 
run;

proc print data=work.season;
   var Customer_FirstName Customer_LastName Customer_BirthDate Promo 
       Customer_Age Promo2; 
run;
*Charpter 10.1 Level 2;
proc contents data=orion.sales;
run;

proc contents data=orion.nonsales;
run;

data work.allemployees;
   set orion.sales 
       orion.nonsales(rename=(First=First_Name Last=Last_Name));
   keep Employee_ID First_Name Last_Name Job_Title Salary;
run;

proc print data=work.allemployees;
run;
*Charpter 10.3 Level 2;
proc sort data=orion.product_list 
          out=work.product_list;
  	by Product_Level;
run;

data work.listlevel;
  	merge orion.product_level work.product_list ;
  	by Product_Level;
	keep Product_ID Product_Name Product_Level Product_Level_Name;
run;

proc print data=work.listlevel noobs;
	where Product_Level=3;   
run;
*Charpter 10.4 Level 2;
proc sort data=orion.customer
          out=work.customer;
   by Country;
run;

data work.allcustomer;
	merge work.customer(in=Cust) 
         orion.lookup_country(rename=(Start=Country Label=Country_Name) in=Ctry);
	by Country;
	keep Customer_ID Country Customer_Name Country_Name;
	if Cust=1 and Ctry=1;
run;

proc print data=work.allcustomer;
run;



