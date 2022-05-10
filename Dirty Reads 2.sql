use Gospodarul
go

--dirty reads 2

go
create or alter procedure Sim_Dirty_Reads_Select
AS
BEGIN
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	begin tran
	select * from Magazine
	waitfor delay '00:00:05'
	select * from Magazine
	commit tran
END
go

go
create or alter procedure Sim_Dirty_Reads_Select_Corect
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

exec dbo.Sim_Dirty_Reads_Select

exec dbo.Sim_Dirty_Reads_Select_Corect