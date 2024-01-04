use hra;
Alter table hr1 rename column employee_id to employee_id1;
select * from hr1;
Select * from hr2 left join hr1 on 
							hr2.Employee_ID = hr1.Employee_ID1;  
set sql_safe_updates = 0;

update hr1 set Attrition = 1 where Attrition = 'yes'; 
update hr1 set Attrition = 0 where Attrition = 'no';
-- KPI1-- Average Attrition Rate for all Department
Select Department,count(Attrition) as CountOfAttrition from hr1 group by Department;

Select Department,round((sum(attrition)/sum(employeecount))*100) as Attrition_rate from hr1 group by department;

-- KPI 2 Average Hourly rate of Male Research Scientist
select jobrole, avg(HourlyRate) from hr1  where JobRole = 'research scientist' and gender = 'male';

-- KPI 3 Attrition rate Vs Monthly income stats -- 
Select avg(monthlyincome), attrition from (Select * from hr2 left join hr1 on 
							hr2.Employee_ID = hr1.Employee_ID1) as da group by Attrition;
                            
-- KPI 4 Average working years for each Department
select department, avg(yearsatcompany) from (Select * from hr2 left join hr1 on 
							hr2.Employee_ID = hr1.Employee_ID1) as da group by Department ;
select department, avg(TotalWorkingYears) from (Select * from hr2 left join hr1 on 
							hr2.Employee_ID = hr1.Employee_ID1) as da group by Department ;
				
-- KPI 5 Job Role Vs Work life balance

select jobrole, round(avg(worklifebalance)) from (Select * from hr2 left join hr1 on 
							hr2.Employee_ID = hr1.Employee_ID1) as da group by Jobrole;
                            
-- KPI 6 Attrition rate Vs Year since last promotion relation
Select Department, avg(YearsSinceLastPromotion) from (Select * from hr2 left join hr1 on 
							hr2.Employee_ID = hr1.Employee_ID1) as da group by Department;

Select Yearssincelastpromotion,(count(attrition)) from (Select * from hr2 left join hr1 on 
							hr2.Employee_ID = hr1.Employee_ID1) as da where attrition = 1 group by YearsSinceLastPromotion;
                            
select YearsSinceLastPromotion, round((sum(attrition)/sum(employeecount))*100) as Attrition_rate from (Select * from hr2 left join hr1 on 
							hr2.Employee_ID = hr1.Employee_ID1) as da group by YearsSinceLastPromotion;



