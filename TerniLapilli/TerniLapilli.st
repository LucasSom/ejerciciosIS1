!classDefinition: #TerniLapilliTest category: #TerniLapilli!
TestCase subclass: #TerniLapilliTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilliTest methodsFor: 'testing' stamp: 'cmmmm 10/17/2019 16:49:24'!
test01NewGameIsEmpty
	
	| game |
	game := TerniLapilli new.
	
	self assert: 0 equals: game jugadorX cantFichas.
	self assert: 0 equals: game jugadorO cantFichas.
	self assert: true equals: game juegaX.
! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'cmmmm 10/17/2019 16:49:24'!
test02XStartsPlaying
	
	| game |
	game := TerniLapilli new.
	
	self assert: true equals: game juegaX.
	self assert: false equals: game juegaO.
! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'cmmmm 10/17/2019 16:49:24'!
test03XPutsInTheCorrectPlace
	
	| game |
	game := TerniLapilli new.
	game putAt: 1@1.
	
	self assert: 1 equals: game jugadorX cantFichas.
	self assert: 0 equals: game jugadorO cantFichas.
	self assert: true equals: (game jugadorX tieneFichaEn: 1@1).
! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'cmmmm 10/17/2019 16:49:24'!
test04OPlaysSecond
	
	| game |
	game := TerniLapilli new.
	game putAt: 1@1.
	
	self assert: true equals: game juegaO.
	self assert: false equals: game juegaX.	
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'cmmmm 10/17/2019 16:41:19'!
test05CannotPlayIfNotMyTurn
	
