#INCLUDE 'TOTVS.CH'
#INCLUDE 'PROTHEUS.CH'

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GetNum  ºAutor  Carlos D. Tirabassi Jr.º Data ³  15/05/2017 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Função usada para retornar um sequencial valido atraves do º±±
±±º          ³ GetSX8Num, validando se o mesmo está livre                 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function GetNum(cAlias,nOrdem,cCampo)
Local cNumero  := ''
Local lOk      := .F.

Default cAlias:= ''
Default nOrdem:= 0
Default cCampo:= ''

//Verifica se os parametros foram informados
If Empty(cAlias) .Or. Empty(cCampo) .Or. nOrdem == 0
	Return cNumero
EndIf


DBSelectArea(cAlias)
DBSetOrdem(nOrdem)

while !lOk

	cNumero:= GetSX8Num(cAlias,cCampo)
	
  //Verifica se a sequencia ja esta sendo usada
	If !((cAlias)->(DBSeek(xFilial(cAlias)+cNumero)))
		lOk:= .T.
    
    //Nao confirmamos o processo aqui para que seja possivel utilizar o rollback no fonte que chamar a rotina
		
    Exit
	EndIf
	
  //Caso a sequencia já esteja sendo usada confirmamos a utilizacao e refazemos o processo
	ConfirmSX8()
	
EndDo
	
Return cNumero
