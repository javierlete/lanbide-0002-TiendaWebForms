USE [master]
GO
/****** Object:  Database [mf0966]    Script Date: 04/10/2021 13:54:49 ******/
CREATE DATABASE [mf0966]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'mf0966', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\mf0966.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'mf0966_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\mf0966_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [mf0966] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [mf0966].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [mf0966] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [mf0966] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [mf0966] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [mf0966] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [mf0966] SET ARITHABORT OFF 
GO
ALTER DATABASE [mf0966] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [mf0966] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [mf0966] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [mf0966] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [mf0966] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [mf0966] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [mf0966] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [mf0966] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [mf0966] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [mf0966] SET  DISABLE_BROKER 
GO
ALTER DATABASE [mf0966] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [mf0966] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [mf0966] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [mf0966] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [mf0966] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [mf0966] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [mf0966] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [mf0966] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [mf0966] SET  MULTI_USER 
GO
ALTER DATABASE [mf0966] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [mf0966] SET DB_CHAINING OFF 
GO
ALTER DATABASE [mf0966] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [mf0966] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [mf0966] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [mf0966] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [mf0966] SET QUERY_STORE = OFF
GO
USE [mf0966]
GO
/****** Object:  Table [dbo].[Categorias]    Script Date: 04/10/2021 13:54:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categorias](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Categorias] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Productos]    Script Date: 04/10/2021 13:54:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Productos](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](50) NOT NULL,
	[Precio] [money] NOT NULL,
	[CategoriaId] [bigint] NOT NULL,
 CONSTRAINT [PK_Productos] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[ProductosCompletos]    Script Date: 04/10/2021 13:54:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ProductosCompletos]
AS
SELECT        dbo.Productos.Id, dbo.Productos.Nombre, dbo.Productos.Precio, dbo.Categorias.Id AS CategoriaId, dbo.Categorias.Nombre AS CategoriaNombre
FROM            dbo.Categorias INNER JOIN
                         dbo.Productos ON dbo.Categorias.Id = dbo.Productos.CategoriaId
GO
/****** Object:  Table [dbo].[Clientes]    Script Date: 04/10/2021 13:54:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Clientes](
	[Id] [bigint] NOT NULL,
	[Nombre] [nvarchar](50) NOT NULL,
	[Apellidos] [nvarchar](100) NULL,
	[FechaNacimiento] [date] NULL,
 CONSTRAINT [PK_Clientes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Empleados]    Script Date: 04/10/2021 13:54:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Empleados](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](50) NOT NULL,
	[JefeId] [bigint] NULL,
 CONSTRAINT [PK_Empleados] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Facturas]    Script Date: 04/10/2021 13:54:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Facturas](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Numero] [char](8) NOT NULL,
	[Fecha] [date] NOT NULL,
	[ClienteId] [bigint] NOT NULL,
 CONSTRAINT [PK_Facturas] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FacturasProductos]    Script Date: 04/10/2021 13:54:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FacturasProductos](
	[FacturaId] [bigint] NOT NULL,
	[ProductoId] [bigint] NOT NULL,
	[Cantidad] [int] NOT NULL,
 CONSTRAINT [PK_FacturasProductos] PRIMARY KEY CLUSTERED 
(
	[FacturaId] ASC,
	[ProductoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Muebles]    Script Date: 04/10/2021 13:54:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Muebles](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](50) NOT NULL,
	[Precio] [money] NULL,
	[Largo] [float] NULL,
	[Ancho] [float] NULL,
	[Alto] [float] NULL,
	[FechaFabricacion] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuarios]    Script Date: 04/10/2021 13:54:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuarios](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[Password] [char](60) NOT NULL,
 CONSTRAINT [PK_Usuarios] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Categorias] ON 
GO
INSERT [dbo].[Categorias] ([Id], [Nombre]) VALUES (12, N'aaa')
GO
INSERT [dbo].[Categorias] ([Id], [Nombre]) VALUES (28, N'asdfasdf')
GO
INSERT [dbo].[Categorias] ([Id], [Nombre]) VALUES (4, N'Electrodomésticos')
GO
INSERT [dbo].[Categorias] ([Id], [Nombre]) VALUES (2, N'Electrónica')
GO
INSERT [dbo].[Categorias] ([Id], [Nombre]) VALUES (1, N'Informática')
GO
SET IDENTITY_INSERT [dbo].[Categorias] OFF
GO
INSERT [dbo].[Clientes] ([Id], [Nombre], [Apellidos], [FechaNacimiento]) VALUES (1, N'Javier', N'Lete', CAST(N'2000-01-21' AS Date))
GO
INSERT [dbo].[Clientes] ([Id], [Nombre], [Apellidos], [FechaNacimiento]) VALUES (2, N'Pepe', N'Pérez', CAST(N'2002-02-12' AS Date))
GO
SET IDENTITY_INSERT [dbo].[Empleados] ON 
GO
INSERT [dbo].[Empleados] ([Id], [Nombre], [JefeId]) VALUES (1, N'Javier', NULL)
GO
INSERT [dbo].[Empleados] ([Id], [Nombre], [JefeId]) VALUES (2, N'Pepe', 1)
GO
INSERT [dbo].[Empleados] ([Id], [Nombre], [JefeId]) VALUES (3, N'Juan', 2)
GO
INSERT [dbo].[Empleados] ([Id], [Nombre], [JefeId]) VALUES (4, N'Pedro', 2)
GO
SET IDENTITY_INSERT [dbo].[Empleados] OFF
GO
SET IDENTITY_INSERT [dbo].[Facturas] ON 
GO
INSERT [dbo].[Facturas] ([Id], [Numero], [Fecha], [ClienteId]) VALUES (2, N'20210001', CAST(N'2021-09-09' AS Date), 1)
GO
INSERT [dbo].[Facturas] ([Id], [Numero], [Fecha], [ClienteId]) VALUES (3, N'20210002', CAST(N'2021-10-02' AS Date), 1)
GO
INSERT [dbo].[Facturas] ([Id], [Numero], [Fecha], [ClienteId]) VALUES (4, N'20210003', CAST(N'2021-10-04' AS Date), 1)
GO
INSERT [dbo].[Facturas] ([Id], [Numero], [Fecha], [ClienteId]) VALUES (6, N'20210004', CAST(N'2021-10-04' AS Date), 1)
GO
INSERT [dbo].[Facturas] ([Id], [Numero], [Fecha], [ClienteId]) VALUES (8, N'20210005', CAST(N'2021-10-04' AS Date), 1)
GO
INSERT [dbo].[Facturas] ([Id], [Numero], [Fecha], [ClienteId]) VALUES (9, N'20210006', CAST(N'2021-10-04' AS Date), 1)
GO
INSERT [dbo].[Facturas] ([Id], [Numero], [Fecha], [ClienteId]) VALUES (10, N'20210007', CAST(N'2021-10-04' AS Date), 1)
GO
INSERT [dbo].[Facturas] ([Id], [Numero], [Fecha], [ClienteId]) VALUES (11, N'20210008', CAST(N'2021-10-04' AS Date), 1)
GO
INSERT [dbo].[Facturas] ([Id], [Numero], [Fecha], [ClienteId]) VALUES (12, N'20210009', CAST(N'2021-10-04' AS Date), 1)
GO
INSERT [dbo].[Facturas] ([Id], [Numero], [Fecha], [ClienteId]) VALUES (13, N'20210010', CAST(N'2021-10-04' AS Date), 1)
GO
INSERT [dbo].[Facturas] ([Id], [Numero], [Fecha], [ClienteId]) VALUES (14, N'20210011', CAST(N'2021-10-04' AS Date), 1)
GO
INSERT [dbo].[Facturas] ([Id], [Numero], [Fecha], [ClienteId]) VALUES (15, N'20210012', CAST(N'2021-10-04' AS Date), 1)
GO
INSERT [dbo].[Facturas] ([Id], [Numero], [Fecha], [ClienteId]) VALUES (16, N'20210013', CAST(N'2021-10-04' AS Date), 2)
GO
SET IDENTITY_INSERT [dbo].[Facturas] OFF
GO
INSERT [dbo].[FacturasProductos] ([FacturaId], [ProductoId], [Cantidad]) VALUES (2, 1, 5)
GO
INSERT [dbo].[FacturasProductos] ([FacturaId], [ProductoId], [Cantidad]) VALUES (2, 2, 3)
GO
INSERT [dbo].[FacturasProductos] ([FacturaId], [ProductoId], [Cantidad]) VALUES (2, 3, 1)
GO
INSERT [dbo].[FacturasProductos] ([FacturaId], [ProductoId], [Cantidad]) VALUES (3, 1, 1)
GO
INSERT [dbo].[FacturasProductos] ([FacturaId], [ProductoId], [Cantidad]) VALUES (3, 2, 2)
GO
INSERT [dbo].[FacturasProductos] ([FacturaId], [ProductoId], [Cantidad]) VALUES (8, 1, 1)
GO
INSERT [dbo].[FacturasProductos] ([FacturaId], [ProductoId], [Cantidad]) VALUES (9, 3, 1)
GO
INSERT [dbo].[FacturasProductos] ([FacturaId], [ProductoId], [Cantidad]) VALUES (10, 2, 1)
GO
INSERT [dbo].[FacturasProductos] ([FacturaId], [ProductoId], [Cantidad]) VALUES (11, 2, 1)
GO
INSERT [dbo].[FacturasProductos] ([FacturaId], [ProductoId], [Cantidad]) VALUES (12, 2, 1)
GO
INSERT [dbo].[FacturasProductos] ([FacturaId], [ProductoId], [Cantidad]) VALUES (13, 2, 1)
GO
INSERT [dbo].[FacturasProductos] ([FacturaId], [ProductoId], [Cantidad]) VALUES (14, 3, 1)
GO
INSERT [dbo].[FacturasProductos] ([FacturaId], [ProductoId], [Cantidad]) VALUES (15, 2, 1)
GO
INSERT [dbo].[FacturasProductos] ([FacturaId], [ProductoId], [Cantidad]) VALUES (16, 4, 2)
GO
INSERT [dbo].[FacturasProductos] ([FacturaId], [ProductoId], [Cantidad]) VALUES (16, 8, 1)
GO
SET IDENTITY_INSERT [dbo].[Muebles] ON 
GO
INSERT [dbo].[Muebles] ([Id], [Nombre], [Precio], [Largo], [Ancho], [Alto], [FechaFabricacion]) VALUES (4, N'dfghdfghdfgh', 123.0000, 1, 2, 3, CAST(N'2021-01-01' AS Date))
GO
INSERT [dbo].[Muebles] ([Id], [Nombre], [Precio], [Largo], [Ancho], [Alto], [FechaFabricacion]) VALUES (5, N'klhjklhjklhjk', 321.0000, 3, 2, 1, CAST(N'2021-12-31' AS Date))
GO
SET IDENTITY_INSERT [dbo].[Muebles] OFF
GO
SET IDENTITY_INSERT [dbo].[Productos] ON 
GO
INSERT [dbo].[Productos] ([Id], [Nombre], [Precio], [CategoriaId]) VALUES (1, N'Ratón', 12.0000, 1)
GO
INSERT [dbo].[Productos] ([Id], [Nombre], [Precio], [CategoriaId]) VALUES (2, N'Teclado', 21.0000, 1)
GO
INSERT [dbo].[Productos] ([Id], [Nombre], [Precio], [CategoriaId]) VALUES (3, N'Monitor', 123.0000, 1)
GO
INSERT [dbo].[Productos] ([Id], [Nombre], [Precio], [CategoriaId]) VALUES (4, N'Secador', 41.0000, 2)
GO
INSERT [dbo].[Productos] ([Id], [Nombre], [Precio], [CategoriaId]) VALUES (6, N'asdfasdf', 123.0000, 4)
GO
INSERT [dbo].[Productos] ([Id], [Nombre], [Precio], [CategoriaId]) VALUES (7, N'Cambiado', 25.2000, 2)
GO
INSERT [dbo].[Productos] ([Id], [Nombre], [Precio], [CategoriaId]) VALUES (8, N'Artículo nuevo', 12.3400, 1)
GO
INSERT [dbo].[Productos] ([Id], [Nombre], [Precio], [CategoriaId]) VALUES (9, N'Prueba', 123.0000, 2)
GO
INSERT [dbo].[Productos] ([Id], [Nombre], [Precio], [CategoriaId]) VALUES (10, N'sdfgsdfg', 321.0000, 4)
GO
INSERT [dbo].[Productos] ([Id], [Nombre], [Precio], [CategoriaId]) VALUES (11, N'sdfgsdfgdfs', 123.0000, 12)
GO
SET IDENTITY_INSERT [dbo].[Productos] OFF
GO
SET IDENTITY_INSERT [dbo].[Usuarios] ON 
GO
INSERT [dbo].[Usuarios] ([Id], [Email], [Password]) VALUES (1, N'javier@email.net', N'$2a$11$GpRmAu7o7Ols.hbt1rmqVufVN029AlpHDll62NLcwkbRu0t8RqWXy')
GO
INSERT [dbo].[Usuarios] ([Id], [Email], [Password]) VALUES (2, N'pepe@email.net', N'$2a$11$lV2enNznjJpCpzrsVywKBuCvAypUeKAShSGet2UcQ8EHL5i58d79O')
GO
INSERT [dbo].[Usuarios] ([Id], [Email], [Password]) VALUES (9, N'admin@email.net', N'$2a$11$Ev3ZBgALyIPAMWbCFBg2h.WIsAEpcd5zky4/4yTgEvlUCYib.H3MW')
GO
INSERT [dbo].[Usuarios] ([Id], [Email], [Password]) VALUES (10, N'sdfgsdf', N'asdfasdfasd                                                 ')
GO
INSERT [dbo].[Usuarios] ([Id], [Email], [Password]) VALUES (11, N'sdfg', N'asdfsgasdf                                                  ')
GO
SET IDENTITY_INSERT [dbo].[Usuarios] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Categorias_Nombre]    Script Date: 04/10/2021 13:54:49 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Categorias_Nombre] ON [dbo].[Categorias]
(
	[Nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Facturas]    Script Date: 04/10/2021 13:54:49 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Facturas] ON [dbo].[Facturas]
(
	[Numero] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Usuarios]    Script Date: 04/10/2021 13:54:49 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Usuarios] ON [dbo].[Usuarios]
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Clientes]  WITH CHECK ADD  CONSTRAINT [FK_Clientes_Usuarios] FOREIGN KEY([Id])
REFERENCES [dbo].[Usuarios] ([Id])
GO
ALTER TABLE [dbo].[Clientes] CHECK CONSTRAINT [FK_Clientes_Usuarios]
GO
ALTER TABLE [dbo].[Empleados]  WITH CHECK ADD  CONSTRAINT [FK_Empleados_Jefes] FOREIGN KEY([JefeId])
REFERENCES [dbo].[Empleados] ([Id])
GO
ALTER TABLE [dbo].[Empleados] CHECK CONSTRAINT [FK_Empleados_Jefes]
GO
ALTER TABLE [dbo].[Facturas]  WITH CHECK ADD  CONSTRAINT [FK_Facturas_Clientes] FOREIGN KEY([ClienteId])
REFERENCES [dbo].[Clientes] ([Id])
GO
ALTER TABLE [dbo].[Facturas] CHECK CONSTRAINT [FK_Facturas_Clientes]
GO
ALTER TABLE [dbo].[FacturasProductos]  WITH CHECK ADD  CONSTRAINT [FK_FacturasProductos_Facturas] FOREIGN KEY([FacturaId])
REFERENCES [dbo].[Facturas] ([Id])
GO
ALTER TABLE [dbo].[FacturasProductos] CHECK CONSTRAINT [FK_FacturasProductos_Facturas]
GO
ALTER TABLE [dbo].[FacturasProductos]  WITH CHECK ADD  CONSTRAINT [FK_FacturasProductos_Productos] FOREIGN KEY([ProductoId])
REFERENCES [dbo].[Productos] ([Id])
GO
ALTER TABLE [dbo].[FacturasProductos] CHECK CONSTRAINT [FK_FacturasProductos_Productos]
GO
ALTER TABLE [dbo].[Productos]  WITH CHECK ADD  CONSTRAINT [FK_Productos_Categorias] FOREIGN KEY([CategoriaId])
REFERENCES [dbo].[Categorias] ([Id])
GO
ALTER TABLE [dbo].[Productos] CHECK CONSTRAINT [FK_Productos_Categorias]
GO
ALTER TABLE [dbo].[Facturas]  WITH CHECK ADD  CONSTRAINT [CK_Facturas] CHECK  (([Fecha]>'2000-01-01'))
GO
ALTER TABLE [dbo].[Facturas] CHECK CONSTRAINT [CK_Facturas]
GO
ALTER TABLE [dbo].[Facturas]  WITH CHECK ADD  CONSTRAINT [CK_Facturas_1] CHECK  (([Fecha]>'1234-12-12'))
GO
ALTER TABLE [dbo].[Facturas] CHECK CONSTRAINT [CK_Facturas_1]
GO
/****** Object:  StoredProcedure [dbo].[BuscarPorEmail]    Script Date: 04/10/2021 13:54:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[BuscarPorEmail]
	-- Add the parameters for the stored procedure here
	@Email NVARCHAR(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF (@Email = '') THROW 70000, 'No se admite un email vacío', 1;
	

    -- Insert statements for procedure here
	SELECT * FROM Usuarios WHERE Email = @Email;
END
GO
/****** Object:  StoredProcedure [dbo].[Prueba]    Script Date: 04/10/2021 13:54:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Prueba]
	@Uno INT, @Dos INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT @Uno, @Dos
END
GO
/****** Object:  Trigger [dbo].[Email_Vacio]    Script Date: 04/10/2021 13:54:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE TRIGGER [dbo].[Email_Vacio]
   ON  [dbo].[Usuarios]
   INSTEAD OF INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @Email NVARCHAR(50);
    -- Insert statements for trigger here
	SELECT @Email = Email FROM inserted

	IF @Email = '' THROW 50000, 'No se admiten emails vacíos', 1;

	INSERT INTO Usuarios SELECT Email, Password FROM Inserted;
END
GO
ALTER TABLE [dbo].[Usuarios] ENABLE TRIGGER [Email_Vacio]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Categorias"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 102
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Productos"
            Begin Extent = 
               Top = 22
               Left = 302
               Bottom = 152
               Right = 472
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ProductosCompletos'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ProductosCompletos'
GO
USE [master]
GO
ALTER DATABASE [mf0966] SET  READ_WRITE 
GO
