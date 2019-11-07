!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:08'!
test01NewCartsAreCreatedEmpty

	self assert: self createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [ cart add: self itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 0 of: self itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 2 of: self itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test06CartRemembersAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self assert: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := self createCart.
	
	self deny: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: 2 of: self itemSellByTheStore.
	self assert: (cart occurrencesOf: self itemSellByTheStore) = 2! !


!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:48'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
defaultCatalog
	
	^ Array with: self itemSellByTheStore! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:44'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
itemSellByTheStore
	
	^ 'validBook'! !


!classDefinition: #CashierTest category: #TusLibros!
TestCase subclass: #CashierTest
	instanceVariableNames: 'catalog cashier cart card merchantProcessorSimulator currentDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'testing' stamp: 'LS 11/7/2019 15:48:30'!
test01NewCashierWith
	
	cart := Cart acceptingItemsOf: (Dictionary with: 'validBook'->100).
		
	self should: [ cashier checkOut: cart withCard: card ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmpty.
			]
		
		 ! !

!CashierTest methodsFor: 'testing' stamp: 'LS 11/7/2019 15:49:03'!
test02CheckoutACartWith1ElementIsCorrect
	
	catalog add:'validBook'->100.
	
	cart add: 'validBook'.
	
	self assert: 100 equals: (cashier checkOut: cart withCard: card) .	

		
		 ! !

!CashierTest methodsFor: 'testing' stamp: 'LS 11/7/2019 15:49:26'!
test03CheckoutACartWithSeveralElementGivesCorrectSubtotal

	catalog add:'validBook'->100; add:'validBook2'->50.
		
	cart add: 'validBook'.
	cart add: 'validBook2'.
	
	self assert: 150 equals: (cashier checkOut: cart withCard: card) .	

		
		 ! !

!CashierTest methodsFor: 'testing' stamp: 'LS 11/6/2019 16:44:34'!
test04CannotCheckoutACartWithAnExpiredCreditCard

	| anExpiredCard anExpiredDate |
	
	anExpiredDate := GregorianMonthOfYear decemberOf: 2018.
	anExpiredCard := CreditCard withNumber: (10 raisedToInteger: 15) expirationDate: anExpiredDate owner: 'San Martin'.
	
	catalog add:'validBook'->100.
	
	cart add: 'validBook'.	

	self should: [ cashier checkOut: cart withCard: anExpiredCard ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardExpired .
			]
		
		 ! !


!CashierTest methodsFor: 'setUp/tearDown' stamp: 'LS 11/7/2019 15:51:40'!
setUp

	| aValidExpirationDate aSalesBook |

	aValidExpirationDate := GregorianMonthOfYear decemberOf: 2020.
	aSalesBook := OrderedCollection new.

	currentDate := GregorianMonthOfYear decemberOf: 2019.	
	merchantProcessorSimulator := MerchantProcessorSimulator onDate: currentDate.
	catalog := Dictionary new.
	cashier := Cashier with: aSalesBook onDate: currentDate withMerchantProcessor: merchantProcessorSimulator.
	cart := Cart acceptingItemsOf: catalog.
	card := CreditCard withNumber: (10 raisedToInteger: 15) expirationDate: aValidExpirationDate owner: 'San Martin'.
		
		 ! !


!classDefinition: #CreditCardTest category: #TusLibros!
TestCase subclass: #CreditCardTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'cmmmmm 11/4/2019 19:51:19'!
test01CannotCreateCardWithInvalidNumber
	| aPerson anExpirationDate anId |
	
	aPerson := 'San Martin'.
	anExpirationDate := GregorianMonthOfYear current.
	anId := 0.
	
self should: [  CreditCard withNumber: anId expirationDate: anExpirationDate owner: aPerson ]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError |
		self assert: anError messageText = CreditCard invalidNumber.
			]! !

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'cmmmmm 11/4/2019 20:09:18'!
test02CannotCreateCardWithInvalidGreaterNumber
	| aPerson anExpirationDate anId |
	
	aPerson := 'San Martin'.
	anExpirationDate := GregorianMonthOfYear current.
	anId := 10 raisedToInteger: 16.
	
self should: [  CreditCard withNumber: anId expirationDate: anExpirationDate owner: aPerson ]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError |
		self assert: anError messageText = CreditCard invalidNumber.
			]! !

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'cmmmmm 11/4/2019 20:10:32'!
test03CannotCreateCardWithemptyOwner
	| aPerson anExpirationDate anId |
	
	aPerson := ''.
	anExpirationDate := GregorianMonthOfYear current.
	anId := 10 raisedToInteger: 15.
	
