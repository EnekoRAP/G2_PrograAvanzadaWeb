-- =====================================================
-- Object:  StoredProcedure [dbo].[ConsultarCasas]
-- =====================================================

CREATE PROCEDURE [dbo].[ConsultarCasas]
AS
BEGIN
	SELECT
		IdCasa,
		DescripcionCasa,
		PrecioCasa,
		ISNULL(UsuarioAlquiler, 'N/D') AS UsuarioAlquiler,
		CASE	WHEN UsuarioAlquiler IS NULL THEN 'Disponible'
		ELSE 'Reservada'
	END AS Estado,
	FORMAT(FechaAlquiler, 'dd/MM/yyyy') AS FechaAlquiler
FROM CasasSistema
WHERE PrecioCasa BETWEEN 115000 AND 180000
ORDER BY
	CASE
		WHEN UsuarioAlquiler IS NULL THEN 0
		ELSE 1
	END
END;