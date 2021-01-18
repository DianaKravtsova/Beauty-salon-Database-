use beautySaloon;


--------------------------------------------------------------------------------------

--Export to xml
go
create procedure ServiceToXml
as
begin
	select nameService, idTypeOfService, price, description
	from servicess
		for xml path('service'), root('servicess');

	exec master.dbo.sp_configure 'show advanced options', 1
		reconfigure with override
	exec master.dbo.sp_configure 'xp_cmdshell', 1
		reconfigure with override;

	declare @cmd nvarchar(255);
	select @cmd = '
    bcp "use beautySaloon; select nameService, idTypeOfService, price, description from servicess for xml path(''service''), root(''servicess'')" ' +
    'queryout "D:\Export.xml" -S .\SQLEXPRESS -T -w -r -t';
exec xp_cmdshell @cmd;
end; 

exec ServiceToXml;

--drop procedure ServiceToXml;

--import from xml to server 

create procedure XmlToService
as begin
DECLARE @xml XML;

SELECT @xml = CONVERT(xml, BulkColumn, 2) FROM OPENROWSET(BULK 'D:\Export.xml', SINGLE_BLOB) AS x

INSERT INTO  servicess(nameService, idTypeOfService, price, description)
SELECT 
	t.x.query('nameService').value('.', 'nvarchar(30)'),
	t.x.query('idTypeOfService').value('.', 'INT'),
	t.x.query('price').value('.', 'nvarchar(30)') ,
	t.x.query('description').value('.', 'nvarchar(2000)')
FROM @xml.nodes('//servicess/service') t(x)
end

select * from servicess;
exec XmlToService;
-----
drop procedure XmlToService;
------
go
Create Procedure DeleteXmlData @number int, @numberend int AS
Begin

While @number <= @numberend
	BEGIN
		delete from servicess where id_service = @number;

		set @number = @number + 1;
	END;
End;

declare @param int, @param2 int;
set @param = 127;
set @param2 = 162;
exec DeleteXmlData @param, @param2;