self should: [  CreditCard withNumber: anId expirationDate: anExpirationDate owner: aPerson ]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError |
		self assert: anError messageText = CreditCard invalidOwner.
			]! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'cmmmmm 11/4/2019 19:24:33'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !

!Cart methodsFor: 'queries' stamp: 'cmmmmm 11/4/2019 19:13:41'!
subtotal
	| sum |

	sum _ 0.
	catalog do: [:anItem | sum _ sum + anItem ]. 
	^sum.! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: 'salesBook gregorianMonthOfYear currentDate merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'initialization' stamp: 'LS 11/7/2019 15:41:07'!
initializeWith: aSalesBook onDate: aGregorianMonthOfYear withMerchantProcessor: aMerchantProcessor
	
	salesBook := aSalesBook.
	currentDate := aGregorianMonthOfYear.
	merchantProcessor := aMerchantProcessor.! !


!Cashier methodsFor: 'as yet unclassified' stamp: 'LS 10/31/2019 21:30:50'!
cartCanNotBeEmpty
	self shouldBeImplemented.! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'LS 11/7/2019 15:55:43'!
checkOut: aCart withCard: aCreditCard
	
	aCart isEmpty ifTrue: [self error: Cashier cartCanNotBeEmpty.].
	merchantProcessor post: aCreditCard withAmount: aCart subtotal.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'instance creation' stamp: 'LS 10/31/2019 21:29:23'!
cartCanNotBeEmpty
	^'cart can not be empty'! !

!Cashier class methodsFor: 'instance creation' stamp: 'LS 11/7/2019 15:43:18'!
with: aSalesBook onDate: aGregorianMonthOfYear withMerchantProcessor: aMerchantProcessor

	^self new initializeWith: aSalesBook onDate: aGregorianMonthOfYear withMerchantProcessor: aMerchantProcessor.! !


!Cashier class methodsFor: 'as yet unclassified' stamp: 'cmmmmm 11/4/2019 20:34:06'!
creditCardExpired
	^'credit card expired'! !


!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'id expirationDate person'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'initialization' stamp: 'cmmmmm 11/4/2019 20:14:54'!
initializeWithNumber: anId expirationDate: anExpirationDate owner: aPerson 
	
	id := anId.
	expirationDate := anExpirationDate.
	person := aPerson.
	self isValid.! !

!CreditCard methodsFor: 'initialization' stamp: 'cmmmmm 11/4/2019 20:14:34'!
isValid

	(id between: (10 raisedToInteger: 15) and: ((10 raisedToInteger: 16) -1)) ifFalse: [self error: CreditCard invalidNumber].
	person isEmpty ifTrue: [self error: CreditCard invalidOwner].
	^true.! !


!CreditCard methodsFor: 'as yet unclassified' stamp: 'cmmmmm 11/4/2019 20:33:41'!
date
	^expirationDate ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'cmmmmm 11/4/2019 19:53:38'!
withNumber: anId expirationDate: anExpirationDate owner: aPerson 
	
	^self new initializeWithNumber: anId expirationDate: anExpirationDate owner: aPerson ! !


!CreditCard class methodsFor: 'Error Handling' stamp: 'cmmmmm 11/4/2019 19:56:26'!
invalidNumber
	^'Invalid card Number'.! !


!CreditCard class methodsFor: 'as yet unclassified' stamp: 'cmmmmm 11/4/2019 20:12:01'!
invalidOwner
	^'InvalidOwner'.! !


!classDefinition: #MerchantProcessorSimulator category: #TusLibros!
Object subclass: #MerchantProcessorSimulator
	instanceVariableNames: 'creditCard currentDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorSimulator methodsFor: 'initialization' stamp: 'LS 11/7/2019 15:53:16'!
initializeOnDate: aGregorianMonthOfYear 
	currentDate := aGregorianMonthOfYear.! !


!MerchantProcessorSimulator methodsFor: 'as yet unclassified' stamp: 'LS 11/7/2019 15:59:01'!
post: aCreditCard withAmount: anAmount

	aCreditCard date < currentDate ifTrue: [self error: MerchantProcessorSimulator creditCardExpired.].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessorSimulator class' category: #TusLibros!
MerchantProcessorSimulator class
	instanceVariableNames: ''!

!MerchantProcessorSimulator class methodsFor: 'initialization' stamp: 'LS 11/7/2019 15:52:36'!
onDate: aGregorianMonthOfYear 
	self new initializeOnDate: aGregorianMonthOfYear.! !
