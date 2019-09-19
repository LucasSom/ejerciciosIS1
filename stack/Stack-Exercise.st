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

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'asdfasf 9/19/2019 16:04:14'!
test01BuscarConPrefijoVacioDevuelveColeccionVacia
	
	| stack sentenceFinder |
	
	stack := OOStack new.
	sentenceFinder := SentenceFinderByPrefix with: stack .
	
	self assert: [ sentenceFinder find: '' isEmpty .].! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'asdfasf 9/19/2019 16:07:50'!
test02BuscarConPrefijoVacioEnStackCon1ElementoDevuelveColeccionVacia
	
	| stack sentenceFinder |
	
	stack := OOStack new.
	stack push: 'Sofi'.
	sentenceFinder := SentenceFinderByPrefix with: stack .
	
	self assert: [ (sentenceFinder find: '') isEmpty .].! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'asdfasf 9/19/2019 16:07:29'!
test03BuscarConPrefijoEnStackCon1ElementoDiferenteDevuelveColeccionVacia
	
	| stack sentenceFinder |
	
	stack := OOStack new.
	sentenceFinder := SentenceFinderByPrefix with: stack .
	
	self assert: [ (sentenceFinder find: 'sofi') isEmpty .].
! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'asdfasf 9/19/2019 16:07:17'!
test04BuscarConPrefijoEnStackConVacioDevuelveColeccionVacia
	
	| stack sentenceFinder |
	
	stack := OOStack new.
	sentenceFinder := SentenceFinderByPrefix with: stack .
	
	self assert: [ (sentenceFinder find: 'sofi') isEmpty .].
! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'asdfasf 9/19/2019 16:06:27'!
test05BuscarConPrefijoEnStackCon1ElementoDiferenteDevuelveColeccionVacia
	
	| stack sentenceFinder |
	
	stack := OOStack new.
	stack push: 'gerardo'.
	sentenceFinder := SentenceFinderByPrefix with: stack .
	
	
	self assert: [ (sentenceFinder find: 'sofi') isEmpty .].
	
	 ! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'asdfasf 9/19/2019 16:10:01'!
test06BuscarConPrefijoEnStackCon1ElementoMasCortoDevuelveColeccionVacia
	
	| stack sentenceFinder |
	
	stack := OOStack new.
	stack push: 'so'.
	sentenceFinder := SentenceFinderByPrefix with: stack .
	
	self assert: [ (sentenceFinder find: 'sofi') isEmpty .].
! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'asdfasf 9/19/2019 16:10:05'!
test07BuscarConPrefijoEnStackCon1ElementoIgualDevuelveColeccionConElemento
	
	| stack sentenceFinder |
	
	stack := OOStack new.
	stack push: 'sofia'.
	sentenceFinder := SentenceFinderByPrefix with: stack .
	
	self assert: [ (sentenceFinder find: 'sofi') = (OrderedCollection with: 'sofia').].
! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'asdfasf 9/19/2019 16:12:59'!
test08BuscarConPrefijoEnStackCon1ElementoMasLargoDevuelveColeccionConElemento
	
	| stack sentenceFinder |
	
	stack := OOStack new.
	stack push: 'sofia Velez'.
	sentenceFinder := SentenceFinderByPrefix with: stack .
	
	self assert: [ (sentenceFinder find: 'sofia') = (OrderedCollection with: 'sofia Velez').].
	! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'asdfasf 9/19/2019 16:13:22'!
test09BuscarConPrefijoEnStackCon2Elementos1PrefijoDevuelveColeccionConElemento
	
	| stack sentenceFinder |
	
	stack := OOStack new.
	stack push: 'sofia Velez'.
	stack push: 'me gustan las milanesas'.
	
	sentenceFinder := SentenceFinderByPrefix with: stack .
	
	self assert: [ (sentenceFinder find: 'sofia') = (OrderedCollection with: 'sofia Velez').].
! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'asdfasf 9/19/2019 16:13:59'!
test10BuscarConPrefijoEnStackCon2ElementosDiferentesDevuelveColeccionVacia
	
	| stack sentenceFinder |
	
	stack := OOStack new.
	stack push: 'sofia Velez'.
	stack push: 'me gustan las milanesas'.
	
	sentenceFinder := SentenceFinderByPrefix with: stack .
	
	self assert: [ (sentenceFinder find: 'gerardo') isEmpty .].
! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'asdfasf 9/19/2019 16:14:38'!
test11BuscarConPrefijoEnStackCon2Elementos2PrefijoDevuelveColeccionConLos2Elementos
	
	| stack sentenceFinder |
	
	stack := OOStack new.
	stack push: 'sofia Velez'.
	stack push: 'sorrentinos de verdura'.
	
	sentenceFinder := SentenceFinderByPrefix with: stack .
	
	self assert: [ (sentenceFinder find: 'so') = (OrderedCollection with: 'sofia Velez' with: 'sorrentinos de verdura').].
! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'asdfasf 9/19/2019 16:18:05'!
test12BuscarConPrefijoQueNoEsteEnStackConVariosElementosDevuelveColeccionVacia
	
	| stack sentenceFinder |
	
	stack := OOStack new.
	stack push: 'sofia Velez'.
	stack push: 'sorrentinos de verdura'.
	stack push: 'Araoz y la Verdad'.
	stack push: 'Esperandolo a Tito'.
	stack push: 'La odisea de los Giles'.
	
	sentenceFinder := SentenceFinderByPrefix with: stack .
	
	self assert: [ (sentenceFinder find: 'rac') isEmpty .].! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'asdfasf 9/19/2019 16:18:33'!
test13BuscarConPrefijoQueEstaRepetidoEnStackConVariosElementosDevuelveColeccionConElementos
	
	| stack sentenceFinder |
	
	stack := OOStack new.
	stack push: 'sofia Velez'.
	stack push: 'sorrentinos de verdura'.
	stack push: 'Araoz y la Verdad'.
	stack push: 'Esperandolo a Tito'.
	stack push: 'La odisea de los Giles'.
	
	sentenceFinder := SentenceFinderByPrefix with: stack .
	
	self assert: [ (sentenceFinder find: 'so') = (OrderedCollection with: 'sofia Velez' with: 'sorrentinos de verdura').].! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'asdfasf 9/19/2019 16:10:34'!
test14BuscarNoDestruyeElStack
	
	| stack stack2 sentenceFinder |
	
	stack := OOStack new.
	stack push: 'sofia Velez'.
	stack push: 'sorrentinos de verdura'.
	stack push: 'Araoz y la Verdad'.
	stack push: 'Esperandolo a Tito'.
	stack push: 'La odisea de los Giles'.
	
	sentenceFinder := SentenceFinderByPrefix with: stack .
	
	sentenceFinder find: 'so'.
	
	stack2 := OOStack new.
	stack2 push: 'sofia Velez'.
	stack2 push: 'sorrentinos de verdura'.
	stack2 push: 'Araoz y la Verdad'.
	stack2 push: 'Esperandolo a Tito'.
	stack2 push: 'La odisea de los Giles'.
	
	self assert: [ stack = stack2] = true.! !


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'size celdaSuperior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'as yet unclassified' stamp: 'LS 9/18/2019 13:43:06'!
incrementarSize
	size := size + 1.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'LS 9/19/2019 14:26:12'!
initialize

	celdaSuperior _ Celda nuevaCeldaVacia.
	size _ 0.
	^self.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'LS 9/18/2019 08:28:08'!
isEmpty
	^size = 0.
	 ! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'LS 9/19/2019 14:26:12'!
pop
	
	^celdaSuperior popEnStack: self.
	 
	! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'LS 9/19/2019 14:27:05'!
push: aNewTopElement
	
	|viejaCeldaSuperior|
	
	viejaCeldaSuperior _ celdaSuperior.
	celdaSuperior := Celda with: aNewTopElement conAnterior: viejaCeldaSuperior enStack: self.
	! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'LS 9/19/2019 14:27:51'!
sacarTope
	
	| celdaSuperiorVieja |

	size _ size-1.
	celdaSuperiorVieja := celdaSuperior content. 
 	celdaSuperior := celdaSuperior anterior.
	^celdaSuperiorVieja.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'LS 9/18/2019 08:27:34'!
size
	
	^ size.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'LS 9/19/2019 14:26:12'!
top
	
	^celdaSuperior content.
	
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
	instanceVariableNames: 'contenido celdaAnterior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!Celda methodsFor: 'as yet unclassified' stamp: 'LS 9/19/2019 14:43:04'!
add: aNewTopElement

	contenido _ aNewTopElement .! !

!Celda methodsFor: 'as yet unclassified' stamp: 'cmmmmm 9/17/2019 18:13:45'!
anterior
	^ self subclassResponsibility.! !

!Celda methodsFor: 'as yet unclassified' stamp: 'cmmmmm 9/17/2019 18:11:56'!
content
	^ self subclassResponsibility.! !

