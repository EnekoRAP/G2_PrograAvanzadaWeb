-- =====================================================
-- Object:  Table [dbo].[Abonos]
-- =====================================================

CREATE TABLE [dbo].Abonos (
    Id_Compra BIGINT NOT NULL,
    Id_Abono BIGINT IDENTITY(1,1) NOT NULL,
    Monto DECIMAL(18, 2) NOT NULL,
    Fecha DATETIME NOT NULL,
	
    CONSTRAINT PK_Abonos PRIMARY KEY CLUSTERED (Id_Abono ASC)
);