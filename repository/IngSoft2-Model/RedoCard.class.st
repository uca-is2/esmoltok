Class {
	#name : #RedoCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #interaction }
RedoCard >> activateOn: aGame to: aPlayerOrCard [
	| card |
	card := aGame lastPlayedCard deepCopy.
	card applyOn: aGame to: aPlayerOrCard
]

{ #category : #interaction }
RedoCard >> applyOn: aGame to: aPlayerOrCard [
	self activateOn: aGame to: aPlayerOrCard
]

{ #category : #validation }
RedoCard >> verifyCardIsApplicableBy: aPlayer on: aGame [
	^ aGame lastPlayedCard verifyCardIsApplicableBy: aPlayer on: aGame
]
