use Gospodarul
go

--problem isolation level read commited
create or alter procedure Sim_Repeated_Reads_Select
AS
BEGIN
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	begin tran
	select * from Magazine
	waitfor delay '00:00:05'
	select * from Magazine
	commit tran
END
go

--solution: level repeatable read
go
create or alter procedure Sim_Repeated_Reads_Select_Corect
AS
BEGIN
	SET TRANSACTION ISOLATION LEVEL REPEATABLE READ 
	begin tran
	select * from Magazine
	waitfor delay '00:00:05'
	select * from Magazine
	commit tran
END
go


exec dbo.Sim_Repeated_Reads_Select

exec dbo.Sim_Repeated_Reads_Select_Corect


