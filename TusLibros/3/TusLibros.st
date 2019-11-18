!classDefinition: #APIRestTest category: #TusLibros stamp: 'cmmmmm 11/18/2019 12:38:39'!
TestCase subclass: #APIRestTest
	instanceVariableNames: 'theTestObjectsFactory validClientID validPassword userDatabase validCreditCard isbn apiRest cartId invalidClientID invalidPassword debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!APIRestTest methodsFor: 'as yet unclassified' stamp: 'cmmmmm 11/14/2019 17:44:16'!
setUp

	theTestObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ].
	
	validClientID := theTestObjectsFactory validClientID.
	validPassword := theTestObjectsFactory validPassword.
	invalidPassword := theTestObjectsFactory inValidPassword.
	invalidClientID := theTestObjectsFactory invalidClientID .

	userDatabase := theTestObjectsFactory userDatabase.
	validCreditCard := theTestObjectsFactory notExpiredCreditCard.
	isbn := theTestObjectsFactory itemSellByTheStore.
	
	apiRest := APIRest with: userDatabase.
	cartId := apiRest createCart: validClientID withPassword: validPassword.
			
	! !

!APIRestTest methodsFor: 'as yet unclassified' stamp: 'cmmmmm 11/14/2019 17:29:54'!
test01LoginWithInvalidClientID
	
	self 
		should: [ apiRest createCart: invalidClientID withPassword: validPassword. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = APIRest invalidClientError.
			]

	
	! !

!APIRestTest methodsFor: 'as yet unclassified' stamp: 'cmmmmm 11/14/2019 17:31:38'!
test02LoginWithValidIDInvalidPassword
	
	self 
		should: [ apiRest createCart: validClientID withPassword: invalidPassword. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = APIRest invalidPasswordError.
			]

	
	! !

!APIRestTest methodsFor: 'as yet unclassified' stamp: 'cmmmmm 11/14/2019 17:34:09'!
test03ListOfNewCartOnValidLoginIsEmpty

	self assert: (apiRest listCart: cartId) isEmpty.! !

!APIRestTest methodsFor: 'as yet unclassified' stamp: 'cmmmmm 11/14/2019 17:35:10'!
test04AddABookToAnEmptyNewCartAndListItShouldShowTheBook

	
	apiRest := APIRest with: userDatabase.
	cartId := apiRest createCart: validClientID withPassword: validPassword.
	
	apiRest addToCart: cartId book: isbn quantity: 1.
	
	self assert: (apiRest listCart: cartId) includes: theTestObjectsFactory itemSellByTheStore.! !

!APIRestTest methodsFor: 'as yet unclassified' stamp: 'cmmmmm 11/14/2019 17:35:46'!
test05checkOutOfNewCartRaiseErrorAndListPurchasesIsEmpty
	
	self 
		should: [ apiRest checkOutCart: cartId creditCardNumber: validCreditCard number creditCardDateOfExpiration: validCreditCard expirationDate owner: validCreditCard owner. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			].
	self assert: (apiRest listPurchases: validClientID password: validPassword) isEmpty.! !

!APIRestTest methodsFor: 'as yet unclassified' stamp: 'cmmmmm 11/14/2019 17:36:59'!
test06checkOutOfACartWithABookIsInListPurchases

	apiRest addToCart: cartId book: isbn quantity: 1.
			
			
	apiRest checkOutCart: cartId creditCardNumber: validCreditCard number creditCardDateOfExpiration: validCreditCard expirationDate owner: validCreditCard owner.
		
	self assert: (apiRest listPurchases: validClientID password: validPassword) includes: isbn.! !


!APIRestTest methodsFor: 'merchant processor' stamp: 'cmmmmm 11/14/2019 17:45:13'!
debit: anAmount from: aCreditCard 

	"^debitBehavior value: anAmount value: aCreditCard "! !


!classDefinition: #CartTest category: #TusLibros stamp: 'cmmmmm 11/18/2019 12:38:39'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: #TusLibros stamp: 'cmmmmm 11/18/2019 12:38:39'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:50'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				throught: self
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:04'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:00'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:59'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #CreditCardTest category: #TusLibros stamp: 'cmmmmm 11/18/2019 12:38:39'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'cmmmmm 11/11/2019 18:46:36'!
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

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'cmmmmm 11/11/2019 18:46:44'!
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

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'cmmmmm 11/11/2019 18:46:51'!
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


