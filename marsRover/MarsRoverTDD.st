!classDefinition: #MarsRoverTest category: #MarsRoverTDD!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverTDD'!

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'cmmmmm 10/3/2019 21:12:32'!
test01EmptyStringDoesNotChange
	
	|rover|
	rover _ MarsRover in: 1@1 oriented: $N. 
	
	rover move: ''.
	self assert: rover position equals: 1@1.
	self assert: rover direction equals: $N.
! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'cmmmmm 10/3/2019 21:13:37'!
test02StringWithFMovesForwardAndDoesNotChangeDirection
	
	|rover|
	rover _ MarsRover in: 1@1 oriented: $N. 
	
	rover move: 'f'.
	self assert: rover position equals: 1@2.
	self assert: rover direction equals: $N.
! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'cmmmmm 10/3/2019 21:19:47'!
test03StringWithBMovesBackwardsAndDoesNotChangeDirection
	
	|rover|
	rover _ MarsRover in: 1@1 oriented: $N. 
	
	rover move: 'b'.
	self assert: rover position equals: 1@0.
	self assert: rover direction equals: $N.
! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'cmmmmm 10/3/2019 21:35:24'!
test04StringWithRRotatesRightAndDoesNotChangePosition
	
	|rover|
	rover _ MarsRover in: 1@1 oriented: $N. 
	
	rover move: 'r'.
	self assert: rover position equals: 1@1.
	self assert: rover direction equals: $E.
! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'cmmmmm 10/3/2019 21:38:36'!
test05StringWithLRotatesLeftAndDoesNotChangePosition
	
	|rover|
	rover _ MarsRover in: 1@1 oriented: $N. 
	
	rover move: 'l'.
	self assert: rover position equals: 1@1.
	self assert: rover direction equals: $O.
! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'cmmmmm 10/3/2019 21:46:40'!
test06InvalidStringRaiseError
	
	|rover|
	rover _ MarsRover in: 1@1 oriented: $N. 
	
	self should: [ rover move: 'x'. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: MarsRover invalidCommandMessage.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'cmmmmm 10/3/2019 21:41:47'!
test07StringWithManyFMovesSeveralPositionsForwardAndDoesNotChangeDirection
	
	|rover|
	rover _ MarsRover in: 1@1 oriented: $N. 
	
	rover move: 'ff'.
	self assert: rover position equals: 1@3.
	self assert: rover direction equals: $N .
! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'cmmmmm 10/8/2019 17:33:00'!
test08StringWithManyBMovesSeveralPositionsBackwardsAndDoesNotChangeDirection
	
	|rover|
	rover _ MarsRover in: 1@1 oriented: $N. 
	
	rover move: 'bb'.
	self assert: rover position equals: 1@-1.
	self assert: rover direction equals: $N.
! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'cmmmmm 10/8/2019 17:37:52'!
test09StringWithManyRRotatesSeveralDirectionsRightAndDoesNotChangePosition
	
	|rover|
	rover _ MarsRover in: 1@1 oriented: $N. 
	
	rover move: 'rrr'.
	self assert: rover position equals: 1@1.
	self assert: rover direction equals: $O.
! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'cmmmmm 10/8/2019 17:40:05'!
test10StringWithManyLRotatesSeveralDirectionsLeftAndDoesNotChangePosition
	
	|rover|
	rover _ MarsRover in: 1@1 oriented: $N. 
	
	rover move: 'lll'.
	self assert: rover position equals: 1@1.
	self assert: rover direction equals: $E.
! !


!classDefinition: #MarsRover category: #MarsRoverTDD!
Object subclass: #MarsRover
	instanceVariableNames: 'position direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverTDD'!

!MarsRover methodsFor: 'as yet unclassified' stamp: 'cmmmmm 10/3/2019 21:10:55'!
direction

	^direction! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'cmmmmm 10/3/2019 21:04:25'!
initializeIn: aPoint oriented: aDirection 
	position := aPoint.
	direction := aDirection.! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'cmmmmm 10/8/2019 18:46:23'!
move: aString
	
	aString do: [:a | self xxxxxxx: a.].

	
	
	
	
	! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'cmmmmm 10/3/2019 21:08:40'!
position

	^position! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'cmmmmm 10/8/2019 18:45:52'!
xxxxxxx: aChar

	aChar = $f ifTrue: [position := position + (0@1)] ifFalse: [
	aChar = $b ifTrue: [position := position - (0@1)] ifFalse: [
	aChar = $r ifTrue: [direction = $N ifTrue: [direction := $E] ifFalse:[ 
						  direction = $O ifTrue: [direction := $N].
						  direction = $S ifTrue: [direction := $O].
						  direction = $E ifTrue: [direction := $S]]] ifFalse: [
				
	aChar = $l ifTrue: [direction = $N ifTrue: [direction := $O] ifFalse:[ 
						  direction = $E ifTrue: [direction := $N].
						  direction = $S ifTrue: [direction := $E].
						  direction = $O ifTrue: [direction := $S]]]
					ifFalse: [ aChar = '' ifFalse: [^ self error: MarsRover invalidCommandMessage.]] 
					
					]]]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: #MarsRoverTDD!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'initialization' stamp: 'cmmmmm 10/3/2019 21:07:58'!
in: aPoint oriented: aDirection
	^MarsRover new initializeIn: aPoint oriented: aDirection! !


!MarsRover class methodsFor: 'error description' stamp: 'LS 10/4/2019 17:36:46'!
invalidCommandMessage
	^'Invalid command'! !


!classDefinition: #PuntoCardinal category: #MarsRoverTDD!
Object subclass: #PuntoCardinal
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverTDD'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PuntoCardinal class' category: #MarsRoverTDD!
PuntoCardinal class
	instanceVariableNames: 'uniqueInstance'!


!classDefinition: #Este category: #MarsRoverTDD!
PuntoCardinal subclass: #Este
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverTDD'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Este class' category: #MarsRoverTDD!
Este class
	instanceVariableNames: ''!

!Este class methodsFor: 'as yet unclassified' stamp: 'cmmmmm 10/8/2019 17:59:51'!
initialize

	uniqueInstance := self basicNew ! !

!Este class methodsFor: 'as yet unclassified' stamp: 'cmmmmm 10/8/2019 18:00:02'!
new 
	
	^uniqueInstance ! !


!classDefinition: #Norte category: #MarsRoverTDD!
PuntoCardinal subclass: #Norte
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverTDD'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Norte class' category: #MarsRoverTDD!
Norte class
	instanceVariableNames: ''!

!Norte class methodsFor: 'as yet unclassified' stamp: 'cmmmmm 10/8/2019 18:00:13'!
initialize

	uniqueInstance := self basicNew ! !

!Norte class methodsFor: 'as yet unclassified' stamp: 'cmmmmm 10/8/2019 18:00:22'!
new

	^uniqueInstance ! !


!classDefinition: #Oeste category: #MarsRoverTDD!
PuntoCardinal subclass: #Oeste
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverTDD'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Oeste class' category: #MarsRoverTDD!
Oeste class
	instanceVariableNames: ''!

!Oeste class methodsFor: 'as yet unclassified' stamp: 'cmmmmm 10/8/2019 18:00:29'!
initialize

	uniqueInstance := self basicNew ! !

!Oeste class methodsFor: 'as yet unclassified' stamp: 'cmmmmm 10/8/2019 18:00:40'!
new

	^uniqueInstance ! !


!classDefinition: #Sur category: #MarsRoverTDD!
PuntoCardinal subclass: #Sur
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverTDD'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sur class' category: #MarsRoverTDD!
Sur class
	instanceVariableNames: ''!

!Sur class methodsFor: 'as yet unclassified' stamp: 'cmmmmm 10/8/2019 18:00:48'!
initialize

	uniqueInstance := self basicNew ! !

!Sur class methodsFor: 'as yet unclassified' stamp: 'cmmmmm 10/8/2019 18:00:54'!
new

	^uniqueInstance ! !

Este initialize!
Norte initialize!
Oeste initialize!
Sur initialize!