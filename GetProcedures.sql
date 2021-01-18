use beautySaloon;


-- get all typeofservice
go
Create procedure GET_TYPE
as begin
SELECT * from typeOfService;
end;

-- get all servicess
go
Create procedure GET_SERVICESS
as begin
SELECT * from servicess;
end;

--EXEC GET_SERVICESS;
--drop procedure GET_SERVICESS;

-- get all servicess by idType
go
Create procedure GET_SERVICESS_BY_ID_TYPE
@search_idType int
as begin
SELECT * from servicess where idTypeOfService = @search_idType;
end;

declare @param int;
set @param = 1;
EXEC GET_SERVICESS_BY_ID_TYPE @param;
-- get servicess by name
go
Create procedure GET_SERVICESS_BY_NAME
@search_text nvarchar(40)
as begin
SELECT * from servicess where (upper(nameService) like upper(@search_text) + '%');
end;

declare @param nvarchar(40);
set @param = 'бот';
EXEC GET_SERVICESS_BY_NAME @param;
--drop procedure GET_SERVICESS_BY_NAME;

go
Create procedure GET_SERVICESS_BY_ID
@search_id int
as begin
SELECT * from servicess where id_service = @search_id;
end;

declare @param int;
set @param = 1;
EXEC GET_SERVICESS_BY_ID @param;
--drop procedure GET_SERVICESS_BY_ID;


-- get all workers
Create
go procedure GET_WORKERS
as begin
SELECT * from workers where role = 0;
end;

--EXEC GET_WORKERS;
--drop procedure GET_WORKERS;


-- get workers by name
go
Create procedure GET_WORKERS_BY_NAME
@search_text nvarchar(40)
as begin
SELECT * from workers where  (upper(secondName) like upper(@search_text) + '%')  or (upper(firstName)  like upper(@search_text) + '%');
end;

declare @param nvarchar(40);
set @param = 'ел';
EXEC GET_WORKERS_BY_NAME @param;
--drop procedure GET_WORKERS_BY_NAME;

go
Create procedure GET_WORKER_BY_EMAIL
@search_text nvarchar(40)
as begin
SELECT * from workers where  email = @search_text;
end;

declare @param nvarchar(40);
set @param = 'chep@gmail.com';
EXEC GET_WORKER_BY_EMAIL @param;
--drop procedure GET_WORKER_BY_EMAIL;

--get id worker by email

go
Create procedure GET_ID_WORKER_BY_EMAIL
@search_email nvarchar(40)
as begin
SELECT id_worker from workers where  email = @search_email;
end;

--drp procedure GET_ID_WORKER_BY_EMAIL;

-- get role worker
go
Create procedure GET_ROLE_WORKER
@search_id int
as begin
SELECT role from workers where id_worker = @search_id;
end;

declare @param int;
set @param = 3;
EXEC GET_ROLE_WORKER @param;
--drop procedure GET_ROLE_WORKER;


-- delete client by id
go
Create procedure DELETE_CLIENT_BY_ID
@idClient int
as begin
delete from clients where id_client = @idClient;
end;


--EXEC DELETE_CLIENT_BY_ID;
--drop procedure DELETE_CLIENT_BY_ID;


-- get all clients
go
Create procedure GET_CLIENTS
as begin
SELECT * from clients;
end;

--EXEC GET_CLIENTS;
--drop procedure GET_CLIENTS;

-- get client by name
go
Create procedure GET_CLIENT_BY_NAME
@search_text nvarchar(40)
as begin
SELECT * from clients where  (upper(secondName) like upper(@search_text) + '%')  or (upper(firstName)  like upper(@search_text) + '%');
end;

declare @param nvarchar(40);
set @param = 'ож';
EXEC GET_CLIENT_BY_NAME @param;
--drop procedure GET_CLIENT_BY_NAME;

-- get client by email
go
Create procedure GET_CLIENT_BY_EMAIL
@search_text nvarchar(40)
as begin
SELECT * from clients where  email = @search_text;
end;

declare @param nvarchar(40);
set @param = 'oduvan@mail.ru';
EXEC GET_CLIENT_BY_EMAIL @param;
--drop procedure GET_CLIENT_BY_EMAIL;


-- get info client
go
Create procedure GET_INFO_CLIENT_BY_ID
@search_id int
as begin
SELECT * from clients where  id_client = @search_id;
end;

declare @param int;
set @param = 1;
EXEC GET_INFO_CLIENT_BY_ID @param;
--drop procedure GET_INFO_CLIENT_BY_ID;

go
Create procedure GET_ID_CLIENT_BY_EMAIL
@search_email nvarchar(40)
as begin
SELECT id_client from clients where  email = @search_email;
end;

declare @param nvarchar(40);
set @param = 'oduvan@mail.ru';
EXEC GET_ID_CLIENT_BY_EMAIL @param;
--drop procedure GET_ID_CLIENT_BY_EMAIL;


