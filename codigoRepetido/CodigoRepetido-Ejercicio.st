!classDefinition: #CantSuspend category: #'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: #'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: #'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'cmmmmm 9/9/2019 16:33:20'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook JohnLennon |
	
	customerBook := CustomerBook new.
	JohnLennon := 'John Lennon'.
	
	self testClosure: [customerBook addCustomerNamed: JohnLennon] withTime: (50*millisecond).
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'cmmmmm 9/9/2019 16:33:28'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	self testClosure: [customerBook addCustomerNamed: paulMcCartney] withTime: (100*millisecond).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'cmmmmm 9/9/2019 16:49:42'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.

	self failing: [customerBook addCustomerNamed: ''] 
		withErrorType: Error
		assert: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'cmmmmm 9/9/2019 16:49:34'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self failing: [customerBook removeCustomerNamed: 'Paul McCartney'.]
		withErrorType: NotFound 
		assert: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]

! !

!CustomerBookTest methodsFor: 'testing' stamp: 'cmmmmm 9/9/2019 16:50:02'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addAndSuspend: paulMcCartney.
	
	self assertNumberOfActive: 0 suspended: 1 ofCustomerBook: customerBook.
	
	self assert: (customerBook includesCustomerNamed: paulMcCartney). 
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'cmmmmm 9/9/2019 16:39:06'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addAndSuspend: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self assertNumberOfActive: 0 suspended: 0 ofCustomerBook: customerBook.
	self deny: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'cmmmmm 9/9/2019 17:04:08'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon paulMcCartney |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	paulMcCartney := 'Paul McCartney'.
	customerBook addCustomerNamed: johnLennon.
	
	self cannotSuspendCustomer: paulMcCartney in: customerBook with: johnLennon .
	

! !

!CustomerBookTest methodsFor: 'testing' stamp: 'cmmmmm 9/9/2019 16:55:54'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addAndSuspend: johnLennon.
	
	self cannotSuspendCustomer: johnLennon in: customerBook .
! !


!CustomerBookTest methodsFor: 'codigoRepetido' stamp: 'cmmmmm 9/6/2019 17:57:34'!
assertNumberOfActive: aNumberOfActives suspended: aNumberOfSuspended ofCustomerBook: aCustomerBook

	| aNumberOfTotalCustomer |
	aNumberOfTotalCustomer := aNumberOfActives + aNumberOfSuspended. 
	self assert: aNumberOfActives equals: aCustomerBook numberOfActiveCustomers.
	self assert: aNumberOfSuspended equals: aCustomerBook numberOfSuspendedCustomers.
	self assert: aNumberOfTotalCustomer equals: aCustomerBook numberOfCustomers.
! !

!CustomerBookTest methodsFor: 'codigoRepetido' stamp: 'cmmmmm 9/6/2019 17:55:21'!
assertNumberOfActive: aNumberOfActives suspended: aNumberOfSuspended totalCustomers: aNumberOfTotalCustomers ofCustomerBook: aCustomerBook

	self assert: aNumberOfActives equals: aCustomerBook numberOfActiveCustomers.
	self assert: aNumberOfSuspended equals: aCustomerBook numberOfSuspendedCustomers.
	self assert: aNumberOfTotalCustomers equals: aCustomerBook numberOfCustomers.
! !

!CustomerBookTest methodsFor: 'codigoRepetido' stamp: 'cmmmmm 9/6/2019 17:48:54'!
assertNumberOfActive: aNumberOfActives suspended: aNumberOfSuspended totalCustomers: aNumberOfTotalCustomers ofCustomerBook: aCustomerBook withCustomer: aCustomer

	self assert: aNumberOfActives equals: aCustomerBook numberOfActiveCustomers.
	self assert: aNumberOfSuspended equals: aCustomerBook numberOfSuspendedCustomers.
	self assert: aNumberOfTotalCustomers equals: aCustomerBook numberOfCustomers.
	self deny: (aCustomerBook includesCustomerNamed: aCustomer ).! !

!CustomerBookTest methodsFor: 'codigoRepetido' stamp: 'cmmmmm 9/9/2019 17:03:59'!
cannotSuspendCustomer: aCustomer in: aCustomerBook

 self cannotSuspendCustomer: aCustomer in: aCustomerBook with: aCustomer.! !

!CustomerBookTest methodsFor: 'codigoRepetido' stamp: 'cmmmmm 9/9/2019 17:03:15'!
cannotSuspendCustomer: aCustomer in: aCustomerBook with: anotherCustomer
	
	
	[aCustomerBook suspendCustomerNamed: aCustomer.
	self fail ]
		on: CantSuspend 
		do: [ :anError | 
			self assert: aCustomerBook numberOfCustomers = 1.
			self assert: (aCustomerBook includesCustomerNamed: anotherCustomer ) ]! !

!CustomerBookTest methodsFor: 'codigoRepetido' stamp: 'LS 9/2/2019 21:51:33'!
failing: aFailingBlock withErrorType: anErrorType assert: assertingBlock

	[ aFailingBlock value. self fail ]
		on: anErrorType 
		do: assertingBlock.! !

!CustomerBookTest methodsFor: 'codigoRepetido' stamp: 'cmmmmm 9/9/2019 16:32:57'!
testClosure: aClosure withTime: aTime

		| millisecondsBeforeRunning millisecondsAfterRunning |

	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	aClosure value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.

	self assert: (millisecondsAfterRunning-millisecondsBeforeRunning) < (aTime)
! !


!classDefinition: #CustomerBook category: #'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 4/3/2019 10:14:26'!
initialize

	super initialize.
	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'cmmmmm 9/9/2019 16:33:52'!
addAndSuspend: aCustomer

	self addCustomerNamed: aCustomer. 
	self suspendCustomerNamed: aCustomer.! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	((active includes: aName) or: [suspended includes: aName]) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfCustomers
	
	^active size + suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
removeCustomerNamed: aName 
 
	1 to: active size do: 
	[ :index |
		aName = (active at: index)
			ifTrue: [
				active removeAt: index.
				^ aName 
			] 
	].

	1 to: suspended size do: 	
	[ :index |
		aName = (suspended at: index)
			ifTrue: [
				suspended removeAt: index.
				^ aName 
			] 
	].
	
	^ NotFound signal.
! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: #'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 9/2/2019 14:41:10'!
customerAlreadyExistsErrorMessage

	^'Customer Already Exists.'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 9/2/2019 14:41:16'!
customerCanNotBeEmptyErrorMessage

	^'Customer Name Cannot Be Empty.'! !