"  Este Test ya no tiene sentido porque cambio la interfaz
	| game |
	game := TerniLapilliXXX new.
	
	self should: [ game putAt: 1@1. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: TerniLapilliXXX invalidPlayerTurn.
	self assert: false equals: (game jugadorO tieneFichaEn: 1@1).			
	"! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'cmmmm 10/17/2019 16:41:31'!
test06CannotPlayXSecond

"  Este Test ya no tiene sentido porque cambio la interfaz	
	| game |
	game := TerniLapilliXXX new.
	game putAt: 1@1.
	
	self should: [ game putAt: 2@1. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: TerniLapilliXXX invalidPlayerTurn.	
	self assert: false equals: (game jugadorX tieneFichaEn: 2@1)."! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'cmmmm 10/17/2019 16:49:24'!
test07XCannotPlayIfPositionIsOccuped
	
	| game |
	game := TerniLapilli new.
	game putAt: 2@2.
	game putAt: 1@1.
	
	self should: [ game putAt: 1@1. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: TerniLapilli invalidPosition.
	self assert: true equals: (game jugadorO tieneFichaEn: 1@1).		
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'cmmmm 10/17/2019 16:49:24'!
test08OCannotPlayIfPositionIsOccuped
	
	| game |
	game := TerniLapilli new.
	game putAt: 1@1.
	
	self should: [ game putAt: 1@1. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: TerniLapilli invalidPosition.
	self assert: true equals: (game jugadorX tieneFichaEn: 1@1).		
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'cmmmm 10/17/2019 16:49:24'!
test09OCannotPlayIfPositionOfLimits
	
	| game |
	game := TerniLapilli new.
	game putAt: 1@1.
	
	self should: [ game putAt: 4@4. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: TerniLapilli invalidPosition.
	self assert: false equals: (game jugadorO tieneFichaEn: 4@4).		
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'cmmmm 10/17/2019 16:49:24'!
test10XCannotPlayIfPositionOfLimits
	
	| game |
	game := TerniLapilli new.
	
	self should: [ game putAt: 0@0. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: TerniLapilli invalidPosition.
	self assert: false equals: (game jugadorX tieneFichaEn: 0@0).	
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'cmmmm 10/17/2019 16:50:15'!
test11CannotPlayIf6ThereAre6FichasOnTheGame
	
	| game |
	game := TerniLapilli new.
	self fillBoard: game.
	
	self should: [ game putAt: 3@3. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: TerniLapilli invalidPlayBoardFull.
	self assert: false equals: (game jugadorX tieneFichaEn: 3@3).		
	
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'cmmmm 10/17/2019 16:51:15'!
test12CannotMoveFichasIfThereAreLessThan6FichasOnTheGame
	
	| game |
	game := TerniLapilli new.
	game putAt: 1@1.
	
	self should: [ game moveFrom: 1@1 to:1@2. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: TerniLapilli invalidPlayBoardNotFull.
	self assert: false equals: (game jugadorX tieneFichaEn: 1@2).! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'cmmmm 10/17/2019 16:50:38'!
test13AValidMoveIfThereAre6FichasChangesThePositionOfTheFicha
	
	| game |
	game := TerniLapilli new.
	self fillBoard: game. 		
	game moveFrom: 2@2 to:3@2.

	self assert: true equals: (game jugadorX tieneFichaEn: 3@2).
	self assert: false equals: (game jugadorX tieneFichaEn: 2@2).	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'cmmmm 10/17/2019 16:50:54'!
test14OMAkesValidMoveIfThereAre6FichasChangesThePositionOfTheFichas
	
	| game |
	game := TerniLapilli new.
	self fillBoard: game.
	game moveFrom: 2@2 to:3@2.
	game moveFrom: 2@1 to:3@1.


	self assert: true equals: (game jugadorO tieneFichaEn: 3@1).
	self assert: false equals: (game jugadorO tieneFichaEn: 2@1).! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'cmmmm 10/17/2019 16:49:24'!
test15XCantMakeMoveToAPointWichIsNotANeighboar
	
	| game |
	game := TerniLapilli new.
	self fillBoard: game.
	
	self should: [ game moveFrom: 1@1 to:3@2. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: TerniLapilli invalidMove .
	self assert: false equals: (game jugadorX tieneFichaEn: 3@2).! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'cmmmm 10/17/2019 16:49:24'!
test16OCantMakeMoveToAPointWichIsNotANeighboar
	
	| game |
	game := TerniLapilli new.
	self fillBoard: game.
	game moveFrom: 2@2 to:3@2.
	
	self should: [ game moveFrom: 1@2 to:3@3. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: TerniLapilli invalidMove .
	self assert: false equals: (game jugadorO tieneFichaEn: 3@3).		
! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'cmmmm 10/17/2019 16:49:24'!
test17GameIsNotOverAfter1PlayAndNobodyHasWon
	
	| game |
	game := TerniLapilli new.
	game putAt: 1@1.
	
	self assert: false equals: (game isOver).
	self assert: false equals: (game hasPlayerXWon).
	self assert: false equals: (game hasPlayerOWon).! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'cmmmm 10/17/2019 16:49:24'!
test18OWinsByMaking3PlaysInALineAndGameIsOver
	
	| game |
	game := TerniLapilli new.
	game putAt: 3@3.
	game putAt: 1@1.
	game putAt: 2@1.
	game putAt: 1@2.
	game putAt: 2@2.
	game putAt: 1@3.

	self assert: true equals: (game hasPlayerOWon).
	self assert: true equals: (game isOver).! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'cmmmm 10/17/2019 16:49:24'!
test19XWinsByMaking3PlaysInTheMiddleLineAndGameIsOver
	
	| game |
	game := TerniLapilli new.
	game putAt: 2@1.
	game putAt: 1@1.
	game putAt: 2@2.
	game putAt: 1@2.
	game putAt: 2@3.

	self assert: true equals: (game hasPlayerXWon).
	self assert: true equals: (game isOver).! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'cmmmm 10/17/2019 16:49:24'!
test20XWinsByMaking3PlaysInTheTopLineAndGameIsOver
	
	| game |
	game := TerniLapilli new.
	game putAt: 3@1.
	game putAt: 1@2.
	game putAt: 3@2.
	game putAt: 1@3.
	game putAt: 3@3.

	self assert: true equals: (game hasPlayerXWon).
	self assert: true equals: (game isOver).! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'cmmmm 10/17/2019 16:49:24'!
test21XWinsByMaking3PlaysInTheDiagonalAndGameIsOver
	
	| game |
	game := TerniLapilli new.
	game putAt: 1@1.
	game putAt: 1@2.
	game putAt: 2@2.
	game putAt: 1@3.
	game putAt: 3@3.

	self assert: true equals: (game hasPlayerXWon).
	self assert: true equals: (game isOver).! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'cmmmm 10/17/2019 16:49:24'!
test22XWinsByMaking3PlaysInBottomLineAndGameIsOver
	
	| game |
	game := TerniLapilli new.
	game putAt: 1@1.
	game putAt: 1@2.
	game putAt: 2@1.
	game putAt: 1@3.
	game putAt: 3@1.

	self assert: true equals: (game hasPlayerXWon).
	self assert: true equals: (game isOver).! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'cmmmm 10/17/2019 16:49:24'!
test23XWinsByMaking3PlaysInBottomLineAndGameIsOver
	
	| game |
	game := TerniLapilli new.
	self fillBoard: game.
	game moveFrom: 2@2 to: 3@3. 
	
	
	self should: [ game moveFrom: 2@3 to: 3@2. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: TerniLapilli invalidMove .
	self assert: false equals: (game jugadorO tieneFichaEn: 3@2).
! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'cmmmm 10/17/2019 16:49:24'!
test24GameIsTiedAfterSeveralPlays
	
	| game |
	game := TerniLapilli new.
	self fillBoard: game.
	game moveFrom: 2@2 to: 3@3. 
	
	self assert: true equals: (game isTied).	
	self assert: false equals: (game isOver).
! !


!TerniLapilliTest methodsFor: 'setUp/tearDown' stamp: 'LS 10/17/2019 01:00:05'!
fillBoard: aGame
	
	aGame putAt: 1@1.
	aGame putAt: 1@2.
	aGame putAt: 1@3.
	aGame putAt: 2@1.
	aGame putAt: 2@2.
	aGame putAt: 2@3.		
! !


!classDefinition: #Jugador category: #TerniLapilli!
Object subclass: #Jugador
	instanceVariableNames: 'fichasJugadas'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!Jugador methodsFor: 'accesing' stamp: 'LS 10/16/2019 18:00:48'!
cantFichas
	^fichasJugadas size.! !

!Jugador methodsFor: 'accesing' stamp: 'LS 10/16/2019 17:58:41'!
fichasJugadas
	^fichasJugadas ! !

!Jugador methodsFor: 'accesing' stamp: 'LS 10/16/2019 19:43:21'!
tieneFichaEn: aPoint

	^fichasJugadas includes: aPoint! !


!Jugador methodsFor: 'plays' stamp: 'cmmmm 10/17/2019 16:49:24'!
moveFrom: aPointSource to: aPointDestination
	
	self fichasJugadas remove: aPointSource ifAbsent: [self error: TerniLapilli invalidMove].
	self putAt: aPointDestination.! !

!Jugador methodsFor: 'plays' stamp: 'cmmmm 10/17/2019 16:49:24'!
putAt: aPoint 
	
	(aPoint x between: 1 and: 3) ifFalse: [ self error: TerniLapilli invalidPosition ].
	(aPoint y between: 1 and: 3) ifFalse: [ self error: TerniLapilli invalidPosition ].
	
	self fichasJugadas add: aPoint.! !


!Jugador methodsFor: 'initialization' stamp: 'LS 10/16/2019 17:52:51'!
initialize
	
	fichasJugadas := Bag new.! !


!classDefinition: #TerniLapilli category: #TerniLapilli!
Object subclass: #TerniLapilli
	instanceVariableNames: 'jugadorX jugadorO jugadorActual'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilli methodsFor: 'accessing' stamp: 'cmmmm 10/17/2019 15:17:16'!
isOver
	self XHizoLinea ifTrue: [^true]. 
	self OHizoLinea ifTrue: [^true]. 
	^false.! !

!TerniLapilli methodsFor: 'accessing' stamp: 'cmmmm 10/17/2019 16:45:24'!
isTied
	^self isOver not.! !

!TerniLapilli methodsFor: 'accessing' stamp: 'LS 10/17/2019 00:23:08'!
jugadorActual

	^jugadorActual ! !

!TerniLapilli methodsFor: 'accessing' stamp: 'LS 10/16/2019 21:49:52'!
jugadorO
	^jugadorO ! !

!TerniLapilli methodsFor: 'accessing' stamp: 'LS 10/16/2019 20:35:55'!
jugadorX
	^jugadorX ! !


!TerniLapilli methodsFor: 'plays' stamp: 'cmmmm 10/17/2019 16:49:24'!
moveFrom: aPointSource to: aPointDestination
	
	self cantidadTotalDeFichas = 6 ifFalse: [self error: TerniLapilli invalidPlayBoardNotFull].
	(self estaEnDiagonal: aPointSource) ifTrue: [(aPointSource eightNeighbors includes: aPointDestination) ifFalse: [self error: TerniLapilli invalidMove].]
									ifFalse:[(aPointSource fourNeighbors includes: aPointDestination) ifFalse: [self error: TerniLapilli invalidMove].].
	
	
	jugadorActual moveFrom: aPointSource to: aPointDestination.
	self cambiarJugadorActual.! !

!TerniLapilli methodsFor: 'plays' stamp: 'cmmmm 10/17/2019 16:49:24'!
putAt: aPoint 
	(self cantidadTotalDeFichas  = 6) ifTrue: [ self error: TerniLapilli invalidPlayBoardFull ].
	(aPoint x between: 1 and: 3) ifFalse: [ self error: TerniLapilli invalidPosition ].
	(aPoint y between: 1 and: 3) ifFalse: [ self error: TerniLapilli invalidPosition ].
	
	(self isEmpty: aPoint) ifFalse: [ self error: TerniLapilli invalidPosition.] ifTrue: [ jugadorActual putAt: aPoint].
	
	self cambiarJugadorActual.	! !


!TerniLapilli methodsFor: 'initialization' stamp: 'cmmmm 10/17/2019 16:49:12'!
initialize
	
	jugadorX := Jugador new.
	jugadorO := Jugador new.
	jugadorActual := jugadorX.
	! !


!TerniLapilli methodsFor: 'characteristics' stamp: 'LS 10/16/2019 21:52:08'!
isEmpty: aPoint 

	^(jugadorO tieneFichaEn: aPoint) not and: (jugadorX tieneFichaEn: aPoint) not.! !

!TerniLapilli methodsFor: 'characteristics' stamp: 'LS 10/17/2019 00:23:55'!
juegaO

	^ jugadorActual == jugadorO .! !

!TerniLapilli methodsFor: 'characteristics' stamp: 'LS 10/17/2019 00:24:08'!
juegaX
		
	^jugadorActual  == jugadorX .! !


!TerniLapilli methodsFor: 'private' stamp: 'cmmmm 10/17/2019 15:45:43'!
OHizoLinea
	^self hizoLinea: jugadorO 	
	! !

!TerniLapilli methodsFor: 'private' stamp: 'cmmmm 10/17/2019 15:45:54'!
XHizoLinea
	^self hizoLinea: jugadorX 	
	! !

!TerniLapilli methodsFor: 'private' stamp: 'LS 10/17/2019 01:20:19'!
cambiarJugadorActual

	jugadorActual == jugadorX ifTrue: [jugadorActual := jugadorO] ifFalse: [jugadorActual := jugadorX].! !

!TerniLapilli methodsFor: 'private' stamp: 'LS 10/17/2019 00:40:07'!
cantidadTotalDeFichas
	
	^jugadorX cantFichas + jugadorO cantFichas.! !

!TerniLapilli methodsFor: 'private' stamp: 'cmmmm 10/17/2019 16:31:18'!
estaEnDiagonal: aPoint 
	^(aPoint x + aPoint y) even.! !

!TerniLapilli methodsFor: 'private' stamp: 'cmmmm 10/17/2019 15:36:50'!
hasPlayerOWon
	^self OHizoLinea.! !

!TerniLapilli methodsFor: 'private' stamp: 'cmmmm 10/17/2019 15:35:59'!
hasPlayerXWon
	^self XHizoLinea.! !

!TerniLapilli methodsFor: 'private' stamp: 'cmmmm 10/17/2019 16:19:51'!
hizoLinea: aPlayer
	| b |
	b := aPlayer fichasJugadas.
	
	"^#(1@1 1@2 1@3) allSatisfy: [:a | b includes: a]."
	^(self hizoLineaDiagonal: aPlayer) or: (self hizoLineaVertical: aPlayer) or: (self hizoLineaHorizontal: aPlayer).
	! !

!TerniLapilli methodsFor: 'private' stamp: 'cmmmm 10/17/2019 16:11:01'!
hizoLineaDiagonal: aPlayer
	| b |
	b := aPlayer fichasJugadas.
	
	^((b includes: 1@1) and: (b includes: 2@2) and: (b includes: 3@3))or:
	((b includes: 1@3) and: (b includes: 2@2) and: (b includes: 3@1)).! !

!TerniLapilli methodsFor: 'private' stamp: 'cmmmm 10/17/2019 16:19:12'!
hizoLineaHorizontal: aPlayer
	| b |
	b := aPlayer fichasJugadas.
	
	^((b includes: 1@1) and: (b includes: 2@1) and: (b includes: 3@1))or:
	((b includes: 1@2) and: (b includes: 2@2) and: (b includes: 3@2)) or:
	((b includes: 1@3) and: (b includes: 2@3) and: (b includes: 3@3)).! !

!TerniLapilli methodsFor: 'private' stamp: 'cmmmm 10/17/2019 16:16:16'!
hizoLineaVertical: aPlayer
	| b |
	b := aPlayer fichasJugadas.
	
	^((b includes: 1@1) and: (b includes: 1@2) and: (b includes: 1@3))or:
	((b includes: 2@1) and: (b includes: 2@2) and: (b includes: 2@3)) or:
	((b includes: 3@1) and: (b includes: 3@2) and: (b includes: 3@3)).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: #TerniLapilli!
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
