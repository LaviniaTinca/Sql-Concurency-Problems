use Gospodarul
go

--Unrepeatable reads
--T1: delay + update + commit, 
--T2: select + delay + select -> see the value inserted before the transaction from the first select of T2 
--+ see the update of the value inserted before the transaction, from the second select of T2 
--(the order in the execution of the operations is: select – update – select)
--Isolation level: Read Committed / Repeatable Read (solution)

create or alter procedure Sim_Repeated_Reads_Update
AS
BEGIN
	begin tran
	--waitfor delay '00:00:05'
	--update Magazine set nume= 'Repeated Read' where nume = 'ABcd'
	update Magazine set nume= 'Repeated Read' where MagazinId = 1240

	waitfor delay '00:00:05'
	--update Magazine set nume= 'nou' where nume = 'Repeated Read'
	commit tran
END
go


--(the order in the execution of the operations is: select – update – select)
exec dbo.Sim_Repeated_Reads_Update

select * from Magazine



update Magazine set nume= 'nou' where nume = 'Repeated Read'
update Magazine set nume ='ABcd' where nume = 'Repeated Read'
update Magazine set nume= 'ABcd' where nume = 'nou'
