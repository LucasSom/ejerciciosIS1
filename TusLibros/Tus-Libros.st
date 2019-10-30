!classDefinition: #CartTest category: #'Tus-Libros' stamp: 'LS 10/29/2019 22:01:32'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Tus-Libros'!

!CartTest methodsFor: 'as yet unclassified' stamp: 'LS 10/29/2019 21:09:29'!
test01NuevoCarritoEsVacio

	| aCart aClient aPassword |
	aPassword := 'passwordExample'.
	aClient := Client with: aPassword.
	aCart := Cart withClient: aClient andPassword: aPassword.
	
	self assert: aCart isEmpty.! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'LS 10/29/2019 21:25:30'!
test02CarritoConUnLibroNoEstaVacio

	| aCart aClient aPassword aBook aQuantity anISBNNumber |
	aPassword := 'passwordExample'.
	aClient := Client with: aPassword.
	aCart := Cart withClient: aClient andPassword: aPassword.
	
	anISBNNumber := 9780805511963.
	aBook := Book with: anISBNNumber.
	aQuantity := 1.
	
	aCart addToCart: aBook isbn quantity: aQuantity.
	
	self deny: aCart isEmpty.! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'LS 10/29/2019 21:45:52'!
test03ListarNuevoCarritoEsListaVacia

	| aCart aClient aPassword aList |
	
	aPassword := 'passwordExample'.
	aClient := Client with: aPassword.
	aCart := Cart withClient: aClient andPassword: aPassword.
	
	aList := aCart listCart.
	
	self assert: aList isEmpty.! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'LS 10/29/2019 21:50:35'!
test04ListarCarritoConUnLibroContieneEseLibro

	| aCart aClient aPassword aBook aQuantity anISBNNumber aList theWantedList |
	aPassword := 'passwordExample'.
	aClient := Client with: aPassword.
	aCart := Cart withClient: aClient andPassword: aPassword.
	
	anISBNNumber := 9780805511963.
	aBook := Book with: anISBNNumber.
	aQuantity := 1.
	aCart addToCart: aBook isbn quantity: aQuantity.
	
	aList := aCart listCart.
	theWantedList := anISBNNumber asString , '|', aQuantity asString.
	
	self assert: theWantedList equals: aList.! !


!classDefinition: #Book category: #'Tus-Libros' stamp: 'LS 10/29/2019 22:01:32'!
Object subclass: #Book
	instanceVariableNames: 'isbn iSBNNumber'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Tus-Libros'!

!Book methodsFor: 'initialization' stamp: 'LS 10/29/2019 21:27:13'!
initializeWith: anISBNNumber 
	
	iSBNNumber := anISBNNumber.! !


!Book methodsFor: 'accessing' stamp: 'LS 10/29/2019 21:27:27'!
isbn
	
	^isbn! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Book class' category: #'Tus-Libros' stamp: 'LS 10/29/2019 22:01:32'!
Book class
	instanceVariableNames: ''!

!Book class methodsFor: 'instance creation' stamp: 'LS 10/29/2019 21:26:44'!
with: anISBNNumber
	
	^self new initializeWith: anISBNNumber ! !


!classDefinition: #Cart category: #'Tus-Libros' stamp: 'LS 10/29/2019 22:01:32'!
Object subclass: #Cart
	instanceVariableNames: 'client password books'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Tus-Libros'!

!Cart methodsFor: 'initialization' stamp: 'LS 10/29/2019 21:32:34'!
initializeWithClient: aClient andPassword: aPassword 
	
	client := aClient.
	password := aPassword.
	books := OrderedCollection new.! !


!Cart methodsFor: 'accessing' stamp: 'LS 10/29/2019 21:33:50'!
isEmpty
	^books isEmpty.! !

!Cart methodsFor: 'accessing' stamp: 'LS 10/29/2019 21:54:40'!
listCart
	
	| aList |
	
	aList := ''.
	books do: [:aBook | aList, aBook isbn asString, '|', 1 ].
	^aList ! !


!Cart methodsFor: 'as yet unclassified' stamp: 'LS 10/29/2019 21:28:43'!
addToCart: aBook quantity: aQuantity 
	books add: aBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #'Tus-Libros' stamp: 'LS 10/29/2019 22:01:32'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'LS 10/29/2019 21:12:32'!
withClient: aClient andPassword: aPassword

	
	^self new initializeWithClient: aClient andPassword: aPassword ! !


!classDefinition: #Client category: #'Tus-Libros' stamp: 'LS 10/29/2019 22:01:32'!
Object subclass: #Client
	instanceVariableNames: 'password'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Tus-Libros'!

!Client methodsFor: 'initialization' stamp: 'LS 10/29/2019 21:11:49'!
initializeWith: aPassword 
	
	password := aPassword.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Client class' category: #'Tus-Libros' stamp: 'LS 10/29/2019 22:01:32'!
Client class
	instanceVariableNames: ''!

!Client class methodsFor: 'class initialization' stamp: 'LS 10/29/2019 21:11:02'!
with: aPassword
	^self new initializeWith: aPassword ! !
