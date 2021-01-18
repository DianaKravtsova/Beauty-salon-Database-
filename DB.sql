create database beautySaloon

use beautySaloon

select * from clients;
delete from clients where email = 'test@mail.ru';
drop table clients;
create table clients(
	id_client int identity(1,1) primary key,
	secondName nvarchar(35) not null,
	firstName nvarchar(35) not null,
	phoneNumber nvarchar(20) not null,
	email nvarchar(50) not null,
	password nvarchar(60) not null
);
insert into clients(secondName,firstName, phoneNumber, email, password)
			values('òåñò', 'òåòñ', '+375298879566', 'oduvan@mail.ru', '12345678');

drop table typeOfService;
create table typeOfService(
	id_type int identity(1,1) primary key,
	nameType nvarchar(30) not null
);
delete from typeOfService where id_type = 1;
insert into typeOfService(nameType) values('Nail service'); --2
insert into typeOfService(nameType) values('Haircutting');--3
insert into typeOfService(nameType) values('Makeup');--4 coloring 5
insert into typeOfService(nameType) values('Face cleaning'); --6
insert into typeOfService(nameType) values('Waxing');--7
insert into typeOfService(nameType) values('Massage'); --8
insert into typeOfService(nameType) values('Hair straightening'); --9


select * from typeOfService;

create table servicess(
	id_service int identity(1,1) primary key,
	nameService nvarchar(30),
	idTypeOfService int foreign key (idTypeOfService) references typeOfService(id_type) not null,
	price nvarchar(30),
	description TEXT
	);
