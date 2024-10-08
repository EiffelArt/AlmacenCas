USE [storage]
GO
/****** Object:  StoredProcedure [dbo].[SP_EditProduct]    Script Date: 13/08/2024 09:07:20 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER Proc [dbo].[SP_EditProduct] @nOperDB tinyint, @idProd int, @nueCant bigint = NULL, @Estatus char
As 
Begin
	Declare @nError int, @Response Varchar(255), @ExisActual bigint
	if  (@nOperDB = 1) Begin
		BEGIN TRAN
		UPDATE producto Set estatus = @Estatus Where idProducto = @idProd
		SET @nError=@@ERROR
		Goto Retorno
		COMMIT TRAN
	End Else If (@nOperDB = 2) Begin
		Select @ExisActual =  existencia From producto Where idProducto = @idProd
		if (@ExisActual <= @nueCant) Begin
			Set @nError = -1
			Goto Retorno
		End
		UPDATE producto Set existencia = @Estatus Where idProducto = @idProd
		SET @nError=@@ERROR
		Goto Retorno
		COMMIT TRAN
	End
	Retorno:
	If @nError<>0 Begin
		Set @Response = 'NO'
		ROLLBACK TRAN
	End
	Select @Response
End