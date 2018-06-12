-- ================================================

-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alberto Alonso
-- Create date: 20180609
-- Description:	Crear el resumen de la tabla de modelaje asociativo de la Práctica de mineria
-- =============================================

-- EXEC [dbo].[SPResumenClientes]


ALTER PROCEDURE [dbo].[SPResumenClientes]

AS
BEGIN
	set language spanish
	set nocount on

	-- drop table ClienteResumen

	CREATE TABLE ClienteResumen (IdCliente nvarchar(100)
					, HoraH int
					, TiendaH nvarchar(100)
					, FormaPagoH nvarchar(100)
					, UnidadesH int
					, ImporteMax float
					, ImporteAvg float
					)

	-- Insertamos la media de Compra del cliente
	declare @TblTotalAvgH table (IdCliente nvarchar(100), ImporteAvg float)

	insert	into @TblTotalAvgH (IdCliente, ImporteAvg)
	SELECT DISTINCT IdCliente
		, (Select AVG(Total)
		from dbo.cabeceraticket1 as T1
		where T1.IdCliente = T0.IdCliente
		group by IdCliente) as HoraH
		FROM dbo.cabeceraticket1 as T0
	
	-- Insertamos el Total Habitual del cliente
	declare @TblTotalH table (IdCliente nvarchar(100), ImporteMax float)

	insert	into @TblTotalH (IdCliente, ImporteMax)
	SELECT DISTINCT IdCliente
		, (Select TOP 1 Total
		from dbo.cabeceraticket1 as T1
		where T1.IdCliente = T0.IdCliente
		group by IdCliente, Total
		order by count(Hora) desc) as HoraH
		FROM dbo.cabeceraticket1 as T0

	-- Insertamos las Unidades Habitual del cliente
	declare @TblUnidadesH table (IdCliente nvarchar(100), UnidadesH int)

	insert	into @TblUnidadesH (IdCliente, UnidadesH)
	SELECT DISTINCT IdCliente
		, (Select TOP 1 UnidadesTicket
		from dbo.cabeceraticket1 as T1
		where T1.IdCliente = T0.IdCliente
		group by IdCliente, UnidadesTicket
		order by count(Hora) desc) as HoraH
		FROM dbo.cabeceraticket1 as T0


	-- Insertamos la Forma de Pago Habitual del cliente
	declare @TblFormaPago table (IdCliente nvarchar(100), FormaPagoH nvarchar(100))

	insert	into @TblFormaPago (IdCliente, FormaPagoH)
	SELECT DISTINCT IdCliente
		, (Select TOP 1 FormaPago
		from dbo.cabeceraticket1 as T1
		where T1.IdCliente = T0.IdCliente
		group by IdCliente, FormaPago
		order by count(Hora) desc) as HoraH
		FROM dbo.cabeceraticket1 as T0
	
	
	declare @TblHora table (IdCliente nvarchar(100), HoraH int)

	insert	into @TblHora (IdCliente,HoraH)
	SELECT DISTINCT IdCliente
		, (Select TOP 1 Hora
		from dbo.cabeceraticket1 as T1
		where T1.IdCliente = T0.IdCliente
		group by IdCliente, Hora
		order by count(Hora) desc) as HoraH
		FROM dbo.cabeceraticket1 as T0

	-- select * from @TblHora

	-- Insertamos la Tienda favorita del cliente
	declare @TblTienda table (IdCliente nvarchar(100), TiendaH nvarchar(100))

	insert	into @TblTienda (IdCliente, TiendaH)
	SELECT DISTINCT IdCliente
		, (Select TOP 1 Tienda
		from dbo.cabeceraticket1 as T1
		where T1.IdCliente = T0.IdCliente
		group by IdCliente, Tienda
		order by count(Hora) desc) as HoraH
		FROM dbo.cabeceraticket1 as T0

	INSERT INTO ClienteResumen
	SELECT IdCliente 
		, HoraH 
		, ''
		, ''
		, ''
		, ''
		, ''
	FROM @TblHora

	update ClienteResumen
	set TiendaH = (SELECT TiendaH from @TblTienda as T1 WHERE ClienteResumen.IdCliente = T1.IdCliente) 
	
	update ClienteResumen
	set  FormaPagoH = (SELECT FormaPagoH from @TblFormaPago as T1 WHERE ClienteResumen.IdCliente = T1.IdCliente) 

	update ClienteResumen
	set UnidadesH = (SELECT UnidadesH from @TblUnidadesH as T1 WHERE ClienteResumen.IdCliente = T1.IdCliente) 

	update ClienteResumen
	set ImporteMax = (SELECT ImporteMax from @TblTotalH as T1 WHERE ClienteResumen.IdCliente = T1.IdCliente) 

	update ClienteResumen
	set ImporteAvg = (SELECT ImporteAvg from @TblTotalAvgH as T1 WHERE ClienteResumen.IdCliente = T1.IdCliente) 
	
	SELECT * from dbo.ClienteResumen

END
GO
