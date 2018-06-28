-----------------------------------------------------------------------------------------
local physics = require( "physics" )
physics.start()
physics.setGravity(0,0)

vidas = 5

scoreAtual = 0
hiScore = 0

-- =========================================================================================== --

function abrirJogo()

	fundo = display.newImage("fundo.png", display.contentWidth/2, 235)
	inicio = display.newImage("inicio.png", display.contentWidth /2+4, 160)
	botaoSim = display.newImage("botaoSim.png",100 ,220)
	botaoSim:addEventListener("touch", iniciarJogo)

	botaoNao = display.newImage("botaoNao.png", 230,220)
	botaoNao:addEventListener("touch", limparAbrirJogo)

end

-- =========================================================================================== --

function iniciarJogo(event)
	
	-- if (event.phase == "began") then
	--	limparAbrirJogo()  
			cenarioCentral = display.newRect(display.contentWidth*0.5, 100,200,600)
			cenarioCentral.strokeWidth = 0
			cenarioCentral:setFillColor( 0,0,1 )

			addFuel = display.newImage("addFuel.png", math.random(70,250), -300)
			
			inimigo4 = display.newImage("inimigo4.png", (math.random (70, 250)),(math.random (-900, -60)))
			inimigo4a = display.newImage("inimigo4a.png", (math.random (70, 250)), (math.random (-900, -60)) )
			inimigo1 = display.newImage("inimigo1.png", (math.random (70, 250)),-50 )

		
			cenarioDireito = display.newImage("lateral1.jpg",290,100)
			cenarioEsquerdo = display.newImage("lateral1.jpg", 30,100)
			

			cenarioPedra1 = display.newImage("pedra1.png",( math.random (-20, 80)) , ( math.random (-100, 0)))
			cenarioPedra2 = display.newImage("pedra2.png",( math.random (290, 300)) , ( math.random (-500, -100)))
			cenarioPedra3 = display.newImage("pedra3.png",( math.random (-10, 50)) , ( math.random (-600, -200)))


			inimigo2 = display.newImage("inimigo2.png", -10, math.random (0, 350))
			inimigo2a = display.newImage("inimigo2a.png", math.random (350, 950), math.random (0, 350))
			inimigo3 = display.newImage("inimigo3.png",  -10 , math.random (0, 350))
			inimigo3a = display.newImage("inimigo3a.png",  350 , math.random (0, 350))


			cenarioRodape = display.newRect(display.contentWidth*0.5,490, display.contentWidth, 100)
			cenarioRodape.strokeWidth = 1
			cenarioRodape:setFillColor( 0,0,0 )


			botaoEsquerda = display.newImage ("botaoEsquerda.png", 50, 480 )
			
			botaoDireita = display.newImage("botaoDireita.png",270, 480 )
			
			botaoTiro = display.newImage("botaoTiro3.png", display.contentWidth*0.5, 480 )

			cenarioScore = display.newRect(display.contentWidth/2, 420, 350, 40 )
			cenarioScore:setFillColor( 0,0,0 )


			cenarioLife = display.newImage("life.png", display.contentWidth - 40, 410 )
			cenariolioApagaLife = display.newRect(356,410,80,15)
			cenariolioApagaLife:setFillColor(0,0,0)
			cenarioCombustivel = display.newImage("fuel.png", display.contentWidth - 35, 428)

			cenarioApagaCombustivel = display.newRect(360,428,80,8)
			cenarioApagaCombustivel:setFillColor( 01,0.5,0.5 )

			nave = display.newImage("nave1.png", display.contentWidth/2, 380)


			---------------------------------------------------------------
			descerCenario = timer.performWithDelay(10, movimentarCenario,0) 
			movimentoInimigos = timer.performWithDelay(10, movimentarinimigo,0)
			incrementoScore = timer.performWithDelay(1000,incrementarScore,0)
			---------------------------------------------------------------

			botaoEsquerda:addEventListener("touch", moverNaveEsquerda)
			botaoDireita:addEventListener("touch", moverNaveDireita)
			botaoTiro:addEventListener("touch", atirar)		
			
			
			cenarioBarraScore = display.newImage("barraScore.png", display.contentWidth/2+10 	, 424)
			cenarioScore = display.newImage("score.png", 62,423)


		
			--	end

	

end


-- =========================================================================================== --


