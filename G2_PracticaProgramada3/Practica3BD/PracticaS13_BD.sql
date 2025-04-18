USE [master]

CREATE DATABASE [PracticaS13]
GO

USE [PracticaS13]
GO

-- =====================================================
-- Object:  Table [dbo].[Abonos]
-- =====================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Abonos](
	[Id_Compra] [bigint] NOT NULL,
	[Id_Abono] [bigint] IDENTITY(1,1) NOT NULL,
	[Monto] [decimal](18, 2) NOT NULL,
	[Fecha] [datetime] NOT NULL,
 CONSTRAINT [PK_Abonos] PRIMARY KEY CLUSTERED 
(
	[Id_Abono] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

-- =====================================================
-- Object:  Table [dbo].[Principal]
-- =====================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Principal](
	[Id_Compra] [bigint] IDENTITY(1,1) NOT NULL,
	[Precio] [decimal](18, 5) NOT NULL,
	[Saldo] [decimal](18, 5) NOT NULL,
	[Descripcion] [varchar](500) NOT NULL,
	[Estado] [varchar](100) NOT NULL,
 CONSTRAINT [PK_Principal] PRIMARY KEY CLUSTERED 
(
	[Id_Compra] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Abonos]  WITH CHECK ADD  CONSTRAINT [FK_Abonos_Principal] FOREIGN KEY([Id_Compra])
REFERENCES [dbo].[Principal] ([Id_Compra])
GO
ALTER TABLE [dbo].[Abonos] CHECK CONSTRAINT [FK_Abonos_Principal]
GO

-- =====================================================
-- Object:  StoredProcedure [dbo].[InsertarAbono]
-- =====================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertarAbono]
	@Id_Compra BIGINT,
	@Monto DECIMAL(18,2)
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO Abonos (Id_Compra, Monto, Fecha)
	VALUES (@Id_Compra, @Monto, GETDATE());

	UPDATE Principal
	SET Saldo = Saldo - @Monto
	WHERE Id_Compra = @Id_Compra;

	DECLARE @NuevoSaldo DECIMAL(18,5);

	SELECT @NuevoSaldo = Saldo
	FROM Principal
	WHERE Id_Compra = @Id_Compra;

	IF @NuevoSaldo = 0
	BEGIN
		UPDATE Principal 
		SET Estado = 'Cancelado'
		WHERE Id_Compra = @Id_Compra;
	END
	SELECT 1 AS Resultado;
END
GO

-- =====================================================
-- Object:  StoredProcedure [dbo].[ObtenerCompras]
-- =====================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
END
GO

-- =====================================================
-- Object:  StoredProcedure [dbo].[ObtenerComprasPendientes]
-- =====================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
END
GO
