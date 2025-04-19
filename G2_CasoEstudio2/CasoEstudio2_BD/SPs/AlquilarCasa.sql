-- =====================================================
-- Object:  StoredProcedure [dbo].[AlquilarCasa]
-- =====================================================

CREATE PROCEDURE [dbo].[AlquilarCasa]
	@IdCasa BIGINT,
	@UsuarioAlquiler VARCHAR(30)
AS
BEGIN
	UPDATE CasasSistema
	SET
		UsuarioAlquiler = @UsuarioAlquiler,
		FechaAlquiler = GETDATE()
	WHERE IdCasa = @IdCasa
END;