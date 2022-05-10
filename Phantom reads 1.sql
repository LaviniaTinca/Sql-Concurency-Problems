use Gospodarul
go

--Phantom reads ( 2 files for 2 transactions)
--T1: delay + insert + commit,
--T2: select + delay + select -> see the inserted value only at the second select from T2 
--(the order in the execution of the operations is: select– insert – select)
--Isolation level: Repeatable Read / Serializable (solution)

create or alter procedure Sim_Phantom_Reads_Update
AS
BEGIN
	begin tran
	waitfor delay '00:00:10'
	insert into Magazine  values ('Phantom', 'cluj', 1)
	
	commit tran
END
go

create or alter procedure Sim_Phantom_Reads_Update_Solution
AS
BEGIN
	begin tran
	waitfor delay '00:00:05'
	insert into Magazine  values ('Phantom-Solution', 'cluj', 1)
	
	commit tran
END
go

--(the order in the execution of the operations is: select– insert – select)

exec dbo.Sim_Phantom_Reads_Update

exec dbo.Sim_Phantom_Reads_Update_Solution


select * from Magazine

delete from Magazine where nume = 'Phantom'
delete from Magazine where nume = 'Phantom-Solution'

