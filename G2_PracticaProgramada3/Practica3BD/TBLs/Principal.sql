-- =====================================================
-- Object:  Table [dbo].[Principal]
-- =====================================================

CREATE TABLE [dbo].[Principal](
	[Id_Compra] [bigint] IDENTITY(1,1) NOT NULL,
	[Precio] [decimal](18, 5) NOT NULL,
	[Saldo] [decimal](18, 5) NOT NULL,
	[Descripcion] [varchar](500) NOT NULL,
	[Estado] [varchar](100) NOT NULL,
	
	CONSTRAINT [PK_Principal] PRIMARY KEY CLUSTERED 
);