!Celda methodsFor: 'as yet unclassified' stamp: 'LS 9/19/2019 14:46:52'!
initialize
	^self.! !

!Celda methodsFor: 'as yet unclassified' stamp: 'cmmmmm 9/17/2019 18:09:21'!
isEmpty
	^ self subclassResponsibility.! !

!Celda methodsFor: 'as yet unclassified' stamp: 'cmmmmm 9/17/2019 18:34:28'!
nuevaCeldaVacia
	^CeldaVacia new.! !

!Celda methodsFor: 'as yet unclassified' stamp: 'LS 9/18/2019 08:56:55'!
popEnStack: unStack

	^self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Celda class' category: #'Stack-Exercise'!
Celda class
	instanceVariableNames: ''!

!Celda class methodsFor: 'as yet unclassified' stamp: 'cmmmmm 9/17/2019 18:47:02'!
nuevaCeldaVacia
	^CeldaVacia new.! !

!Celda class methodsFor: 'as yet unclassified' stamp: 'LS 9/18/2019 08:41:35'!
with: unElemento conAnterior: celdaAnterior enStack: unStack
	
	^CeldaNoVacia safeWithElement: unElemento conAnterior: celdaAnterior enStack: unStack .! !


!classDefinition: #CeldaNoVacia category: #'Stack-Exercise'!
Celda subclass: #CeldaNoVacia
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!CeldaNoVacia methodsFor: 'as yet unclassified' stamp: 'LS 9/19/2019 14:43:32'!
anterior
	^ celdaAnterior.! !

!CeldaNoVacia methodsFor: 'as yet unclassified' stamp: 'LS 9/19/2019 14:43:04'!
content
	^contenido.! !

!CeldaNoVacia methodsFor: 'as yet unclassified' stamp: 'LS 9/19/2019 14:43:32'!
initializeSafeWith: unElemento conAnterior: unaCelda

	contenido _ unElemento.
	celdaAnterior _ unaCelda.
	! !

!CeldaNoVacia methodsFor: 'as yet unclassified' stamp: 'cmmmmm 9/17/2019 18:09:55'!
isEmpty
	^ false.! !

!CeldaNoVacia methodsFor: 'as yet unclassified' stamp: 'LS 9/18/2019 08:58:37'!
popEnStack: unStack

	^unStack sacarTope.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CeldaNoVacia class' category: #'Stack-Exercise'!
CeldaNoVacia class
	instanceVariableNames: ''!

!CeldaNoVacia class methodsFor: 'as yet unclassified' stamp: 'LS 9/18/2019 08:42:51'!
safeWithElement: unElemento conAnterior: celdaAnterior enStack: unStack.
	
	unStack incrementarSize.
	^self new initializeSafeWith: unElemento conAnterior: celdaAnterior .! !


!classDefinition: #CeldaVacia category: #'Stack-Exercise'!
Celda subclass: #CeldaVacia
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!CeldaVacia methodsFor: 'as yet unclassified' stamp: 'cmmmmm 9/17/2019 18:14:32'!
anterior
	^ self error: 'celda vacia no tiene anterior'.! !

!CeldaVacia methodsFor: 'as yet unclassified' stamp: 'LS 9/18/2019 16:48:39'!
content 
	^ self error: OOStack stackEmptyErrorDescription.! !

!CeldaVacia methodsFor: 'as yet unclassified' stamp: 'cmmmmm 9/17/2019 18:09:43'!
isEmpty
	^ true.! !

!CeldaVacia methodsFor: 'as yet unclassified' stamp: 'LS 9/18/2019 16:45:43'!
popEnStack: unStack

	^self error: OOStack stackEmptyErrorDescription.! !

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


!classDefinition: #SentenceFinderByPrefix category: #'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'stackxxxxxxxx stackToReorder'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'asdfasf 9/19/2019 15:59:55'!
find: aPrefix
	
	| stringToCompare resCollection |

	resCollection := OrderedCollection new.
	
	stackxxxxxxxx size timesRepeat: [
	
	stringToCompare := stackxxxxxxxx pop.
	
	(stringToCompare beginsWith: aPrefix) ifTrue: [resCollection addLast: stringToCompare] .
		
	stackToReorder push: stringToCompare.].	

	^resCollection! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'asdfasf 9/19/2019 16:01:11'!
initializeWith: aStack
	stackxxxxxxxx := aStack .
	stackToReorder := OOStack new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: #'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'asdfasf 9/19/2019 15:39:52'!
with: aStack

	^self new initializeWith: aStack. ! !

CeldaVacia initialize!