!classDefinition: #APIRest category: #TusLibros stamp: 'cmmmmm 11/18/2019 12:38:39'!
Object subclass: #APIRest
	instanceVariableNames: 'listOfClients userDatabase cartDatabase'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!APIRest methodsFor: 'cart management' stamp: 'cmmmmm 11/11/2019 17:50:19'!
addToCart: aCartId book: anIsbnNumber quantity: aQuantity
	(cartDatabase at: aCartId) add: aQuantity of: anIsbnNumber! !

!APIRest methodsFor: 'cart management' stamp: 'cmmmmm 11/7/2019 21:14:16'!
createCart: aClientID withPassword: aClientPassword 

	| aNewCart newCartID |

	(userDatabase includesKey: aClientID) ifFalse: [self error: APIRest invalidClientError.].
	(userDatabase at: aClientID) = aClientPassword ifFalse: [self error: APIRest invalidPasswordError].
	
	aNewCart := StoreTestObjectsFactory new createCart.
	newCartID := cartDatabase size.
	cartDatabase add: newCartID->aNewCart.
	
	^newCartID.! !

!APIRest methodsFor: 'cart management' stamp: 'cmmmmm 11/7/2019 19:53:37'!
listCart
	^OrderedCollection new.! !

!APIRest methodsFor: 'cart management' stamp: 'cmmmmm 11/11/2019 17:53:12'!
listCart: aCartID 
	^(cartDatabase at: aCartID) listCart.! !


!APIRest methodsFor: 'initialization' stamp: 'cmmmmm 11/7/2019 21:10:07'!
initializeWith: aUserDatabase 
	
	userDatabase := aUserDatabase.
	cartDatabase := Dictionary new! !


!APIRest methodsFor: 'as yet unclassified' stamp: 'cmmmmm 11/18/2019 11:47:44'!
checkOutCart: aCartID creditCardNumber: aCreditCardNumber creditCardDateOfExpiration: aCreditCardExpiringDate owner: aValidOwner
	
	| testObjectsFactory cashier |
	testObjectsFactory := StoreTestObjectsFactory new.
	
	cashier := Cashier 
		toCheckout: (cartDatabase at: aCartID)
		charging: testObjectsFactory notExpiredCreditCard
		throught: APIRestTest new
		on: testObjectsFactory today
		registeringOn: testObjectsFactory salesBook.
	cashier checkOut.
	! !


!APIRest methodsFor: 'accessing' stamp: 'cmmmmm 11/11/2019 19:16:54'!
listPurchases: aClientID password: aPassword
	^OrderedCollection new.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'APIRest class' category: #TusLibros stamp: 'cmmmmm 11/18/2019 12:38:39'!
APIRest class
	instanceVariableNames: ''!

!APIRest class methodsFor: 'as yet unclassified' stamp: 'cmmmmm 11/11/2019 18:38:23'!
errorCheckOutEmptyCart
	^'Cannot Checkout empty cart'! !

!APIRest class methodsFor: 'as yet unclassified' stamp: 'cmmmmm 11/7/2019 20:08:52'!
invalidClientError
	^'Invalid clienti ID'.! !

!APIRest class methodsFor: 'as yet unclassified' stamp: 'cmmmmm 11/7/2019 20:34:41'!
invalidPasswordError
	^'invalid password'! !


!APIRest class methodsFor: 'instance creation' stamp: 'cmmmmm 11/7/2019 20:18:05'!
with: aUserDatabase
	
	^self new initializeWith: aUserDatabase ! !


!classDefinition: #Cart category: #TusLibros stamp: 'cmmmmm 11/18/2019 12:38:39'!
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


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:06'!
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


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 19:09'!
total

	^ items sum: [ :anItem | catalog at: anItem ]! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !


!Cart methodsFor: 'accessing' stamp: 'cmmmmm 11/11/2019 18:01:18'!
listCart
	^items copy.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros stamp: 'cmmmmm 11/18/2019 12:38:39'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: #TusLibros stamp: 'cmmmmm 11/18/2019 12:38:39'!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:07'!
createSale

	^ Sale of: total
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !


!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 6/17/2013 19:06'!
checkOut

	self calculateTotal.
	self debitTotal.
	self registerSale.

	^ total! !


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:53'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros stamp: 'cmmmmm 11/18/2019 12:38:39'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:51'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #CreditCard category: #TusLibros stamp: 'cmmmmm 11/18/2019 12:38:39'!
Object subclass: #CreditCard
	instanceVariableNames: 'expirationDate id owner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'cmmmmm 11/11/2019 19:11:35'!
