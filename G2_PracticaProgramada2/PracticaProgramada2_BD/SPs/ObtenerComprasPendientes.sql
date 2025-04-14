-- =====================================================
-- OBTENER COMPRAS PENDIENTES
-- =====================================================

CREATE PROCEDURE [dbo].[ObtenerComprasPendientes]
AS
BEGIN
	SELECT
		Id_Compra,
		Descripcion,
		Saldo
	FROM Principal
	WHERE Estado = 'Pendiente';
END
GO