!classDefinition: #PortfolioTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'LS 10/17/2019 20:13:56'!
test01PortfolioHaveZeroAsBalanceWhenCreated 

	| portfolio |
	
	portfolio := Portfolio new.

	self assert: 0 equals: portfolio balance.
	self assert: portfolio transactions isEmpty.
! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'LS 10/17/2019 20:43:28'!
test02PortfolioHaveSameBalanceThanAccountWhenAddAccount

	| portfolio account |
	
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	portfolio addAccount: account.

	self assert: account balance equals: portfolio balance.
	self assert: account transactions = portfolio transactions.
! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'LS 10/17/2019 20:44:37'!
test03PortfolioHaveSameBalanceThanAccountWithATransactionWhenAdded

	| portfolio account deposit |
	
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	deposit := Deposit  register: 100 on: account .
	
	portfolio addAccount: account.
	
	self assert: account balance equals: portfolio balance.
	self assert: account transactions = portfolio transactions.
! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'LS 10/17/2019 20:54:59'!
test04PortfolioHaveSameBalanceThan2AccountsWithATransactionWhenAdded

	| portfolio account account2 deposit withdraw |
	
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	deposit := Deposit  register: 100 on: account .
	
	account2 := ReceptiveAccount new.
	withdraw := Withdraw  register: 40 on: account2 .
	
	portfolio addAccount: account.
	portfolio addAccount: account2.	

	self assert: 60 equals: portfolio balance.
	self assertTransactionsOf: portfolio includes: account.
	self assertTransactionsOf: portfolio includes: account2.
! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'cmmmm 10/17/2019 19:19:16'!
test05CantAddARepeatedAccountToPortfolio

	| portfolio account |
	
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	
	portfolio addAccount: account.	

	self should: [ portfolio addAccount: account ]
		raise: Error - MessageNotUnderstood 
		withMessageText: Portfolio accountAlreadyExists.
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'cmmmm 10/17/2019 19:38:55'!
test06CanAddAPortfolioToAnotherPortfolio

	| portfolio portfolioToAdd |
	
	portfolio := Portfolio new.
	portfolioToAdd := Portfolio new.
	
	portfolio addPortfolio: portfolioToAdd.
	
	self assert: 0 equals: portfolio balance.

		! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'cmmmm 10/17/2019 19:44:56'!
test07BalanceOfAPortfolioWithAccountAddedToAnotherPortfolioIsCorrect

	| portfolio portfolioToAdd account deposit |
	
	portfolio := Portfolio new.
	portfolioToAdd := Portfolio new.
		
	account := ReceptiveAccount new.
	deposit := Deposit  register: 100 on: account .
	
	portfolioToAdd addAccount: account.
	portfolio addPortfolio: portfolioToAdd.
		
	self assert: 100 equals: portfolio balance.

		! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'cmmmm 10/17/2019 19:53:54'!
test08CantAddARepeatedPortfolioToPortfolio

	| portfolio portfolioToAdd |
	
	portfolio := Portfolio new.
	portfolioToAdd := Portfolio new.
	
	portfolio addPortfolio: portfolioToAdd .	

	self should: [ portfolio addPortfolio: portfolioToAdd . ]
		raise: Error - MessageNotUnderstood 
		withMessageText: Portfolio portfolioAlreadyExists.
	! !


!PortfolioTest methodsFor: 'assertions' stamp: 'LS 10/17/2019 20:54:30'!
assertTransactionsOf: aPortfolio includes: aReceptiveAccount
	
	aReceptiveAccount transactions do: [:transaction | (aPortfolio transactions includes: transaction) ifFalse: [^false]].
	^true.! !


!classDefinition: #ReceptiveAccountTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:54'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:21:24'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #AccountTransaction category: #'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'cmmmm 10/17/2019 19:28:36'!
updateBalance: aBalance

	^self subclassResponsibility ! !

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'cmmmm 10/17/2019 19:27:56'!
updateBalance: aBalance

	^ aBalance + value! !

!Deposit methodsFor: 'value' stamp: 'cmmmm 10/17/2019 18:42:54'!
valorParaBalance

	^ value! !

!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'cmmmm 10/17/2019 19:28:10'!
updateBalance: aBalance

	^ aBalance - value! !

!Withdraw methodsFor: 'value' stamp: 'cmmmm 10/17/2019 18:42:47'!
valorParaBalance
	^ value negated ! !

!Withdraw methodsFor: 'value' stamp: 'cmmmm 10/17/2019 18:41:16'!
value

	^ value ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Portfolio category: #'Portfolio-Ejercicio'!
Object subclass: #Portfolio
	instanceVariableNames: 'accounts portfolios'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'as yet unclassified' stamp: 'cmmmm 10/17/2019 19:18:37'!
addAccount: aReceptiveAccount 

	(accounts includes: aReceptiveAccount) ifFalse: [accounts add: aReceptiveAccount] ifTrue: [ self error: Portfolio accountAlreadyExists ]
	
	! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'cmmmm 10/17/2019 19:57:56'!
addPortfolio: aPortfolio 
	
	(portfolios includes: aPortfolio ) ifFalse: [portfolios add: aPortfolio ] ifTrue: [ self error: Portfolio portfolioAlreadyExists ]
	! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'cmmmm 10/17/2019 19:50:36'!
balance
	| suma |
	suma _ accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ].
	^suma := suma + (portfolios sum: [ :anPortfolio | anPortfolio balance ] ifEmpty: [ 0 ] ).! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'cmmmm 10/17/2019 19:41:54'!
initialize

	accounts := Set new.

	portfolios := Set new.	! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'LS 10/17/2019 20:40:59'!
transactions

	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [:anAccount | anAccount transactions do: [:aTransaction | transactions add: aTransaction] ].
	^transactions.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error handling' stamp: 'cmmmm 10/17/2019 19:15:20'!
accountAlreadyExists
	^'account Already Exists'! !

!Portfolio class methodsFor: 'error handling' stamp: 'cmmmm 10/17/2019 19:55:10'!
portfolioAlreadyExists
	^'portfolio alredy exists'! !


!classDefinition: #ReceptiveAccount category: #'Portfolio-Ejercicio'!
Object subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'cmmmm 10/17/2019 18:42:23'!
balance

	^transactions sum: [ :aTransaction | aTransaction valorParaBalance ] ifEmpty: [ 0 ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !
