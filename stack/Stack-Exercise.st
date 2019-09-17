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
	instanceVariableNames: 'elementosEnLaPila xxxxxstackInternoAbstracto xxxtope'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'as yet unclassified' stamp: 'cmmmmm 9/17/2019 18:36:16'!
initialize

	xxxtope _ Celda nuevaCeldaVacia.
	^self.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'cmmmmm 9/17/2019 18:42:41'!
isEmpty
	^xxxtope isEmpty.
	 ! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'cmmmmm 9/17/2019 18:40:35'!
pop
	| yyyytopeViejo |

	yyyytopeViejo := xxxtope content. 
 	xxxtope := xxxtope anterior.
	^yyyytopeViejo.
	 
	! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'cmmmmm 9/17/2019 18:19:14'!
push: aNewTopElement
	
	|viejoTope|
	
	viejoTope _ xxxtope.
	xxxtope := Celda with: aNewTopElement conAnterior: viejoTope.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'cmmmmm 9/16/2019 20:14:00'!
size
	
	^ elementosEnLaPila size.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'cmmmmm 9/17/2019 18:39:15'!
top
	
	^xxxtope content.
	
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
	instanceVariableNames: 'contenido anterior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!Celda methodsFor: 'as yet unclassified' stamp: 'cmmm 9/16/2019 21:35:42'!
add: aNewTopElement

	contenido _ aNewTopElement .! !

!Celda methodsFor: 'as yet unclassified' stamp: 'cmmmmm 9/17/2019 18:13:45'!
anterior
	^ self subclassResponsibility.! !

!Celda methodsFor: 'as yet unclassified' stamp: 'cmmmmm 9/17/2019 18:11:56'!
content
	^ self subclassResponsibility.! !

!Celda methodsFor: 'as yet unclassified' stamp: 'cmmm 9/16/2019 21:32:32'!
initialize
	anterior _ self.
	size _ 0.
	^self.! !

!Celda methodsFor: 'as yet unclassified' stamp: 'cmmmmm 9/17/2019 18:09:21'!
isEmpty
	^ self subclassResponsibility.! !

!Celda methodsFor: 'as yet unclassified' stamp: 'cmmmmm 9/17/2019 18:34:28'!
nuevaCeldaVacia
	^CeldaVacia new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Celda class' category: #'Stack-Exercise'!
Celda class
	instanceVariableNames: ''!

!Celda class methodsFor: 'as yet unclassified' stamp: 'cmmmmm 9/17/2019 18:47:02'!
nuevaCeldaVacia
	^CeldaVacia new.! !

!Celda class methodsFor: 'as yet unclassified' stamp: 'cmmmmm 9/17/2019 18:21:44'!
with: unElemento conAnterior: xxxxxx
	! !


!classDefinition: #CeldaNoVacia category: #'Stack-Exercise'!
Celda subclass: #CeldaNoVacia
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!CeldaNoVacia methodsFor: 'as yet unclassified' stamp: 'cmmmmm 9/17/2019 18:14:00'!
anterior
	^ anterior.! !

!CeldaNoVacia methodsFor: 'as yet unclassified' stamp: 'cmmmmm 9/17/2019 18:12:39'!
content
	^contenido.! !

!CeldaNoVacia methodsFor: 'as yet unclassified' stamp: 'cmmmmm 9/17/2019 18:09:55'!
isEmpty
	^ false.! !


!classDefinition: #CeldaVacia category: #'Stack-Exercise'!
Celda subclass: #CeldaVacia
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!CeldaVacia methodsFor: 'as yet unclassified' stamp: 'cmmmmm 9/17/2019 18:14:32'!
anterior
	^ self error: 'celda vacia no tiene anterior'.! !

!CeldaVacia methodsFor: 'as yet unclassified' stamp: 'cmmmmm 9/17/2019 18:13:03'!
content 
	^ self error: 'celda vacia'.! !

!CeldaVacia methodsFor: 'as yet unclassified' stamp: 'cmmmmm 9/17/2019 18:09:43'!
isEmpty
	^ true.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CeldaVacia class' category: #'Stack-Exercise'!
CeldaVacia class
	instanceVariableNames: 'uniqueInstance'!

!CeldaVacia class methodsFor: 'as yet unclassified' stamp: 'cmmmmm 9/17/2019 18:45:33'!
initialize
	
	uniqueInstance := self basicNew.! !

!CeldaVacia class methodsFor: 'as yet unclassified' stamp: 'cmmmmm 9/17/2019 18:45:44'!
new
	
	^uniqueInstance.! !


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

!OOStackAbstractoNoVacio methodsFor: 'as yet unclassified' stamp: 'cmmmmm 9/17/2019 17:54:20'!
pop: anOrderedCollection

	^anOrderedCollection removeFirst. ! !


!classDefinition: #OOStackAbstractoVacio category: #'Stack-Exercise'!
OOStackAbstracto subclass: #OOStackAbstractoVacio
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackAbstractoVacio methodsFor: 'as yet unclassified' stamp: 'cmmmmm 9/17/2019 17:55:16'!
pop: anOrderedCollection

	 ^self class error: self class stackEmptyErrorDescription.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackAbstractoVacio class' category: #'Stack-Exercise'!
OOStackAbstractoVacio class
	instanceVariableNames: 'uniqueInstance'!

!OOStackAbstractoVacio class methodsFor: 'as yet unclassified' stamp: 'cmmmmm 9/17/2019 17:40:23'!
initialize
	
	uniqueInstance := self basicNew.! !

!OOStackAbstractoVacio class methodsFor: 'as yet unclassified' stamp: 'cmmmmm 9/17/2019 17:41:10'!
new
	
	^uniqueInstance.! !


!classDefinition: #SentenceFinderByPrefix category: #'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

CeldaVacia initialize!
OOStackAbstractoVacio initialize!