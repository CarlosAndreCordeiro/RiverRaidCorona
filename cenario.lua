-----------------------------------------------------------------------------------------

cenario = {}

local physics = require( "physics" )
physics.start()
physics.setGravity(0,0)
physics.setDrawMode("hybrid")


scoreAtual = 0
hiScore = 0

-- =========================================================================================== 

-- =========================================================================================== --

function gerarFuel( )
	addFuel = display.newImage("addFuel.png", math.random(70,250), -300)
	physics.addBody(addFuel)
	addFuel:addEventListener("collision", adicionarVida)
	addFuel:setLinearVelocity(0,50)
end

gerarGasolina = timer.performWithDelay(5000, gerarFuel,0)

function criarCenario(event)
	
	 if (event.phase == "began") then
			limparAbrirJogo()  
			cenarioCentral = display.newRect(display.contentWidth*0.5, 100,200,600)
			cenarioCentral.strokeWidth = 0
			cenarioCentral:setFillColor( 0,0,1 )

			

			cenarioDireito = display.newImage("lateral1.jpg",290,100)
			cenarioEsquerdo = display.newImage("lateral1.jpg", 30,100)
			

			cenarioPedra1 = display.newImage("pedra1.png",( math.random (-20, 80)) , ( math.random (-100, 0)))
			cenarioPedra2 = display.newImage("pedra2.png",( math.random (290, 300)) , ( math.random (-500, -100)))
			cenarioPedra3 = display.newImage("pedra3.png",( math.random (-10, 50)) , ( math.random (-600, -200)))


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
			physics.addBody(nave, "static")
			nave:addEventListener("collision", decrementarVida)

			
			botaoEsquerda:addEventListener("touch", moverNaveEsquerda)
			botaoDireita:addEventListener("touch", moverNaveDireita)
			botaoTiro:addEventListener("touch", atirar)		
			
			
			cenarioBarraScore = display.newImage("barraScore.png", display.contentWidth/2+10 	, 424)
			cenarioScore = display.newImage("score.png", 62,423)

	-------------------------------------------------------------------------------
			descerCenario = timer.performWithDelay(10, movimentarCenario,0) 
			--movimentoInimigos = timer.performWithDelay(10, movimentarinimigo,0)
			--incrementoScore = timer.performWithDelay(1000,incrementarScore,0)
	-------------------------------------------------------------------------------

	criarInimigo()
	end
end

function criarInimigo()
--	inimigo4 = display.newImage("inimigo4.png", (math.random (70, 250)),(math.random (-900, -60)))
--	inimigo4a = display.newImage("inimigo4a.png", (math.random (70, 250)), (math.random (-900, -60)) )
--	inimigo2 = display.newImage("inimigo2.png", -10, math.random (0, 350))
--	inimigo2a = display.newImage("inimigo2a.png", math.random (350, 950), math.random (0, 350))
--	inimigo3 = display.newImage("inimigo3.png",  -10 , math.random (0, 350))
--	inimigo3a = display.newImage("inimigo3a.png",  350 , math.random (0, 350))



	inimigo1 = display.newImage("inimigo1.png", (math.random (70, 250)),-50 )
	physics.addBody(inimigo1)
	inimigo1:setLinearVelocity(0, 100)


end

gerarInimigo = timer.performWithDelay(3000, criarInimigo,0)
-- =========================================================================================== --

local pontuacaoText = display.newText("0",0,0)
   
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
	pontuacaoText.isVisible = false
	pontuacaoText = display.newText(options )
   
	pontuacaoText:setFillColor( 00.1, 0.1, 0.1 )

end

-- ============================================================= --
function apagarPlacarantigo()	
	
end

function incrementarScore()
		
	scoreAtual = scoreAtual + 100
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
		--fundo:removeSelf()
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
	
	velocidadeCenario = 1
	
	
		cenarioEsquerdo.y = cenarioEsquerdo.y + velocidadeCenario
		cenarioDireito.y = cenarioDireito.y + velocidadeCenario
		--addFuel.y= addFuel.y +velocidadeCenario
		cenarioPedra1.y = cenarioPedra1.y + velocidadeCenario
		cenarioPedra2.y = cenarioPedra2.y + velocidadeCenario
		cenarioPedra3.y = cenarioPedra3.y + velocidadeCenario
	
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
	
		if(vidas >=1)then
			cenarioApagaCombustivel.x = cenarioApagaCombustivel.x - 0.05
		else
		abrirJogo()
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


--function movimentarinimigo()

--	if inimigo1 ~= nil then
--	inimigo1.y = inimigo1.y + 1.9
--	end
		
--end


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

function adicionarVida(event)
		print("Adicionou a vida")
		
		display.remove(event.target)
		addFuel = nil
		if event.phase == "began" then
			if vidas < 5 then
			cenariolioApagaLife.x = cenariolioApagaLife.x + 15
			vidas = vidas+1 
			end
		end
		
		print("Quantidade de vida: " .. vidas)

end


-- =========================================================================================== --

function decrementarVida(event)
		
		display.remove(event.other)
		inimigo1 = nil
		addFuel = nil
		if event.phase == "began" then
			if vidas > 0 then
				cenariolioApagaLife.x = cenariolioApagaLife.x - 15
				vidas = vidas - 1
			end
		end
	print("Quantidade de vidas: ".. vidas)
	
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
			shotAudio = audio.loadStream(shot)
			audio.play(chotAudio)



			local contTiro = #tiro+1

			
			tiro[contTiro] = display.newRect(nave.x,nave.y-25,5,3)
			tiro[contTiro].id = contTiro
			
			physics.addBody(tiro[contTiro])
			tiro[contTiro]:setLinearVelocity(0,-100)
			tiro[contTiro]:addEventListener("collision", matarInimigo)
	end
end



function abrirJogo()

	inicio = display.newImage("inicio.png", display.contentWidth /2+4, 160)
	
	botaoSim = display.newImage("botaoSim.png",100 ,220)
	botaoSim:addEventListener("touch", criarCenario)
	
	botaoNao = display.newImage("botaoNao.png", 230,220)
	botaoNao:addEventListener("touch", limparAbrirJogo)

end








return cenario