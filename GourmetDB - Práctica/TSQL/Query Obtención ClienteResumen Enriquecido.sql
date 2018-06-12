SELECT  
	T0.*
	, CASE 
		WHEN (T0.Sexo = 'Hombre') THEN 1
		WHEN (T0.Sexo = 'Mujer') THEN 2
		ELSE 0
	END as IdSexo
	, CASE
		WHEN (T0.EstadoCivil like '%Casad%') THEN 1
		WHEN (T0.EstadoCivil like '%Solte%') THEN 2
		WHEN (T0.EstadoCivil like '%Viud%') THEN 3
		WHEN (T0.EstadoCivil like '%Divor%') THEN 4
		WHEN (T0.EstadoCivil like '%Separa%') THEN 5
		ELSE 0
	END as IdEstadoCivil
		, CASE
		WHEN (T0.Nacionalidad like '%Espa%') THEN 1
		WHEN (T0.Nacionalidad like '%Reino%') THEN 2
		ELSE 0
	END as IdNacionalidad
	, CASE
		WHEN (T0.Profesion like '%Alimen%') THEN 1
		WHEN (T0.Profesion like '%Servicio%') THEN 2
		WHEN (T0.Profesion like '%Ama de%') THEN 3
		WHEN (T0.Profesion like '%Archi%') THEN 4
		WHEN (T0.Profesion like '%Inge%') THEN 5
		WHEN (T0.Profesion like '%Food%') THEN 6
		WHEN (T0.Profesion like '%Gerentes%') THEN 7
		WHEN (T0.Profesion like '%Catering%') THEN 8
		WHEN (T0.Profesion like '%Economi%') THEN 9
		WHEN (T0.Profesion like '%Docto%') THEN 10
		ELSE 0
	END as IdProfesion
		, CASE
		WHEN (T1.TiendaH like '%Barcelona%') THEN 1
		WHEN (T1.TiendaH like '%Florencia%') THEN 2
		WHEN (T1.TiendaH like '%Fort L%') THEN 3
		WHEN (T1.TiendaH like '%Liverp%') THEN 4
		WHEN (T1.TiendaH = 'Londres I') THEN 5
		WHEN (T1.TiendaH = 'Londres II') THEN 6
		WHEN (T1.TiendaH = 'Madrid') THEN 7
		WHEN (T1.TiendaH = 'Manhattan I') THEN 8
		WHEN (T1.TiendaH = 'Manhattan II') THEN 9
		WHEN (T1.TiendaH like '%Miami%') THEN 10
		WHEN (T1.TiendaH like '%Milán%') THEN 11
		WHEN (T1.TiendaH like '%Munich%') THEN 12
		WHEN (T1.TiendaH = 'París I') THEN 13
		WHEN (T1.TiendaH = 'París II') THEN 14
		WHEN (T1.TiendaH like '%Roma%') THEN 15
		ELSE 0
	END as IdTienda
	, CASE
		WHEN (T1.FormaPagoH = 'Cheque') THEN 1
		WHEN (T1.FormaPagoH like '%Turista%') THEN 2
		WHEN (T1.FormaPagoH like '%Efecti%') THEN 3
		WHEN (T1.FormaPagoH like '%Otra%') THEN 3
		WHEN (T1.FormaPagoH like '%Crédito%') THEN 4
		WHEN (T1.FormaPagoH like '%Débito%') THEN 2
		ELSE 0
	END as IdFormaPago
	, T1.IdCliente
	, T1.HoraH
	, T1.TiendaH
	, T1.FormaPagoH
	, T1.UnidadesH
	, T1.ImporteMax
	, T1.ImporteAvg 
FROM  ClienteResumen as T1
JOIN cliente as T0
ON T0.IdCliente = T1.IdCliente


