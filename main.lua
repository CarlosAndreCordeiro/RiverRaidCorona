-----------------------------------------------------------------------------------------
local physics = require( "physics" )
physics.start()
physics.setGravity(0,0)


-- =========================================================================================== --

	cenarioCentral = display.newRect(display.contentWidth*0.5,100,200,600)
    cenarioCentral.strokeWidth = 4
    cenarioCentral:setFillColor( 0,0,1 )

	
-- ============================================================================================ --


	inimigo1 = display.newImage("inimigo1.png", (math.random (70, 250)),-50 )
	inimigo4 = display.newImage("inimigo4.png", (math.random (70, 250)),(math.random (-900, -60)))
	inimigo4a = display.newImage("inimigo4a.png", (math.random (70, 250)), (math.random (-900, -60)) )
	
	
--============================================================================================= --
	cenarioDireito = display.newImage("lateral1.jpg",290,100)
	cenarioEsquerdo = display.newImage("lateral1.jpg", 30,100)
	 

--============================================================================================== --


	inimigo2 = display.newImage("inimigo2.png", -10, math.random (0, 350))
	inimigo2a = display.newImage("inimigo2a.png", math.random (350, 950), math.random (0, 350))
	inimigo3 = display.newImage("inimigo3.png",  -10 , math.random (0, 350))
	inimigo3a = display.newImage("inimigo3a.png",  350 , math.random (0, 350))
	cenarioPedraEsquerda = display.newImage("pedra.png",( math.random (0, 65)) , ( math.random (-300, -50)))



--=============================================================================================== --

	cenarioRodape = display.newRect(display.contentWidth*0.5,490, display.contentWidth, 100)
    cenarioRodape.strokeWidth = 1
	cenarioRodape:setFillColor( 0.5,0.5,0.5 )
	


function movimentarCenario()
	for i = 1, 5 do
		cenarioEsquerdo.y = cenarioEsquerdo.y + 0.1
		cenarioDireito.y = cenarioDireito.y + 0.1
		inimigo4.y = inimigo4.y +0.1
		inimigo4a.y = inimigo4a.y +0.1
		cenarioPedraEsquerda.y = cenarioPedraEsquerda.y +0.1
	end
	
	if cenarioEsquerdo.y >= 850 then
		recriarCenario(cenarioEsquerdo)
		recriarCenario(cenarioDireito)
	end

	if inimigo4.y >= 400 then
		recriarVertical(inimigo4)
	end

	if inimigo4a.y >= 400 then
		recriarCenario(inimigo4a)
	end
end

function recriarCenario(objeto) 

	objeto.y = -500


end



function movimentarinimigo()

	for i = 1, 5 do
		inimigo1.y = inimigo1.y + 0.5
		inimigo2.x = inimigo2.x + 0.15
		inimigo2a.x = inimigo2a.x - 0.15
		inimigo3.x = inimigo3.x + 0.3
		inimigo3.y = inimigo3.y + 0.2
		inimigo3a.x = inimigo3a.x - 0.1
		inimigo3a.y = inimigo3a.y + 0.1
	end

	if inimigo1.y >= 400 then
		recriarVertical(inimigo1)
	end
	if inimigo2.x >= 500 then
		recriarHorizontal(inimigo2) 
	end
	if inimigo2a.x <= -200 then
		recriarHorizontalReverso(inimigo2a)
	end
	if inimigo3.y >= 500 then
		recriarDiagonal(inimigo3)
	end

	if inimigo3a.y >= 500 then
		recriarDiagonalReverso(inimigo3a)
	end

	if cenarioPedraEsquerda.y >= 500 then
		recriarVertical(cenarioPedraEsquerda)

	end


end

function recriarDiagonal(objeto)
	objeto.x= -10
	objeto.y =  math.random (0, 300)
end



function recriarHorizontal(objeto)
	objeto.x = (math.random (-600, -30))
	objeto.y = (math.random (0, 350))

end

function recriarHorizontalReverso(objeto)
	objeto.x = (math.random (350, 950))
	objeto.y = (math.random (0, 350))

end

function recriarDiagonalReverso(objeto)

objeto.x = (math.random (350, 500 ))
objeto.y = (math.random (-100, 350))

end

function recriarVertical(objeto)
	objeto.y = (math.random (-600, -30))
	objeto.x = (math.random (70, 250))
	
end

function moverNaveEsquerda(event)

	if event.phase == "began" then
		if nave.x > display.actualContentWidth/4 -10  then
		nave.x = nave.x - 10
		end
	end
end



function moverNaveDireita(event)

	if event.phase == "began" then
		if nave.x < display.actualContentWidth -70  then
			nave.x = nave.x + 10
		end
	end
end



tiro = {}

function atirar(event)

		if event.phase == "began" then
		
			local contTiro = #tiro+1
			
			tiro[contTiro] = display.newRect(nave.x,nave.y-15,5,3)
			tiro[contTiro].id = contTiro
			
			physics.addBody(tiro[contTiro])

			
			--tiro[contTiro]:addEventListener("collision", verificarAcertoInimigo)
			
			tiro[contTiro]:setLinearVelocity(0,-100)

		
	end

end



botaoEsquerda = display.newImage ("botaoEsquerda.png", 50, 480 )
botaoEsquerda:addEventListener("touch", moverNaveEsquerda)

botaoDireita = display.newImage("botaoDireita.png",270, 480 )
botaoDireita:addEventListener("touch", moverNaveDireita)


botaoTiro = display.newImage("botaoTiro3.png", display.contentWidth*0.5, 480 )
botaoTiro:addEventListener("touch", atirar)


cenarioScore = display.newRect(display.contentWidth/2, 420, 350, 40 )


nave = display.newImage("nave1.png", display.contentWidth*0.5, 380 )





---------------------------------------------------------------------

descerCenario = timer.performWithDelay(10, movimentarCenario,0) 

movimentoInimigos = timer.performWithDelay(10, movimentarinimigo,0)




