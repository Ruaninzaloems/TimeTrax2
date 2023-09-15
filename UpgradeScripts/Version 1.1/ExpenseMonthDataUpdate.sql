/***********************************************
Script created on 14/08/2005 by SB

Script updates all existing expenses to have an
expense month as the first day of the month
for the Expense Date
***********************************************/
set dateformat dmy
Update 	TT_Expenses
Set	ExpenseMonth = convert(datetime, '01-' + convert(varchar,datepart(month,ExpenseDate)) + '-' + convert(varchar,datepart(year,ExpenseDate)))
where 	ExpenseMonth is null
