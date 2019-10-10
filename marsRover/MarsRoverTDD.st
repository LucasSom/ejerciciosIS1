!classDefinition: #MarsRoverTest category: #MarsRoverTDD!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverTDD'!

!MarsRoverTest methodsFor: 'tests for invalid inputs' stamp: 'LS 10/9/2019 20:50:29'!
test01EmptyStringDoesNotChange
	
	marsRover move: ''.
	self assert: marsRover position equals: 1@1.
	self assert: Norte new equals: marsRover direction.
! !

!MarsRoverTest methodsFor: 'tests for invalid inputs' stamp: 'LS 10/9/2019 21:14:03'!
test06InvalidStringRaiseError
	
	self should: [ marsRover move: 'x'. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: MarsRover invalidCommandMessage.! !


!MarsRoverTest methodsFor: 'tests for 1 move' stamp: 'LS 10/9/2019 21:13:10'!
test02StringWithFMovesForwardAndDoesNotChangeDirection
	
	marsRover move: 'f'.
	self assert: marsRover position equals: 1@2.
	self assert: Norte new equals: marsRover direction.
! !

!MarsRoverTest methodsFor: 'tests for 1 move' stamp: 'LS 10/9/2019 21:13:22'!
test03StringWithBMovesBackwardsAndDoesNotChangeDirection
	
	marsRover move: 'b'.
	self assert: marsRover position equals: 1@0.
	self assert: Norte new equals: marsRover direction.
! !

!MarsRoverTest methodsFor: 'tests for 1 move' stamp: 'LS 10/9/2019 21:13:34'!
test04StringWithRRotatesRightAndDoesNotChangePosition
	
	marsRover move: 'r'.
	self assert: marsRover position equals: 1@1.
	self assert: Este new equals: marsRover direction.
! !

!MarsRoverTest methodsFor: 'tests for 1 move' stamp: 'LS 10/9/2019 21:13:43'!
test05StringWithLRotatesLeftAndDoesNotChangePosition
	
	marsRover move: 'l'.
	self assert: marsRover position equals: 1@1.
	self assert: Oeste new equals: marsRover direction.
! !


!MarsRoverTest methodsFor: 'tests for several equal moves' stamp: 'LS 10/9/2019 21:15:36'!
test07StringWithManyFMovesSeveralPositionsForwardAndDoesNotChangeDirection
	
	marsRover move: 'ff'.
	self assert: marsRover position equals: 1@3.
	self assert: Norte new equals: marsRover direction.
! !

!MarsRoverTest methodsFor: 'tests for several equal moves' stamp: 'LS 10/9/2019 21:15:47'!
test08StringWithManyBMovesSeveralPositionsBackwardsAndDoesNotChangeDirection
	
	marsRover move: 'bb'.
	self assert: marsRover position equals: 1@-1.
	self assert: Norte new equals: marsRover direction.
! !

!MarsRoverTest methodsFor: 'tests for several equal moves' stamp: 'LS 10/9/2019 21:15:58'!
test09StringWithManyRRotatesSeveralDirectionsRightAndDoesNotChangePosition
	
	marsRover move: 'rrr'.
	self assert: marsRover position equals: 1@1.
	self assert: Oeste new equals: marsRover direction.
! !

!MarsRoverTest methodsFor: 'tests for several equal moves' stamp: 'LS 10/9/2019 21:16:14'!
test10StringWithManyLRotatesSeveralDirectionsLeftAndDoesNotChangePosition
	
	marsRover move: 'lll'.
	self assert: marsRover position equals: 1@1.
	self assert: Este new equals: marsRover direction.
! !


!MarsRoverTest methodsFor: 'tests for different moves' stamp: 'LS 10/9/2019 19:27:36'!
test11StringWithRAndFMovesToRightAndChangeDirection
	
	marsRover move: 'rf'.
	self assert: marsRover position equals: 2@1.
	self assert: Este new equals: marsRover direction.
! !

!MarsRoverTest methodsFor: 'tests for different moves' stamp: 'LS 10/9/2019 19:30:22'!
test12StringWithLAndFMovesToLeftAndChangeDirection
	
	marsRover move: 'lf'.
	self assert: marsRover position equals: 0@1.
	self assert: Oeste new equals: marsRover direction.
! !

!MarsRoverTest methodsFor: 'tests for different moves' stamp: 'LS 10/9/2019 19:32:35'!
test13StringWith2RAndFMovesDownAndChangeDirection
	
	marsRover move: 'rrf'.
	self assert: marsRover position equals: 1@0.
	self assert: Sur new equals: marsRover direction.
! !

!MarsRoverTest methodsFor: 'tests for different moves' stamp: 'LS 10/9/2019 19:38:46'!
test14StringWithRAndBMovesToLeftAndChangeDirection
	
	marsRover move: 'rb'.
	self assert: marsRover position equals: 0@1.
	self assert: Este new equals: marsRover direction.! !

!MarsRoverTest methodsFor: 'tests for different moves' stamp: 'LS 10/9/2019 19:40:22'!
test15StringWithLAndBMovesToRightAndChangeDirection
	
	marsRover move: 'lb'.
	self assert: marsRover position equals: 2@1.
	self assert: Oeste new equals: marsRover direction.! !

!MarsRoverTest methodsFor: 'tests for different moves' stamp: 'LS 10/9/2019 19:41:53'!
test16StringWith2RAndBMovesUpAndChangeDirection
	
	marsRover move: 'rrb'.
	self assert: marsRover position equals: 1@2.
	self assert: Sur new equals: marsRover direction.! !

!MarsRoverTest methodsFor: 'tests for different moves' stamp: 'LS 10/9/2019 21:10:48'!
test17
	
	marsRover move: 'rrffflbffllfrff'.
	
	self assert: marsRover position equals: 1@0.
	self assert: Norte new equals: marsRover direction.! !


!MarsRoverTest methodsFor: 'setUp/tearDown' stamp: 'cmmmmm 10/8/2019 20:27:35'!
setUp
	
	marsRover _ MarsRover in: 1@1 oriented: Norte new. ! !


!classDefinition: #MarsRover category: #MarsRoverTDD!
Object subclass: #MarsRover
	instanceVariableNames: 'position direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverTDD'!

!MarsRover methodsFor: 'movement' stamp: 'LS 10/9/2019 21:02:21'!
move: aString
	
	aString do: [:a | self singleMove: a.].

	
	
	
	
	! !


!MarsRover methodsFor: 'accessing' stamp: 'cmmmmm 10/3/2019 21:10:55'!
direction

	^direction! !

!MarsRover methodsFor: 'accessing' stamp: 'cmmmmm 10/3/2019 21:08:40'!
position

	^position! !


!MarsRover methodsFor: 'initialization' stamp: 'cmmmmm 10/3/2019 21:04:25'!
initializeIn: aPoint oriented: aDirection 
	position := aPoint.
	direction := aDirection.! !


!MarsRover methodsFor: 'private' stamp: 'LS 10/9/2019 21:01:35'!
moveTo: aRelativePosition
	
	^position := position + aRelativePosition.! !

!MarsRover methodsFor: 'private' stamp: 'LS 10/9/2019 21:01:48'!
singleMove: aChar

	aChar = $f ifTrue: [self moveTo: direction forward]
	ifFalse: [
	
	aChar = $b ifTrue: [self moveTo: direction backward]
	ifFalse: [
	
	aChar = $r ifTrue: [direction := (direction r) ] ifFalse: [
				
	aChar = $l ifTrue: [direction := (direction l) ]
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

!PuntoCardinal methodsFor: 'movement' stamp: 'LS 10/9/2019 20:53:33'!
backward

	^self subclassResponsibility ! !

!PuntoCardinal methodsFor: 'movement' stamp: 'LS 10/9/2019 20:33:19'!
forward

	^self subclassResponsibility! !


!PuntoCardinal methodsFor: 'rotation' stamp: 'cmmmmm 10/8/2019 19:05:41'!
l 

	^self subclassResponsibility.! !

!PuntoCardinal methodsFor: 'rotation' stamp: 'cmmmmm 10/8/2019 19:05:47'!
r 

	^self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PuntoCardinal class' category: #MarsRoverTDD!
PuntoCardinal class
	instanceVariableNames: 'uniqueInstance'!

!PuntoCardinal class methodsFor: 'initialization' stamp: 'chris m 10/8/2019 22:07:42'!
initialize

	uniqueInstance := self basicNew ! !

!PuntoCardinal class methodsFor: 'initialization' stamp: 'chris m 10/8/2019 22:07:53'!
new 
	
	^uniqueInstance ! !


!classDefinition: #Este category: #MarsRoverTDD!
PuntoCardinal subclass: #Este
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverTDD'!

!Este methodsFor: 'movement' stamp: 'LS 10/9/2019 20:47:58'!
backward
	
	^(-1@0)! !

!Este methodsFor: 'movement' stamp: 'LS 10/9/2019 20:44:19'!
forward

	^(1@0)! !


!Este methodsFor: 'rotation' stamp: 'cmmmmm 10/8/2019 19:06:11'!
l
	
	^Norte new! !

!Este methodsFor: 'rotation' stamp: 'cmmmmm 10/8/2019 19:06:02'!
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

!Norte methodsFor: 'movement' stamp: 'LS 10/9/2019 20:47:47'!
backward
	
	^(0@-1)! !

!Norte methodsFor: 'movement' stamp: 'LS 10/9/2019 20:45:16'!
forward

	^(0@1)! !


!Norte methodsFor: 'rotation' stamp: 'cmmmmm 10/8/2019 19:06:31'!
l
	
	^Oeste new! !

!Norte methodsFor: 'rotation' stamp: 'cmmmmm 10/8/2019 20:12:25'!
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

!Oeste methodsFor: 'movement' stamp: 'LS 10/9/2019 20:47:23'!
backward

	^(1@0)! !

!Oeste methodsFor: 'movement' stamp: 'LS 10/9/2019 20:45:43'!
forward

	^(-1@0)! !


!Oeste methodsFor: 'rotation' stamp: 'cmmmmm 10/8/2019 19:07:05'!
l
	
	^Sur new! !

!Oeste methodsFor: 'rotation' stamp: 'cmmmmm 10/8/2019 19:06:59'!
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

!Sur methodsFor: 'rotation' stamp: 'cmmmmm 10/8/2019 19:07:16'!
l
	
	^Este new! !

!Sur methodsFor: 'rotation' stamp: 'cmmmmm 10/8/2019 19:07:22'!
r
	
	^Oeste new! !


!Sur methodsFor: 'movement' stamp: 'LS 10/9/2019 20:47:37'!
backward
	
	^(0@1)! !

!Sur methodsFor: 'movement' stamp: 'LS 10/9/2019 20:45:31'!
forward

	^(0@-1)! !

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