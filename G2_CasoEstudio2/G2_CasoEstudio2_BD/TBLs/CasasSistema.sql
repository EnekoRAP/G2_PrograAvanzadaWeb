-- =====================================================
-- Object:  Table [dbo].[CasasSistema]
-- =====================================================

CREATE TABLE [dbo].[CasasSistema](
	[IdCasa] [bigint] IDENTITY(1,1) NOT NULL,
	[DescripcionCasa] [varchar](30) NOT NULL,
	[PrecioCasa] [decimal](10, 2) NOT NULL,
	[UsuarioAlquiler] [varchar](30) NULL,
	[FechaAlquiler] [datetime] NULL,
);