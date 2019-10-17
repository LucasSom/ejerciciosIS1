!classDefinition: #TerniLapilliTest category: #TerniLapilliLucas!
TestCase subclass: #TerniLapilliTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilliLucas'!

!TerniLapilliTest methodsFor: 'testing' stamp: 'LS 10/16/2019 20:08:11'!
test01NewGameIsEmpty
	
	| game |
	game := TerniLapilli new.
	
	self assert: 0 equals: game jugadorX cantFichas.
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

!TerniLapilliTest methodsFor: 'testing' stamp: 'cmmmm 10/15/2019 21:31:04'!
test04OPlaysSecond
	
	| game |
	game := TerniLapilli new.
	game putXAt: 1@1.
	
	self assert: true equals: game juegaO.
	self assert: false equals: game juegaX.	
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'cmmmm 10/15/2019 21:30:18'!
test05CannotPlayIfNotMyTurn
	
	| game |
	game := TerniLapilli new.
	
	self should: [ game putOAt: 1@1. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: TerniLapilli invalidPlayerTurn.
	self assert: false equals: (game hayOEn: 1@1).			
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'cmmmm 10/15/2019 21:30:02'!
test06CannotPlayXSecond
	
	| game |
	game := TerniLapilli new.
	game putXAt: 1@1.
	
	self should: [ game putXAt: 2@1. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: TerniLapilli invalidPlayerTurn.	
	self assert: false equals: (game hayXEn: 2@1).	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'cmmmm 10/15/2019 21:29:49'!
test07XCannotPlayIfPositionIsOccuped
	
	| game |
	game := TerniLapilli new.
	game putXAt: 2@2.
	game putOAt: 1@1.
	
	self should: [ game putXAt: 1@1. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: TerniLapilli invalidPosition.
	self assert: true equals: (game hayOEn: 1@1).		
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'cmmmm 10/15/2019 21:29:29'!
test08OCannotPlayIfPositionIsOccuped
	
	| game |
	game := TerniLapilli new.
	game putXAt: 1@1.
	
	self should: [ game putOAt: 1@1. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: TerniLapilli invalidPosition.
	self assert: true equals: (game hayXEn: 1@1).		
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'cmmmm 10/15/2019 21:29:06'!
test09OCannotPlayIfPositionOfLimits
	
	| game |
	game := TerniLapilli new.
	game putXAt: 1@1.
	
	self should: [ game putOAt: 4@4. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: TerniLapilli invalidPosition.
	self assert: false equals: (game hayOEn: 4@4).		
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'cmmmm 10/15/2019 21:28:40'!
test10XCannotPlayIfPositionOfLimits
	
	| game |
	game := TerniLapilli new.
	
	self should: [ game putXAt: 0@0. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: TerniLapilli invalidPosition.
	self assert: false equals: (game hayXEn: 0@0).	
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'cmmmm 10/15/2019 21:28:20'!
test11CannotPlayIf6ThereAre6xxxOnTheGame
	
	| game |
	game := TerniLapilli new.
	self fillBoard: game.
	
	self should: [ game putXAt: 3@3. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: TerniLapilli invalidPlayBoardFull.
	self assert: false equals: (game hayXEn: 3@3).		
	
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'cmmmm 10/15/2019 21:28:04'!
test12CannotMovexxxIfThereAreLessThan6xxxOnTheGame
	
	| game |
	game := TerniLapilli new.
	game putXAt: 1@1.
	
	self should: [ game moveXFrom: 1@1 to:1@2. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: TerniLapilli invalidPlayBoardNotFull.
	self assert: false equals: (game hayXEn: 1@2).! !

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

!TerniLapilliTest methodsFor: 'testing' stamp: 'cmmmm 10/15/2019 21:26:43'!
test15XCantMakeMoveToAPointWichIsNotANeighboar
	
	| game |
	game := TerniLapilli new.
	self fillBoard: game.
	
	self should: [ game moveXFrom: 1@1 to:3@2. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: TerniLapilli invalidMove .
	self assert: false equals: (game hayXEn: 3@2).! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'cmmmm 10/15/2019 21:27:07'!
test16OCantMakeMoveToAPointWichIsNotANeighboar
	
	| game |
	game := TerniLapilli new.
	self fillBoard: game.
	game moveXFrom: 2@2 to:3@2.
	
	self should: [ game moveOFrom: 1@2 to:3@3. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: TerniLapilli invalidMove .
	self assert: false equals: (game hayOEn: 3@3).		
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


!classDefinition: #Jugador category: #TerniLapilliLucas!
Object subclass: #Jugador
	instanceVariableNames: 'fichasJugadas'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilliLucas'!

!Jugador methodsFor: 'as yet unclassified' stamp: 'LS 10/16/2019 18:00:48'!
cantFichas
	^fichasJugadas size.! !

!Jugador methodsFor: 'as yet unclassified' stamp: 'LS 10/16/2019 17:58:41'!
fichasJugadas
	^fichasJugadas ! !

!Jugador methodsFor: 'as yet unclassified' stamp: 'LS 10/16/2019 17:52:51'!
initialize
	
	fichasJugadas := Bag new.! !

!Jugador methodsFor: 'as yet unclassified' stamp: 'LS 10/16/2019 19:43:21'!
tieneFichaEn: aPoint

	^fichasJugadas includes: aPoint! !


!classDefinition: #TerniLapilli category: #TerniLapilliLucas!
Object subclass: #TerniLapilli
	instanceVariableNames: 'fichasJugadasO juegaX jugadorX jugadorO'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilliLucas'!

!TerniLapilli methodsFor: 'accessing' stamp: 'LS 10/16/2019 21:49:52'!
jugadorO
	^jugadorO ! !

!TerniLapilli methodsFor: 'accessing' stamp: 'LS 10/16/2019 20:35:55'!
jugadorX
	^jugadorX ! !


!TerniLapilli methodsFor: 'plays' stamp: 'LS 10/16/2019 21:54:20'!
moveOFrom: aPointSource to: aPointDestination
	
	(jugadorX cantFichas + jugadorO cantFichas) > 5 ifFalse: [self error: TerniLapilli invalidPlayBoardNotFull].
	(aPointSource eightNeighbors includes: aPointDestination) ifFalse: [self error: TerniLapilli invalidMove].
	jugadorO fichasJugadas remove: aPointSource ifAbsent: [self error: TerniLapilli invalidMove].
	self putOAt: aPointDestination. ! !

!TerniLapilli methodsFor: 'plays' stamp: 'LS 10/16/2019 21:53:38'!
moveXFrom: aPointSource to: aPointDestination
	
	(jugadorX cantFichas + jugadorO cantFichas) > 5 ifFalse: [self error: TerniLapilli invalidPlayBoardNotFull].
	(aPointSource eightNeighbors includes: aPointDestination) ifFalse: [self error: TerniLapilli invalidMove].
	jugadorX fichasJugadas remove: aPointSource ifAbsent: [self error: TerniLapilli invalidMove].
	self putXAt: aPointDestination. ! !

!TerniLapilli methodsFor: 'plays' stamp: 'LS 10/16/2019 21:54:59'!
putAt: aPoint 

	(aPoint x between: 1 and: 3) ifFalse: [ self error: TerniLapilli invalidPosition ].
	(aPoint y between: 1 and: 3) ifFalse: [ self error: TerniLapilli invalidPosition ].

	(jugadorX cantFichas + jugadorO cantFichas) = 6 ifFalse: [self error: TerniLapilli invalidPlayBoardNotFull].	
	(self isEmpty: aPoint) ifTrue: [ self juegaX ifTrue: [jugadorX fichasJugadas add: aPoint ] ifFalse: [jugadorO fichasJugadas add: aPoint ]].

	! !

!TerniLapilli methodsFor: 'plays' stamp: 'LS 10/16/2019 23:31:26'!
putOAt: aPoint 

	((jugadorX fichasJugadas size + jugadorO fichasJugadas size) > 5) ifTrue: [ self error: TerniLapilli invalidPlayBoardFull ].

	(aPoint x between: 1 and: 3) ifFalse: [ self error: TerniLapilli invalidPosition ].
	(aPoint y between: 1 and: 3) ifFalse: [ self error: TerniLapilli invalidPosition ].
	self juegaO ifFalse: [ self error: TerniLapilli invalidPlayerTurn ].
	
	(self isEmpty: aPoint) ifFalse: [ self error: TerniLapilli invalidPosition.] ifTrue: [jugadorO fichasJugadas add: aPoint.].
	juegaX := true.
! !

!TerniLapilli methodsFor: 'plays' stamp: 'LS 10/16/2019 21:55:33'!
putXAt: aPoint 
	
	((jugadorX fichasJugadas size + jugadorO fichasJugadas size) > 5) ifTrue: [ self error: TerniLapilli invalidPlayBoardFull ].
	(aPoint x between: 1 and: 3) ifFalse: [ self error: TerniLapilli invalidPosition ].
	(aPoint y between: 1 and: 3) ifFalse: [ self error: TerniLapilli invalidPosition ].	
	
	self juegaX ifFalse: [ self error: TerniLapilli invalidPlayerTurn ].
	(self isEmpty: aPoint) ifFalse: [ self error: TerniLapilli invalidPosition.] ifTrue: [jugadorX fichasJugadas add: aPoint.].
	juegaX := false.! !


!TerniLapilli methodsFor: 'initialization' stamp: 'LS 10/16/2019 20:14:37'!
initialize
	
	fichasJugadasO := Bag new.
	jugadorX := Jugador new.
	jugadorO := Jugador new.
	juegaX := true. 
	! !


!TerniLapilli methodsFor: 'characteristics' stamp: 'LS 10/16/2019 21:51:02'!
cantFichasO

	^jugadorO cantFichas.! !

!TerniLapilli methodsFor: 'characteristics' stamp: 'LS 10/16/2019 20:24:03'!
cantFichasX

	^jugadorX cantFichas.! !

!TerniLapilli methodsFor: 'characteristics' stamp: 'LS 10/16/2019 21:51:43'!
fichasJugadasO
	^jugadorO fichasJugadas.! !

!TerniLapilli methodsFor: 'characteristics' stamp: 'LS 10/16/2019 20:24:45'!
fichasJugadasX
	^jugadorX fichasJugadas.! !

!TerniLapilli methodsFor: 'characteristics' stamp: 'LS 10/16/2019 21:51:52'!
hayOEn: aPoint 

	^jugadorO tieneFichaEn: aPoint.! !

!TerniLapilli methodsFor: 'characteristics' stamp: 'LS 10/16/2019 20:25:41'!
hayXEn: aPoint 

	^jugadorX tieneFichaEn: aPoint.! !

!TerniLapilli methodsFor: 'characteristics' stamp: 'LS 10/16/2019 21:52:08'!
isEmpty: aPoint 

	^(jugadorO tieneFichaEn: aPoint) not and: (jugadorX tieneFichaEn: aPoint) not.! !

!TerniLapilli methodsFor: 'characteristics' stamp: 'LS 10/16/2019 20:26:05'!
juegaO

	^ self juegaX not.! !

!TerniLapilli methodsFor: 'characteristics' stamp: 'LS 10/16/2019 20:26:13'!
juegaX
		
	^juegaX.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: #TerniLapilliLucas!
TerniLapilli class
	instanceVariableNames: ''!

!TerniLapilli class methodsFor: 'error handling' stamp: 'cmmmm 10/15/2019 17:37:26'!
invalidMove
	^'invalid move'.! !

!TerniLapilli class methodsFor: 'error handling' stamp: 'cmmmm 10/15/2019 16:14:46'!
invalidPlayBoardFull
	^'Invalid Play board is Full'! !

!TerniLapilli class methodsFor: 'error handling' stamp: 'cmmmm 10/15/2019 16:15:09'!
invalidPlayBoardNotFull
	^'Invalid move board not full'.! !

!TerniLapilli class methodsFor: 'error handling' stamp: 'cmmmmm 10/10/2019 20:10:16'!
invalidPlayerTurn
	^'invalidPlayerTurn'! !

!TerniLapilli class methodsFor: 'error handling' stamp: 'cmmm 10/15/2019 00:38:41'!
invalidPosition
		^'invalidPosition'! !
