-----------------------------------------------------------------------------------------
local physics = require( "physics" )
physics.start()
physics.setGravity(0,0)
--physics.setDrawMode("hybrid")
vidas = 5
scoreAtual = 0
hiScore = 0

-- =========================================================================================== --

local pontuacaoText = display.newText("0",0,0)
function exibirPontuacao()
    local options = 
    {
        text = scoreAtual,     
        x = display.actualContentWidth/2-25,
        y = 422,
        width = 130,
        font = native.systemFont,   
        fontSize = 20,
        align = "right"
    }
	pontuacaoText.isVisible = false
	pontuacaoText = display.newText(options )
	pontuacaoText:setFillColor( 00.1, 0.1, 0.1 )
end


function incrementarScore()
	scoreAtual = scoreAtual + 100
	exibirPontuacao()
end

-- =========================================================================================== --

function adicionarVida(event)
	print("Adicionou uma vida " .. vidas)
	display.remove(event.target)
	addFuel = nil
	somarVida()
end

function perderVida()
	
	if (vidas > 1) then
		vidas = vidas-1
		cenarioApagaLife.x = cenarioApagaLife.x -15 
		print("Quantidade de vidas agora é: " .. vidas)
	else
		print ("vidas esgotadas quantidade:> " ..  vidas)
	end
end

function somarVida ()
	if vidas < 5 then
		vidas = vidas +1
		cenarioApagaLife.x = cenarioApagaLife.x +15 
	end
end

function morrerPorColisao(event)
		display.remove(event.other)
		inimigo1 = nil
		perderVida()				
end




-- =========================================================================================== --

function moverNaveEsquerda(event)
	if event.phase == "began" then
		if nave.x > display.actualContentWidth/4  then
		nave.x = nave.x - 10
		end
	end
end

function moverNaveDireita(event)
	if event.phase == "began" then
		if nave.x < display.actualContentWidth/4*3  then
			nave.x = nave.x + 10
		end
	end
end

tiro = {}

function atirar(event)
		if event.phase == "began" then
			local contTiro = #tiro+1
			tiro[contTiro] = display.newRect(nave.x,nave.y-25,5,3)
			tiro[contTiro].id = contTiro
			physics.addBody(tiro[contTiro])
			tiro[contTiro]:setLinearVelocity(0,-100)
			tiro[contTiro]:addEventListener("collision", matarInimigo)
	end
end

function matarInimigo(event)
	display.remove(event.target)
	display.remove(event.other)
	inimigo1 = nil
	incrementarScore()
end

-- =========================================================================================== --


function gerarFuel( )
	addFuel = display.newImage("addFuel.png", math.random(70,250), -300)
	physics.addBody(addFuel)
	addFuel:addEventListener("collision", adicionarVida)
	addFuel:setLinearVelocity(0,100)
end
-- =========================================================================================== --

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
		--inimigo1:addEventListener("collision", morrerPorColisao)
	end
-- =========================================================================================== --

function descerCenario()
	cenarioSuperior.y = cenarioSuperior.y +1
	if(cenarioSuperior.y >= 400) then
		cenarioSuperior.y = 50
	end
	
	cenarioPedra1.y = cenarioPedra1.y +1
	if(cenarioPedra1.y >=450)then
		mudarLadoX(cenarioPedra1)
	end

	
	cenarioPedra2.y = cenarioPedra2.y +1
	if(cenarioPedra2.y >=450)then
		mudarLadoX(cenarioPedra2)
	end

	
	cenarioPedra3.y = cenarioPedra3.y +1
	if(cenarioPedra3.y >=450)then
		mudarLadoX(cenarioPedra3)
	end
end


function mudarLadoX(objeto)

	objeto.y = (math.random(-500,-50))
	if (objeto.x <=30) then
		objeto.x = math.random(290,330)
	else
		objeto.x = math.random(-20, 30)
	end
end

function gastarCombustivel() 
	if (vidas >=1) then
		cenarioApagaCombustivel.x = cenarioApagaCombustivel.x-0.1
		if(cenarioApagaCombustivel.x <=280) then
			cenarioApagaCombustivel.x = 360
			perderVida()
		end
		
	end


end


-- =========================================================================================== --
decerCenario = timer.performWithDelay(10, descerCenario,0)
gerarInimigo = timer.performWithDelay(1000, criarInimigo,0)
geraFuel = timer.performWithDelay(5000, gerarFuel,0)
gastaCombustivel = timer.performWithDelay(10, gastarCombustivel,0)
-- =========================================================================================== --



-- =========================================================================================== --
cenarioSuperior = display.newImage("cenarioSuperior.png",display.actualContentWidth/2,200)
cenarioPedra1 = display.newImage("pedra1.png",( math.random (-20, 30)) , ( math.random (-200, 0)))
cenarioPedra2 = display.newImage("pedra2.png",( math.random (290, 300)) , ( math.random (-400, -200)))
cenarioPedra3 = display.newImage("pedra3.png",( math.random (-10, 50)) , ( math.random (-900, -400)))
cenarioInferior = display.newImage("cenarioInferior.png",display.actualContentWidth/2,display.actualContentHeight/8*7)

cenarioApagaCombustivel = display.newRect(360,428,80,8)
cenarioApagaCombustivel:setFillColor( 01,0.5,0.5 )
cenarioApagaLife = display.newRect(356,410,80,15)
cenarioApagaLife:setFillColor(0,0,0)
-- =========================================================================================== --


-- =========================================================================================== --
botaoEsquerda = display.newImage ("botaoEsquerda.png", 50, 480 )
botaoDireita = display.newImage("botaoDireita.png",270, 480 )			
botaoTiro = display.newImage("botaoTiro3.png", display.contentWidth*0.5, 480 )
botaoEsquerda:addEventListener("touch", moverNaveEsquerda)
botaoDireita:addEventListener("touch", moverNaveDireita)
botaoTiro:addEventListener("touch", atirar)	
-- =========================================================================================== --


-- =========================================================================================== --
nave = display.newImage("nave1.png", display.contentWidth/2, 380)
physics.addBody(nave, "static")
nave:addEventListener("collision", morrerPorColisao)
-- =========================================================================================== --


