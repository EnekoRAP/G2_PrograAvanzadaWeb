-- =====================================================
-- Object:  StoredProcedure [dbo].[ObtenerComprasPendientes]
-- =====================================================

CREATE PROCEDURE [dbo].[ObtenerComprasPendientes]
AS
BEGIN
	SELECT
		Id_Compra,
		Precio,
		Saldo,
		Descripcion,
		Estado
	FROM Principal
	WHERE Estado = 'Pendiente';
END;