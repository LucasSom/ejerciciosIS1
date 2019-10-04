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

!MarsRover methodsFor: 'as yet unclassified' stamp: 'cmmmmm 10/3/2019 21:54:22'!
move: aString
	aString = 'f' ifTrue: [position := position + (0@1)] ifFalse: [
	aString = 'b' ifTrue: [position := position - (0@1)] ifFalse: [
	aString = 'r' ifTrue: [direction = $N ifTrue: [direction := $E] ifFalse:[ 
						  direction = $O ifTrue: [direction := $N].
						  direction = $S ifTrue: [direction := $O].
						  direction = $E ifTrue: [direction := $S]]] ifFalse: [
				
	aString = 'l' ifTrue: [direction = $N ifTrue: [direction := $O] ifFalse:[ 
						  direction = $E ifTrue: [direction := $N].
						  direction = $S ifTrue: [direction := $E].
						  direction = $O ifTrue: [direction := $S]]] ifFalse: [				
				
	aString = 'ff' ifTrue: [position := position + (0@2)] ifFalse: [^MarsRover invalidCommandMessage ] ]]]] 
	
	
	
	! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'cmmmmm 10/3/2019 21:08:40'!
position

	^position! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: #MarsRoverTDD!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'initialization' stamp: 'cmmmmm 10/3/2019 21:07:58'!
in: aPoint oriented: aDirection
	^MarsRover new initializeIn: aPoint oriented: aDirection! !


!MarsRover class methodsFor: 'as yet unclassified' stamp: 'cmmmmm 10/3/2019 21:48:08'!
invalidCommandMessage
	^'Invalid command'! !
