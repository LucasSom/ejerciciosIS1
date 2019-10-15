!classDefinition: #TerniLapilliTest category: #TerniLapilli!
TestCase subclass: #TerniLapilliTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'cmmmmm 10/10/2019 18:54:06'!
test01NewGameIsEmpty
	
	| game |
	game := TerniLapilli new.
	
	self assert: 0 equals: game cantFichasX.
	self assert: 0 equals: game cantFichasO.
	self assert: true equals: game juegaX.
! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'cmmmmm 10/10/2019 18:54:14'!
test02XStartsPlaying
	
	| game |
	game := TerniLapilli new.
	
	self assert: true equals: game juegaX.
	self assert: false equals: game juegaO.
! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'cmmm 10/15/2019 15:41:44'!
test03XPutsInTheCorrectPlace
	
	| game |
	game := TerniLapilli new.
	game putXAt: 1@1.
	
	self assert: 1 equals: game cantFichasX.
	self assert: 0 equals: game cantFichasO.
	self assert: true equals: (game hayXEn: 0@0).
! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'cmmm 10/15/2019 15:41:50'!
test04OPlaysSecond
	
	| game |
	game := TerniLapilli new.
	game putXAt: 1@1.
	
	self assert: true equals: game juegaO.
	self assert: false equals: game juegaX.
	! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'cmmm 10/15/2019 15:41:57'!
test05CannotPlayIfNotMyTurn
	
	| game |
	game := TerniLapilli new.
	
	self should: [ game putOAt: 1@1. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: TerniLapilli invalidPlayerTurn.	
	! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'cmmm 10/15/2019 15:42:08'!
test06CannotPlayXSecond
	
	| game |
	game := TerniLapilli new.
	game putXAt: 1@1.
	
	self should: [ game putXAt: 2@1. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: TerniLapilli invalidPlayerTurn.	
	! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'cmmm 10/15/2019 15:42:26'!
test07XCannotPlayIfPositionIsOccuped
	
	| game |
	game := TerniLapilli new.
	game putXAt: 2@2.
	game putOAt: 1@1.
	
	self should: [ game putXAt: 1@1. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: TerniLapilli invalidPosition.	
	! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'cmmm 10/15/2019 15:42:40'!
test08OCannotPlayIfPositionIsOccuped
	
	| game |
	game := TerniLapilli new.
	game putXAt: 1@1.
	
	self should: [ game putOAt: 1@1. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: TerniLapilli invalidPosition.	
	! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'cmmm 10/15/2019 15:42:48'!
test09OCannotPlayIfPositionOfLimits
	
	| game |
	game := TerniLapilli new.
	game putXAt: 1@1.
	
	self should: [ game putOAt: 4@4. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: TerniLapilli invalidPosition.	
	! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'cmmm 10/15/2019 15:43:13'!
test10XCannotPlayIfPositionOfLimits
	
	| game |
	game := TerniLapilli new.
	
	self should: [ game putXAt: 0@0. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: TerniLapilli invalidPosition.	
	! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'cmmm 10/15/2019 15:56:37'!
test11CannotPlayIf6ThereAre6xxxOnTheGame
	
	| game |
	game := TerniLapilli new.
	game putXAt: 1@1.
	game putOAt: 1@2.
	game putXAt: 1@3.
	game putOAt: 2@1.
	game putXAt: 2@2.
	game putOAt: 2@3.
	
	
	
	self should: [ game putXAt: 3@3. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: TerniLapilli invalidPlayBoardFull.	
	! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'cmmmm 10/15/2019 16:17:41'!
test12CannotMovexxxIfThereAreLessThan6xxxOnTheGame
	
	| game |
	game := TerniLapilli new.
	game putXAt: 1@1.
	
	self should: [ game moveXFrom: 1@1 to:1@2. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: TerniLapilli invalidPlayBoardNotFull.
	! !


!classDefinition: #TerniLapilli category: #TerniLapilli!
Object subclass: #TerniLapilli
	instanceVariableNames: 'cantFichasX cantFichasO fichasJugadasX fichasJugadasO'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'cmmm 10/15/2019 15:15:50'!
cantFichasO

	^fichasJugadasO size.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'cmmm 10/15/2019 15:15:59'!
cantFichasX

	^fichasJugadasX size.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'cmmm 10/15/2019 00:35:42'!
hayXEn: aPoint 

	^true.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'cmmmmm 10/10/2019 18:58:29'!
juegaO

	^ self juegaX not.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'cmmm 10/15/2019 15:17:39'!
juegaX
		
	^(self cantFichasX + self cantFichasO) even ifTrue: [^true] ifFalse: [^false ].! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'cmmmm 10/15/2019 16:27:12'!
moveXFrom: aPoint to: aPoint2
	self error: TerniLapilli invalidPlayBoardNotFull.
	! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'cmmm 10/15/2019 15:40:14'!
putOAt: aPoint 

	(aPoint x between: 1 and: 3) ifFalse: [ self error: TerniLapilli invalidPosition ].
	(aPoint y between: 1 and: 3) ifFalse: [ self error: TerniLapilli invalidPosition ].
	
	self juegaO ifFalse: [ self error: TerniLapilli invalidPlayerTurn ].
	(fichasJugadasO includes: aPoint) ifTrue: [ self error: TerniLapilli invalidPosition.] ifFalse: [(fichasJugadasX includes: aPoint) ifTrue: [ self error: TerniLapilli invalidPosition.] ifFalse: [fichasJugadasO add: aPoint.].].
	! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'cmmmm 10/15/2019 16:05:56'!
putXAt: aPoint 
	
	((fichasJugadasX size + fichasJugadasO size) > 5) ifTrue: [ self error: TerniLapilli invalidPlayBoardFull ].
	(aPoint x between: 1 and: 3) ifFalse: [ self error: TerniLapilli invalidPosition ].
	(aPoint y between: 1 and: 3) ifFalse: [ self error: TerniLapilli invalidPosition ].	
	
	self juegaX ifFalse: [ self error: TerniLapilli invalidPlayerTurn ].
	(fichasJugadasO includes: aPoint) ifTrue: [ self error: TerniLapilli invalidPosition.] ifFalse: [(fichasJugadasX includes: aPoint) ifTrue: [ self error: TerniLapilli invalidPosition.] ifFalse: [fichasJugadasX add: aPoint.].].! !


!TerniLapilli methodsFor: 'initialization' stamp: 'cmmm 10/15/2019 15:14:37'!
initialize
	
	fichasJugadasX := Bag new.
	fichasJugadasO := Bag new.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: #TerniLapilli!
TerniLapilli class
	instanceVariableNames: ''!

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'cmmmm 10/15/2019 16:14:46'!
invalidPlayBoardFull
	^'Invalid Play board is Full'! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'cmmmm 10/15/2019 16:15:09'!
invalidPlayBoardNotFull
	^'Invalid move board not full'.! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'cmmmmm 10/10/2019 20:10:16'!
invalidPlayerTurn
	^'invalidPlayerTurn'! !


!TerniLapilli class methodsFor: 'error handling' stamp: 'cmmm 10/15/2019 00:38:41'!
invalidPosition
		^'invalidPosition'! !