--get client email
go
Create procedure GET_EMAIL_CLIENT_BY_ID
@search_id nvarchar(40)
as begin
SELECT email  from clients where  id_client = @search_id;
end;

declare @param int;
set @param = 3;
EXEC GET_EMAIL_CLIENT_BY_ID @param;
--drop procedure GET_EMAIL_CLIENT_BY_ID;


--get count client's orders

go
Create procedure GET_CLIENT_ORDERS_BY_ID
@search_id int
as begin
SELECT * from orderList where  idClient = @search_id;
end;

declare @param nvarchar(40);
set @param = 1;
EXEC GET_CLIENT_ORDERS_BY_ID @param;
--drop procedure GET_CLIENT_ORDERS_BY_ID;

--get service's comments

go
Create procedure GET_SERVICE_COMMENTS_BY_ID
@search_id int
as begin
SELECT idClient, message from comments where  idService = @search_id;
end;

declare @param nvarchar(40);
set @param = 1;
EXEC GET_SERVICE_COMMENTS_BY_ID @param;
--drop procedure GET_SERVICE_COMMENTS_BY_ID;

--get count service's comments

go
Create procedure GET_COUNT_SERVICE_COMMENTS_BY_ID
@search_id int
as begin
SELECT count(*) from comments where  idService = @search_id;
end;

declare @param nvarchar(40);
set @param = 1;
EXEC GET_COUNT_SERVICE_COMMENTS_BY_ID @param;
--drop procedure GET_COUNT_SERVICE_COMMENTS_BY_ID;


-- get datetime order
go
Create procedure GET_DATETIME_ORDER_BY_ID
@search_id int
as begin
SELECT * from timetableWorkers where  id_freeDateTime = @search_id;
end;

declare @param int;
set @param = 1;
EXEC GET_DATETIME_ORDER_BY_ID @param;
--drop procedure GET_DATETIME_ORDER_BY_ID;



--get service worker
go
Create procedure GET_SERVICE_WORKERS
@search_service nvarchar(40)
as begin
declare @id_type int;
set @id_type = (SELECT idTypeOfService from servicess where  nameService = @search_service);
declare @id_position int;
set @id_position = (select id_position from positions where idTypeOfService = @id_type);

select firstName, secondName from workers where idPosition = @id_position; 
end;

declare @param nvarchar(40);
set @param = 'Keratin straightening(sh.h.)';
EXEC GET_SERVICE_WORKERS @param;
--drop procedure GET_SERVICE_WORKERS;
SELECT idTypeOfService from servicess where  nameService = 'Keratin straightening(sh.h.)'
--get free datetime worker

go
Create procedure GET_FREEDATETIME_WORKER
@search_worker_firstname nvarchar(40),
@search_worker_secondname nvarchar(40)
as begin
declare @id_worker int;
set @id_worker = (SELECT id_worker from workers where  firstName = @search_worker_firstname and
													   secondName = @search_worker_secondname);

select freeDate, freeTime from timetableWorkers where idWorker = @id_worker and 
													  status = 0; 
end;

declare @param1 nvarchar(40),  @param2 nvarchar(40);
set @param1 = 'Елизавета';
set @param2 = 'Чепелева';
EXEC GET_FREEDATETIME_WORKER @param1, @param2;
--drop procedure GET_FREEDATETIME_WORKER;


--get type id by name

go
Create procedure GET_TYPE_ID_BY_NAME
@search_type nvarchar(40)
as begin

select id_type from typeOfService where nameType = @search_type; 
end;

declare @param nvarchar(40);
set @param = 'Волосы';
EXEC GET_TYPE_ID_BY_NAME @param;
--drop procedure GET_TYPE_ID_BY_NAME;

--get comment by id service

go
Create procedure GET_COMMENT_BY_ID_SERVICE
@search_id int
as begin

select * from comments where idService = @search_id; 
end;

declare @param int;
set @param = 1;
EXEC GET_COMMENT_BY_ID_SERVICE @param;
--drop procedure GET_COMMENT_BY_ID_SERVICE;

--add comment
go 
create procedure ADD_COMMENT 
@idClient int,
@idService int,
@inputMessage text

as begin

declare @time time, @date date;
set @date = CONVERT (date, GETDATE());
set @time = CONVERT (time, GETDATE());

insert into comments(idClient, idService, commentDate, commentTime, message)
	   values(@idClient, @idService, @date, @time, @inputMessage);

end;

declare @idC int, @idS int, @message nvarchar(40);
set @idC = 3;
set @idS = 1;
set @message = 'NICE!!!';
exec ADD_COMMENT @idC,  @idS, @message;
--drop procedure ADD_COMMENT;

--delete comment
go 
create procedure DELETE_COMMENT 
@idComment int

as begin

delete from comments where id_comment = @idComment;

end;

--drop procedure DELETE_COMMENT;
	 