-- =====================================================
-- Object:  StoredProcedure [dbo].[ObtenerCompras]
-- =====================================================

CREATE PROCEDURE [dbo].[ObtenerCompras]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
		Id_Compra,
        Precio,
        Saldo,
        Descripcion,
        Estado
    FROM 
        dbo.Principal
    ORDER BY 
        CASE 
            WHEN Estado = 'Pendiente' THEN 0 
            ELSE 1 
        END,
        Estado;
END;