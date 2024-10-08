USE [storage]
GO
/****** Object:  StoredProcedure [dbo].[SP_CreateProd]    Script Date: 13/08/2024 08:53:48 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER proc [dbo].[SP_CreateProd] @Nombre Varchar(120), @Desc Varchar(255), @Codigo Varchar(60), @Foto Varchar(255), 
@CantMin int, @Precio numeric(12, 3), @User int, @Categoria int, @UOM int
as
Begin
	Declare @nError int, @Response Varchar(255)
	Begin Tran
	INSERT INTO producto VALUES (@Nombre, @Desc, @Codigo, @Foto, @CantMin, @Precio, 0, 'A', GETDATE(), @User, @UOM, 
	@Categoria)
	SET @nError=@@ERROR
	IF (@nError<>0) GOTO Retorno
	COMMIT TRAN
	Set @Response = 'OK'
	Retorno:
		If @nError<>0 Begin
			Set @Response = 'NO'
			ROLLBACK TRAN
		End
	Select @Response
End