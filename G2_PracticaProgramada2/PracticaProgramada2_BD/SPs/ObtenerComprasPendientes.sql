-- =====================================================
-- Object:  StoredProcedure [dbo].[ObtenerComprasPendientes]
-- =====================================================

CREATE PROCEDURE [dbo].[ObtenerComprasPendientes]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        Id_Compra,
        Descripcion,
        Saldo
    FROM Principal
    WHERE Estado = 'Pendiente';
END;