insert into servicess(nameService, idTypeOfService, price, description) values('Womens haircut (l.h.)', 3, '22$', 
																		       'Haircut is performed for any length of hair, the price includes daily hair styling.

Haircuts can be both classic and creative.');


delete from servicess; where id_service = 9;	
select * from servicess;


create table positions (
	id_position int identity(1,1) primary key,
	namePosition nvarchar(30) not null,
	idTypeOfService int foreign key (idTypeOfService) references typeOfService(id_type) not null
);
insert into positions(namePosition, idTypeOfService) values('Visagiste', 4);
insert into positions(namePosition, idTypeOfService) values('Master of nail service', 2);
insert into positions(namePosition, idTypeOfService) values('Ñolorists', 5);
insert into positions(namePosition, idTypeOfService) values('Hairdresser', 3);
insert into positions(namePosition, idTypeOfService) values('Cosmetologist', 6);
insert into positions(namePosition, idTypeOfService) values('Depilation master', 7);
insert into positions(namePosition, idTypeOfService) values('Masseur', 8);
insert into positions(namePosition, idTypeOfService) values('Master of keratin', 9);
select * from positions
delete FROM positions;

select * from workers;
drop table workers;
create table workers(
	id_worker int identity(1,1) primary key,
	secondName nvarchar(35),
	firstName nvarchar(35),
	idPosition int foreign key (idPosition) references positions(id_position),
	phoneNumber nvarchar(20),
	email nvarchar(50),
	password nvarchar(60),
	role smallint, --0 - worker, 1 -admin
	salary nvarchar(20)
);
select * from workers;
insert into workers(secondName,firstName, phoneNumber, email, password, role, salary, idPosition)
		     values('Smith', 'Tom', '+375331245856', 'tomsmith@gmail.com','21232f297a57a5a743894a0e4a801fc3', 0, '360$', 9);

insert into workers(secondName,firstName, phoneNumber, email, password, role, salary, idPosition)
		     values('Ford', 'Reyna', '+375254589632', 'freyna@gmail.com','21232f297a57a5a743894a0e4a801fc3', 0, '420$', 5);

insert into workers(secondName,firstName, phoneNumber, email, password, role, salary, idPosition)
		     values('Chapman', 'Morgan', '+375338950127', 'liloooo@gmail.com','21232f297a57a5a743894a0e4a801fc3', 0, '390$', 7);

insert into workers(secondName,firstName, phoneNumber, email, password, role, salary, idPosition)
		     values('Kelly', 'Piper', '+375299875823', 'piperka@gmail.com','21232f297a57a5a743894a0e4a801fc3', 0, '610$', 8);

insert into workers(secondName,firstName, phoneNumber, email, password, role) --admin
		     values('Admin', 'Admin', '+375448695364', 'admin@mail.ru','21232f297a57a5a743894a0e4a801fc3', 1);

insert into workers(secondName,firstName, phoneNumber, email, password, role, salary, idPosition)
		     values('Miller', 'Victoria', '+375444789507', 'vik@gmail.com','21232f297a57a5a743894a0e4a801fc3', 0, '250$', 11);

insert into workers(secondName,firstName, phoneNumber, email, password, role, salary, idPosition)
		     values('Cooper', 'Tina', '+375444748507', 'coop@gmail.com','21232f297a57a5a743894a0e4a801fc3', 0, '310$', 3);

insert into workers(secondName,firstName, phoneNumber, email, password, role, salary, idPosition)
		     values('Jones', 'Lila', '+375338950127', 'liloooo@gmail.com','21232f297a57a5a743894a0e4a801fc3', 0, '220$', 6);

insert into workers(secondName,firstName, phoneNumber, email, password, role, salary, idPosition)
		     values('Wood', 'Lolita', '+375298289507', 'woooooood@gmail.com','21232f297a57a5a743894a0e4a801fc3', 0, '550$', 4);
update workers set idPosition = 2 where id_worker = 4;
delete from workers where id_worker = 4;

drop table timetableWorkers;
create table timetableWorkers(
	id_freeDateTime int identity(1,1) primary key,
	idWorker int foreign key (idWorker) references workers(id_worker), 
	freeDate date not null,
	freeTime time not null,
	status smallint -- 0 -free
);
insert into timetableWorkers(idWorker,freeDate, freetime, status)
			values(5, '30-12-2020', '13:50', 0);
insert into timetableWorkers(idWorker,freeDate, freetime, status)
			values(5, '28-12-2020', '15:30', 0);
insert into timetableWorkers(idWorker,freeDate, freetime, status)
			values(6, '29-12-2020', '9:50', 0);
insert into timetableWorkers(idWorker,freeDate, freetime, status)
			values(6, '30-12-2020', '20:50', 0);
insert into timetableWorkers(idWorker,freeDate, freetime, status)
			values(7, '25-12-2020', '13:50', 0);
insert into timetableWorkers(idWorker,freeDate, freetime, status)
			values(7, '26-12-2020', '11:00', 0);
insert into timetableWorkers(idWorker,freeDate, freetime, status)
			values(8, '30-12-2020', '13:00', 0);
insert into timetableWorkers(idWorker,freeDate, freetime, status)
			values(8, '30-12-2020', '14:30', 0);
insert into timetableWorkers(idWorker,freeDate, freetime, status)
			values(9, '30-12-2020', '13:50', 0);
insert into timetableWorkers(idWorker,freeDate, freetime, status)
			values(9, '30-12-2020', '13:50', 0);
insert into timetableWorkers(idWorker,freeDate, freetime, status)
			values(10, '30-12-2020', '10:45', 0);
insert into timetableWorkers(idWorker,freeDate, freetime, status)
			values(10, '26-12-2020', '17:00', 0);
insert into timetableWorkers(idWorker,freeDate, freetime, status)
			values(11, '18-12-2020', '17:50', 0);
insert into timetableWorkers(idWorker,freeDate, freetime, status)
			values(11, '29-12-2020', '9:00', 0);
insert into timetableWorkers(idWorker,freeDate, freetime, status)
			values(11, '30-12-2020', '13:50', 0);
select * from timetableWorkers ;
update timetableWorkers set status = 0 where id_freeDateTime = 2;
delete from timetableWorkers;

--create table orderList(
--	id_order int identity(1,1) primary key,
--	idClient int foreign key (idClient) references clients(id_client), 
--	idWorker int foreign key (idWorker) references workers(id_worker), 
--	idService int foreign key (idService) references servicess(id_service) not null,
--	orderDate date not null,
--	ordertime time not null,
--	status smallint -- 0 - completed, 1 -not done
--)

create table orderList(
	id_order int identity(1,1) primary key,
	idClient int foreign key (idClient) references clients(id_client), 
	idWorker int foreign key (idWorker) references workers(id_worker), 
	idService int foreign key (idService) references servicess(id_service) not null,
	idFreeTime int foreign key (idFreeTime) references timetableWorkers(id_freeDateTime) not null,
	status smallint -- 0 - completed, 1 -not done
)
insert into orderList(idClient,  idWorker, idService,idFreeTime , status)
			values(1, 1, 1, 3, 0);
drop table orderList;
insert into orderList(idClient,  idWorker, idService, orderDate, ordertime, status)
			values(1, 1, 1, '30-10-2020', '13:20', 0);
update orderList set status = 1 where id_order = 2;
select * from orderList; where idClient = 4;
delete from orderList where status = 0;

drop table orderHistory;
select * from orderHistory;
create table orderHistory(
	id_order int,
	idClient int foreign key (idClient) references clients(id_client), 
	idWorker int foreign key (idWorker) references workers(id_worker), 
	idService int foreign key (idService) references servicess(id_service) not null,
	idFreeTime int foreign key (idFreeTime) references timetableWorkers(id_freeDateTime) not null,
	status smallint -- 0 - completed, 1 -not done
)

create table comments(
	id_comment int identity(1,1) primary key,
	idClient int foreign key (idClient) references clients(id_client) not null, 
	idService int foreign key (idService) references servicess(id_service) not null,
	commentDate date not null,
	commentTime time not null,
	message TEXT not null
)
delete from comments;

insert into comments(idClient, idService, commentDate, commentTime, message)
			values(3, 1, '28-10-2020', '13:20',  'I really liked this service.I advise everyone');

select * from comments;

drop table comments;

