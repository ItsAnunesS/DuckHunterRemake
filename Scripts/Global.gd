extends Node

var ducksMissed = 0
var ducksHitted = 0
var ducksInScreen = 0
var wave = 1
var gameStarted = false
var labelPoints
var labelWave
var audioNewWave

func increaseDucksHitted():
	ducksHitted += 1
	refreshLabels()
	decreaseDucksInScreen()

func increaseDucksMissed():
	ducksMissed += 1
	refreshLabels()
	decreaseDucksInScreen()
	
func increaseWave():
	wave += 1
	audioNewWave.play()
	refreshLabels()

func resetWave():
	wave = 1
	ducksHitted = 0
	ducksMissed = 0
	refreshLabels()
	
func decreaseDucksInScreen():
	ducksInScreen -= 1

func refreshLabels():
	if (labelWave != null):
		labelWave.text = str(wave)
	
	if (labelPoints != null):
		labelPoints.text = str(ducksHitted)
