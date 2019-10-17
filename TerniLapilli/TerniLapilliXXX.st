!classDefinition: #TerniLapilliXXXTest category: #TerniLapilliXXX!
TestCase subclass: #TerniLapilliXXXTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilliXXX'!

!TerniLapilliXXXTest methodsFor: 'testing' stamp: 'LS 10/17/2019 01:24:21'!
test01NewGameIsEmpty
	
	| game |
	game := TerniLapilliXXX new.
	
	self assert: 0 equals: game jugadorX cantFichas.
	self assert: 0 equals: game jugadorO cantFichas.
	self assert: true equals: game juegaX.
! !

!TerniLapilliXXXTest methodsFor: 'testing' stamp: 'LS 10/17/2019 01:24:21'!
test02XStartsPlaying
	
	| game |
	game := TerniLapilliXXX new.
	
	self assert: true equals: game juegaX.
	self assert: false equals: game juegaO.
! !

!TerniLapilliXXXTest methodsFor: 'testing' stamp: 'LS 10/17/2019 01:24:21'!
test03XPutsInTheCorrectPlace
	
	| game |
	game := TerniLapilliXXX new.
	game putAt: 1@1.
	
	self assert: 1 equals: game jugadorX cantFichas.
	self assert: 0 equals: game jugadorO cantFichas.
	self assert: true equals: (game jugadorX tieneFichaEn: 1@1).
! !

!TerniLapilliXXXTest methodsFor: 'testing' stamp: 'LS 10/17/2019 01:24:21'!
test04OPlaysSecond
	
	| game |
	game := TerniLapilliXXX new.
	game putAt: 1@1.
	
	self assert: true equals: game juegaO.
	self assert: false equals: game juegaX.	
	! !

