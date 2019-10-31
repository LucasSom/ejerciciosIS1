!classDefinition: #CartTest category: #'Tus-Libros' stamp: 'cmmmmm 10/31/2019 17:16:00'!
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

!CartTest methodsFor: 'as yet unclassified' stamp: 'cmmmmm 10/31/2019 17:01:21'!
test03ListarNuevoCarritoEsListaVacia

	| aCart aClient aPassword aList |
	
	aPassword := 'passwordExample'.
	aClient := Client with: aPassword.
	aCart := Cart withClient: aClient andPassword: aPassword.
	
	aList := aCart listCart.
	
	self assert: '0' equals: aList.! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'cmmmmm 10/31/2019 17:00:34'!
test04ListarCarritoConUnLibroContieneEseLibro

	| aCart aClient aPassword aBook aQuantity anISBNNumber aList theWantedList |
	aPassword := 'passwordExample'.
	aClient := Client with: aPassword.
	aCart := Cart withClient: aClient andPassword: aPassword.
	
	anISBNNumber := 9780805511963.
	aBook := Book with: anISBNNumber.
	aQuantity := 1.
	aCart addToCart: aBook quantity: aQuantity.
	
	aList := aCart listCart.
	theWantedList := '0','|', anISBNNumber asString , '|', aQuantity asString.
	
	self assert: theWantedList equals: aList.! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'cmmmmm 10/31/2019 17:01:45'!
test05ListarCarritoCon2LibrosMuestraLos2Libros

	| aCart aClient aPassword aBook aBook2 aQuantity anISBNNumber anISBNNumber2 aList theWantedList |
	aPassword := 'passwordExample'.
	aClient := Client with: aPassword.
	aCart := Cart withClient: aClient andPassword: aPassword.
	
	anISBNNumber := 9780805511963.
	aBook := Book with: anISBNNumber.
	aQuantity := 1.
	aCart addToCart: aBook quantity: aQuantity.
	
	anISBNNumber2 := 9780805511969.
	aBook2 := Book with: anISBNNumber2.
	aQuantity := 1.
	aCart addToCart: aBook2 quantity: aQuantity.
	
	
	aList := aCart listCart.
	theWantedList := '0','|',anISBNNumber asString , '|', aQuantity asString, '|', anISBNNumber2 asString , '|', aQuantity asString.
	
	self assert: theWantedList equals: aList.! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'cmmmmm 10/31/2019 17:03:24'!
test06ListarCarritoCon2LibrosIgualesMuestra1LibroConCantidad2

	| aCart aClient aPassword aBook aQuantity anISBNNumber aList theWantedList |
	aPassword := 'passwordExample'.
	aClient := Client with: aPassword.
	aCart := Cart withClient: aClient andPassword: aPassword.
	
	anISBNNumber := 9780805511963.
	aBook := Book with: anISBNNumber.
	aQuantity := 2.
	aCart addToCart: aBook quantity: aQuantity.
	
	aList := aCart listCart.
	theWantedList := '0','|',anISBNNumber asString , '|', aQuantity asString.
	
	self assert: theWantedList equals: aList.! !


!classDefinition: #Book category: #'Tus-Libros' stamp: 'cmmmmm 10/31/2019 17:16:00'!
Object subclass: #Book
	instanceVariableNames: 'isbn'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Tus-Libros'!

!Book methodsFor: 'initialization' stamp: 'LS 10/30/2019 16:31:08'!
initializeWith: anISBNNumber 
	
	isbn := anISBNNumber.! !


!Book methodsFor: 'accessing' stamp: 'LS 10/29/2019 21:27:27'!
isbn
	
	^isbn! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Book class' category: #'Tus-Libros' stamp: 'cmmmmm 10/31/2019 17:16:00'!
Book class
	instanceVariableNames: ''!

!Book class methodsFor: 'instance creation' stamp: 'LS 10/29/2019 21:26:44'!
with: anISBNNumber
	
	^self new initializeWith: anISBNNumber ! !


!classDefinition: #Cart category: #'Tus-Libros' stamp: 'cmmmmm 10/31/2019 17:16:00'!
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

!Cart methodsFor: 'accessing' stamp: 'cmmmmm 10/31/2019 17:15:44'!
listCart
	
	| aList |
	
	aList := '0'.
	
	books do: [:aBook | ((books occurrencesOf: aBook) > 1) ifTrue: [^aList := aList, '|', aBook isbn asString, '|', '2' ] ifFalse: [aList := aList, '|', aBook isbn asString, '|', '1'] ].
	
	^aList ! !


!Cart methodsFor: 'as yet unclassified' stamp: 'cmmmmm 10/31/2019 17:04:19'!
addToCart: aBook quantity: aQuantity 
	
	aQuantity timesRepeat: [books add: aBook ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #'Tus-Libros' stamp: 'cmmmmm 10/31/2019 17:16:00'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'LS 10/29/2019 21:12:32'!
withClient: aClient andPassword: aPassword

	
	^self new initializeWithClient: aClient andPassword: aPassword ! !


!classDefinition: #Client category: #'Tus-Libros' stamp: 'cmmmmm 10/31/2019 17:16:00'!
Object subclass: #Client
	instanceVariableNames: 'password'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Tus-Libros'!

!Client methodsFor: 'initialization' stamp: 'LS 10/29/2019 21:11:49'!
initializeWith: aPassword 
	
	password := aPassword.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Client class' category: #'Tus-Libros' stamp: 'cmmmmm 10/31/2019 17:16:00'!
Client class
	instanceVariableNames: ''!

!Client class methodsFor: 'class initialization' stamp: 'LS 10/29/2019 21:11:02'!
with: aPassword
	^self new initializeWith: aPassword ! !