isExpiredOn: aDate 
	
	^expirationDate start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !

!CreditCard methodsFor: 'testing' stamp: 'cmmmmm 11/11/2019 19:12:23'!
isValid

	(id between: (10 raisedToInteger: 15) and: ((10 raisedToInteger: 16) -1)) ifFalse: [self error: CreditCard invalidNumber].
	owner isEmpty ifTrue: [self error: CreditCard invalidOwner].
	^true.! !


!CreditCard methodsFor: 'initialization' stamp: 'cmmmmm 11/11/2019 19:11:35'!
initializeExpiringOn: aMonth 
	
	expirationDate := aMonth ! !

!CreditCard methodsFor: 'initialization' stamp: 'cmmmmm 11/11/2019 19:12:10'!
initializeWithNumber: anId expirationDate: anExpirationDate owner: aPerson 
	
	id := anId.
	expirationDate := anExpirationDate.
	owner := aPerson.
	self isValid.! !


!CreditCard methodsFor: 'as yet unclassified' stamp: 'cmmmmm 11/11/2019 19:11:35'!
expirationDate
	^expirationDate! !


!CreditCard methodsFor: 'accessing' stamp: 'cmmmmm 11/11/2019 19:09:59'!
number
	^id! !

!CreditCard methodsFor: 'accessing' stamp: 'cmmmmm 11/11/2019 19:12:48'!
owner
	^owner.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros stamp: 'cmmmmm 11/18/2019 12:38:39'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth 
	
	^self new initializeExpiringOn: aMonth! !


!CreditCard class methodsFor: 'as yet unclassified' stamp: 'cmmmmm 11/11/2019 18:47:57'!
invalidNumber
	^'Invalid card Number'.! !

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'cmmmmm 11/11/2019 18:48:05'!
invalidOwner
	^'InvalidOwner'.! !

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'cmmmmm 11/11/2019 18:47:50'!
withNumber: anId expirationDate: anExpirationDate owner: aPerson 
	
	^self new initializeWithNumber: anId expirationDate: anExpirationDate owner: aPerson ! !


!classDefinition: #Sale category: #TusLibros stamp: 'cmmmmm 11/18/2019 12:38:39'!
Object subclass: #Sale
	instanceVariableNames: 'total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:47'!
initializeTotal: aTotal

	total := aTotal ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: #TusLibros stamp: 'cmmmmm 11/18/2019 12:38:39'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:47'!
of: aTotal

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal ! !


!classDefinition: #StoreTestObjectsFactory category: #TusLibros stamp: 'cmmmmm 11/18/2019 12:38:39'!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'cmmmmm 11/18/2019 11:46:44'!
salesBook

	^OrderedCollection new! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'cmmmmm 11/11/2019 18:55:24'!
expiredCreditCard
	
	^CreditCard withNumber: self validCardNumber expirationDate: (Month month: today monthIndex year: today yearNumber - 1) owner: self validOwner.! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'cmmmmm 11/11/2019 18:55:53'!
notExpiredCreditCard
	
	^CreditCard withNumber: self validCardNumber expirationDate: (Month month: today monthIndex year: today yearNumber + 1) owner: self validOwner.! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'cmmmmm 11/11/2019 18:57:48'!
validCardNumber
	^1234123412341234! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'cmmmmm 11/11/2019 18:56:55'!
validOwner
	^'Valid Owner Perez'! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !


!StoreTestObjectsFactory methodsFor: 'login' stamp: 'cmmmmm 11/7/2019 20:33:34'!
inValidPassword
	^'invalidPassword'! !

!StoreTestObjectsFactory methodsFor: 'login' stamp: 'cmmmmm 11/7/2019 20:00:59'!
invalidClientID
	^'invalidClientID'! !

!StoreTestObjectsFactory methodsFor: 'login' stamp: 'cmmmmm 11/7/2019 20:51:05'!
userDatabase
	
	| aDatabase |
	
	aDatabase := Dictionary new.
	aDatabase add: ((self validClientID)->(self validPassword)).
	^aDatabase.! !

!StoreTestObjectsFactory methodsFor: 'login' stamp: 'cmmmmm 11/7/2019 19:50:03'!
validClientID
	^'validClientID'! !

!StoreTestObjectsFactory methodsFor: 'login' stamp: 'cmmmmm 11/7/2019 19:51:50'!
validPassword
	^'aValidPassword'! !
