!classDefinition: #MarsRoverTest category: #MarsRoverTDD!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverTDD'!

!MarsRoverTest methodsFor: 'tests for invalid inputs' stamp: 'cmmmmm 10/10/2019 15:42:21'!
test01EmptyStringDoesNotChange
	
	marsRover move: ''.
	self assert: marsRover IsIn: 1@1  pointing: Norte new. 
	! !

!MarsRoverTest methodsFor: 'tests for invalid inputs' stamp: 'LS 10/9/2019 21:14:03'!
test06InvalidStringRaiseError
	
	self should: [ marsRover move: 'x'. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: MarsRover invalidCommandMessage.! !


!MarsRoverTest methodsFor: 'tests for 1 move' stamp: 'cmmmmm 10/10/2019 15:42:57'!
test02StringWithFMovesForwardAndDoesNotChangeDirection
	
	marsRover move: 'f'.
	self assert: marsRover IsIn: 1@2  pointing: Norte new. 
! !

!MarsRoverTest methodsFor: 'tests for 1 move' stamp: 'cmmmmm 10/10/2019 15:43:22'!
test03StringWithBMovesBackwardsAndDoesNotChangeDirection
	
	marsRover move: 'b'.
	self assert: marsRover IsIn: 1@0  pointing: Norte new. 
! !

!MarsRoverTest methodsFor: 'tests for 1 move' stamp: 'cmmmmm 10/10/2019 15:43:39'!
test04StringWithRRotatesRightAndDoesNotChangePosition
	
	marsRover move: 'r'.
	self assert: marsRover IsIn: 1@1  pointing: Este new. 
! !

!MarsRoverTest methodsFor: 'tests for 1 move' stamp: 'cmmmmm 10/10/2019 15:44:11'!
test05StringWithLRotatesLeftAndDoesNotChangePosition
	
	marsRover move: 'l'.
	self assert: marsRover IsIn: 1@1  pointing: Oeste new. 
! !


!MarsRoverTest methodsFor: 'tests for several equal moves' stamp: 'cmmmmm 10/10/2019 15:44:27'!
test07StringWithManyFMovesSeveralPositionsForwardAndDoesNotChangeDirection
	
	marsRover move: 'ff'.
	self assert: marsRover IsIn: 1@3  pointing: Norte new. 
	! !

!MarsRoverTest methodsFor: 'tests for several equal moves' stamp: 'cmmmmm 10/10/2019 15:44:43'!
test08StringWithManyBMovesSeveralPositionsBackwardsAndDoesNotChangeDirection
	
	marsRover move: 'bb'.
	self assert: marsRover IsIn: 1@-1  pointing: Norte new. 
	! !

!MarsRoverTest methodsFor: 'tests for several equal moves' stamp: 'cmmmmm 10/10/2019 15:45:05'!
test09StringWithManyRRotatesSeveralDirectionsRightAndDoesNotChangePosition
	
	marsRover move: 'rrr'.
	self assert: marsRover IsIn: 1@1  pointing: Oeste new. 

! !

!MarsRoverTest methodsFor: 'tests for several equal moves' stamp: 'cmmmmm 10/10/2019 15:46:01'!
test10StringWithManyLRotatesSeveralDirectionsLeftAndDoesNotChangePosition
	
	marsRover move: 'lll'.
	self assert: marsRover IsIn: 1@1  pointing: Este new. 
	! !


!MarsRoverTest methodsFor: 'tests for different moves' stamp: 'cmmmmm 10/10/2019 15:46:34'!
test11StringWithRAndFMovesToRightAndChangeDirection
	
	marsRover move: 'rf'.
	self assert: marsRover IsIn: 2@1  pointing: Este new. 
	! !

!MarsRoverTest methodsFor: 'tests for different moves' stamp: 'cmmmmm 10/10/2019 15:46:51'!
test12StringWithLAndFMovesToLeftAndChangeDirection
	
	marsRover move: 'lf'.
	self assert: marsRover IsIn: 0@1  pointing: Oeste new. 
	! !

!MarsRoverTest methodsFor: 'tests for different moves' stamp: 'cmmmmm 10/10/2019 15:47:11'!
test13StringWith2RAndFMovesDownAndChangeDirection
	
	marsRover move: 'rrf'.
	self assert: marsRover IsIn: 1@0  pointing: Sur new. 
! !

!MarsRoverTest methodsFor: 'tests for different moves' stamp: 'cmmmmm 10/10/2019 15:47:33'!
test14StringWithRAndBMovesToLeftAndChangeDirection
	
	marsRover move: 'rb'.
	self assert: marsRover IsIn: 0@1  pointing: Este new. 
	! !

!MarsRoverTest methodsFor: 'tests for different moves' stamp: 'cmmmmm 10/10/2019 15:47:47'!
test15StringWithLAndBMovesToRightAndChangeDirection
	
	marsRover move: 'lb'.
	self assert: marsRover IsIn: 2@1  pointing: Oeste new. 
! !

!MarsRoverTest methodsFor: 'tests for different moves' stamp: 'cmmmmm 10/10/2019 15:48:09'!
test16StringWith2RAndBMovesUpAndChangeDirection
	
	marsRover move: 'rrb'.
	self assert: marsRover IsIn: 1@2  pointing: Sur new. 
! !


!MarsRoverTest methodsFor: 'setUp/tearDown' stamp: 'cmmmmm 10/8/2019 20:27:35'!
setUp
	
	marsRover _ MarsRover in: 1@1 oriented: Norte new. ! !


!MarsRoverTest methodsFor: 'assertions' stamp: 'cmmmmm 10/10/2019 15:41:25'!
assert: aRover IsIn: aPosition pointing: aDirection
	
	self assert: aPosition equals: aRover position .
	self assert: aDirection equals: aRover direction.
! !


!classDefinition: #MarsRover category: #MarsRoverTDD!
Object subclass: #MarsRover
	instanceVariableNames: 'position direction commandToMovement'
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


!MarsRover methodsFor: 'private' stamp: 'cmmmmm 10/10/2019 16:47:25'!
initialize
	
	commandToMovement := Dictionary new.
	commandToMovement add: $f->[self moveTo: direction forward].
	commandToMovement add: $b->[self moveTo: direction backward ].
	commandToMovement add: $r->[direction := direction rotateRight ].
	commandToMovement add: $l->[direction := direction rotateLeft ].
	
! !

!MarsRover methodsFor: 'private' stamp: 'LS 10/9/2019 21:01:35'!
moveTo: aRelativePosition
	
	^position := position + aRelativePosition.! !

!MarsRover methodsFor: 'private' stamp: 'cmmmmm 10/10/2019 16:47:25'!
singleMove: aChar

	(commandToMovement at: aChar ifAbsent: [^ self error: MarsRover invalidCommandMessage.]) value.	
	! !

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


!PuntoCardinal methodsFor: 'rotation' stamp: 'cmmmmm 10/10/2019 16:09:23'!
rotateLeft 

	^self subclassResponsibility.! !

!PuntoCardinal methodsFor: 'rotation' stamp: 'cmmmmm 10/10/2019 16:10:13'!
rotateRight 

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


!Este methodsFor: 'rotation' stamp: 'cmmmmm 10/10/2019 16:09:23'!
rotateLeft
	
	^Norte new! !

!Este methodsFor: 'rotation' stamp: 'cmmmmm 10/10/2019 16:10:13'!
rotateRight
	
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


!Norte methodsFor: 'rotation' stamp: 'cmmmmm 10/10/2019 16:09:23'!
rotateLeft
	
	^Oeste new! !

!Norte methodsFor: 'rotation' stamp: 'cmmmmm 10/10/2019 16:10:13'!
rotateRight
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


!Oeste methodsFor: 'rotation' stamp: 'cmmmmm 10/10/2019 16:09:23'!
rotateLeft
	
	^Sur new! !

!Oeste methodsFor: 'rotation' stamp: 'cmmmmm 10/10/2019 16:10:13'!
rotateRight
	
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

!Sur methodsFor: 'rotation' stamp: 'cmmmmm 10/10/2019 16:09:23'!
rotateLeft
	
	^Este new! !

!Sur methodsFor: 'rotation' stamp: 'cmmmmm 10/10/2019 16:10:13'!
rotateRight
	
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