!TerniLapilliXXXTest methodsFor: 'testing' stamp: 'LS 10/17/2019 01:24:21'!
test05CannotPlayIfNotMyTurn
	
	| game |
	game := TerniLapilliXXX new.
	
	self should: [ game putAt: 1@1. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: TerniLapilliXXX invalidPlayerTurn.
	self assert: false equals: (game jugadorO tieneFichaEn: 1@1).			
	! !

!TerniLapilliXXXTest methodsFor: 'testing' stamp: 'LS 10/17/2019 01:24:21'!
test06CannotPlayXSecond
	
	| game |
	game := TerniLapilliXXX new.
	game putAt: 1@1.
	
	self should: [ game putAt: 2@1. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: TerniLapilliXXX invalidPlayerTurn.	
	self assert: false equals: (game jugadorX tieneFichaEn: 2@1).	! !

!TerniLapilliXXXTest methodsFor: 'testing' stamp: 'LS 10/17/2019 01:24:21'!
test07XCannotPlayIfPositionIsOccuped
	
	| game |
	game := TerniLapilliXXX new.
	game putAt: 2@2.
	game putAt: 1@1.
	
	self should: [ game putAt: 1@1. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: TerniLapilliXXX invalidPosition.
	self assert: true equals: (game jugadorO tieneFichaEn: 1@1).		
	! !

!TerniLapilliXXXTest methodsFor: 'testing' stamp: 'LS 10/17/2019 01:24:21'!
test08OCannotPlayIfPositionIsOccuped
	
	| game |
	game := TerniLapilliXXX new.
	game putAt: 1@1.
	
	self should: [ game putAt: 1@1. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: TerniLapilliXXX invalidPosition.
	self assert: true equals: (game jugadorX tieneFichaEn: 1@1).		
	! !

!TerniLapilliXXXTest methodsFor: 'testing' stamp: 'LS 10/17/2019 01:24:21'!
test09OCannotPlayIfPositionOfLimits
	
	| game |
	game := TerniLapilliXXX new.
	game putAt: 1@1.
	
	self should: [ game putAt: 4@4. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: TerniLapilliXXX invalidPosition.
	self assert: false equals: (game jugadorO tieneFichaEn: 4@4).		
	! !

!TerniLapilliXXXTest methodsFor: 'testing' stamp: 'LS 10/17/2019 01:24:21'!
test10XCannotPlayIfPositionOfLimits
	
	| game |
	game := TerniLapilliXXX new.
	
	self should: [ game putAt: 0@0. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: TerniLapilliXXX invalidPosition.
	self assert: false equals: (game jugadorX tieneFichaEn: 0@0).	
	! !

!TerniLapilliXXXTest methodsFor: 'testing' stamp: 'LS 10/17/2019 01:24:21'!
test11CannotPlayIf6ThereAre6xxxOnTheGame
	
	| game |
	game := TerniLapilliXXX new.
	self fillBoard: game.
	
	self should: [ game putAt: 3@3. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: TerniLapilliXXX invalidPlayBoardFull.
	self assert: false equals: (game jugadorX tieneFichaEn: 3@3).		
	
	! !

!TerniLapilliXXXTest methodsFor: 'testing' stamp: 'LS 10/17/2019 01:24:21'!
test12CannotMovexxxIfThereAreLessThan6xxxOnTheGame
	
	| game |
	game := TerniLapilliXXX new.
	game putAt: 1@1.
	
	self should: [ game moveFrom: 1@1 to:1@2. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: TerniLapilliXXX invalidPlayBoardNotFull.
	self assert: false equals: (game jugadorX tieneFichaEn: 1@2).! !

!TerniLapilliXXXTest methodsFor: 'testing' stamp: 'LS 10/17/2019 01:24:21'!
test13AValidMoveIfThereAre6xxxxChangesThePositionOfThexxxx
	
	| game |
	game := TerniLapilliXXX new.
	self fillBoard: game. 		
	game moveFrom: 2@2 to:3@2.

	self assert: true equals: (game jugadorX tieneFichaEn: 3@2).
	self assert: false equals: (game jugadorX tieneFichaEn: 2@2).	! !

!TerniLapilliXXXTest methodsFor: 'testing' stamp: 'LS 10/17/2019 01:24:21'!
test14OMAkesValidMoveIfThereAre6xxxxChangesThePositionOfThexxxx
	
	| game |
	game := TerniLapilliXXX new.
	self fillBoard: game.
	game moveFrom: 2@2 to:3@2.
	game moveFrom: 2@1 to:3@1.


	self assert: true equals: (game jugadorO tieneFichaEn: 3@1).
	self assert: false equals: (game jugadorO tieneFichaEn: 2@1).! !

!TerniLapilliXXXTest methodsFor: 'testing' stamp: 'LS 10/17/2019 01:24:21'!
test15XCantMakeMoveToAPointWichIsNotANeighboar
	
	| game |
	game := TerniLapilliXXX new.
	self fillBoard: game.
	
	self should: [ game moveFrom: 1@1 to:3@2. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: TerniLapilliXXX invalidMove .
	self assert: false equals: (game jugadorX tieneFichaEn: 3@2).! !

!TerniLapilliXXXTest methodsFor: 'testing' stamp: 'LS 10/17/2019 01:24:21'!
test16OCantMakeMoveToAPointWichIsNotANeighboar
	
	| game |
	game := TerniLapilliXXX new.
	self fillBoard: game.
	game moveFrom: 2@2 to:3@2.
	
	self should: [ game moveFrom: 1@2 to:3@3. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: TerniLapilliXXX invalidMove .
	self assert: false equals: (game jugadorO tieneFichaEn: 3@3).		
! !


!TerniLapilliXXXTest methodsFor: 'setUp/tearDown' stamp: 'LS 10/17/2019 01:00:05'!
fillBoard: aGame
	
	aGame putAt: 1@1.
	aGame putAt: 1@2.
	aGame putAt: 1@3.
	aGame putAt: 2@1.
	aGame putAt: 2@2.
	aGame putAt: 2@3.		
! !


!classDefinition: #JugadorXXX category: #TerniLapilliXXX!
Object subclass: #JugadorXXX
	instanceVariableNames: 'fichasJugadas'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilliXXX'!

!JugadorXXX methodsFor: 'as yet unclassified' stamp: 'LS 10/16/2019 18:00:48'!
cantFichas
	^fichasJugadas size.! !

!JugadorXXX methodsFor: 'as yet unclassified' stamp: 'LS 10/16/2019 17:58:41'!
fichasJugadas
	^fichasJugadas ! !

!JugadorXXX methodsFor: 'as yet unclassified' stamp: 'LS 10/16/2019 17:52:51'!
initialize
	
	fichasJugadas := Bag new.! !

!JugadorXXX methodsFor: 'as yet unclassified' stamp: 'LS 10/17/2019 01:24:21'!
moveFrom: aPointSource to: aPointDestination
	
	self fichasJugadas remove: aPointSource ifAbsent: [self error: TerniLapilliXXX invalidMove].
	self putAt: aPointDestination.! !

!JugadorXXX methodsFor: 'as yet unclassified' stamp: 'LS 10/17/2019 01:24:21'!
putAt: aPoint 
	
	(aPoint x between: 1 and: 3) ifFalse: [ self error: TerniLapilliXXX invalidPosition ].
	(aPoint y between: 1 and: 3) ifFalse: [ self error: TerniLapilliXXX invalidPosition ].
	
	self fichasJugadas add: aPoint.! !

!JugadorXXX methodsFor: 'as yet unclassified' stamp: 'LS 10/16/2019 19:43:21'!
tieneFichaEn: aPoint

	^fichasJugadas includes: aPoint! !


!classDefinition: #TerniLapilliXXX category: #TerniLapilliXXX!
Object subclass: #TerniLapilliXXX
	instanceVariableNames: 'jugadorX jugadorO jugadorActual'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilliXXX'!

!TerniLapilliXXX methodsFor: 'accessing' stamp: 'LS 10/17/2019 00:23:08'!
jugadorActual

	^jugadorActual ! !

!TerniLapilliXXX methodsFor: 'accessing' stamp: 'LS 10/16/2019 21:49:52'!
jugadorO
	^jugadorO ! !

!TerniLapilliXXX methodsFor: 'accessing' stamp: 'LS 10/16/2019 20:35:55'!
jugadorX
	^jugadorX ! !


!TerniLapilliXXX methodsFor: 'plays' stamp: 'LS 10/17/2019 01:24:21'!
moveFrom: aPointSource to: aPointDestination
	
	self cantidadTotalDeFichas > 5 ifFalse: [self error: TerniLapilliXXX invalidPlayBoardNotFull].
	(aPointSource eightNeighbors includes: aPointDestination) ifFalse: [self error: TerniLapilliXXX invalidMove].
	
	jugadorActual moveFrom: aPointSource to: aPointDestination.
	self cambiarJugadorActual.! !

!TerniLapilliXXX methodsFor: 'plays' stamp: 'LS 10/17/2019 01:24:21'!
putAt: aPoint 
	(self cantidadTotalDeFichas > 5) ifTrue: [ self error: TerniLapilliXXX invalidPlayBoardFull ].
	(aPoint x between: 1 and: 3) ifFalse: [ self error: TerniLapilliXXX invalidPosition ].
	(aPoint y between: 1 and: 3) ifFalse: [ self error: TerniLapilliXXX invalidPosition ].
	
	(self isEmpty: aPoint) ifFalse: [ self error: TerniLapilliXXX invalidPosition.] ifTrue: [ jugadorActual putAt: aPoint].
	
	self cambiarJugadorActual.	! !


!TerniLapilliXXX methodsFor: 'initialization' stamp: 'LS 10/17/2019 01:24:40'!
initialize
	
	jugadorX := JugadorXXX new.
	jugadorO := JugadorXXX new.
	jugadorActual := jugadorX.
	! !


!TerniLapilliXXX methodsFor: 'characteristics' stamp: 'LS 10/16/2019 21:52:08'!
isEmpty: aPoint 

	^(jugadorO tieneFichaEn: aPoint) not and: (jugadorX tieneFichaEn: aPoint) not.! !

!TerniLapilliXXX methodsFor: 'characteristics' stamp: 'LS 10/17/2019 00:23:55'!
juegaO

	^ jugadorActual == jugadorO .! !

!TerniLapilliXXX methodsFor: 'characteristics' stamp: 'LS 10/17/2019 00:24:08'!
juegaX
		
	^jugadorActual  == jugadorX .! !


!TerniLapilliXXX methodsFor: 'private' stamp: 'LS 10/17/2019 01:20:19'!
cambiarJugadorActual

	jugadorActual == jugadorX ifTrue: [jugadorActual := jugadorO] ifFalse: [jugadorActual := jugadorX].! !

!TerniLapilliXXX methodsFor: 'private' stamp: 'LS 10/17/2019 00:40:07'!
cantidadTotalDeFichas
	
	^jugadorX cantFichas + jugadorO cantFichas.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliXXX class' category: #TerniLapilliXXX!
TerniLapilliXXX class
	instanceVariableNames: ''!

!TerniLapilliXXX class methodsFor: 'error handling' stamp: 'cmmmm 10/15/2019 17:37:26'!
invalidMove
	^'invalid move'.! !

!TerniLapilliXXX class methodsFor: 'error handling' stamp: 'cmmmm 10/15/2019 16:14:46'!
invalidPlayBoardFull
	^'Invalid Play board is Full'! !

!TerniLapilliXXX class methodsFor: 'error handling' stamp: 'cmmmm 10/15/2019 16:15:09'!
invalidPlayBoardNotFull
	^'Invalid move board not full'.! !

!TerniLapilliXXX class methodsFor: 'error handling' stamp: 'cmmmmm 10/10/2019 20:10:16'!
invalidPlayerTurn
	^'invalidPlayerTurn'! !

!TerniLapilliXXX class methodsFor: 'error handling' stamp: 'cmmm 10/15/2019 00:38:41'!
invalidPosition
		^'invalidPosition'! !
