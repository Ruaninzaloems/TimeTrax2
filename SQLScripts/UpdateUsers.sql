select * from 


select * from Usr_UserDetail
inner join 
(
select 1 as UserID,  'customer.care@intermap.co.za' as email
union all select  2, 'happiness.hlongwana@sebata.co.za'
union all select  3, 'charlene@micromega.co.za'
union all select  4, 'sizwe.moosa@sebata.co.za'
) EmailUpdate

on Usr_UserDetail.UserID = EmailUpdate.UserID