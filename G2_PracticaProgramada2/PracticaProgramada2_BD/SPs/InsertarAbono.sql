-- =====================================================
-- INSERTAR ABONO
-- =====================================================

CREATE PROCEDURE [dbo].[InsertarAbono]
	@Id_Compra BIGINT,
	@Monto DECIMAL(18,2)
AS
BEGIN

	DECLARE @SaldoAnterior DECIMAL(18,5)

	SELECT @SaldoAnterior = Saldo
	FROM Principal
	WHERE Id_Compra = @Id_Compra;

	IF @Monto > @SaldoAnterior
	BEGIN
		RAISERROR('El abono no puede ser mayor al saldo actual.', 16,1);
		RETURN;
	END

	INSERT INTO Abonos (Id_Compra, Monto, Fecha)
	VALUES (@Id_Compra, @Monto, GETDATE());

	UPDATE Principal
	SET Saldo = Saldo - @Monto
	WHERE Id_Compra = @Id_Compra;

	IF (@SaldoAnterior - @Monto) = 0
	BEGIN
		UPDATE Principal 
		SET Estado = 'Cancelado'
		WHERE Id_Compra = @Id_Compra;
	END
END
GO