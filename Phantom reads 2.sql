use Gospodarul
go

--problem: isolation level repeatable read
create or alter procedure Sim_Phantom_Reads_Select
AS
BEGIN
	SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
	begin tran
	select * from Magazine
	waitfor delay '00:00:15'
	select * from Magazine
	commit tran
END
go

--solution: level serializable
go
create or alter procedure Sim_Phantom_Reads_Select_Corect
AS
BEGIN
	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
	begin tran
	select * from Magazine
	waitfor delay '00:00:15'
	select * from Magazine
	commit tran
END
go


exec dbo.Sim_Phantom_Reads_Select

exec dbo.Sim_Phantom_Reads_Select_Corect

--the new inserted value is visible now
select * from Magazine


