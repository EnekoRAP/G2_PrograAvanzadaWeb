-- =====================================================
-- OBTENER COMPRAS
-- =====================================================

CREATE PROCEDURE [dbo].[ObtenerCompras]
AS
	BEGIN
		SELECT
			Id_Compra,
			Precio,
			Saldo, 
			Descripcion,
			Estado
		FROM Principal
		ORDER BY
			CASE Estado
				WHEN 'Pendiente' THEN 0
				ELSE 1
			END,
			Id_Compra DESC;
END
GO