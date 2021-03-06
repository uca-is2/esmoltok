Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#instVars : [
		'noEffect',
		'speedUpEffect',
		'wormHoleEffect',
		'moonWalkEffect',
		'atomicEffect'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #'test utilities' }
GameTest >> assert: a hasTheSameOrderThan: b [
	self assert: a equals: b asOrderedCollection
]

{ #category : #'test utilities' }
GameTest >> collectionOf16NoEffect [
	| distributor |
	distributor := FixedDistributor
		withProbabilityOfSpeedUp: 0
		wormhole: 0
		atomic: 0
		noEffect: 100
		moonwalk: 0
		andMaximumMoonwalkSteps: 5.
	^ distributor boardOfLength: 16
]

{ #category : #'test utilities' }
GameTest >> collectionOf5NoEffect [
	| distributor |
	distributor := FixedDistributor
		withProbabilityOfSpeedUp: 0
		wormhole: 0
		atomic: 0
		noEffect: 100
		moonwalk: 0
		andMaximumMoonwalkSteps: 5.
	^ distributor boardOfLength: 5
]

{ #category : #'test utilities' }
GameTest >> collectionOf80NoEffect [
	| distributor |
	distributor := FixedDistributor
		withProbabilityOfSpeedUp: 0
		wormhole: 0
		atomic: 0
		noEffect: 100
		moonwalk: 0
		andMaximumMoonwalkSteps: 5.
	^ distributor boardOfLength: 80
]

{ #category : #'create tests' }
GameTest >> gameDistributedWithPlayer: playerNamedLeo and: playerNamedGlenn [
	| lapsAmount board die game deck |
	noEffect := NoEffect new.
	speedUpEffect := SpeedUpEffect new.
	wormHoleEffect := WormholeEffect new.
	moonWalkEffect := MoonWalkEffect withSteps: 2.
	atomicEffect := AtomicEffect new.
	board := {speedUpEffect.
	speedUpEffect.
	noEffect.
	noEffect.
	noEffect.
	noEffect.
	wormHoleEffect.
	wormHoleEffect.
	moonWalkEffect.
	speedUpEffect} asOrderedCollection.
	deck := CircularIterator over: {OverloadCard new}.
	die := Die withSides: 4 andGenerator: (CircularIterator over: {1 . 7 . 3 . 8 . 1 . 6 . 10 . 1 . 5 . 6 . 3}).
	lapsAmount := 3.
	game := Game
		playedBy:
			{playerNamedLeo.
			playerNamedGlenn}
		throwing: {die}
		using: deck
		in: board
		andAmountOfLaps: lapsAmount.
	^ game
]

{ #category : #'test laps' }
GameTest >> gameForLapsWithPlayer: playerNamedLeo and: playerNamedGlenn and: playerNamedAlbert [
	| oneMoreDie anotherDie board die game deck |
	board := UtilitiesForTests collectionOf20NoEffect.
	deck := CircularIterator over: {OverloadCard new}.
	die := Die withSides: 4 andGenerator: (CircularIterator over: {1 . 7 . 1}).
	anotherDie := Die withSides: 4 andGenerator: (CircularIterator over: {1 . 7 . 1}).
	oneMoreDie := Die withSides: 4 andGenerator: (CircularIterator over: {1 . 7 . 1}).
	game := Game
		playedBy:
			{playerNamedLeo.
			playerNamedAlbert.
			playerNamedGlenn}
		throwing:
			{die.
			anotherDie.
			oneMoreDie}
		using: deck
		in: board
		andAmountOfLaps: 2.
	^ game
]

{ #category : #'test laps' }
GameTest >> gameForPositionForWithPlayer: playerNamedLeo and: playerNamedGlenn and: playerNamedAlbert [
	| oneMoreDie anotherDie board die game deck |
	board := UtilitiesForTests collectionOf20NoEffect.
	deck := CircularIterator over: {OverloadCard new}.
	die := Die withSides: 4 andGenerator: (CircularIterator over: {1 . 5 . 1}).
	anotherDie := Die withSides: 4 andGenerator: (CircularIterator over: {1 . 5 . 1}).
	oneMoreDie := Die withSides: 4 andGenerator: (CircularIterator over: {1 . 5 . 1}).
	game := Game
		playedBy:
			{playerNamedLeo.
			playerNamedAlbert.
			playerNamedGlenn}
		throwing:
			{die.
			anotherDie.
			oneMoreDie}
		using: deck
		in: board
		andAmountOfLaps: 2.
	^ game
]

{ #category : #'test results' }
GameTest >> gameForResultsAnotherIteratorWithPlayer: playerNamedLeo and: playerNamedGlenn and: playerNamedAlbert [
	| oneMoreDie anotherDie board die game deck |
	board := self collectionOf16NoEffect.
	deck := CircularIterator over: {OverloadCard new}.
	die := Die withSides: 4 andGenerator: (CircularIterator over: {1 . 2 . 3 . 4}).
	anotherDie := Die withSides: 6 andGenerator: (CircularIterator over: {1 . 2 . 3 . 4 . 5 . 6}).
	oneMoreDie := Die withSides: 5 andGenerator: (CircularIterator over: {1 . 2 . 3 . 4 . 5}).
	game := Game
		playedBy:
			{playerNamedLeo.
			playerNamedAlbert.
			playerNamedGlenn}
		throwing:
			{die.
			anotherDie.
			oneMoreDie}
		using: deck
		in: board
		andAmountOfLaps: 1.
	^ game
]

{ #category : #'test results' }
GameTest >> gameForResultsIteratorWithPlayer: playerNamedLeo and: playerNamedGlenn and: playerNamedAlbert [
	| oneMoreDie anotherDie board die game deck |
	board := self collectionOf80NoEffect.
	deck := CircularIterator over: {OverloadCard new}.
	die := Die withSides: 6 andGenerator: (CircularIterator over: {1 . 2 . 3 . 5 . 6 . 40}).
	anotherDie := Die withSides: 6 andGenerator: (CircularIterator over: {1 . 2 . 3 . 5 . 6 . 40}).
	oneMoreDie := Die withSides: 6 andGenerator: (CircularIterator over: {1 . 2 . 3 . 5 . 6 . 40}).
	"this way, we are assured that the third player will win"
	game := Game
		playedBy:
			{playerNamedLeo.
			playerNamedAlbert.
			playerNamedGlenn}
		throwing:
			{die.
			anotherDie.
			oneMoreDie}
		using: deck
		in: board
		andAmountOfLaps: 1.
	^ game
]

{ #category : #'test return' }
GameTest >> gameForReturnLenghtOf: board [
	| playerNamedLeo collection playerNamedGlenn lapsAmount die game deck |
	playerNamedLeo := Player named: 'Leo'.
	playerNamedGlenn := Player named: 'Glenn'.
	collection := {1 . 2 . 3 . 4 . 5}.
	deck := CircularIterator over: {OverloadCard new}.
	die := Die withSides: 4 andGenerator: (CircularIterator over: collection).
	lapsAmount := 3.
	game := Game
		playedBy:
			{playerNamedLeo.
			playerNamedGlenn}
		throwing:
			{die.
			die}
		using: deck
		in: board
		andAmountOfLaps: lapsAmount.
	^ game
]

{ #category : #'turn tests' }
GameTest >> gameForTurnOrderLike: playerNamedLeo and: playerNamedGlenn [
	| die game collection board deck |
	collection := {1 . 2 . 3 . 4 . 5}.
	deck := CircularIterator over: {OverloadCard new}.
	die := Die withSides: 4 andGenerator: (CircularIterator over: collection).
	board := UtilitiesForTests collectionOf20NoEffect.
	game := Game
		playedBy:
			{playerNamedLeo.
			playerNamedGlenn}
		throwing:
			{die.
			die}
		using: deck
		in: board
		andAmountOfLaps: 1.
	self assert: game boardLength equals: 20.
	self assert: (game positionFor: playerNamedLeo) equals: 1.
	self assert: (game positionFor: playerNamedGlenn) equals: 1.
	self
		assert: game dice
		equals:
			{die.
			die}.
	^ game
]

{ #category : #'turn tests' }
GameTest >> gameUsingAnAtomicEffectWithPlayer: playerNamedLeo and: playerNamedGlenn [
	| collection lapsAmount board die game deck |
	collection := {1}.
	deck := CircularIterator over: {OverloadCard new}.
	die := Die withSides: 4 andGenerator: (CircularIterator over: collection).
	board := {NoEffect new.
	NoEffect new.
	AtomicEffect new.
	NoEffect new.
	NoEffect new}.
	lapsAmount := 3.
	game := Game
		playedBy:
			{playerNamedLeo.
			playerNamedGlenn}
		throwing: {die}
		using: deck
		in: board
		andAmountOfLaps: lapsAmount.
	^ game
]

{ #category : #'turn tests' }
GameTest >> gameUsingAnotherAtomicEffectWithPlayer: playerNamedLeo and: playerNamedGlenn [
	| collection lapsAmount board die game deck |
	collection := {6 . 6 . 1}.
	deck := CircularIterator over: {OverloadCard new}.
	die := Die withSides: 4 andGenerator: (CircularIterator over: collection).
	board := {NoEffect new.
	NoEffect new.
	AtomicEffect new.
	NoEffect new.
	NoEffect new}.
	lapsAmount := 3.
	game := Game
		playedBy:
			{playerNamedLeo.
			playerNamedGlenn}
		throwing: {die}
		using: deck
		in: board
		andAmountOfLaps: lapsAmount.
	^ game
]

{ #category : #'cards tests' }
GameTest >> gameUsingCardsWithFirstPlayer: playerNamedLeo andSecondPlayer: playerNamedGlenn WithDeck: aDeck [
	| collection board die game |
	collection := {1 . 2 . 3 . 4 . 5 . 20}.
	die := Die
		withSides: 4
		andGenerator: (CircularIterator over: collection).
	board := UtilitiesForTests collectionOf20NoEffect.
	self assert: playerNamedLeo quantityOfCardsInHand equals: 0.
	self assert: playerNamedGlenn quantityOfCardsInHand equals: 0.
	game := Game
		playedBy:
			{playerNamedLeo.
			playerNamedGlenn}
		throwing:
			{die}
		using: aDeck
		in: board
		andAmountOfLaps: 1.
		^game
]

{ #category : #'cards tests' }
GameTest >> gameUsingRandomCardsWithFirstPlayer: playerNamedLeo andSecondPlayer: playerNamedGlenn [
	| collection deck board die game |
	deck := RandomElementSelector
		over:
			{OverloadCard new.
			SpeedCard new.
			AccelerationCard new.
			CancellationCard new.
			RedoCard new.
			RepeatCard new}.
	collection := {1 . 2 . 3 . 4 . 5}.
	die := Die
		withSides: 4
		andGenerator: (CircularIterator over: collection).
	board := UtilitiesForTests collectionOf20NoEffect.
	self assert: playerNamedLeo quantityOfCardsInHand equals: 0.
	self assert: playerNamedGlenn quantityOfCardsInHand equals: 0.
	game := Game
		playedBy:
			{playerNamedLeo.
			playerNamedGlenn}
		throwing:
			{die}
		using: deck
		in: board
		andAmountOfLaps: 1
]

{ #category : #'test laps' }
GameTest >> gameWith5NoEffectBoardWithPlayer: playerNamedLeo [
	| die game board deck |
	board := self collectionOf5NoEffect.
	deck := CircularIterator over: {OverloadCard new}.
	die := Die withSides: 4 andGenerator: (CircularIterator over: {5}).
	game := Game
		playedBy: {playerNamedLeo}
		throwing: {die}
		using: deck
		in: board
		andAmountOfLaps: 3.
	^ game
]

{ #category : #'turn tests' }
GameTest >> gameWithPlayer: playerNamedGlenn and: playerNamedLeo and: playerNamedAlbert [
	| oneMoreDie anotherDie board die game deck |
	board := UtilitiesForTests collectionOf20NoEffect.
	deck := CircularIterator over: {OverloadCard new}.
	die := Die withSides: 4 andGenerator: (CircularIterator over: {1 . 2 . 3 . 4}).
	anotherDie := Die withSides: 6 andGenerator: (CircularIterator over: {1 . 2 . 3 . 4 . 5 . 6}).
	oneMoreDie := Die withSides: 5 andGenerator: (CircularIterator over: {1 . 2 . 3 . 4 . 5}).
	game := Game
		playedBy:
			{playerNamedLeo.
			playerNamedAlbert.
			playerNamedGlenn}
		throwing:
			{die.
			anotherDie.
			oneMoreDie}
		using: deck
		in: board
		andAmountOfLaps: 1.
	^ game
]

{ #category : #'turn tests' }
GameTest >> gameWithPlayer: playerNamedLeo and: playerNamedGlenn usingEffect: effect [
	| collection lapsAmount board die game deck |
	collection := {1}.
	deck := CircularIterator over: {OverloadCard new}.
	die := Die withSides: 4 andGenerator: (CircularIterator over: collection).
	board := {NoEffect new.
	effect.
	NoEffect new.
	NoEffect new.
	NoEffect new}.
	lapsAmount := 3.
	game := Game
		playedBy:
			{playerNamedLeo.
			playerNamedGlenn}
		throwing: {die}
		using: deck
		in: board
		andAmountOfLaps: lapsAmount.
	^ game
]

{ #category : #'create tests' }
GameTest >> testCreateGame [
	| game playerNamedLeo playerNamedGlenn die board collection deck |
	playerNamedLeo := Player named: 'Leo'.
	playerNamedGlenn := Player named: 'Glenn'.
	deck := CircularIterator over: {OverloadCard new}.
	collection := {1 . 2 . 3 . 4 . 5}.
	die := Die withSides: 4 andGenerator: (CircularIterator over: collection).
	board := UtilitiesForTests collectionOf20NoEffect.
	game := Game
		playedBy:
			{playerNamedLeo.
			playerNamedGlenn}
		throwing:
			{die.
			die}
		using: deck
		in: board
		andAmountOfLaps: 1.
	self assert: game boardLength equals: 20.
	self assert: (game positionFor: playerNamedLeo) equals: 1.
	self assert: (game positionFor: playerNamedGlenn) equals: 1.
	self
		assert: game dice
		equals:
			{die.
			die}
]

{ #category : #'create tests' }
GameTest >> testCreateGameWithBoard [
	| board game playerNamedLeo playerNamedGlenn die collection lapsAmount deck |
	playerNamedLeo := Player named: 'Leo'.
	playerNamedGlenn := Player named: 'Glenn'.
	deck := CircularIterator over: {OverloadCard new}.
	collection := {1 . 2 . 3 . 4 . 5}.
	die := Die withSides: 4 andGenerator: (CircularIterator over: collection).
	board := {NoEffect new.
	WormholeEffect new.
	SpeedUpEffect new.
	AtomicEffect new.
	(MoonWalkEffect withSteps: 1)}.
	lapsAmount := 3.
	game := Game
		playedBy:
			{playerNamedLeo.
			playerNamedGlenn}
		throwing:
			{die.
			die}
		using: deck
		in: board
		andAmountOfLaps: lapsAmount.
	self assert: game board equals: board
]

{ #category : #'create tests' }
GameTest >> testCreateGameWithDistributedBoardGiveRanking [
	| game playerNamedLeo playerNamedGlenn |
	playerNamedLeo := Player named: 'Leo'.
	playerNamedGlenn := Player named: 'Glenn'.
	game := self gameDistributedWithPlayer: playerNamedLeo and: playerNamedGlenn.
	"First turn:"
	self assert: (game positionFor: playerNamedLeo) equals: 1.
	self assert: (game lapFor: playerNamedLeo) equals: 0.
	self assert: (game positionFor: playerNamedGlenn) equals: 1.
	self assert: (game lapFor: playerNamedGlenn) equals: 0.
	playerNamedLeo takesATurnIn: game.	"dice rolls 1, ends in position 2."
	self assert: (game positionFor: playerNamedLeo) equals: 6.	"SpeedUp effect applied, goes 4 positions forward."
	self assert: (game lapFor: playerNamedLeo) equals: 0.
	playerNamedGlenn takesATurnIn: game.	"dice rolls 7, ends in position 8"
	self assert: (game positionFor: playerNamedGlenn) equals: 4.	"Wormhole effect applied, goes 4 positions backwards."
	self assert: (game lapFor: playerNamedGlenn) equals: 0.
	"Second turn:"
	playerNamedLeo takesATurnIn: game.	"dice rolls 3, ends in position 9"
	self assert: (game positionFor: playerNamedLeo) equals: 9.	"moonwalk effect applied, Glenn goes 2 positions backwards."
	self assert: (game lapFor: playerNamedLeo) equals: 0.
	playerNamedGlenn takesATurnIn: game.	"dice rolls 8, ends in position 10"
	self assert: (game positionFor: playerNamedGlenn) equals: 4.	"SpeedUp effect applied, ends 4 positions forward. Ends in next lap."
	self assert: (game lapFor: playerNamedGlenn) equals: 1.
	"Third turn:"
	playerNamedLeo takesATurnIn: game.	"dice rolls 1, ends in position 10"
	self assert: (game positionFor: playerNamedLeo) equals: 4.	"SpeedUp effect applied, ends 4 positions forward in next lap."
	self assert: (game lapFor: playerNamedLeo) equals: 1.
	playerNamedGlenn takesATurnIn: game.	"dice rolls 6, ends in position 10"
	self assert: (game positionFor: playerNamedGlenn) equals: 4.	"SpeedUp effect applied, ends 4 positions forward. Ends in next lap."
	self assert: (game lapFor: playerNamedGlenn) equals: 2.
	"Fourth turn:"
	playerNamedLeo takesATurnIn: game.	"dice rolls 10, ends in the same position, next lap."
	self assert: (game positionFor: playerNamedLeo) equals: 4.
	self assert: (game lapFor: playerNamedLeo) equals: 2.
	playerNamedGlenn takesATurnIn: game.	"dice rolls 1, ends in position 5"
	self assert: (game positionFor: playerNamedGlenn) equals: 5.
	self assert: (game lapFor: playerNamedGlenn) equals: 2.
	"Fifth turn:"
	playerNamedLeo takesATurnIn: game.	"dice rolls 5, ends in position 9"
	self assert: (game positionFor: playerNamedLeo) equals: 9.	"moonwalk effect applied, Glenn goes 2 positions backwards."
	self assert: (game lapFor: playerNamedLeo) equals: 2.
	playerNamedGlenn takesATurnIn: game.	"dice rolls 6, ends in position 9"
	self assert: (game positionFor: playerNamedGlenn) equals: 9.	"moonwalk effect applied, Leo goes 2 positions backwards."
	self assert: (game lapFor: playerNamedGlenn) equals: 2.
	"Sixth turn:"
	playerNamedLeo takesATurnIn: game.	"dice rolls 3, ends in position 10"
	self assert: (game positionFor: playerNamedLeo) equals: 4.	"SpeedUp effect applied, goes 4 positions forward. Ends in next lap. Leo wins"
	self assert: (game lapFor: playerNamedLeo) equals: 3.
	self assert: (game positionFor: playerNamedGlenn) equals: 9.
	self assert: (game lapFor: playerNamedGlenn) equals: 2.
	self
		assert: game ranking
		hasTheSameOrderThan:
			{playerNamedLeo.
			playerNamedGlenn}
]

{ #category : #'create tests' }
GameTest >> testCreateGameWithLaps [
	| game playerNamedLeo playerNamedGlenn die board collection lapsAmount deck |
	playerNamedLeo := Player named: 'Leo'.
	playerNamedGlenn := Player named: 'Glenn'.
	deck := CircularIterator over: {OverloadCard new}.
	collection := {1 . 2 . 3 . 4 . 5}.
	die := Die withSides: 4 andGenerator: (CircularIterator over: collection).
	board := UtilitiesForTests collectionOf20NoEffect.
	lapsAmount := 3.
	game := Game
		playedBy:
			{playerNamedLeo.
			playerNamedGlenn}
		throwing:
			{die.
			die}
		using: deck
		in: board
		andAmountOfLaps: lapsAmount.
	self assert: game laps equals: 3
]

{ #category : #'turn tests' }
GameTest >> testCreateGameWithTurnOrder [
	| game playerNamedLeo playerNamedGlenn |
	playerNamedLeo := Player named: 'Leo'.
	playerNamedGlenn := Player named: 'Glenn'.
	game := self gameForTurnOrderLike: playerNamedLeo and: playerNamedGlenn.
	self
		assert: game turnOrder
		equals:
			{playerNamedLeo.
			playerNamedGlenn}
]

{ #category : #'test laps' }
GameTest >> testGameWithLapsHasEnded [
	| game playerNamedLeo |
	playerNamedLeo := Player named: 'Leo'.
	game := self gameWith5NoEffectBoardWithPlayer: playerNamedLeo.
	self assert: (game lapFor: playerNamedLeo) equals: 0.
	self assert: (game positionFor: playerNamedLeo) equals: 1.
	playerNamedLeo takesATurnIn: game.
	self assert: (game lapFor: playerNamedLeo) equals: 1.
	self assert: (game positionFor: playerNamedLeo) equals: 1.
	playerNamedLeo takesATurnIn: game.
	self assert: (game lapFor: playerNamedLeo) equals: 2.
	self assert: (game positionFor: playerNamedLeo) equals: 1.
	playerNamedLeo takesATurnIn: game.
	self assert: (game lapFor: playerNamedLeo) equals: 3.
	self assert: (game positionFor: playerNamedLeo) equals: 1.
	self
		should: [ playerNamedLeo takesATurnIn: game ]
		raise: AssertionFailure
		withExceptionDo: [ :signal | self assert: signal messageText equals: 'The game is over...' ].
	self assert: (game lapFor: playerNamedLeo) equals: 3.
	self assert: (game positionFor: playerNamedLeo) equals: 1
]

{ #category : #'test results' }
GameTest >> testGiveResultUsingAnotherCircularIterator [
	| game playerNamedLeo playerNamedAlbert playerNamedGlenn |
	playerNamedLeo := Player named: 'Leo'.
	playerNamedAlbert := Player named: 'Albert'.
	playerNamedGlenn := Player named: 'Glenn'.
	game := self
		gameForResultsAnotherIteratorWithPlayer: playerNamedLeo
		and: playerNamedGlenn
		and: playerNamedAlbert.
	"1st round start:"
	playerNamedLeo takesATurnIn: game.
	playerNamedAlbert takesATurnIn: game.
	playerNamedGlenn takesATurnIn: game.
	"1st round end."
	self assert: (game positionFor: playerNamedLeo) equals: 4.
	self assert: (game positionFor: playerNamedAlbert) equals: 7.
	self assert: (game positionFor: playerNamedGlenn) equals: 10.
	"2nd round start:"
	playerNamedLeo takesATurnIn: game.
	self
		should: [ playerNamedAlbert takesATurnIn: game ]
		raise: AssertionFailure
		withExceptionDo: [ :signal | self assert: signal messageText equals: 'The game is over...' ].
	self
		should: [ playerNamedGlenn takesATurnIn: game ]
		raise: AssertionFailure
		withExceptionDo: [ :signal | self assert: signal messageText equals: 'The game is over...' ].
	"2nd round end."
	"results:"
	self assert: (game positionFor: playerNamedLeo) equals: 16.
	self assert: (game positionFor: playerNamedAlbert) equals: 7.
	self assert: (game positionFor: playerNamedGlenn) equals: 10
]

{ #category : #'test results' }
GameTest >> testGiveResultUsingCircularIterator [
	| game playerNamedLeo playerNamedAlbert playerNamedGlenn |
	playerNamedLeo := Player named: 'Leo'.
	playerNamedAlbert := Player named: 'Albert'.
	playerNamedGlenn := Player named: 'Glenn'.
	game := self
		gameForResultsIteratorWithPlayer: playerNamedLeo
		and: playerNamedGlenn
		and: playerNamedAlbert.
	"1st round start:"
	playerNamedLeo takesATurnIn: game.
	playerNamedAlbert takesATurnIn: game.
	playerNamedGlenn takesATurnIn: game.
	"1st round end."
	"2nd round start:"
	playerNamedLeo takesATurnIn: game.
	playerNamedAlbert takesATurnIn: game.
	playerNamedGlenn takesATurnIn: game.
	"2nd round end."
	"results:"
	self assert: (game positionFor: playerNamedLeo) equals: 19.
	self assert: (game positionFor: playerNamedAlbert) equals: 25.
	self assert: (game positionFor: playerNamedGlenn) equals: 50
]

{ #category : #'test laps' }
GameTest >> testLapForPlayer [
	| game playerNamedLeo playerNamedAlbert playerNamedGlenn |
	playerNamedLeo := Player named: 'Leo'.
	playerNamedAlbert := Player named: 'Albert'.
	playerNamedGlenn := Player named: 'Glenn'.
	game := self
		gameForLapsWithPlayer: playerNamedLeo
		and: playerNamedGlenn
		and: playerNamedAlbert.
	playerNamedLeo takesATurnIn: game.
	self assert: (game lapFor: playerNamedLeo) equals: 0.
	playerNamedAlbert takesATurnIn: game.
	self assert: (game positionFor: playerNamedAlbert) equals: 2.
	self assert: (game lapFor: playerNamedAlbert) equals: 1.
	playerNamedGlenn takesATurnIn: game.
	self assert: (game lapFor: playerNamedGlenn) equals: 0.
	playerNamedLeo takesATurnIn: game.
	self assert: (game lapFor: playerNamedLeo) equals: 0.
	playerNamedAlbert takesATurnIn: game.
	self assert: (game positionFor: playerNamedAlbert) equals: 3.
	self assert: (game lapFor: playerNamedAlbert) equals: 2
]

{ #category : #'test laps' }
GameTest >> testPositionForWithLaps [
	| game playerNamedLeo playerNamedAlbert playerNamedGlenn |
	playerNamedLeo := Player named: 'Leo'.
	playerNamedAlbert := Player named: 'Albert'.
	playerNamedGlenn := Player named: 'Glenn'.
	game := self
		gameForPositionForWithPlayer: playerNamedLeo
		and: playerNamedGlenn
		and: playerNamedAlbert.
	playerNamedLeo takesATurnIn: game.
	self assert: (game positionFor: playerNamedLeo) equals: 4.
	playerNamedAlbert takesATurnIn: game.
	self assert: (game positionFor: playerNamedAlbert) equals: 16.
	playerNamedGlenn takesATurnIn: game.
	self assert: (game positionFor: playerNamedGlenn) equals: 4.
	playerNamedLeo takesATurnIn: game.
	self assert: (game positionFor: playerNamedLeo) equals: 7.
	playerNamedAlbert takesATurnIn: game.
	self assert: (game positionFor: playerNamedAlbert) equals: 11
]

{ #category : #'test return' }
GameTest >> testReturnLengthOfBoard [
	| board game |
	board := {NoEffect new.
	WormholeEffect new.
	SpeedUpEffect new.
	AtomicEffect new.
	(MoonWalkEffect withSteps: 1)}.
	game := self gameForReturnLenghtOf: board.
	self assert: game boardLength equals: board size
]

{ #category : #'test return' }
GameTest >> testReturnRanking [
	| game playerNamedLeo playerNamedAlbert playerNamedGlenn |
	playerNamedLeo := Player named: 'Leo'.
	playerNamedAlbert := Player named: 'Albert'.
	playerNamedGlenn := Player named: 'Glenn'.
	game := self gameForResultsAnotherIteratorWithPlayer: playerNamedLeo and: playerNamedGlenn and: playerNamedAlbert.
	"1st round start:"
	playerNamedLeo takesATurnIn: game.
	playerNamedAlbert takesATurnIn: game.
	playerNamedGlenn takesATurnIn: game.
	"1st round end."
	self assert: (game positionFor: playerNamedLeo) equals: 4.
	self assert: (game positionFor: playerNamedAlbert) equals: 7.
	self assert: (game positionFor: playerNamedGlenn) equals: 10.
	self
		assert: game ranking
		hasTheSameOrderThan:
			{playerNamedGlenn.
			playerNamedAlbert.
			playerNamedLeo}.
	"2nd round start:"
	playerNamedLeo takesATurnIn: game.
	"2nd round end."
	"results:"
	self assert: (game positionFor: playerNamedLeo) equals: 16.
	self assert: (game positionFor: playerNamedAlbert) equals: 7.
	self assert: (game positionFor: playerNamedGlenn) equals: 10
]

{ #category : #'turn tests' }
GameTest >> testSimulateTurn [
	| game playerNamedLeo playerNamedAlbert playerNamedGlenn |
	playerNamedLeo := Player named: 'Leo'.
	playerNamedAlbert := Player named: 'Albert'.
	playerNamedGlenn := Player named: 'Glenn'.
	game := self
		gameWithPlayer: playerNamedGlenn
		and: playerNamedLeo
		and: playerNamedAlbert.
	playerNamedLeo takesATurnIn: game.
	playerNamedAlbert takesATurnIn: game.
	playerNamedGlenn takesATurnIn: game.
	self assert: (game positionFor: playerNamedLeo) equals: 4.
	self assert: (game positionFor: playerNamedAlbert) equals: 7.
	self assert: (game positionFor: playerNamedGlenn) equals: 10
]

{ #category : #'turn tests' }
GameTest >> testSimulateTurnWithAtomicEffect [
	| game playerNamedLeo playerNamedGlenn |
	playerNamedLeo := Player named: 'Leo'.
	playerNamedGlenn := Player named: 'Glenn'.
	game := self
		gameUsingAnAtomicEffectWithPlayer: playerNamedLeo
		and: playerNamedGlenn.
	playerNamedLeo takesATurnIn: game.
	self assert: (game positionFor: playerNamedLeo) equals: 2.
	self assert: (game lapFor: playerNamedLeo) equals: 0.
	playerNamedGlenn takesATurnIn: game.
	self assert: (game positionFor: playerNamedGlenn) equals: 2.
	self assert: (game lapFor: playerNamedGlenn) equals: 0.
	playerNamedLeo takesATurnIn: game.
	self assert: (game positionFor: playerNamedLeo) equals: 1.
	self assert: (game lapFor: playerNamedLeo) equals: 0.
	self assert: (game positionFor: playerNamedGlenn) equals: 1.
	self assert: (game lapFor: playerNamedGlenn) equals: 0
]

{ #category : #'turn tests' }
GameTest >> testSimulateTurnWithAtomicEffectOnLapNumber1 [
	| game playerNamedLeo playerNamedGlenn |
	playerNamedLeo := Player named: 'Leo'.
	playerNamedGlenn := Player named: 'Glenn'.
	game := self
		gameUsingAnotherAtomicEffectWithPlayer: playerNamedLeo
		and: playerNamedGlenn.
	playerNamedLeo takesATurnIn: game.
	self assert: (game positionFor: playerNamedLeo) equals: 2.
	self assert: (game lapFor: playerNamedLeo) equals: 1.
	playerNamedGlenn takesATurnIn: game.
	self assert: (game positionFor: playerNamedGlenn) equals: 2.
	self assert: (game lapFor: playerNamedGlenn) equals: 1.
	playerNamedLeo takesATurnIn: game.
	self assert: (game positionFor: playerNamedLeo) equals: 1.
	self assert: (game lapFor: playerNamedLeo) equals: 1.
	self assert: (game positionFor: playerNamedGlenn) equals: 1.
	self assert: (game lapFor: playerNamedGlenn) equals: 1
]

{ #category : #'turn tests' }
GameTest >> testSimulateTurnWithCorrectOrderOfPlayers [
	| game playerNamedLeo playerNamedAlbert playerNamedGlenn |
	playerNamedLeo := Player named: 'Leo'.
	playerNamedAlbert := Player named: 'Albert'.
	playerNamedGlenn := Player named: 'Glenn'.
	game := self gameWithPlayer: playerNamedGlenn and: playerNamedLeo and: playerNamedAlbert.
	self assert: game currentPlayerTurn equals: playerNamedLeo.
	playerNamedLeo takesATurnIn: game.
	self assert: game currentPlayerTurn equals: playerNamedAlbert.
	playerNamedAlbert takesATurnIn: game.
	self assert: game currentPlayerTurn equals: playerNamedGlenn.
	playerNamedGlenn takesATurnIn: game.
	self assert: (game positionFor: playerNamedLeo) equals: 4.
	self assert: (game positionFor: playerNamedAlbert) equals: 7.
	self assert: (game positionFor: playerNamedGlenn) equals: 10
]

{ #category : #'turn tests' }
GameTest >> testSimulateTurnWithMoonWalkEffect [
	| game playerNamedLeo playerNamedGlenn moonwalk |
	
	playerNamedLeo := Player named: 'Leo'.
	playerNamedGlenn := Player named: 'Glenn'.
	moonwalk := MoonWalkEffect withSteps: 2.
	game := self gameWithPlayer: playerNamedLeo and: playerNamedGlenn usingEffect: moonwalk.
	self assert: (game positionFor: playerNamedLeo) equals: 1.
	self assert: (game lapFor: playerNamedLeo) equals: 0.
	self assert: (game positionFor: playerNamedLeo) equals: 1.
	self assert: (game lapFor: playerNamedLeo) equals: 0.
	playerNamedLeo takesATurnIn: game.
	self assert: (game positionFor: playerNamedLeo) equals: 2.	"Leo was in position 1 (NoEffect), die rolled 1, goes to position 2 but there's a MoonWalk (with 2 steps)"
	self assert: (game lapFor: playerNamedLeo) equals: 0.
	self assert: (game positionFor: playerNamedGlenn) equals: 4. "everyone else (Glenn) goes 2 positions backwards, they end in position 4 on lap -1."
	self assert: (game lapFor: playerNamedGlenn) equals: -1

]

{ #category : #'turn tests' }
GameTest >> testSimulateTurnWithSpeedUpEffect [
	| game playerNamedLeo playerNamedGlenn |
	playerNamedLeo := Player named: 'Leo'.
	playerNamedGlenn := Player named: 'Glenn'.
	game := self
		gameWithPlayer: playerNamedLeo
		and: playerNamedGlenn
		usingEffect: SpeedUpEffect new.
	playerNamedLeo takesATurnIn: game.
	self assert: (game positionFor: playerNamedLeo) equals: 1.
	self assert: (game lapFor: playerNamedLeo) equals: 1
	"was in position 1 (NoEffect), die rolled 1, goes to position 2 but there's a SpeedUp, goes 4 positions forward, ends in position 1 on lap 1."
]

{ #category : #'turn tests' }
GameTest >> testSimulateTurnWithWormholeEffect [
	|  game playerNamedLeo playerNamedGlenn  |
	playerNamedLeo := Player named: 'Leo'.
	playerNamedGlenn := Player named: 'Glenn'.
	game := self
		gameWithPlayer: playerNamedLeo
		and: playerNamedGlenn
		usingEffect: WormholeEffect new.
	playerNamedLeo takesATurnIn: game.
	self assert: (game positionFor: playerNamedLeo) equals: 3.
	self assert: (game lapFor: playerNamedLeo) equals: -1
	"was in position 1 (NoEffect), die rolled 1, goes to position 2 but there's a Wormhole, goes back 4 positions, ends in position 3 on lap -1."
]

{ #category : #'turn tests' }
GameTest >> testSimulateTurnWithWrongOrderOfPlayersRaisesException [
	| game playerNamedLeo playerNamedAlbert playerNamedGlenn |
	playerNamedLeo := Player named: 'Leo'.
	playerNamedAlbert := Player named: 'Albert'.
	playerNamedGlenn := Player named: 'Glenn'.
	game := self gameWithPlayer: playerNamedGlenn and: playerNamedLeo and: playerNamedAlbert.
	self assert: game currentPlayerTurn equals: playerNamedLeo.
	playerNamedLeo takesATurnIn: game.
	self assert: game currentPlayerTurn equals: playerNamedAlbert.
	self
		should: [ playerNamedGlenn takesATurnIn: game ]
		raise: AssertionFailure
		withExceptionDo: [ :signal | self assert: signal messageText equals: 'This isn''t the turn of Glenn' ].
	playerNamedAlbert takesATurnIn: game.
	self assert: game currentPlayerTurn equals: playerNamedGlenn.
	playerNamedGlenn takesATurnIn: game.
	self assert: (game positionFor: playerNamedLeo) equals: 4.
	self assert: (game positionFor: playerNamedAlbert) equals: 7.
	self assert: (game positionFor: playerNamedGlenn) equals: 10
]

{ #category : #'cards tests' }
GameTest >> testUsingCardsGivesTwoCardsAtStartToEachPlayer [
	| playerNamedLeo playerNamedGlenn game |
	playerNamedLeo := Player named: 'Leo'.
	playerNamedGlenn := Player named: 'Glenn'.
	game := self
		gameUsingRandomCardsWithFirstPlayer: playerNamedLeo
		andSecondPlayer: playerNamedGlenn.
	self assert: playerNamedLeo quantityOfCardsInHand equals: 2.
	self assert: playerNamedGlenn quantityOfCardsInHand equals: 2
]

{ #category : #'cards tests' }
GameTest >> testWithCardAndGiveRanking [
	| playerNamedLeo playerNamedGlenn game deck overload speed acceleration cancellation |
	playerNamedLeo := Player named: 'Leo'.
	playerNamedGlenn := Player named: 'Glenn'.
	overload := OverloadCard new.
	speed := SpeedCard new.
	acceleration := AccelerationCard new.
	cancellation := CancellationCard new.
	deck := CircularIterator
		over:
			{overload.
			speed.
			acceleration.
			cancellation}.
	game := self
		gameUsingCardsWithFirstPlayer: playerNamedLeo
		andSecondPlayer: playerNamedGlenn
		WithDeck: deck.
	self assert: playerNamedLeo quantityOfCardsInHand equals: 2.
	self assert: playerNamedGlenn quantityOfCardsInHand equals: 2.
	"First round"
	self assert: (game positionFor: playerNamedLeo) equals: 1.
	self assert: (game positionFor: playerNamedGlenn) equals: 1.
	playerNamedLeo uses: overload on: game affecting: playerNamedGlenn.
	playerNamedLeo takesATurnIn: game.
	self assert: (game positionFor: playerNamedLeo) equals: 2.
	playerNamedGlenn uses: acceleration on: game affecting: playerNamedLeo.
	playerNamedGlenn takesATurnIn: game.
	"Second round"
	self assert: (game positionFor: playerNamedLeo) equals: 2.
	self assert: (game positionFor: playerNamedGlenn) equals: 2.
	playerNamedLeo uses: speed on: game affecting: playerNamedLeo.
	playerNamedGlenn uses: cancellation on: game affecting: overload.
	playerNamedLeo takesATurnIn: game.
	self assert: (game positionFor: playerNamedLeo) equals: 7.
	playerNamedGlenn takesATurnIn: game.
	"Third round"
	self assert: (game positionFor: playerNamedLeo) equals: 7.
	self assert: (game positionFor: playerNamedGlenn) equals: 7.
	playerNamedLeo takesATurnIn: game.
	self assert: (game positionFor: playerNamedLeo) equals: 14.
	playerNamedGlenn takesATurnIn: game.
	self assert: (game positionFor: playerNamedGlenn) equals: 8.
	self assert: (game ranking ) equals: { playerNamedGlenn . playerNamedLeo} asOrderedCollection 
]
