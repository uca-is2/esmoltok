Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'boardLength',
		'dice',
		'finished',
		'playersPosition'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Game class >> playedBy: aPlayer throwing: aDice inABoardOfLenght: aBoardLength [
	^ self new initializeWithLength: aBoardLength dice: aDice player: aPlayer
]

{ #category : #accessing }
Game >> boardLength [
	^ boardLength
]

{ #category : #accessing }
Game >> dice [
	^ dice
]

{ #category : #updating }
Game >> endsTheGame [
	finished := true
]

{ #category : #updating }
Game >> gameHasEndedIfBoardLenghtHasBeenReachedBy: aPlayer [
	(self positionOfPlayers at: aPlayer) >= self boardLength
		ifTrue: [ self endsTheGame ]
]

{ #category : #checking }
Game >> hasEnded [
	^ finished
]

{ #category : #initialization }
Game >> initializeWithLength: aBoardLength dice: aCollectionOfDice player: aCollectionOfPlayers [
	boardLength := aBoardLength.
	dice := aCollectionOfDice.
	playersPosition := Dictionary new.
	1 to: aCollectionOfPlayers size do: [ :index | playersPosition at: (aCollectionOfPlayers at: index) name put: 0 ].
	finished := false
]

{ #category : #updating }
Game >> letsPlay: aPlayer [
	self hasEnded
		ifFalse: [ | aNumberOfCells |
			aNumberOfCells := aPlayer throwDice: self dice.
			self updatePositionBy: aNumberOfCells OfThePlayerNamed: (aPlayer name)]
]

{ #category : #accessing }
Game >> positionOfPlayers [
	^ playersPosition
]

{ #category : #updating }
Game >> updatePositionBy: aNumberOfCells OfThePlayerNamed: aPlayer [
	self positionOfPlayers at: aPlayer put: (self positionOfPlayers at: aPlayer) + aNumberOfCells.
	self gameHasEndedIfBoardLenghtHasBeenReachedBy: aPlayer
]