function exibirPontuacao()

    local options = 
    {
        text = scoreAtual,     
        x = display.actualContentWidth/2-25,
        y = 425,
        width = 130,
        font = native.systemFont,   
        fontSize = 20,
        align = "right"
    }
    local pontuacaoText = display.newText(options )
    pontuacaoText:setFillColor( 00.1, 0.1, 0.1 )
           

end

-- ============================================================= --
function apagarPlacarantigo()	
	pontuacaoText:removeSelf()
end

function incrementarScore()
	

	
	if(scoreAtual<=999999)then
		scoreAtual = scoreAtual + 10
	else
		zerouJogo()
	end
	exibirPontuacao()
end

-- ============================================================= --

function zerouJogo()

	zerouJogo = display.newImage("highScore.png", display.actualContentWidth/2,200)

    local options = 
    {
        text = scoreAtual,     
        x = display.actualContentWidth/2,
        y = 350,
        width = 130,
        font = native.systemFont,   
        fontSize = 30,
        align = "center"
    }
    local myText = display.newText(options )
    myText:setFillColor( 0.9, 0.6, 00.2 )
           
end
-- ============================================================= --

function limparAbrirJogo()

		botaoSim:removeSelf()
		botaoNao:removeSelf()
		fundo:removeSelf()
		inicio:removeSelf()
	
end


-- =============================================================================================== --

function gameOver()
	if scoreAtual > hiScore then
		hiScore = scoreAtual
	end
end
-- =============================================================================================== --

function movimentarCenario()
	
	velocidadeCenario = 0.2
	
	for i = 1, 5 do
		cenarioEsquerdo.y = cenarioEsquerdo.y + velocidadeCenario
		cenarioDireito.y = cenarioDireito.y + velocidadeCenario
		addFuel.y= addFuel.y +velocidadeCenario
		cenarioPedra1.y = cenarioPedra1.y + velocidadeCenario
		cenarioPedra2.y = cenarioPedra2.y + velocidadeCenario
		cenarioPedra3.y = cenarioPedra3.y + velocidadeCenario
		
		
		if(vidas >=1)then
			cenarioApagaCombustivel.x = cenarioApagaCombustivel.x - 0.005
			
			
		else
		--abrirJogo()
		end
	end
	
	if addFuel.y >500 then
		recriarVertical(addFuel)

	end


	if cenarioEsquerdo.y >= 850 then
		recriarCenario(cenarioEsquerdo)
		recriarCenario(cenarioDireito)
	end


end 


-- =============================================================================== --

function recriarCenario(objeto) 
	objeto.y = -500 		
end

-- =============================================================================== --

function inserirObjetoCenario(objeto)
	
	if(objeto.y >= 500) then
		objeto.y = ( math.random (-500, -50))
		
		if objeto.x <=200 then
			objeto.x= (math.random (290,350))
		else 
			objeto.x =( math.random (-20, 40))
		end
	end
end


-- =============================================================================== --


function movimentarinimigo()

	for i = 1, 5 do
		inimigo1.y = inimigo1.y + 0.25
		inimigo2.x = inimigo2.x + 0.15
		inimigo2a.x = inimigo2a.x - 0.15
		inimigo3.x = inimigo3.x + 0.3
		inimigo3.y = inimigo3.y + 0.2
		inimigo3a.x = inimigo3a.x - 0.1
		inimigo3a.y = inimigo3a.y + 0.1
		inimigo4.y = inimigo4.y + 0.1
		inimigo4a.y = inimigo4a.y + 0.1

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

	if cenarioPedra1.y >= 500 then
		inserirObjetoCenario(cenarioPedra1)

	end
	if cenarioPedra2.y >= 500 then
		inserirObjetoCenario(cenarioPedra2)
	end
	if cenarioApagaCombustivel.x <=280 then
		cenarioApagaCombustivel.x = 360
		decrementarVida()
	end

	if inimigo4.y >= 400 then
		recriarVertical(inimigo4)
	end

	if inimigo4a.y >= 400 then
		recriarCenario(inimigo4a)
	end
end


-- =============================================================================== --


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
-- =========================================================================================== --

function adicionarVida()
	if (vidas < 5) then
		cenariolioApagaLife.x = cenariolioApagaLife.x + 15
		vidas = vidas+1 
	end

end

-- =========================================================================================== --

function decrementarVida()
	if(vidas >= 1) then
		cenariolioApagaLife.x  = cenariolioApagaLife.x - 15
		vidas = vidas -1
	else
	abrirJogo()
	
	end
end

-- =========================================================================================== --



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

iniciarJogo()


