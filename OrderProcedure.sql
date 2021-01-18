use beautySaloon;

--добавить заказ
GO
CREATE PROCEDURE AddOrder 
    @idClient int,
    @orderDate date,
    @orderTime time, 
	@nameService nvarchar(30),
	@firstNameWorker nvarchar(35),
	@secondNameWorker nvarchar(35)
AS begin
	declare @idWorker int, @idService int, @idFreeTime int;
	set @idService = (select id_service from servicess where nameService = @nameService);
	set @idWorker = (select id_worker from workers where firstName = @firstNameWorker and 
														secondName = @secondNameWorker);
	set @idFreeTime = (select id_freeDateTime from timetableWorkers where 
														freeDate = @orderDate and
														freeTime = @orderTime);
	INSERT INTO orderList(idClient, idWorker, idService, idFreeTime, status) 
	VALUES(@idClient, @idWorker, @idService, @idFreeTime, 0);
end

declare @paramIdClient int, @paramOrderDate date, @paramOrderTime time, 
		@paramNameService nvarchar(30), @paramFirstNameWorker nvarchar(35),
		@paramSecondNameWorker nvarchar(35);
set @paramIdClient = 1;
set @paramOrderDate = '30-11-2020';
set @paramOrderTime = '13:50';
set @paramNameService = 'Ботокс волос';
set @paramFirstNameWorker = 'Елизавета';
set @paramSecondNameWorker = 'Чепелева';
EXEC AddOrder @paramIdClient, @paramOrderDate,
								@paramOrderTime,@paramNameService,
								@paramFirstNameWorker,
								@paramSecondNameWorker;
--drop procedure AddOrder;


--удалить заказ у клиента
GO
CREATE PROCEDURE DeleteOrder 
    @idOrder int
AS begin
	declare  @idFreeTime int;
	set @idFreeTime = (select idFreeTime from orderList where id_order = @idOrder);
	delete from orderList where id_order = @idOrder;
	update timetableWorkers set status = 0 where id_freeDateTime = @idFreeTime;
end

declare @param int;
set @param = 4;
exec DeleteOrder @param;
--drop procedure DeleteOrder

--обновить заказ у клиента
GO
CREATE PROCEDURE UpdateOrderByClient 
    @idOrder int, 
    @orderDate date,
    @orderTime time
AS begin
	declare  @idFreeTime int, @idWorker int;

	set @idWorker = (select idWorker from orderList where id_order = @idOrder);
	set @idFreeTime = (select id_freeDateTime from timetableWorkers where idWorker = @idWorker and freeDate = @orderDate and freeTime = @orderTime);

	update orderList set idFreeTime = @idFreeTime where id_order = @idOrder;
	
end

select * from orderList;
select * from timetableWorkers;
declare @paramIdOrder int, @paramOrderDate date, @paramOrderTime time;
set @paramIdOrder = 10;
set @paramOrderDate = '30-12-2020';
set @paramOrderTime = '13:50';
exec UpdateOrderByClient @paramIdOrder, @paramOrderDate, @paramOrderTime;
--drop procedure DeleteOrder

