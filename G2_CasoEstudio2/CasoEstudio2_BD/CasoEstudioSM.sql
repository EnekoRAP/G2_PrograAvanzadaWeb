USE [master]
GO

CREATE DATABASE [CasoEstudioSM]
GO

USE [CasoEstudioSM]
GO

-- =====================================================
-- Object:  Table [dbo].[CasasSistema]
-- =====================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CasasSistema](
	[IdCasa] [bigint] IDENTITY(1,1) NOT NULL,
	[DescripcionCasa] [varchar](30) NOT NULL,
	[PrecioCasa] [decimal](10, 2) NOT NULL,
	[UsuarioAlquiler] [varchar](30) NULL,
	[FechaAlquiler] [datetime] NULL
) ON [PRIMARY]
GO

-- =====================================================
-- Object:  StoredProcedure [dbo].[AlquilarCasa]
-- =====================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AlquilarCasa]
	@IdCasa BIGINT,
	@UsuarioAlquiler VARCHAR(30)
AS
BEGIN
	UPDATE CasasSistema
	SET
		UsuarioAlquiler = @UsuarioAlquiler,
		FechaAlquiler = GETDATE()
	WHERE IdCasa = @IdCasa
END
GO

-- =====================================================
-- Object:  StoredProcedure [dbo].[ConsultarCasas]
-- =====================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ConsultarCasas]
AS
BEGIN
	SELECT
		IdCasa,
		DescripcionCasa,
		PrecioCasa,
		ISNULL(UsuarioAlquiler, 'N/D') AS UsuarioAlquiler,
		CASE	WHEN UsuarioAlquiler IS NULL THEN 'Disponible'
		ELSE 'Reservada'
	END AS Estado,
	FORMAT(FechaAlquiler, 'dd/MM/yyyy') AS FechaAlquiler
FROM CasasSistema
WHERE PrecioCasa BETWEEN 115000 AND 180000
ORDER BY
	CASE
		WHEN UsuarioAlquiler IS NULL THEN 0
		ELSE 1
	END
END
GO

-- =====================================================
-- Object:  StoredProcedure [dbo].[ObtenerCasasDisponibles]
-- =====================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ObtenerCasasDisponibles]
AS
BEGIN
	SELECT
		IdCasa,
		DescripcionCasa,
		PrecioCasa
	FROM CasasSistema
	WHERE UsuarioAlquiler IS NULL
END
GO
