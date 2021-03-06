USE [master]
GO
CREATE DATABASE [reserva]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'reserva', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\reserva.mdf' , SIZE = 4160KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'reserva_log', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\reserva_log.ldf' , SIZE = 1040KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [reserva] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [reserva].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [reserva] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [reserva] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [reserva] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [reserva] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [reserva] SET ARITHABORT OFF 
GO
ALTER DATABASE [reserva] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [reserva] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [reserva] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [reserva] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [reserva] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [reserva] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [reserva] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [reserva] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [reserva] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [reserva] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [reserva] SET  DISABLE_BROKER 
GO
ALTER DATABASE [reserva] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [reserva] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [reserva] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [reserva] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [reserva] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [reserva] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [reserva] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [reserva] SET RECOVERY FULL 
GO
ALTER DATABASE [reserva] SET  MULTI_USER 
GO
ALTER DATABASE [reserva] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [reserva] SET DB_CHAINING OFF 
GO
ALTER DATABASE [reserva] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [reserva] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [reserva]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[deletecancha]
	@cancha_id int
as
update cancha 
set activo = 0, fecha_modificacion = GETDATE()
where cancha_id = @cancha_id









GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[deleteReserva]
	@reserva_id int
as
update reserva 
set activo = 0, fecha_modificacion = GETDATE()
where reserva_id = @reserva_id









GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[deleteUsuario](@usuario_id int)
as
update usuario 
set activo = 0, fecha_modificacion = GETDATE()
where usuario_id = @usuario_id









GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[getCanchaPorId](@cancha_id int)
AS
/*
Obtiene Cancha por ID
exec getCanchaPorId 9
*/
begin
	select c.cancha_descripcion,
	c.Cancha_ImagenUrl,
	c.cancha_nombre,
	c.Cancha_PrecioxHora,
	c.cancha_tipo_id,
	c.cancha_distrito_id,
	tmd.tablamaestradetalle_descripcion TipoCancha,
	tmd2.tablamaestradetalle_descripcion cancha_distrito
	from cancha c inner join tablamaestradetalle tmd
	on tmd.tablamaestradetalle_descripcion_id = c.cancha_tipo_id and tmd.tablamaestra_id = 1 and tmd.activo = 1
	inner join tablamaestradetalle tmd2
	on tmd2.tablamaestradetalle_descripcion_id = c.cancha_distrito_id and tmd2.tablamaestra_id = 2 and tmd2.activo = 1
	where c.cancha_id = @cancha_id
end

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[insertCancha] 
	 @cancha_usuario_id int,
	 @cancha_nombre varchar(100),
	 @cancha_descripcion varchar(200),
	 @cancha_tipo_id int,
	 @cancha_distrito_id int,
	 @cancha_precio decimal(6,2),
	 @cancha_url_imagen varchar(200)

As
INSERT INTO dbo.cancha
           (cancha_usuario_id           ,cancha_nombre
           ,cancha_descripcion          ,cancha_tipo_id			,cancha_distrito_id
		   ,activo						,Cancha_PrecioxHora		,Cancha_ImagenUrl
           ,usuario_creacion			,fecha_creacion)
     VALUES
           (@cancha_usuario_id          ,@cancha_nombre
           ,@cancha_descripcion         ,@cancha_tipo_id,	@cancha_distrito_id        
		   ,1							,@cancha_precio		,@cancha_url_imagen
           ,'master'					,GETDATE())









GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[insertReserva]
	@reserva_fecha datetime, @reserva_horainicio time, @reserva_horafin time,
	@reserva_canchaid int,@reserva_cliente_dni varchar(10), @reserva_cliente_nombre varchar(50),
	@reserva_cliente_apellido varchar(50), @reserva_cliente_email varchar(50),@reserva_cliente_telefono varchar(50),
	@reserva_cliente_celular varchar(12)
as
INSERT INTO [dbo].[reserva]
           ([reserva_fecha]
           ,[reserva_horainicio]
           ,[reserva_horafin]
           ,[reserva_canchaid]
           ,[reserva_cliente_dni]
           ,[reserva_cliente_nombre]
           ,[reserva_cliente_apellido]
           ,[reserva_cliente_email]
           ,[reserva_cliente_telefono]
           ,[reserva_cliente_celular]
           ,[activo]
           ,[usuario_creacion]
           ,[fecha_creacion]
           )
     VALUES
           (@reserva_fecha
           ,@reserva_horainicio
           ,@reserva_horafin
           ,@reserva_canchaid
           ,@reserva_cliente_dni
           ,@reserva_cliente_nombre
           ,@reserva_cliente_apellido
           ,@reserva_cliente_email
           ,@reserva_cliente_telefono
           ,@reserva_cliente_celular
           ,1
           ,'master'
           ,GETDATE()
           )









GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[insertUsuario]
			@usuario_nombre varchar(50)
           ,@usuario_contraseña varchar(50)           ,@usuario_razonsocial varchar(50)
           ,@usuario_ruc varchar(12)           ,@usuario_email varchar(50)
           ,@usuario_telefono varchar(12)           ,@usuario_foto_url varchar(50)
           ,@usuario_presentacion varchar(500)           
as
insert into dbo.usuario
		(
			usuario_nombre 
           ,usuario_contraseña          ,usuario_razonsocial 
           ,usuario_ruc					,usuario_email
           ,usuario_telefono            ,usuario_foto_url 
           ,usuario_presentacion        ,activo 
		   ,fecha_creacion				,usuario_creacion
		   )
values(
			@usuario_nombre
           ,@usuario_contraseña         ,@usuario_razonsocial
           ,@usuario_ruc				,@usuario_email
           ,@usuario_telefono           ,@usuario_foto_url
           ,@usuario_presentacion       ,1
		   ,GETDATE()					,'master'
)









GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[ListarReservasByCalendar](
@cancha_Id int,
@Fecha_Inicio varchar(20),
@Fecha_Fin varchar(20)
)
AS
/*
Descripcion: Lista todos los eventos para el calendario
EXEC ListarReservasByCalendar 9,'20170801','20170803'
*/
BEGIN
select r.reserva_id IdReserva
,convert(varchar(20),r.reserva_fecha_inicio,20) FechaInicio
,convert(varchar(20),r.reserva_fecha_fin,20) FechaFin
,r.reserva_descripcion Titulo
,r.reserva_id_estado IdEstado
,r.reserva_Cliente_nombre ClienteNombre
,r.reserva_canchaid IdCancha
from reserva r
where r.reserva_canchaid = @cancha_Id
and convert (varchar(30),r.reserva_fecha_inicio,112) >= @Fecha_Inicio
and convert (varchar(30),r.reserva_fecha_fin,112) <= @Fecha_Fin
END


GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[selectAllCancha]
as
select c.cancha_id		,c.cancha_nombre		,c.cancha_descripcion
,c.cancha_usuario_id	,c.Cancha_ImagenUrl		,c.Cancha_PrecioxHora
,c.cancha_usuario_id	,c.cancha_tipo_id		,c.cancha_distrito_id,
tmd.tablamaestradetalle_descripcion cancha_tipo,
tmd2.tablamaestradetalle_descripcion cancha_distrito
from dbo.cancha c
inner join tablamaestradetalle tmd on tmd.tablamaestradetalle_descripcion_id = c.cancha_tipo_id and tmd.tablamaestra_id=1
inner join tablamaestradetalle tmd2 on tmd2.tablamaestradetalle_descripcion_id = c.cancha_distrito_id and tmd2.tablamaestra_id=2
where c.activo =1



GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[selectAllCanchaxDistritoId]
	@cancha_distrito_id int
as
select c.cancha_id		,c.cancha_nombre		,c.cancha_descripcion
,c.cancha_usuario_id	,c.Cancha_ImagenUrl		,c.Cancha_PrecioxHora
,c.cancha_usuario_id	,c.cancha_tipo_id		,c.cancha_distrito_id,
tmd.tablamaestradetalle_descripcion cancha_tipo,
tmd2.tablamaestradetalle_descripcion cancha_distrito
from dbo.cancha c
inner join tablamaestradetalle tmd on tmd.tablamaestradetalle_descripcion_id = c.cancha_tipo_id and tmd.tablamaestra_id=1
inner join tablamaestradetalle tmd2 on tmd2.tablamaestradetalle_descripcion_id = c.cancha_distrito_id and tmd2.tablamaestra_id=2
where c.cancha_distrito_id = @cancha_distrito_id and c.activo =1








GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[selectAllCanchaxDistritoIdDistritoName]
	@cancha_nombre varchar(100), @cancha_distrito_id int
as
select c.cancha_id		,c.cancha_nombre		,c.cancha_descripcion
,c.cancha_usuario_id	,c.Cancha_ImagenUrl		,c.Cancha_PrecioxHora
,c.cancha_usuario_id	,c.cancha_tipo_id		,c.cancha_distrito_id,
tmd.tablamaestradetalle_descripcion cancha_tipo,
tmd2.tablamaestradetalle_descripcion cancha_distrito
from dbo.cancha c
inner join tablamaestradetalle tmd on tmd.tablamaestradetalle_descripcion_id = c.cancha_tipo_id and tmd.tablamaestra_id=1
inner join tablamaestradetalle tmd2 on tmd2.tablamaestradetalle_descripcion_id = c.cancha_distrito_id and tmd2.tablamaestra_id=2
where c.cancha_nombre like '%'+@cancha_nombre+'%' and c.cancha_distrito_id = @cancha_distrito_id and c.activo =1















GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[selectAllCanchaxNombreCancha]
	@cancha_nombre varchar(50)
as
select c.cancha_id		,c.cancha_nombre		,c.cancha_descripcion
,c.cancha_usuario_id	,c.Cancha_ImagenUrl		,c.Cancha_PrecioxHora
,c.cancha_usuario_id	,c.cancha_tipo_id		,c.cancha_distrito_id,
tmd.tablamaestradetalle_descripcion cancha_tipo,
tmd2.tablamaestradetalle_descripcion cancha_distrito
from dbo.cancha c
inner join tablamaestradetalle tmd on tmd.tablamaestradetalle_descripcion_id = c.cancha_tipo_id and tmd.tablamaestra_id=1
inner join tablamaestradetalle tmd2 on tmd2.tablamaestradetalle_descripcion_id = c.cancha_distrito_id and tmd2.tablamaestra_id=2
where c.cancha_nombre like '%'+@cancha_nombre+'%' and c.activo =1








GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[selectAllCanchaxUsuarioId]
	@cancha_usuario_id int
as
select c.cancha_id		,c.cancha_nombre		,c.cancha_descripcion
,c.cancha_usuario_id	,c.Cancha_ImagenUrl		,c.Cancha_PrecioxHora
,c.cancha_usuario_id	,c.cancha_tipo_id		,c.cancha_distrito_id,
tmd.tablamaestradetalle_descripcion cancha_tipo,
tmd2.tablamaestradetalle_descripcion cancha_distrito
from dbo.cancha c
inner join tablamaestradetalle tmd on tmd.tablamaestradetalle_descripcion_id = c.cancha_tipo_id and tmd.tablamaestra_id=1
inner join tablamaestradetalle tmd2 on tmd2.tablamaestradetalle_descripcion_id = c.cancha_distrito_id and tmd2.tablamaestra_id=2
where c.cancha_usuario_id = @cancha_usuario_id and c.activo =1








GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[selectAllDistrito]
as
select c.tablamaestradetalle_descripcion_id cancha_distrito_id,
c.tablamaestradetalle_descripcion cancha_distrito
from dbo.tablamaestradetalle c
where c.tablamaestra_id =2



GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[selectAllReserva]
as
select * from dbo.reserva









GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[selectAllServicio]
as
select c.tablamaestradetalle_descripcion_id cancha_servicio_id,
c.tablamaestradetalle_descripcion cancha_servicio
from dbo.tablamaestradetalle c
where c.tablamaestra_id =3



GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[selectAllTipoCancha]
as
select c.tablamaestradetalle_descripcion_id cancha_tipo_id,
c.tablamaestradetalle_descripcion cancha_tipo
from dbo.tablamaestradetalle c
where c.tablamaestra_id =1



GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[selectAllUsuario]
as
select * from dbo.usuario









GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[selectCancha] @cancha_nombre int
as
select * from dbo.cancha 
where cancha_nombre = @cancha_nombre









GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[selectReserva]
	@reserva_id int
as
select * from dbo.reserva
where reserva_id = @reserva_id









GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[selectUsuario] (@usuario_nombre int)
as
select * from dbo.usuario
where usuario_nombre = @usuario_nombre









GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE procedure [dbo].[updateCancha](
	@cancha_id int,
	@cancha_usuario_id int, @cancha_nombre varchar(100),
	@cancha_descripcion varchar(200), @cancha_tipo_id int)
As
update cancha
set 		
            cancha_usuario_id = @cancha_usuario_id           ,cancha_nombre = @cancha_nombre
           ,cancha_descripcion = @cancha_descripcion           ,cancha_tipo_id = @cancha_tipo_id
           ,fecha_modificacion = GETDATE()		   
where cancha_id = @cancha_id









GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[updateReserva]
	@reserva_id int, @reserva_fecha datetime, @reserva_horainicio time, @reserva_horafin time,
	@reserva_canchaid int,@reserva_cliente_dni varchar(10), @reserva_cliente_nombre varchar(50),
	@reserva_cliente_apellido varchar(50), @reserva_cliente_email varchar(50),@reserva_cliente_telefono varchar(50),
	@reserva_cliente_celular varchar(12)
as
UPDATE [dbo].[reserva]
   SET [reserva_fecha] = @reserva_fecha
      ,[reserva_horainicio] = @reserva_horainicio
      ,[reserva_horafin] = @reserva_horafin
      ,[reserva_canchaid] = @reserva_canchaid
      ,[reserva_cliente_dni] = @reserva_cliente_dni
      ,[reserva_cliente_nombre] = @reserva_cliente_nombre
      ,[reserva_cliente_apellido] = @reserva_cliente_apellido
      ,[reserva_cliente_email] = @reserva_cliente_email
      ,[reserva_cliente_telefono] = @reserva_cliente_telefono
      ,[reserva_cliente_celular] = @reserva_cliente_celular
      ,[fecha_modificacion] = GETDATE()
 WHERE reserva_id = @reserva_id









GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[updateUsuario]
			@usuario_id int						,@usuario_nombre varchar(50)
           ,@usuario_contraseña varchar(50)     ,@usuario_razonsocial varchar(50)
           ,@usuario_ruc varchar(12)			,@usuario_email varchar(50)
           ,@usuario_telefono varchar(12)       ,@usuario_foto_url varchar(50)
           ,@usuario_presentacion varchar(500)           
as
update usuario
set
			usuario_nombre =@usuario_nombre
           ,usuario_contraseña =@usuario_contraseña         ,usuario_razonsocial =@usuario_razonsocial
           ,usuario_ruc =@usuario_ruc						,usuario_email =@usuario_email
           ,usuario_telefono =@usuario_telefono				,usuario_foto_url =@usuario_foto_url
           ,usuario_presentacion =@usuario_presentacion		,fecha_modificacion =GETDATE()
where
usuario_id  = @usuario_id









GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_InsertaReserva](
@reserva_fecha_inicio datetime,
@reserva_fecha_fin datetime,
@reserva_canchaid int,
@reserva_descripcion varchar(250),
@reserva_cliente_dni varchar(10),
@reserva_cliente_nombre varchar(250),
@reserva_cliente_email varchar(50),
@reserva_cliente_celular varchar(20),
@reserva_acepta_terminos bit,
@reserva_tipo_pago varchar(10),
@reserva_precio_total decimal(10,2)
)
AS
BEGIN
	insert into reserva(
	reserva_fecha_inicio,
	reserva_fecha_fin,
	reserva_canchaid,
	reserva_descripcion,
	reserva_cliente_dni,
	reserva_cliente_nombre,
	reserva_cliente_email,
	reserva_cliente_celular,
	reserva_acepta_terminos,
	reserva_tipo_pago,
	reserva_precio_total,
	activo,
	fecha_creacion,
	usuario_creacion,
	reserva_id_estado	
	)
	values(
	@reserva_fecha_inicio,
	@reserva_fecha_fin,
	@reserva_canchaid,
	@reserva_descripcion ,
	@reserva_cliente_dni ,
	@reserva_cliente_nombre ,
	@reserva_cliente_email ,
	@reserva_cliente_celular ,
	@reserva_acepta_terminos ,
	@reserva_tipo_pago ,
	@reserva_precio_total,
	1,
	getdate(),
	'master',
	1	
	)
END













GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[cancha](
	[cancha_id] [int] IDENTITY(1,1) NOT NULL,
	[cancha_usuario_id] [int] NOT NULL,
	[cancha_nombre] [varchar](100) NULL,
	[cancha_descripcion] [varchar](200) NULL,
	[cancha_tipo_id] [int] NOT NULL,
	[cancha_distrito_id] [int] NULL,
	[activo] [bit] NOT NULL,
	[usuario_creacion] [varchar](50) NULL,
	[usuario_modificacion] [varchar](50) NULL,
	[fecha_creacion] [datetime] NULL,
	[fecha_modificacion] [datetime] NULL,
	[Cancha_PrecioxHora] [decimal](6, 2) NULL,
	[Cancha_ImagenUrl] [varchar](200) NULL,
 CONSTRAINT [PK_cancha] PRIMARY KEY CLUSTERED 
(
	[cancha_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[reserva](
	[reserva_id] [int] IDENTITY(1,1) NOT NULL,
	[reserva_fecha_inicio] [datetime] NULL,
	[reserva_fecha_fin] [datetime] NULL,
	[reserva_canchaid] [int] NULL,
	[reserva_descripcion] [varchar](250) NULL,
	[reserva_cliente_dni] [varchar](10) NOT NULL,
	[reserva_cliente_nombre] [varchar](50) NULL,
	[reserva_cliente_apellido] [varchar](50) NULL,
	[reserva_cliente_email] [varchar](50) NULL,
	[reserva_cliente_telefono] [varchar](12) NULL,
	[reserva_cliente_celular] [varchar](12) NULL,
	[reserva_cliente_ruc] [varchar](20) NULL,
	[reserva_con_factura] [bit] NULL,
	[reserva_acepta_terminos] [bit] NULL,
	[reserva_tipo_pago] [varchar](10) NULL,
	[reserva_precio_total] [decimal](10, 2) NULL,
	[reserva_id_estado] [int] NULL,
	[activo] [bit] NULL,
	[usuario_creacion] [varchar](50) NULL,
	[usuario_modificacion] [varchar](50) NULL,
	[fecha_creacion] [datetime] NULL,
	[fecha_modificacion] [datetime] NULL,
 CONSTRAINT [PK_reserva] PRIMARY KEY CLUSTERED 
(
	[reserva_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tabla_maestra](
	[tablamaestra_id] [int] IDENTITY(1,1) NOT NULL,
	[tablamaestra_descripcion] [varchar](100) NULL,
	[usuario_creacion] [varchar](50) NULL,
	[usuario_modificacion] [varchar](50) NULL,
	[fecha_creacion] [datetime] NULL,
	[fecha_modificacion] [datetime] NULL,
	[activo] [bit] NOT NULL,
 CONSTRAINT [PK_tabla_maestra] PRIMARY KEY CLUSTERED 
(
	[tablamaestra_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tablamaestradetalle](
	[tablamaestradetalle_id] [int] IDENTITY(1,1) NOT NULL,
	[tablamaestra_id] [int] NOT NULL,
	[tablamaestradetalle_descripcion_id] [int] NULL,
	[tablamaestradetalle_descripcion] [varchar](100) NULL,
	[tablamaestradetalle_orden] [int] NULL,
	[usuario_creacion] [varchar](50) NULL,
	[usuario_modificacion] [varchar](50) NULL,
	[fecha_creacion] [datetime] NULL,
	[fecha_modificacion] [datetime] NULL,
	[activo] [bit] NOT NULL,
 CONSTRAINT [PK_tablamaestradetalle] PRIMARY KEY CLUSTERED 
(
	[tablamaestradetalle_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[usuario](
	[usuario_id] [int] IDENTITY(1,1) NOT NULL,
	[usuario_nombre] [varchar](50) NULL,
	[usuario_contraseña] [varchar](50) NULL,
	[usuario_razonsocial] [varchar](50) NULL,
	[usuario_ruc] [varchar](12) NULL,
	[usuario_email] [varchar](50) NULL,
	[usuario_telefono] [varchar](12) NULL,
	[usuario_foto_url] [varchar](50) NULL,
	[usuario_presentacion] [varchar](500) NULL,
	[activo] [bit] NOT NULL,
	[usuario_creacion] [varchar](50) NULL,
	[usuario_modificacion] [varchar](50) NULL,
	[fecha_creacion] [datetime] NULL,
	[fecha_modificacion] [datetime] NULL,
 CONSTRAINT [PK_usuario] PRIMARY KEY CLUSTERED 
(
	[usuario_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[cancha] ON 

INSERT [dbo].[cancha] ([cancha_id], [cancha_usuario_id], [cancha_nombre], [cancha_descripcion], [cancha_tipo_id], [cancha_distrito_id], [activo], [usuario_creacion], [usuario_modificacion], [fecha_creacion], [fecha_modificacion], [Cancha_PrecioxHora], [Cancha_ImagenUrl]) VALUES (1, 1, N'La 7', N'(Colegio San Juan Macias)', 1, 2, 1, N'master', NULL, CAST(0x0000A7BF017C8ED1 AS DateTime), NULL, CAST(80.00 AS Decimal(6, 2)), N'1.jpg')
INSERT [dbo].[cancha] ([cancha_id], [cancha_usuario_id], [cancha_nombre], [cancha_descripcion], [cancha_tipo_id], [cancha_distrito_id], [activo], [usuario_creacion], [usuario_modificacion], [fecha_creacion], [fecha_modificacion], [Cancha_PrecioxHora], [Cancha_ImagenUrl]) VALUES (2, 1, N'La 10', N'Campo deportivo Exclusivo', 1, 1, 1, N'master', NULL, CAST(0x0000A7BF017C9C91 AS DateTime), NULL, CAST(100.00 AS Decimal(6, 2)), N'2.jpg')
INSERT [dbo].[cancha] ([cancha_id], [cancha_usuario_id], [cancha_nombre], [cancha_descripcion], [cancha_tipo_id], [cancha_distrito_id], [activo], [usuario_creacion], [usuario_modificacion], [fecha_creacion], [fecha_modificacion], [Cancha_PrecioxHora], [Cancha_ImagenUrl]) VALUES (3, 2, N'Complejo Dep. La 9', N'Full Torneos', 1, 3, 1, N'master', NULL, CAST(0x0000A7BF017CED24 AS DateTime), NULL, CAST(120.00 AS Decimal(6, 2)), N'3.jpg')
INSERT [dbo].[cancha] ([cancha_id], [cancha_usuario_id], [cancha_nombre], [cancha_descripcion], [cancha_tipo_id], [cancha_distrito_id], [activo], [usuario_creacion], [usuario_modificacion], [fecha_creacion], [fecha_modificacion], [Cancha_PrecioxHora], [Cancha_ImagenUrl]) VALUES (4, 1, N'Canchitas VIP', N'Tu mejor elección para el deporte', 4, 6, 1, N'master', NULL, CAST(0x0000A7C100039943 AS DateTime), NULL, CAST(150.00 AS Decimal(6, 2)), N'4.jpg')
INSERT [dbo].[cancha] ([cancha_id], [cancha_usuario_id], [cancha_nombre], [cancha_descripcion], [cancha_tipo_id], [cancha_distrito_id], [activo], [usuario_creacion], [usuario_modificacion], [fecha_creacion], [fecha_modificacion], [Cancha_PrecioxHora], [Cancha_ImagenUrl]) VALUES (5, 1, N'Villa Sport', N'Los Precursores Deport', 7, 10, 1, N'master', NULL, CAST(0x0000A7C10003AC26 AS DateTime), NULL, CAST(160.00 AS Decimal(6, 2)), N'5.jpg')
INSERT [dbo].[cancha] ([cancha_id], [cancha_usuario_id], [cancha_nombre], [cancha_descripcion], [cancha_tipo_id], [cancha_distrito_id], [activo], [usuario_creacion], [usuario_modificacion], [fecha_creacion], [fecha_modificacion], [Cancha_PrecioxHora], [Cancha_ImagenUrl]) VALUES (6, 2, N'La Bombonera', N'Más que deporte', 6, 8, 1, N'master', NULL, CAST(0x0000A7C1000448AF AS DateTime), NULL, CAST(100.00 AS Decimal(6, 2)), N'6.jpg')
INSERT [dbo].[cancha] ([cancha_id], [cancha_usuario_id], [cancha_nombre], [cancha_descripcion], [cancha_tipo_id], [cancha_distrito_id], [activo], [usuario_creacion], [usuario_modificacion], [fecha_creacion], [fecha_modificacion], [Cancha_PrecioxHora], [Cancha_ImagenUrl]) VALUES (7, 1, N'La Cantera F7', N'Somos deportistas', 2, 1, 1, N'master', NULL, CAST(0x0000A7C3001B39D3 AS DateTime), NULL, CAST(120.00 AS Decimal(6, 2)), N'7.jpg')
INSERT [dbo].[cancha] ([cancha_id], [cancha_usuario_id], [cancha_nombre], [cancha_descripcion], [cancha_tipo_id], [cancha_distrito_id], [activo], [usuario_creacion], [usuario_modificacion], [fecha_creacion], [fecha_modificacion], [Cancha_PrecioxHora], [Cancha_ImagenUrl]) VALUES (9, 2, N'Complejo de Futsal', N'Futsal', 1, 3, 1, N'master', NULL, CAST(0x0000A7C300000000 AS DateTime), NULL, CAST(100.00 AS Decimal(6, 2)), N'8.jpg')
INSERT [dbo].[cancha] ([cancha_id], [cancha_usuario_id], [cancha_nombre], [cancha_descripcion], [cancha_tipo_id], [cancha_distrito_id], [activo], [usuario_creacion], [usuario_modificacion], [fecha_creacion], [fecha_modificacion], [Cancha_PrecioxHora], [Cancha_ImagenUrl]) VALUES (10, 1, N'wewerewrew12121', N'123123123123', 4, 2, 1, N'master', NULL, CAST(0x0000A7C500394053 AS DateTime), NULL, CAST(0.00 AS Decimal(6, 2)), N'20170804032826_wewerewrew12121_astronave.jpg')
INSERT [dbo].[cancha] ([cancha_id], [cancha_usuario_id], [cancha_nombre], [cancha_descripcion], [cancha_tipo_id], [cancha_distrito_id], [activo], [usuario_creacion], [usuario_modificacion], [fecha_creacion], [fecha_modificacion], [Cancha_PrecioxHora], [Cancha_ImagenUrl]) VALUES (11, 1, N'sdf', N'sdfsdf', 1, 10, 1, N'master', NULL, CAST(0x0000A7C5003C4F74 AS DateTime), NULL, CAST(6.80 AS Decimal(6, 2)), N'20170804033911_sdf_124.png')
INSERT [dbo].[cancha] ([cancha_id], [cancha_usuario_id], [cancha_nombre], [cancha_descripcion], [cancha_tipo_id], [cancha_distrito_id], [activo], [usuario_creacion], [usuario_modificacion], [fecha_creacion], [fecha_modificacion], [Cancha_PrecioxHora], [Cancha_ImagenUrl]) VALUES (12, 1, N'wefwerw', N'ewrwer', 1, 1, 1, N'master', NULL, CAST(0x0000A7C5003D3860 AS DateTime), NULL, CAST(8.50 AS Decimal(6, 2)), N'image_no_found.png')
INSERT [dbo].[cancha] ([cancha_id], [cancha_usuario_id], [cancha_nombre], [cancha_descripcion], [cancha_tipo_id], [cancha_distrito_id], [activo], [usuario_creacion], [usuario_modificacion], [fecha_creacion], [fecha_modificacion], [Cancha_PrecioxHora], [Cancha_ImagenUrl]) VALUES (13, 1, N'ssfsf', N'sdfsdf', 4, 10, 1, N'master', NULL, CAST(0x0000A7C5003F27DB AS DateTime), NULL, CAST(100.00 AS Decimal(6, 2)), N'image_no_found.png')
SET IDENTITY_INSERT [dbo].[cancha] OFF
SET IDENTITY_INSERT [dbo].[reserva] ON 

INSERT [dbo].[reserva] ([reserva_id], [reserva_fecha_inicio], [reserva_fecha_fin], [reserva_canchaid], [reserva_descripcion], [reserva_cliente_dni], [reserva_cliente_nombre], [reserva_cliente_apellido], [reserva_cliente_email], [reserva_cliente_telefono], [reserva_cliente_celular], [reserva_cliente_ruc], [reserva_con_factura], [reserva_acepta_terminos], [reserva_tipo_pago], [reserva_precio_total], [reserva_id_estado], [activo], [usuario_creacion], [usuario_modificacion], [fecha_creacion], [fecha_modificacion]) VALUES (1, CAST(0x0000A7C400B54640 AS DateTime), CAST(0x0000A7C400C5C100 AS DateTime), 9, N'Titulo descripc', N'44602755', N'Joel Panocca', N'Panocca', N'panocca@gmail.com', N'962288169', N'962288169', N'446027552', 0, 1, N'SO', NULL, 1, 1, N'admin', NULL, CAST(0x0000A7C400000000 AS DateTime), NULL)
INSERT [dbo].[reserva] ([reserva_id], [reserva_fecha_inicio], [reserva_fecha_fin], [reserva_canchaid], [reserva_descripcion], [reserva_cliente_dni], [reserva_cliente_nombre], [reserva_cliente_apellido], [reserva_cliente_email], [reserva_cliente_telefono], [reserva_cliente_celular], [reserva_cliente_ruc], [reserva_con_factura], [reserva_acepta_terminos], [reserva_tipo_pago], [reserva_precio_total], [reserva_id_estado], [activo], [usuario_creacion], [usuario_modificacion], [fecha_creacion], [fecha_modificacion]) VALUES (2, CAST(0x0000A7C600735B40 AS DateTime), CAST(0x0000A7C60083D600 AS DateTime), 9, N'Resrva Titulo', N'44602755', N'joel', NULL, N'joel@gmail.com', NULL, N'962288169', NULL, NULL, 1, N'PagoEfecti', CAST(160.00 AS Decimal(10, 2)), NULL, 1, N'master', NULL, CAST(0x0000A7C4011F88D9 AS DateTime), NULL)
INSERT [dbo].[reserva] ([reserva_id], [reserva_fecha_inicio], [reserva_fecha_fin], [reserva_canchaid], [reserva_descripcion], [reserva_cliente_dni], [reserva_cliente_nombre], [reserva_cliente_apellido], [reserva_cliente_email], [reserva_cliente_telefono], [reserva_cliente_celular], [reserva_cliente_ruc], [reserva_con_factura], [reserva_acepta_terminos], [reserva_tipo_pago], [reserva_precio_total], [reserva_id_estado], [activo], [usuario_creacion], [usuario_modificacion], [fecha_creacion], [fecha_modificacion]) VALUES (3, CAST(0x0000A7C50083D600 AS DateTime), CAST(0x0000A7C5009450C0 AS DateTime), 9, N'Nuevo Mundo', N'54214521', N'Cristian', NULL, N'cosorio@nm.com', NULL, N'96565211', NULL, NULL, 1, N'SO', CAST(160.00 AS Decimal(10, 2)), 1, 1, N'master', NULL, CAST(0x0000A7C40121451C AS DateTime), NULL)
INSERT [dbo].[reserva] ([reserva_id], [reserva_fecha_inicio], [reserva_fecha_fin], [reserva_canchaid], [reserva_descripcion], [reserva_cliente_dni], [reserva_cliente_nombre], [reserva_cliente_apellido], [reserva_cliente_email], [reserva_cliente_telefono], [reserva_cliente_celular], [reserva_cliente_ruc], [reserva_con_factura], [reserva_acepta_terminos], [reserva_tipo_pago], [reserva_precio_total], [reserva_id_estado], [activo], [usuario_creacion], [usuario_modificacion], [fecha_creacion], [fecha_modificacion]) VALUES (4, CAST(0x0000A7C500A4CB80 AS DateTime), CAST(0x0000A7C500B54640 AS DateTime), 9, N'Sport La Botella', N'4512422', N'Luis Fiestas', NULL, N'lfiestas@gmail.com', NULL, N'95841111', NULL, NULL, 1, N'Efectivo', CAST(160.00 AS Decimal(10, 2)), 1, 1, N'master', NULL, CAST(0x0000A7C4012172C1 AS DateTime), NULL)
INSERT [dbo].[reserva] ([reserva_id], [reserva_fecha_inicio], [reserva_fecha_fin], [reserva_canchaid], [reserva_descripcion], [reserva_cliente_dni], [reserva_cliente_nombre], [reserva_cliente_apellido], [reserva_cliente_email], [reserva_cliente_telefono], [reserva_cliente_celular], [reserva_cliente_ruc], [reserva_con_factura], [reserva_acepta_terminos], [reserva_tipo_pago], [reserva_precio_total], [reserva_id_estado], [activo], [usuario_creacion], [usuario_modificacion], [fecha_creacion], [fecha_modificacion]) VALUES (5, CAST(0x0000A7C500C5C100 AS DateTime), CAST(0x0000A7C500D63BC0 AS DateTime), 9, N'Team Nuevo Mundo', N'46124578', N'Andres Panocca', NULL, N'panocca@gmail.com', NULL, N'965522154', NULL, NULL, 1, N'Efectivo', CAST(160.00 AS Decimal(10, 2)), 1, 1, N'master', NULL, CAST(0x0000A7C40129BBA6 AS DateTime), NULL)
INSERT [dbo].[reserva] ([reserva_id], [reserva_fecha_inicio], [reserva_fecha_fin], [reserva_canchaid], [reserva_descripcion], [reserva_cliente_dni], [reserva_cliente_nombre], [reserva_cliente_apellido], [reserva_cliente_email], [reserva_cliente_telefono], [reserva_cliente_celular], [reserva_cliente_ruc], [reserva_con_factura], [reserva_acepta_terminos], [reserva_tipo_pago], [reserva_precio_total], [reserva_id_estado], [activo], [usuario_creacion], [usuario_modificacion], [fecha_creacion], [fecha_modificacion]) VALUES (6, CAST(0x0000A7C500E6B680 AS DateTime), CAST(0x0000A7C500F73140 AS DateTime), 9, N'Team best', N'454212121', N'Roberto', NULL, N'panocca@gmail.com', NULL, N'56565656', NULL, NULL, 1, N'Efectivo', CAST(160.00 AS Decimal(10, 2)), 1, 1, N'master', NULL, CAST(0x0000A7C4012B5981 AS DateTime), NULL)
INSERT [dbo].[reserva] ([reserva_id], [reserva_fecha_inicio], [reserva_fecha_fin], [reserva_canchaid], [reserva_descripcion], [reserva_cliente_dni], [reserva_cliente_nombre], [reserva_cliente_apellido], [reserva_cliente_email], [reserva_cliente_telefono], [reserva_cliente_celular], [reserva_cliente_ruc], [reserva_con_factura], [reserva_acepta_terminos], [reserva_tipo_pago], [reserva_precio_total], [reserva_id_estado], [activo], [usuario_creacion], [usuario_modificacion], [fecha_creacion], [fecha_modificacion]) VALUES (7, CAST(0x0000A7C50107AC00 AS DateTime), CAST(0x0000A7C5011826C0 AS DateTime), 9, N'Reserva Naranja', N'44422255', N'Alberto Fuji', NULL, N'panocca@gmail.com', NULL, N'962288169', NULL, NULL, 1, N'Efectivo', CAST(100.00 AS Decimal(10, 2)), 1, 1, N'master', NULL, CAST(0x0000A7C5000305E0 AS DateTime), NULL)
INSERT [dbo].[reserva] ([reserva_id], [reserva_fecha_inicio], [reserva_fecha_fin], [reserva_canchaid], [reserva_descripcion], [reserva_cliente_dni], [reserva_cliente_nombre], [reserva_cliente_apellido], [reserva_cliente_email], [reserva_cliente_telefono], [reserva_cliente_celular], [reserva_cliente_ruc], [reserva_con_factura], [reserva_acepta_terminos], [reserva_tipo_pago], [reserva_precio_total], [reserva_id_estado], [activo], [usuario_creacion], [usuario_modificacion], [fecha_creacion], [fecha_modificacion]) VALUES (8, CAST(0x0000A7C600A4CB80 AS DateTime), CAST(0x0000A7C600BD83A0 AS DateTime), 9, N'Reserva Naranja', N'44422255', N'Alberto Fuji', NULL, N'panocca@gmail.com', NULL, N'962288169', NULL, NULL, 1, N'Efectivo', CAST(100.00 AS Decimal(10, 2)), 1, 1, N'master', NULL, CAST(0x0000A7C500039010 AS DateTime), NULL)
INSERT [dbo].[reserva] ([reserva_id], [reserva_fecha_inicio], [reserva_fecha_fin], [reserva_canchaid], [reserva_descripcion], [reserva_cliente_dni], [reserva_cliente_nombre], [reserva_cliente_apellido], [reserva_cliente_email], [reserva_cliente_telefono], [reserva_cliente_celular], [reserva_cliente_ruc], [reserva_con_factura], [reserva_acepta_terminos], [reserva_tipo_pago], [reserva_precio_total], [reserva_id_estado], [activo], [usuario_creacion], [usuario_modificacion], [fecha_creacion], [fecha_modificacion]) VALUES (9, CAST(0x0000A7C600C5C100 AS DateTime), CAST(0x0000A7C600D63BC0 AS DateTime), 9, N'Reserva Crema ', N'45451254', N'jose', NULL, N'panocca@gmail.com', NULL, N'962288169', NULL, NULL, 1, N'efectivo', CAST(100.00 AS Decimal(10, 2)), 1, 1, N'master', NULL, CAST(0x0000A7C500041A8B AS DateTime), NULL)
INSERT [dbo].[reserva] ([reserva_id], [reserva_fecha_inicio], [reserva_fecha_fin], [reserva_canchaid], [reserva_descripcion], [reserva_cliente_dni], [reserva_cliente_nombre], [reserva_cliente_apellido], [reserva_cliente_email], [reserva_cliente_telefono], [reserva_cliente_celular], [reserva_cliente_ruc], [reserva_con_factura], [reserva_acepta_terminos], [reserva_tipo_pago], [reserva_precio_total], [reserva_id_estado], [activo], [usuario_creacion], [usuario_modificacion], [fecha_creacion], [fecha_modificacion]) VALUES (10, CAST(0x0000A7C600CDFE60 AS DateTime), CAST(0x0000A7C600D63BC0 AS DateTime), 1, N'434342', N'23424', N'ewew', NULL, N'234@few.com', NULL, N'234234', NULL, NULL, 1, N'23324234', CAST(0.00 AS Decimal(10, 2)), 1, 1, N'master', NULL, CAST(0x0000A7C5002310BB AS DateTime), NULL)
INSERT [dbo].[reserva] ([reserva_id], [reserva_fecha_inicio], [reserva_fecha_fin], [reserva_canchaid], [reserva_descripcion], [reserva_cliente_dni], [reserva_cliente_nombre], [reserva_cliente_apellido], [reserva_cliente_email], [reserva_cliente_telefono], [reserva_cliente_celular], [reserva_cliente_ruc], [reserva_con_factura], [reserva_acepta_terminos], [reserva_tipo_pago], [reserva_precio_total], [reserva_id_estado], [activo], [usuario_creacion], [usuario_modificacion], [fecha_creacion], [fecha_modificacion]) VALUES (11, CAST(0x0000A7C600B54640 AS DateTime), CAST(0x0000A7C600BD83A0 AS DateTime), 10, N'234243', N'213123', N'1231231', NULL, N'123@werer.com', NULL, N'123123', NULL, NULL, 1, N'234', CAST(0.00 AS Decimal(10, 2)), 1, 1, N'master', NULL, CAST(0x0000A7C5003968E9 AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[reserva] OFF
SET IDENTITY_INSERT [dbo].[tabla_maestra] ON 

INSERT [dbo].[tabla_maestra] ([tablamaestra_id], [tablamaestra_descripcion], [usuario_creacion], [usuario_modificacion], [fecha_creacion], [fecha_modificacion], [activo]) VALUES (1, N'Tipo_cancha', N'master', NULL, NULL, NULL, 1)
INSERT [dbo].[tabla_maestra] ([tablamaestra_id], [tablamaestra_descripcion], [usuario_creacion], [usuario_modificacion], [fecha_creacion], [fecha_modificacion], [activo]) VALUES (2, N'Distrito', N'master', NULL, NULL, NULL, 1)
INSERT [dbo].[tabla_maestra] ([tablamaestra_id], [tablamaestra_descripcion], [usuario_creacion], [usuario_modificacion], [fecha_creacion], [fecha_modificacion], [activo]) VALUES (3, N'Servicios', N'master', NULL, NULL, NULL, 1)
SET IDENTITY_INSERT [dbo].[tabla_maestra] OFF
SET IDENTITY_INSERT [dbo].[tablamaestradetalle] ON 

INSERT [dbo].[tablamaestradetalle] ([tablamaestradetalle_id], [tablamaestra_id], [tablamaestradetalle_descripcion_id], [tablamaestradetalle_descripcion], [tablamaestradetalle_orden], [usuario_creacion], [usuario_modificacion], [fecha_creacion], [fecha_modificacion], [activo]) VALUES (1, 1, 1, N'5x5', 1, N'master', NULL, NULL, NULL, 1)
INSERT [dbo].[tablamaestradetalle] ([tablamaestradetalle_id], [tablamaestra_id], [tablamaestradetalle_descripcion_id], [tablamaestradetalle_descripcion], [tablamaestradetalle_orden], [usuario_creacion], [usuario_modificacion], [fecha_creacion], [fecha_modificacion], [activo]) VALUES (2, 1, 2, N'6x6', 2, N'master', NULL, NULL, NULL, 1)
INSERT [dbo].[tablamaestradetalle] ([tablamaestradetalle_id], [tablamaestra_id], [tablamaestradetalle_descripcion_id], [tablamaestradetalle_descripcion], [tablamaestradetalle_orden], [usuario_creacion], [usuario_modificacion], [fecha_creacion], [fecha_modificacion], [activo]) VALUES (3, 1, 3, N'7x7', 3, N'master', NULL, NULL, NULL, 1)
INSERT [dbo].[tablamaestradetalle] ([tablamaestradetalle_id], [tablamaestra_id], [tablamaestradetalle_descripcion_id], [tablamaestradetalle_descripcion], [tablamaestradetalle_orden], [usuario_creacion], [usuario_modificacion], [fecha_creacion], [fecha_modificacion], [activo]) VALUES (4, 1, 4, N'8x8', 4, N'master', NULL, NULL, NULL, 1)
INSERT [dbo].[tablamaestradetalle] ([tablamaestradetalle_id], [tablamaestra_id], [tablamaestradetalle_descripcion_id], [tablamaestradetalle_descripcion], [tablamaestradetalle_orden], [usuario_creacion], [usuario_modificacion], [fecha_creacion], [fecha_modificacion], [activo]) VALUES (5, 1, 5, N'9x9', 5, N'master', NULL, NULL, NULL, 1)
INSERT [dbo].[tablamaestradetalle] ([tablamaestradetalle_id], [tablamaestra_id], [tablamaestradetalle_descripcion_id], [tablamaestradetalle_descripcion], [tablamaestradetalle_orden], [usuario_creacion], [usuario_modificacion], [fecha_creacion], [fecha_modificacion], [activo]) VALUES (6, 1, 6, N'10x10', 6, N'master', NULL, NULL, NULL, 1)
INSERT [dbo].[tablamaestradetalle] ([tablamaestradetalle_id], [tablamaestra_id], [tablamaestradetalle_descripcion_id], [tablamaestradetalle_descripcion], [tablamaestradetalle_orden], [usuario_creacion], [usuario_modificacion], [fecha_creacion], [fecha_modificacion], [activo]) VALUES (7, 1, 7, N'11x11', 7, N'master', NULL, NULL, NULL, 1)
INSERT [dbo].[tablamaestradetalle] ([tablamaestradetalle_id], [tablamaestra_id], [tablamaestradetalle_descripcion_id], [tablamaestradetalle_descripcion], [tablamaestradetalle_orden], [usuario_creacion], [usuario_modificacion], [fecha_creacion], [fecha_modificacion], [activo]) VALUES (8, 2, 1, N'Santa Anita', 1, N'master', NULL, NULL, NULL, 1)
INSERT [dbo].[tablamaestradetalle] ([tablamaestradetalle_id], [tablamaestra_id], [tablamaestradetalle_descripcion_id], [tablamaestradetalle_descripcion], [tablamaestradetalle_orden], [usuario_creacion], [usuario_modificacion], [fecha_creacion], [fecha_modificacion], [activo]) VALUES (9, 2, 2, N'San Isidro', 2, N'master', NULL, NULL, NULL, 1)
INSERT [dbo].[tablamaestradetalle] ([tablamaestradetalle_id], [tablamaestra_id], [tablamaestradetalle_descripcion_id], [tablamaestradetalle_descripcion], [tablamaestradetalle_orden], [usuario_creacion], [usuario_modificacion], [fecha_creacion], [fecha_modificacion], [activo]) VALUES (10, 2, 3, N'Lince', 3, N'master', NULL, NULL, NULL, 1)
INSERT [dbo].[tablamaestradetalle] ([tablamaestradetalle_id], [tablamaestra_id], [tablamaestradetalle_descripcion_id], [tablamaestradetalle_descripcion], [tablamaestradetalle_orden], [usuario_creacion], [usuario_modificacion], [fecha_creacion], [fecha_modificacion], [activo]) VALUES (11, 2, 4, N'Surquillo', 4, N'master', NULL, NULL, NULL, 1)
INSERT [dbo].[tablamaestradetalle] ([tablamaestradetalle_id], [tablamaestra_id], [tablamaestradetalle_descripcion_id], [tablamaestradetalle_descripcion], [tablamaestradetalle_orden], [usuario_creacion], [usuario_modificacion], [fecha_creacion], [fecha_modificacion], [activo]) VALUES (12, 2, 5, N'Miraflores', 5, N'master', NULL, NULL, NULL, 1)
INSERT [dbo].[tablamaestradetalle] ([tablamaestradetalle_id], [tablamaestra_id], [tablamaestradetalle_descripcion_id], [tablamaestradetalle_descripcion], [tablamaestradetalle_orden], [usuario_creacion], [usuario_modificacion], [fecha_creacion], [fecha_modificacion], [activo]) VALUES (13, 2, 6, N'La Molina', 6, N'master', NULL, NULL, NULL, 1)
INSERT [dbo].[tablamaestradetalle] ([tablamaestradetalle_id], [tablamaestra_id], [tablamaestradetalle_descripcion_id], [tablamaestradetalle_descripcion], [tablamaestradetalle_orden], [usuario_creacion], [usuario_modificacion], [fecha_creacion], [fecha_modificacion], [activo]) VALUES (14, 2, 7, N'Los Olivos', 7, N'master', NULL, NULL, NULL, 1)
INSERT [dbo].[tablamaestradetalle] ([tablamaestradetalle_id], [tablamaestra_id], [tablamaestradetalle_descripcion_id], [tablamaestradetalle_descripcion], [tablamaestradetalle_orden], [usuario_creacion], [usuario_modificacion], [fecha_creacion], [fecha_modificacion], [activo]) VALUES (15, 2, 8, N'Rimac', 8, N'master', NULL, NULL, NULL, 1)
INSERT [dbo].[tablamaestradetalle] ([tablamaestradetalle_id], [tablamaestra_id], [tablamaestradetalle_descripcion_id], [tablamaestradetalle_descripcion], [tablamaestradetalle_orden], [usuario_creacion], [usuario_modificacion], [fecha_creacion], [fecha_modificacion], [activo]) VALUES (16, 2, 9, N'Cercado de Lima', 9, N'master', NULL, NULL, NULL, 1)
INSERT [dbo].[tablamaestradetalle] ([tablamaestradetalle_id], [tablamaestra_id], [tablamaestradetalle_descripcion_id], [tablamaestradetalle_descripcion], [tablamaestradetalle_orden], [usuario_creacion], [usuario_modificacion], [fecha_creacion], [fecha_modificacion], [activo]) VALUES (17, 2, 10, N'Callao', 10, N'master', NULL, NULL, NULL, 1)
INSERT [dbo].[tablamaestradetalle] ([tablamaestradetalle_id], [tablamaestra_id], [tablamaestradetalle_descripcion_id], [tablamaestradetalle_descripcion], [tablamaestradetalle_orden], [usuario_creacion], [usuario_modificacion], [fecha_creacion], [fecha_modificacion], [activo]) VALUES (18, 3, 1, N'Estacionamiento', 1, N'master', NULL, NULL, NULL, 1)
INSERT [dbo].[tablamaestradetalle] ([tablamaestradetalle_id], [tablamaestra_id], [tablamaestradetalle_descripcion_id], [tablamaestradetalle_descripcion], [tablamaestradetalle_orden], [usuario_creacion], [usuario_modificacion], [fecha_creacion], [fecha_modificacion], [activo]) VALUES (19, 3, 2, N'Ducha', 2, N'master', NULL, NULL, NULL, 1)
INSERT [dbo].[tablamaestradetalle] ([tablamaestradetalle_id], [tablamaestra_id], [tablamaestradetalle_descripcion_id], [tablamaestradetalle_descripcion], [tablamaestradetalle_orden], [usuario_creacion], [usuario_modificacion], [fecha_creacion], [fecha_modificacion], [activo]) VALUES (20, 3, 3, N'Tienda', 3, N'master', NULL, NULL, NULL, 1)
SET IDENTITY_INSERT [dbo].[tablamaestradetalle] OFF
SET IDENTITY_INSERT [dbo].[usuario] ON 

INSERT [dbo].[usuario] ([usuario_id], [usuario_nombre], [usuario_contraseña], [usuario_razonsocial], [usuario_ruc], [usuario_email], [usuario_telefono], [usuario_foto_url], [usuario_presentacion], [activo], [usuario_creacion], [usuario_modificacion], [fecha_creacion], [fecha_modificacion]) VALUES (1, N'adsf', N'adf', N'adsf', N'ads', N'f', N'sadf', N'dfa', N'asdf', 1, N'master', NULL, CAST(0x0000A7BF017C8501 AS DateTime), NULL)
INSERT [dbo].[usuario] ([usuario_id], [usuario_nombre], [usuario_contraseña], [usuario_razonsocial], [usuario_ruc], [usuario_email], [usuario_telefono], [usuario_foto_url], [usuario_presentacion], [activo], [usuario_creacion], [usuario_modificacion], [fecha_creacion], [fecha_modificacion]) VALUES (2, N'aef', N'asdfsad', N'fadsf', N'sadf', N'dsfa', N'sadf', N'sdf', N'asdf', 1, N'master', NULL, CAST(0x0000A7BF017CE3C5 AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[usuario] OFF
ALTER TABLE [dbo].[cancha] ADD  CONSTRAINT [DF_cancha_activo]  DEFAULT ((1)) FOR [activo]
GO
ALTER TABLE [dbo].[tabla_maestra] ADD  CONSTRAINT [DF_tabla_maestra_activo]  DEFAULT ((1)) FOR [activo]
GO
ALTER TABLE [dbo].[tablamaestradetalle] ADD  CONSTRAINT [DF_tablamaestradetalle_activo]  DEFAULT ((1)) FOR [activo]
GO
ALTER TABLE [dbo].[usuario] ADD  CONSTRAINT [DF_usuario_activo]  DEFAULT ((1)) FOR [activo]
GO
USE [master]
GO
ALTER DATABASE [reserva] SET  READ_WRITE 
GO
