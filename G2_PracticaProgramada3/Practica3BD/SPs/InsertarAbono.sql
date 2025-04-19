-- =====================================================
-- Object:  StoredProcedure [dbo].[InsertarAbono]
-- =====================================================

CREATE PROCEDURE [dbo].[InsertarAbono]
	@Id_Compra BIGINT,
	@Monto DECIMAL(18,2)
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO Abonos (Id_Compra, Monto, Fecha)
	VALUES (@Id_Compra, @Monto, GETDATE());

	UPDATE Principal
	SET Saldo = Saldo - @Monto
	WHERE Id_Compra = @Id_Compra;

	DECLARE @NuevoSaldo DECIMAL(18,5);

	SELECT @NuevoSaldo = Saldo
	FROM Principal
	WHERE Id_Compra = @Id_Compra;

	IF @NuevoSaldo = 0
	BEGIN
		UPDATE Principal 
		SET Estado = 'Cancelado'
		WHERE Id_Compra = @Id_Compra;
	END
	SELECT 1 AS Resultado;
END;