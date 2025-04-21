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
        UsuarioAlquiler,
        FechaAlquiler
    FROM 
        dbo.CasasSistema
    ORDER BY 
        CASE 
            WHEN FechaAlquiler IS NULL THEN 0 
            ELSE 1 
        END,
        FechaAlquiler;
END;