USE [storage]
GO
/****** Object:  StoredProcedure [dbo].[SP_ValidarUser]    Script Date: 12/08/2024 03:50:50 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
alter proc [dbo].[SP_ValidarUser] @MAIL VARCHAR(50), @PASSWORD VARCHAR(25)
as
begin
	Create Table #Result(
		mensaje varchar(60) NULL,
		nombre varchar(100) NULL,
		email varchar(50) NULL,
		rol varchar(20)
		
	)
	Declare @Existe tinyint, @Response Varchar(255), @PassActual Varchar(25);
	Declare @Nombre Varchar(100), @Rol Varchar(25), @email varchar(50);
	Select @Existe = COUNT(*) From usuarios WHERE correo = @MAIL
	If(@Existe = 0) Begin
			Insert Into #Result Values ('Usuario no Encontrado', NULL, NULL, NULL)
			Goto Retorno
	End 
	SELECT @PassActual = contrasena FROM usuarios WHERE correo = @MAIL
	
	IF (@PassActual != @PASSWORD) Begin
		Insert Into #Result Values ('Password Incorrecto', NULL, NULL, NULL)
		Goto Retorno
	End Else Begin
		Select @Nombre = u.nombre, @Rol = r.nombre, @email = u.correo  FROM usuarios u INNER JOIN rol r On u.idRol = r.idRol WHERE correo = @MAIL
		Insert Into #Result Values ('', @Nombre, @email, @Rol)
		Goto Retorno
	End
Retorno:
	Select * from #Result
	drop table #Result
end