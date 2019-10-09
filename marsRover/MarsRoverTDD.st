!classDefinition: #MarsRoverTest category: #MarsRoverTDD!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverTDD'!

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'cmmmmm 10/8/2019 20:28:01'!
test01EmptyStringDoesNotChange
	
	marsRover move: ''.
	self assert: marsRover position equals: 1@1.
	self assert: Norte new equals: marsRover direction.
! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'cmmmmm 10/8/2019 20:28:58'!
test02StringWithFMovesForwardAndDoesNotChangeDirection
	
	marsRover move: 'f'.
	self assert: marsRover position equals: 1@2.
	self assert: Norte new equals: marsRover direction.
! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'cmmmmm 10/8/2019 20:29:11'!
test03StringWithBMovesBackwardsAndDoesNotChangeDirection
	
	marsRover move: 'b'.
	self assert: marsRover position equals: 1@0.
	self assert: Norte new equals: marsRover direction.
! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'cmmmmm 10/8/2019 20:29:16'!
test04StringWithRRotatesRightAndDoesNotChangePosition
	
	marsRover move: 'r'.
	self assert: marsRover position equals: 1@1.
	self assert: Este new equals: marsRover direction.
! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'cmmmmm 10/8/2019 20:29:26'!
test05StringWithLRotatesLeftAndDoesNotChangePosition
	
	marsRover move: 'l'.
	self assert: marsRover position equals: 1@1.
	self assert: Oeste new equals: marsRover direction.
! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'cmmmmm 10/8/2019 20:29:34'!
test06InvalidStringRaiseError
	
	self should: [ marsRover move: 'x'. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: MarsRover invalidCommandMessage.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'cmmmmm 10/8/2019 20:29:40'!
test07StringWithManyFMovesSeveralPositionsForwardAndDoesNotChangeDirection
	
	marsRover move: 'ff'.
	self assert: marsRover position equals: 1@3.
	self assert: Norte new equals: marsRover direction.
! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'cmmmmm 10/8/2019 20:29:48'!
test08StringWithManyBMovesSeveralPositionsBackwardsAndDoesNotChangeDirection
	
	marsRover move: 'bb'.
	self assert: marsRover position equals: 1@-1.
	self assert: Norte new equals: marsRover direction.
! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'cmmmmm 10/8/2019 20:29:57'!
test09StringWithManyRRotatesSeveralDirectionsRightAndDoesNotChangePosition
	
	marsRover move: 'rrr'.
	self assert: marsRover position equals: 1@1.
	self assert: Oeste new equals: marsRover direction.
! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'cmmmmm 10/8/2019 20:30:04'!
test10StringWithManyLRotatesSeveralDirectionsLeftAndDoesNotChangePosition
	
	marsRover move: 'lll'.
	self assert: marsRover position equals: 1@1.
	self assert: Este new equals: marsRover direction.
! !


!MarsRoverTest methodsFor: 'setUp/tearDown' stamp: 'cmmmmm 10/8/2019 20:27:35'!
setUp
	
	marsRover _ MarsRover in: 1@1 oriented: Norte new. ! !


!classDefinition: #MarsRover category: #MarsRoverTDD!
Object subclass: #MarsRover
	instanceVariableNames: 'position direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverTDD'!

!MarsRover methodsFor: 'as yet unclassified' stamp: 'cmmmmm 10/3/2019 21:10:55'!
direction

	^direction! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'chris m 10/9/2019 00:52:34'!
executeMovement: aChar

	aChar = $f ifTrue: [position := position + (0@1)] ifFalse: [
	aChar = $b ifTrue: [position := position - (0@1)] ifFalse: [
	aChar = $r ifTrue: [direction := (direction r) ] ifFalse: [
				
	aChar = $l ifTrue: [direction := (direction l) ]
					ifFalse: [ aChar = '' ifFalse: [^ self error: MarsRover invalidCommandMessage.]] 
					
					]]]! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'chris m 10/9/2019 00:52:34'!
move: aString
	
	aString do: [:a | self executeMovement: a.].

	
	
	
	
	! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'cmmmmm 10/3/2019 21:08:40'!
position

	^position! !


!MarsRover methodsFor: 'initialization' stamp: 'cmmmmm 10/3/2019 21:04:25'!
initializeIn: aPoint oriented: aDirection 
	position := aPoint.
	direction := aDirection.! !

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

!PuntoCardinal methodsFor: 'as yet unclassified' stamp: 'cmmmmm 10/8/2019 19:05:41'!
l 

	^self subclassResponsibility.! !

!PuntoCardinal methodsFor: 'as yet unclassified' stamp: 'cmmmmm 10/8/2019 19:05:47'!
r 

	^self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PuntoCardinal class' category: #MarsRoverTDD!
PuntoCardinal class
	instanceVariableNames: 'uniqueInstance'!

!PuntoCardinal class methodsFor: 'as yet unclassified' stamp: 'chris m 10/8/2019 22:07:42'!
initialize

	uniqueInstance := self basicNew ! !

!PuntoCardinal class methodsFor: 'as yet unclassified' stamp: 'chris m 10/8/2019 22:07:53'!
new 
	
	^uniqueInstance ! !


!classDefinition: #Este category: #MarsRoverTDD!
PuntoCardinal subclass: #Este
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverTDD'!

!Este methodsFor: 'as yet unclassified' stamp: 'cmmmmm 10/8/2019 19:06:11'!
l
	
	^Norte new! !

!Este methodsFor: 'as yet unclassified' stamp: 'cmmmmm 10/8/2019 19:06:02'!
r
	
	^Sur new! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Este class' category: #MarsRoverTDD!
Este class
	instanceVariableNames: ''!

!Este class methodsFor: 'initialization' stamp: 'cmmmmm 10/8/2019 17:59:51'!
initialize

	uniqueInstance := self basicNew ! !

!Este class methodsFor: 'initialization' stamp: 'cmmmmm 10/8/2019 18:00:02'!
new 
	
	^uniqueInstance ! !


!classDefinition: #Norte category: #MarsRoverTDD!
PuntoCardinal subclass: #Norte
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverTDD'!

!Norte methodsFor: 'as yet unclassified' stamp: 'cmmmmm 10/8/2019 19:06:31'!
l
	
	^Oeste new! !

!Norte methodsFor: 'as yet unclassified' stamp: 'cmmmmm 10/8/2019 20:12:25'!
r
	| nuevaDireccion |
	nuevaDireccion := Este new.
	^nuevaDireccion.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Norte class' category: #MarsRoverTDD!
Norte class
	instanceVariableNames: ''!

!Norte class methodsFor: 'initialization' stamp: 'cmmmmm 10/8/2019 18:00:13'!
initialize

	uniqueInstance := self basicNew ! !

!Norte class methodsFor: 'initialization' stamp: 'cmmmmm 10/8/2019 18:00:22'!
new

	^uniqueInstance ! !


!classDefinition: #Oeste category: #MarsRoverTDD!
PuntoCardinal subclass: #Oeste
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverTDD'!

!Oeste methodsFor: 'as yet unclassified' stamp: 'cmmmmm 10/8/2019 19:07:05'!
l
	
	^Sur new! !

!Oeste methodsFor: 'as yet unclassified' stamp: 'cmmmmm 10/8/2019 19:06:59'!
r
	
	^Norte new! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Oeste class' category: #MarsRoverTDD!
Oeste class
	instanceVariableNames: ''!

!Oeste class methodsFor: 'initialization' stamp: 'cmmmmm 10/8/2019 18:00:29'!
initialize

	uniqueInstance := self basicNew ! !

!Oeste class methodsFor: 'initialization' stamp: 'cmmmmm 10/8/2019 18:00:40'!
new

	^uniqueInstance ! !


!classDefinition: #Sur category: #MarsRoverTDD!
PuntoCardinal subclass: #Sur
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverTDD'!

!Sur methodsFor: 'as yet unclassified' stamp: 'cmmmmm 10/8/2019 19:07:16'!
l
	
	^Este new! !

!Sur methodsFor: 'as yet unclassified' stamp: 'cmmmmm 10/8/2019 19:07:22'!
r
	
	^Oeste new! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sur class' category: #MarsRoverTDD!
Sur class
	instanceVariableNames: ''!

!Sur class methodsFor: 'initialization' stamp: 'cmmmmm 10/8/2019 18:00:48'!
initialize

	uniqueInstance := self basicNew ! !

!Sur class methodsFor: 'initialization' stamp: 'cmmmmm 10/8/2019 18:00:54'!
new

	^uniqueInstance ! !

PuntoCardinal initialize!
Este initialize!
Norte initialize!
Oeste initialize!
Sur initialize!