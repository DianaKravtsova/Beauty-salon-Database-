use beautySaloon;

-- create random word
Create Procedure CreateRandomWord
@size integer,
	@Name char(50) OUTPUT
AS
Begin
	SET @Name = (
	SELECT
		c1 AS [text()]
	FROM
		(
		SELECT TOP (@size) c1
		FROM
		  (
		VALUES
		  ('A'), ('B'), ('C'), ('D'), ('E'), ('F'), ('G'), ('H'), ('I'), ('J'),
		  ('K'), ('L'), ('M'), ('N'), ('O'), ('P'), ('Q'), ('R'), ('S'), ('T'),
		  ('U'), ('V'), ('W'), ('X'), ('Y'), ('Z')
		  ) AS T1(c1)
		ORDER BY ABS(CHECKSUM(NEWID()))
		) AS T2
	FOR XML PATH('')
	);
End;

go
Create Procedure InsertComments AS
Begin

DECLARE @NUMBER int, @Random_Message nvarchar(15),
		@Random_IdClient int, @Random_IdService int,
		@Random_Date date, @Random_Time time, 
		@set_service nvarchar(30);

SET @number = 1;

declare @FromDate date = '30-08-2020';
declare @ToDate date = '30-12-2020';
While @number <= 100000
	BEGIN
		exec CreateRandomWord 15, @Random_Message OUTPUT;
		set @Random_Date = dateadd(day, rand(checksum(newid())) * (1 + datediff(day, @FromDate, @ToDate)), @FromDate);
		set @Random_Time = CONVERT (time, GETDATE());
		set @Random_IdClient =  ABS(CHECKSUM(NEWID()) % 3) + 1;
		set @Random_IdService =  ABS(CHECKSUM(NEWID()) % 45) + 91;
		set @set_service = (select nameService from servicess where id_service = @Random_IdService);

		if(@set_service is not null)
		begin
			insert into comments(idClient, idService, commentDate, commentTime, message) 
			values (@Random_IdClient, @Random_IdService, @Random_Date, @Random_Time, @Random_Message);
		end
			SET @number = @number + 1;
	END;
End;

exec InsertComments;

drop procedure InsertComments;

select * from comments;

ñ