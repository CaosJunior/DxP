function onTimer(cid, interval, lastExecution) 

doBroadcastMessage("Golden Arena will begin in 10 minutes! Go prepare yourself!")
addEvent(doBroadcastMessage, 300000, "Golden Arena will begin in 5 minutes!\nWe hope that participants are already prepared!") 
addEvent(puxaParticipantes, 480000)  	
addEvent(doWave, 600000, true) --alterado v1.8       --480000 / 600000

return true
end



		<globalevent name="GoldenArena1" time="0:50" event="script" value="Golden Arena.lua"/>
	<globalevent name="GoldenArena2" time="5:50" event="script" value="Golden Arena.lua"/>
	<globalevent name="GoldenArena3" time="10:50" event="script" value="Golden Arena.lua"/>
	<globalevent name="GoldenArena4" time="15:50" event="script" value="Golden Arena.lua"/>
	<globalevent name="GoldenArena5" time="20:50" event="script" value="Golden Arena.lua"/>