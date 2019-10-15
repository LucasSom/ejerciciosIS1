!classDefinition: #TerniLapilliTest category: #TerniLapilli!
TestCase subclass: #TerniLapilliTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilliTest methodsFor: 'testing' stamp: 'cmmmmm 10/10/2019 18:54:06'!
test01NewGameIsEmpty
	
	| game |
	game := TerniLapilli new.
	
	self assert: 0 equals: game cantFichasX.
	self assert: 0 equals: game cantFichasO.
	self assert: true equals: game juegaX.
! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'cmmmmm 10/10/2019 18:54:14'!
test02XStartsPlaying
	
	| game |
	game := TerniLapilli new.
	
	self assert: true equals: game juegaX.
	self assert: false equals: game juegaO.
! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'cmmmm 10/15/2019 17:53:47'!
test03XPutsInTheCorrectPlace
	
	| game |
	game := TerniLapilli new.
	game putXAt: 1@1.
	
	self assert: 1 equals: game cantFichasX.
	self assert: 0 equals: game cantFichasO.
	self assert: true equals: (game hayXEn: 1@1).
! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'cmmm 10/15/2019 15:41:50'!
test04OPlaysSecond
	
	| game |
	game := TerniLapilli new.
	game putXAt: 1@1.
	
	self assert: true equals: game juegaO.
	self assert: false equals: game juegaX.
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'cmmm 10/15/2019 15:41:57'!
test05CannotPlayIfNotMyTurn
	
	| game |
	game := TerniLapilli new.
	
	self should: [ game putOAt: 1@1. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: TerniLapilli invalidPlayerTurn.	
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'cmmm 10/15/2019 15:42:08'!
test06CannotPlayXSecond
	
	| game |
	game := TerniLapilli new.
	game putXAt: 1@1.
	
	self should: [ game putXAt: 2@1. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: TerniLapilli invalidPlayerTurn.	
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'cmmm 10/15/2019 15:42:26'!
test07XCannotPlayIfPositionIsOccuped
	
	| game |
	game := TerniLapilli new.
	game putXAt: 2@2.
	game putOAt: 1@1.
	
	self should: [ game putXAt: 1@1. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: TerniLapilli invalidPosition.	
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'cmmm 10/15/2019 15:42:40'!
test08OCannotPlayIfPositionIsOccuped
	
	| game |
	game := TerniLapilli new.
	game putXAt: 1@1.
	
	self should: [ game putOAt: 1@1. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: TerniLapilli invalidPosition.	
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'cmmm 10/15/2019 15:42:48'!
test09OCannotPlayIfPositionOfLimits
	
	| game |
	game := TerniLapilli new.
	game putXAt: 1@1.
	
	self should: [ game putOAt: 4@4. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: TerniLapilli invalidPosition.	
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'cmmmm 10/15/2019 19:26:14'!
test10XCannotPlayIfPositionOfLimits
	
	| game |
	game := TerniLapilli new.
	
	self should: [ game putXAt: 0@0. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: TerniLapilli invalidPosition.
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'cmmmm 10/15/2019 18:02:11'!
test11CannotPlayIf6ThereAre6xxxOnTheGame
	
	| game |
	game := TerniLapilli new.
	self fillBoard: game.
	
	self should: [ game putXAt: 3@3. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: TerniLapilli invalidPlayBoardFull.	
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'cmmmm 10/15/2019 16:17:41'!
test12CannotMovexxxIfThereAreLessThan6xxxOnTheGame
	
	| game |
	game := TerniLapilli new.
	game putXAt: 1@1.
	
	self should: [ game moveXFrom: 1@1 to:1@2. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: TerniLapilli invalidPlayBoardNotFull.
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'cmmmm 10/15/2019 18:00:55'!
test13AValidMoveIfThereAre6xxxxChangesThePositionOfThexxxx
	
	| game |
	game := TerniLapilli new.
	self fillBoard: game. 		
	game moveXFrom: 2@2 to:3@2.

	self assert: true equals: (game hayXEn: 3@2).
	self assert: false equals: (game hayXEn: 2@2).	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'cmmmm 10/15/2019 19:23:10'!
test14OMAkesValidMoveIfThereAre6xxxxChangesThePositionOfThexxxx
	
	| game |
	game := TerniLapilli new.
	self fillBoard: game.
	game moveXFrom: 2@2 to:3@2.
	game moveOFrom: 2@1 to:3@1.


	self assert: true equals: (game hayOEn: 3@1).
	self assert: false equals: (game hayOEn: 2@1).! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'cmmmm 10/15/2019 19:46:33'!
test15XCantMakeMoveToAPointWichIsNotANeighboar
	
	| game |
	game := TerniLapilli new.
	self fillBoard: game.
	
	self should: [ game moveXFrom: 1@1 to:3@2. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: TerniLapilli invalidMove .
! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'cmmmm 10/15/2019 19:47:45'!
test16OCantMakeMoveToAPointWichIsNotANeighboar
	
	| game |
	game := TerniLapilli new.
	self fillBoard: game.
	game moveXFrom: 2@2 to:3@2.
	
	self should: [ game moveOFrom: 1@2 to:3@3. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: TerniLapilli invalidMove .
! !


!TerniLapilliTest methodsFor: 'setUp/tearDown' stamp: 'cmmmm 10/15/2019 18:00:25'!
fillBoard: aGame
	
	aGame putXAt: 1@1.
	aGame putOAt: 1@2.
	aGame putXAt: 1@3.
	aGame putOAt: 2@1.
	aGame putXAt: 2@2.
	aGame putOAt: 2@3.		
! !


!classDefinition: #TerniLapilli category: #TerniLapilli!
Object subclass: #TerniLapilli
	instanceVariableNames: 'fichasJugadasX fichasJugadasO juegaX'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'cmmm 10/15/2019 15:15:50'!
cantFichasO

	^fichasJugadasO size.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'cmmm 10/15/2019 15:15:59'!
cantFichasX

	^fichasJugadasX size.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'cmmmm 10/15/2019 17:57:48'!
hayOEn: aPoint 

	^fichasJugadasO includes: aPoint.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'cmmmm 10/15/2019 17:53:20'!
hayXEn: aPoint 

	^fichasJugadasX includes: aPoint.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'cmmmmm 10/10/2019 18:58:29'!
juegaO

	^ self juegaX not.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'cmmmm 10/15/2019 17:44:01'!
juegaX
		
	^juegaX.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'cmmmm 10/15/2019 19:48:29'!
moveOFrom: aPointSource to: aPointDestination
	
	(self cantFichasX + self cantFichasO) > 5 ifFalse: [self error: TerniLapilli invalidPlayBoardNotFull].
	(aPointSource eightNeighbors includes: aPointDestination) ifFalse: [self error: TerniLapilli invalidMove].
	fichasJugadasO remove: aPointSource ifAbsent: [self error: TerniLapilli invalidMove].
	self putOAt: aPointDestination. ! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'cmmmm 10/15/2019 19:38:59'!
moveXFrom: aPointSource to: aPointDestination
	
	(self cantFichasX + self cantFichasO) > 5 ifFalse: [self error: TerniLapilli invalidPlayBoardNotFull].
	(aPointSource eightNeighbors includes: aPointDestination) ifFalse: [self error: TerniLapilli invalidMove].
	fichasJugadasX remove: aPointSource ifAbsent: [self error: TerniLapilli invalidMove].
	self putXAt: aPointDestination. ! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'cmmmm 10/15/2019 17:46:15'!
putOAt: aPoint 

	(aPoint x between: 1 and: 3) ifFalse: [ self error: TerniLapilli invalidPosition ].
	(aPoint y between: 1 and: 3) ifFalse: [ self error: TerniLapilli invalidPosition ].
	
	self juegaO ifFalse: [ self error: TerniLapilli invalidPlayerTurn ].
	(fichasJugadasO includes: aPoint) ifTrue: [ self error: TerniLapilli invalidPosition.] ifFalse: [(fichasJugadasX includes: aPoint) ifTrue: [ self error: TerniLapilli invalidPosition.] ifFalse: [fichasJugadasO add: aPoint.].].
	juegaX := true.
	! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'cmmmm 10/15/2019 17:46:28'!
putXAt: aPoint 
	
	((fichasJugadasX size + fichasJugadasO size) > 5) ifTrue: [ self error: TerniLapilli invalidPlayBoardFull ].
	(aPoint x between: 1 and: 3) ifFalse: [ self error: TerniLapilli invalidPosition ].
	(aPoint y between: 1 and: 3) ifFalse: [ self error: TerniLapilli invalidPosition ].	
	
	self juegaX ifFalse: [ self error: TerniLapilli invalidPlayerTurn ].
	(fichasJugadasO includes: aPoint) ifTrue: [ self error: TerniLapilli invalidPosition.] ifFalse: [(fichasJugadasX includes: aPoint) ifTrue: [ self error: TerniLapilli invalidPosition.] ifFalse: [fichasJugadasX add: aPoint.].].
	juegaX := false.! !


!TerniLapilli methodsFor: 'initialization' stamp: 'cmmmm 10/15/2019 17:45:03'!
initialize
	
	fichasJugadasX := Bag new.
	fichasJugadasO := Bag new.
	juegaX := true. 
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: #TerniLapilli!
TerniLapilli class
	instanceVariableNames: ''!

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'cmmmm 10/15/2019 17:37:26'!
invalidMove
	^'invalid move'.! !

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
