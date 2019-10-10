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

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'cmmmmm 10/10/2019 20:20:41'!
test03XPutsInTheCorrectPlace
	
	| game |
	game := TerniLapilli new.
	game putXAt: 0@0.
	
	self assert: 1 equals: game cantFichasX.
	self assert: 0 equals: game cantFichasO.
	self assert: true equals: (game hayXEn: 0@0).
! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'cmmmmm 10/10/2019 20:20:47'!
test04OPlaysSecond
	
	| game |
	game := TerniLapilli new.
	game putXAt: 0@0.
	
	self assert: true equals: game juegaO.
	self assert: false equals: game juegaX.
	! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'cmmmmm 10/10/2019 20:20:34'!
test05CannotPlayIfNotMyTurn
	
	| game |
	game := TerniLapilli new.
	
	self should: [ game putOAt: 0@0. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: TerniLapilli invalidPlayerTurn.	
	! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'cmmmmm 10/10/2019 20:20:06'!
test06CannotPlayXSecond
	
	| game |
	game := TerniLapilli new.
	game putXAt: 0@0.
	
	self should: [ game putXAt: 0@1. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: TerniLapilli invalidPlayerTurn.	
	! !


!classDefinition: #TerniLapilli category: #TerniLapilli!
Object subclass: #TerniLapilli
	instanceVariableNames: 'cantFichasX cantFichasO'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!


!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'cmmmmm 10/10/2019 18:36:58'!
cantFichasO
	^cantFichasO ! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'cmmmmm 10/10/2019 18:36:52'!
cantFichasX
	^cantFichasX ! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'cmmmmm 10/10/2019 19:07:51'!
hayXEn: aPoint 
	^true.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'cmmmmm 10/10/2019 18:58:29'!
juegaO

	^ self juegaX not.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'cmmmmm 10/10/2019 18:58:11'!
juegaX
		
	^(cantFichasX + cantFichasO) even ifTrue: [^true] ifFalse: [^false ].! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'cmmmmm 10/10/2019 20:18:36'!
putOAt: aPoint 
	self juegaO ifFalse: [ self error: TerniLapilli invalidPlayerTurn ].
	cantFichasO := cantFichasX +1.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'cmmmmm 10/10/2019 20:21:25'!
putXAt: aPoint 
	
	self juegaX ifFalse: [ self error: TerniLapilli invalidPlayerTurn ].
	cantFichasX := cantFichasX +1.! !


!TerniLapilli methodsFor: 'initialization' stamp: 'cmmmmm 10/10/2019 18:37:36'!
initialize
	
	cantFichasX := 0.
	cantFichasO := 0.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: #TerniLapilli!
TerniLapilli class
	instanceVariableNames: ''!

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'cmmmmm 10/10/2019 20:10:16'!
invalidPlayerTurn
	^'invalidPlayerTurn'! !
