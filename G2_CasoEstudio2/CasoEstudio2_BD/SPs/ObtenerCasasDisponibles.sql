-- =====================================================
-- Object:  StoredProcedure [dbo].[ObtenerCasasDisponibles]
-- =====================================================

CREATE PROCEDURE [dbo].[ObtenerCasasDisponibles]
AS
BEGIN
	SELECT
		IdCasa,
		DescripcionCasa,
		PrecioCasa
	FROM CasasSistema
	WHERE UsuarioAlquiler IS NULL
END;