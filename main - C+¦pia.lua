-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here












	cenarioCentral = display.newRect(display.contentWidth*0.5,100,200,600)
    cenarioCentral.strokeWidth = 4
    cenarioCentral:setFillColor( 0,0,1 )




--	inimigo1 = display.newRect(display.contentWidth*0.5 ,1,20,10)
	inimigo1 = display.newRect(160 ,-50,20,10)
    inimigo1.strokeWidth = 0
    inimigo1:setFillColor( 0,1,1 )


	inimigo2 = display.newRect(90 ,-50,20,10)
    inimigo2.strokeWidth = 0
    inimigo2:setFillColor( 0,1,1 )




	cenarioDireito = display.newRect(30,100,60,600)
    cenarioDireito.strokeWidth = 1
    cenarioDireito:setFillColor( 0,1,0 )


	cenarioEsquerdo = display.newRect(290,100,60,600)
    cenarioEsquerdo.strokeWidth = 1
    cenarioEsquerdo:setFillColor( 0,1,0 )

	cenarioObjeto1 = display.newRect(20,1,20,10)
	cenarioObjeto1.strokeWidth = 1
	cenarioObjeto1:setFillColor(0,0,0)

	cenarioObjeto2 = display.newRect(300,50,40,10)
	cenarioObjeto2.strokeWidth = 1
	cenarioObjeto2:setFillColor(0,0,0)




	cenarioObjeto3 = display.newRect(10,-10, 60, 30)
	cenarioObjeto3.strokeWidth = 1
	cenarioObjeto3:setFillColor(0.5,0,0)


	cenarioObjeto4 = display.newRect(300,100, 60, 20)
	cenarioObjeto4.strokeWidth = 1
	cenarioObjeto4:setFillColor(0.5,0,0)


	cenarioRodape = display.newRect(display.contentWidth*0.5,460, display.contentWidth, 125)
    cenarioRodape.strokeWidth = 1
    cenarioRodape:setFillColor( 0.5,0.5,0.5 )





function movimentarCenario()

	for i = 1, 5 do
		
		cenarioObjeto1.y = cenarioObjeto1.y + 0.5
		cenarioObjeto2.y = cenarioObjeto2.y + 0.5
		cenarioObjeto3.y = cenarioObjeto3.y + 0.5
		cenarioObjeto4.y = cenarioObjeto4.y + 0.5

		if(cenarioObjeto4.y >= 400) then
			recriarObjetoCenario(cenarioObjeto4)

		end


		if cenarioObjeto1.y >= 400	then
			cenarioObjeto1.y = 250
			recriarObjetoCenario(cenarioObjeto1)
					
		end
		
		if cenarioObjeto2.y >=400 then 
			cenarioObjeto2.y = -300
			recriarObjetoCenario(cenarioObjeto2)
		end
	end
end



function recriarObjetoCenario(objeto)
	
	if objeto.x == 10 then
		objeto.x = 300
	else
		objeto.x = 10
	end

	

end



function movimentarinimigo()


	for i = 1, 5 do

		inimigo1.y = inimigo1.y + 0.5
		inimigo2.y = inimigo2.y + 0.4
		inimigo2.x = inimigo2.x + 0.15

		if inimigo1.y >= 390 then
			inimigo1.y = -50
		end

		if inimigo2.y >=390 then
			inimigo2.y = -100
			
		end

	end
end



descerInimigo = timer.performWithDelay(50, movimentarinimigo,0)


descerCenario = timer.performWithDelay(10, movimentarCenario,0)




