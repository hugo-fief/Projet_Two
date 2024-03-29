USE [master]
GO
/****** Object:  Database [fiefdouglou]    Script Date: 08/04/2020 18:10:19 ******/
DROP DATABASE IF EXISTS [fiefdouglou]
GO
CREATE DATABASE [fiefdouglou]
GO
ALTER DATABASE [fiefdouglou] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [fiefdouglou].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [fiefdouglou] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [fiefdouglou] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [fiefdouglou] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [fiefdouglou] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [fiefdouglou] SET ARITHABORT OFF 
GO
ALTER DATABASE [fiefdouglou] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [fiefdouglou] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [fiefdouglou] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [fiefdouglou] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [fiefdouglou] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [fiefdouglou] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [fiefdouglou] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [fiefdouglou] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [fiefdouglou] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [fiefdouglou] SET  DISABLE_BROKER 
GO
ALTER DATABASE [fiefdouglou] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [fiefdouglou] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [fiefdouglou] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [fiefdouglou] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [fiefdouglou] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [fiefdouglou] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [fiefdouglou] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [fiefdouglou] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [fiefdouglou] SET  MULTI_USER 
GO
ALTER DATABASE [fiefdouglou] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [fiefdouglou] SET DB_CHAINING OFF 
GO
ALTER DATABASE [fiefdouglou] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [fiefdouglou] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [fiefdouglou] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [fiefdouglou] SET QUERY_STORE = OFF
GO
USE [fiefdouglou]
GO
/****** Object:  Table [dbo].[client]    Script Date: 08/04/2020 18:10:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[client](
	[id_client] [int] IDENTITY(1,1) NOT NULL,
	[id_intervention] [int] NOT NULL,
	[site] [varchar](50) NOT NULL,
	[nom] [varchar](50) NOT NULL,
	[prenom] [varchar](255) NOT NULL,
	[mail] [varchar](50) NOT NULL,
	[telephone] [varchar](50) NOT NULL,
 CONSTRAINT [PK_client] PRIMARY KEY CLUSTERED 
(
	[id_client] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[client_site]    Script Date: 08/04/2020 18:10:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[client_site](
	[id_client] [int] NOT NULL,
	[id_site] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[intervention]    Script Date: 08/04/2020 18:10:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[intervention](
	[id_intervention] [int] IDENTITY(1,1) NOT NULL,
	[id_technicien] [int] NOT NULL,
	[materiel_concerne] [varchar](50) NOT NULL,
	[commentaire] [text] NOT NULL,
	[date_intervention] [datetime] NOT NULL,
	[valide] [bit] NOT NULL,
	[id_site] [int] NULL,
	[id_client] [int] NULL,
 CONSTRAINT [PK_intervention] PRIMARY KEY CLUSTERED 
(
	[id_intervention] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[login]    Script Date: 08/04/2020 18:10:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[login](
	[login] [varchar](50) NOT NULL,
	[password] [varchar](255) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[mat_site]    Script Date: 08/04/2020 18:10:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[mat_site](
	[id_mat] [int] NOT NULL,
	[id_site] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[materiel]    Script Date: 08/04/2020 18:10:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[materiel](
	[id_mat] [int] IDENTITY(1,1) NOT NULL,
	[id_client] [int] NOT NULL,
	[id_site] [int] NOT NULL,
	[nom] [varchar](50) NOT NULL,
	[description] [varchar](50) NOT NULL,
	[type] [varchar](50) NOT NULL,
	[date_intervention_faite] [datetime] NOT NULL,
	[mtbf] [int] NOT NULL,
	[picture] [varchar](50) NULL,
 CONSTRAINT [PK_materiel] PRIMARY KEY CLUSTERED 
(
	[id_mat] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[site]    Script Date: 08/04/2020 18:10:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[site](
	[id_site] [int] IDENTITY(1,1) NOT NULL,
	[id_intervention] [int] NOT NULL,
	[nom] [varchar](50) NOT NULL,
	[adresse] [varchar](50) NULL,
	[code_postal] [varchar](50) NULL,
	[ville] [varchar](50) NULL,
 CONSTRAINT [PK_site] PRIMARY KEY CLUSTERED 
(
	[id_site] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[technicien]    Script Date: 08/04/2020 18:10:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[technicien](
	[id_technicien] [int] IDENTITY(1,1) NOT NULL,
	[id_intervention] [int] NOT NULL,
	[nom] [varchar](50) NOT NULL,
 CONSTRAINT [PK_technicien] PRIMARY KEY CLUSTERED 
(
	[id_technicien] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[client] ON 

INSERT [dbo].[client] ([id_client], [id_intervention], [site], [nom], [prenom], [mail], [telephone]) VALUES (2, 2, N'1', N'test', N'test', N'test@gmail.com', N'0623321423')
SET IDENTITY_INSERT [dbo].[client] OFF
SET IDENTITY_INSERT [dbo].[intervention] ON 

INSERT [dbo].[intervention] ([id_intervention], [id_technicien], [materiel_concerne], [commentaire], [date_intervention], [valide], [id_site], [id_client]) VALUES (2, 2, N'ram', N'je suis en manque', CAST(N'2020-02-12T00:00:00.000' AS DateTime), 0, 1, 2)
INSERT [dbo].[intervention] ([id_intervention], [id_technicien], [materiel_concerne], [commentaire], [date_intervention], [valide], [id_site], [id_client]) VALUES (3, 3, N'carte mère', N'je vuex un i7', CAST(N'2020-03-13T00:00:00.000' AS DateTime), 0, 1, 2)
INSERT [dbo].[intervention] ([id_intervention], [id_technicien], [materiel_concerne], [commentaire], [date_intervention], [valide], [id_site], [id_client]) VALUES (6, 6, N'pc', N'mon pc est trop lent', CAST(N'2020-04-22T00:00:00.000' AS DateTime), 1, 1, 2)
SET IDENTITY_INSERT [dbo].[intervention] OFF
INSERT [dbo].[login] ([login], [password]) VALUES (N'test', N'$2a$12$yKr7ulnFRgK0crxDTTS.auVViY7BQtKCMb7dLyx3x830Pmywi4Kp6')
SET IDENTITY_INSERT [dbo].[materiel] ON 

INSERT [dbo].[materiel] ([id_mat], [id_client], [id_site], [nom], [description], [type], [date_intervention_faite], [mtbf], [picture]) VALUES (9, 2, 1, N'pc', N'c''est un pc', N'informatique', CAST(N'2020-06-22T00:00:00.000' AS DateTime), 11, N'pc.jpg')
INSERT [dbo].[materiel] ([id_mat], [id_client], [id_site], [nom], [description], [type], [date_intervention_faite], [mtbf], [picture]) VALUES (11, 2, 1, N'carte mère', N'carte mère', N'informatique', CAST(N'2020-05-13T00:00:00.000' AS DateTime), 10, N'carte.jpg')
INSERT [dbo].[materiel] ([id_mat], [id_client], [id_site], [nom], [description], [type], [date_intervention_faite], [mtbf], [picture]) VALUES (18, 2, 1, N'ram', N'c est un rame', N'informatique', CAST(N'1900-01-01T00:00:00.000' AS DateTime), 11, N'ram.jpg')
SET IDENTITY_INSERT [dbo].[materiel] OFF
SET IDENTITY_INSERT [dbo].[site] ON 

INSERT [dbo].[site] ([id_site], [id_intervention], [nom], [adresse], [code_postal], [ville]) VALUES (1, 2, N'site fif', N'autre', N'78800', N'Bredouille')
SET IDENTITY_INSERT [dbo].[site] OFF
SET IDENTITY_INSERT [dbo].[technicien] ON 

INSERT [dbo].[technicien] ([id_technicien], [id_intervention], [nom]) VALUES (2, 6, N'Michel')
INSERT [dbo].[technicien] ([id_technicien], [id_intervention], [nom]) VALUES (3, 3, N'Christian')
INSERT [dbo].[technicien] ([id_technicien], [id_intervention], [nom]) VALUES (12, 2, N'Alexis')
SET IDENTITY_INSERT [dbo].[technicien] OFF
ALTER TABLE [dbo].[client]  WITH CHECK ADD  CONSTRAINT [FK_client_intervention] FOREIGN KEY([id_intervention])
REFERENCES [dbo].[intervention] ([id_intervention])
GO
ALTER TABLE [dbo].[client] CHECK CONSTRAINT [FK_client_intervention]
GO
ALTER TABLE [dbo].[client_site]  WITH CHECK ADD  CONSTRAINT [FK_client_site_client] FOREIGN KEY([id_client])
REFERENCES [dbo].[client] ([id_client])
GO
ALTER TABLE [dbo].[client_site] CHECK CONSTRAINT [FK_client_site_client]
GO
ALTER TABLE [dbo].[client_site]  WITH CHECK ADD  CONSTRAINT [FK_client_site_site] FOREIGN KEY([id_site])
REFERENCES [dbo].[site] ([id_site])
GO
ALTER TABLE [dbo].[client_site] CHECK CONSTRAINT [FK_client_site_site]
GO
ALTER TABLE [dbo].[intervention]  WITH CHECK ADD  CONSTRAINT [FK_intervention_client] FOREIGN KEY([id_client])
REFERENCES [dbo].[client] ([id_client])
GO
ALTER TABLE [dbo].[intervention] CHECK CONSTRAINT [FK_intervention_client]
GO
ALTER TABLE [dbo].[intervention]  WITH CHECK ADD  CONSTRAINT [FK_intervention_site] FOREIGN KEY([id_site])
REFERENCES [dbo].[site] ([id_site])
GO
ALTER TABLE [dbo].[intervention] CHECK CONSTRAINT [FK_intervention_site]
GO
ALTER TABLE [dbo].[mat_site]  WITH CHECK ADD  CONSTRAINT [FK_mat_site_materiel] FOREIGN KEY([id_mat])
REFERENCES [dbo].[materiel] ([id_mat])
GO
ALTER TABLE [dbo].[mat_site] CHECK CONSTRAINT [FK_mat_site_materiel]
GO
ALTER TABLE [dbo].[mat_site]  WITH CHECK ADD  CONSTRAINT [FK_mat_site_site] FOREIGN KEY([id_site])
REFERENCES [dbo].[site] ([id_site])
GO
ALTER TABLE [dbo].[mat_site] CHECK CONSTRAINT [FK_mat_site_site]
GO
ALTER TABLE [dbo].[materiel]  WITH CHECK ADD  CONSTRAINT [FK_materiel_client] FOREIGN KEY([id_client])
REFERENCES [dbo].[client] ([id_client])
GO
ALTER TABLE [dbo].[materiel] CHECK CONSTRAINT [FK_materiel_client]
GO
ALTER TABLE [dbo].[materiel]  WITH CHECK ADD  CONSTRAINT [FK_materiel_site] FOREIGN KEY([id_site])
REFERENCES [dbo].[site] ([id_site])
GO
ALTER TABLE [dbo].[materiel] CHECK CONSTRAINT [FK_materiel_site]
GO
ALTER TABLE [dbo].[site]  WITH CHECK ADD  CONSTRAINT [FK_site_intervention] FOREIGN KEY([id_intervention])
REFERENCES [dbo].[intervention] ([id_intervention])
GO
ALTER TABLE [dbo].[site] CHECK CONSTRAINT [FK_site_intervention]
GO
ALTER TABLE [dbo].[technicien]  WITH CHECK ADD  CONSTRAINT [FK_technicien_intervention] FOREIGN KEY([id_intervention])
REFERENCES [dbo].[intervention] ([id_intervention])
GO
ALTER TABLE [dbo].[technicien] CHECK CONSTRAINT [FK_technicien_intervention]
GO
USE [master]
GO
ALTER DATABASE [fiefdouglou] SET  READ_WRITE 
GO
