-- =====================================================
-- Object:  Table [dbo].[Principal]
-- =====================================================

CREATE TABLE dbo.Principal (
    Id_Compra   BIGINT IDENTITY(1,1) NOT NULL,
    Precio      DECIMAL(18, 5) NOT NULL,
    Saldo       DECIMAL(18, 5) NOT NULL,
    Descripcion VARCHAR(500) NOT NULL,
    Estado      VARCHAR(100) NOT NULL,
	
    CONSTRAINT PK_Principal PRIMARY KEY CLUSTERED (Id_Compra ASC)
);