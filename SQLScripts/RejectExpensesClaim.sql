--select * from TT_Expenses
--where datediff(day,ExpenseMonth,'1 May 2016') = 0
--and userid in (1474)

--and ExpenseId in ( 

--35408
--,35409
--,35410
--,35411
--,35412
--,35413
--,35414
--,35415
--,35416
--,35417
--,35418
--,35419
--,35420
--,35421
--,35422
--,35423

--)


update TT_Expenses 
set Submitted = null,
ApprovalStage  = null 

where datediff(day,ExpenseMonth,'1 May 2016') = 0
and userid in (1474)

and ExpenseId in ( 

35408
,35409
,35410
,35411
,35412
,35413
,35414
,35415
,35416
,35417
,35418
,35419
,35420
,35421
,35422
,35423

)




--Andries	Mofokeng - 1469

--Gojane	Seleke -1476

--Martin 	Swanlow -1470

--Kopano Dibetso 1474
