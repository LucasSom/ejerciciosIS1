!classDefinition: #OOStackTest category: #'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:31'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/8/2012 08:20'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:33'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'First'.
	secondPushedObject := 'Second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:35'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:36'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:36'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: #'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'elementosEnLaPila'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'as yet unclassified' stamp: 'cmmmmm 9/16/2019 20:14:00'!
initialize

	elementosEnLaPila _ OrderedCollection new.
	^self.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'cmmmmm 9/16/2019 20:14:00'!
isEmpty
	^elementosEnLaPila isEmpty.
	 ! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'cmmmmm 9/16/2019 20:14:00'!
pop 
	
	self isEmpty ifTrue: [ ^self class error: self class stackEmptyErrorDescription ].
	^elementosEnLaPila removeFirst. ! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'cmmmmm 9/16/2019 20:14:00'!
push: aNewTopElement

	elementosEnLaPila addFirst: aNewTopElement. ! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'cmmmmm 9/16/2019 20:14:00'!
size
	
	^ elementosEnLaPila size.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'cmmmmm 9/16/2019 20:14:00'!
top
	
	self isEmpty ifTrue: [ ^self class error: self class stackEmptyErrorDescription  ].
	^ elementosEnLaPila first.

	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !


!classDefinition: #Celda category: #'Stack-Exercise'!
OOStack subclass: #Celda
	instanceVariableNames: 'contenido anterior size'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!Celda methodsFor: 'as yet unclassified' stamp: 'cmmm 9/16/2019 21:35:42'!
add: aNewTopElement

	contenido _ aNewTopElement .! !

!Celda methodsFor: 'as yet unclassified' stamp: 'cmmm 9/16/2019 21:32:32'!
initialize
	anterior _ self.
	size _ 0.
	^self.! !

!Celda methodsFor: 'as yet unclassified' stamp: 'cmmm 9/16/2019 21:33:11'!
isEmpty
	^ [size = 0] value.! !


!classDefinition: #OOStackAbstracto category: #'Stack-Exercise'!
Object subclass: #OOStackAbstracto
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!


!classDefinition: #OOStackAbstractoNoVacio category: #'Stack-Exercise'!
OOStackAbstracto subclass: #OOStackAbstractoNoVacio
	instanceVariableNames: 'elementosEnLaPila'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!


!classDefinition: #OOStackAbstractoVacio category: #'Stack-Exercise'!
OOStackAbstracto subclass: #OOStackAbstractoVacio
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!


!classDefinition: #SentenceFinderByPrefix category: #'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!