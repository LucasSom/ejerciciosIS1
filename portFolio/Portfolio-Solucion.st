!classDefinition: #PortfolioTest category: #'Portfolio-Solucion'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'LS 10/18/2019 17:01:33'!
test01PortfolioHaveZeroAsBalanceAndHasntTransactionsWhenCreated 

	| portfolio |
	
	portfolio := Portfolio new.

	self assert: 0 equals: portfolio balance.
	self assert: portfolio transactions isEmpty.
! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'LS 10/18/2019 17:01:52'!
test02PortfolioHaveSameBalanceAndTransactionsThanAccountWhenAddAccount

	| portfolio account |
	
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	portfolio addAccount: account.

	self assert: account balance equals: portfolio balance.
	self assert: account transactions = portfolio transactions.
! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'LS 10/18/2019 17:02:40'!
test03PortfolioHaveSameBalanceAndTransactionsThanAccountWithATransactionWhenAdded

	| portfolio account deposit |
	
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	deposit := Deposit  register: 100 on: account .
	
	portfolio addAccount: account.
	
	self assert: account balance equals: portfolio balance.
	self assert: account transactions = portfolio transactions.
! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'LS 10/19/2019 13:02:34'!
test04PortfolioHaveSameBalanceAndTransactionsThan2AccountsWithATransactionWhenAdded

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

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'LS 10/18/2019 16:58:19'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	|portfolio account deposit withdraw |
	
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
	
	portfolio addAccount: account.
		
	self assert: (portfolio hasRegistered: deposit).
	self assert: (portfolio hasRegistered: withdraw).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'LS 10/19/2019 13:09:31'!
test06CantAddARepeatedAccountToPortfolio

	| portfolio account |
	
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	
	portfolio addAccount: account.	

	self should: [ portfolio addAccount: account ]
		raise: Error - MessageNotUnderstood 
		withMessageText: Portfolio accountAlreadyExists.
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'LS 10/19/2019 13:10:33'!
test07CanAddAPortfolioToAnotherPortfolio

	| portfolio portfolioToAdd |
	
	portfolio := Portfolio new.
	portfolioToAdd := Portfolio new.
	
	portfolio addPortfolio: portfolioToAdd.
	
	self assert: 0 equals: portfolio balance.
	self assert: portfolio transactions isEmpty.

		! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'LS 10/19/2019 13:15:11'!
test08BalanceOfAPortfolioWithAccountAddedToAnotherPortfolioIsCorrectAndIsRegistered

	| portfolio portfolioToAdd account deposit |
	
	portfolio := Portfolio new.
	portfolioToAdd := Portfolio new.
		
	account := ReceptiveAccount new.
	deposit := Deposit  register: 100 on: account .
	
	portfolioToAdd addAccount: account.
	portfolio addPortfolio: portfolioToAdd.
		
	self assert: 100 equals: portfolio balance.
	self assertTransactionsOf: portfolio includes: portfolioToAdd.
	self assert: (portfolio hasRegistered: deposit).
		! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'LS 10/19/2019 13:12:08'!
test09CantAddARepeatedPortfolioToPortfolio

	| portfolio portfolioToAdd |
	
	portfolio := Portfolio new.
	portfolioToAdd := Portfolio new.
	
	portfolio addPortfolio: portfolioToAdd .	

	self should: [ portfolio addPortfolio: portfolioToAdd . ]
		raise: Error - MessageNotUnderstood 
		withMessageText: Portfolio portfolioAlreadyExists.
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'LS 10/21/2019 12:11:20'!
test10CantAddARepeatedAccountToAnAddedPortfolio

	| portfolio portfolioToAdd  account|
	
	portfolio := Portfolio new.
	portfolioToAdd := Portfolio new.
	account := ReceptiveAccount new.
	
	portfolio addAccount: account.
	portfolio addPortfolio: portfolioToAdd .

	self should: [ portfolioToAdd addAccount: account . ]
		raise: Error - MessageNotUnderstood 
		withMessageText: Portfolio accountAlreadyExists.
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'LS 10/21/2019 12:16:35'!
test11CantAddAPortfolioWithRepeatedAccountToPortfolio

	| portfolio1 portfolio2 portfolio3 account |
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	portfolio3 := Portfolio new.
	account := ReceptiveAccount new.
	
	portfolio1 addAccount: account.
	portfolio2 addAccount: account.
	portfolio2 addPortfolio: portfolio3.

	self should: [ portfolio3 addPortfolio: portfolio1. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: Portfolio accountAlreadyExists.
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'LS 10/21/2019 12:19:15'!
test12CantAddAnAccountOfAPortfolioChild

	| portfolio1 portfolio2 account |
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	account := ReceptiveAccount new.
	
	portfolio2 addAccount: account.
	portfolio1 addPortfolio: portfolio2.

	self should: [ portfolio1 addAccount: account. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: Portfolio accountAlreadyExists.
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'LS 10/21/2019 12:21:06'!
test13CantAddAPortfolioWithSameAccount

	| portfolio1 portfolio2 account |
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	account := ReceptiveAccount new.
	
	portfolio1 addAccount: account.
	portfolio2 addAccount: account.
	
	self should: [ portfolio1 addPortfolio: portfolio2. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: Portfolio accountAlreadyExists.
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'LS 10/21/2019 12:24:37'!
test14CantAddARepeatedAccountToPortfolioWithManyParents

	| portfolio1 portfolio2 portfolio3 account |
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	portfolio3 := Portfolio new.
	account := ReceptiveAccount new.
	
	portfolio2 addAccount: account.
	portfolio1 addPortfolio: portfolio3.
	portfolio2 addPortfolio: portfolio3.
	
	self should: [ portfolio3 addAccount: account. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: Portfolio accountAlreadyExists.
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'LS 10/21/2019 12:35:04'!
test15AParentHasBalanceAndAllTransactionsRegisteredOfChildren

	| portfolio1 portfolio2 portfolio3 portfolio4 account1 account2 account3 account4 deposit1 deposit2 deposit3 deposit4 withdraw1 withdraw2 |
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	portfolio3 := Portfolio new.
	portfolio4 := Portfolio new.
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	account4 := ReceptiveAccount new.
		
	portfolio2 addAccount: account1.
	portfolio3 addAccount: account2.
	portfolio3 addAccount: account3.
	portfolio4 addAccount: account4.
	
	portfolio1 addPortfolio: portfolio2.
	portfolio2 addPortfolio: portfolio3.
	portfolio2 addPortfolio: portfolio4.
	
	deposit1 := Deposit  register: 100 on: account1.
	deposit2 := Deposit  register: 110 on: account2.
	deposit3 := Deposit  register: 120 on: account3.
	deposit4 := Deposit  register: 130 on: account4.
	withdraw1 := Withdraw register: 50 on: account2.
	withdraw2 := Withdraw register: 45 on: account2.
		
	self assert: (100+110+120+130-50-45) equals: portfolio1 balance.
	self assertTransactionsOf: portfolio1 includes: portfolio1.
	self assertTransactionsOf: portfolio1 includes: portfolio2.
	self assertTransactionsOf: portfolio1 includes: portfolio3.
	self assertTransactionsOf: portfolio1 includes: portfolio4.
	self assert: (portfolio1 hasRegistered: deposit1).
	self assert: (portfolio1 hasRegistered: deposit2).
	self assert: (portfolio1 hasRegistered: deposit3).
	self assert: (portfolio1 hasRegistered: deposit4).
	self assert: (portfolio1 hasRegistered: withdraw1).
	self assert: (portfolio1 hasRegistered: withdraw2).! !


!PortfolioTest methodsFor: 'assertions' stamp: 'LS 10/17/2019 20:54:30'!
assertTransactionsOf: aPortfolio includes: aReceptiveAccount
	
	aReceptiveAccount transactions do: [:transaction | (aPortfolio transactions includes: transaction) ifFalse: [^false]].
	^true.! !


!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:17:51'!
test02BalanceOfPortfolioWithOneAccountIsAccountBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:23:25'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:15'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:11'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:06'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:15'!
test08PortfolioTransasctionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #ReceptiveAccountTest category: #'Portfolio-Solucion'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

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


!classDefinition: #TransferenceTest category: #'Portfolio-Solucion'!
TestCase subclass: #TransferenceTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferenceTest methodsFor: 'tests' stamp: 'LS 10/22/2019 16:40:52'!
test01MakingATransferMakesADepositAndWithdraw

	| accountSource accountDestiny deposit |
	
	accountSource := ReceptiveAccount new.
	accountDestiny := ReceptiveAccount new.
	deposit := Deposit register: 100 on: accountSource .
	
	Transference from: accountSource to: accountDestiny of: 10.		
	
	self assert: 90 equals: accountSource balance.
	self assert: 10 equals: accountDestiny balance.! !

!TransferenceTest methodsFor: 'tests' stamp: 'LS 10/22/2019 17:18:49'!
test02CannotMakeANegativeTransaction

	| accountSource accountDestiny deposit |
	
	accountSource := ReceptiveAccount new.
	accountDestiny := ReceptiveAccount new.
	deposit := Deposit register: 100 on: accountSource .
	
		self 
		should: [ Transference from: accountSource to: accountDestiny of: -10. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Transference cannotTransferNegativeAmount equals: anError messageText.
			self assert: 100 equals: accountSource balance.
			self assert: 0 equals: accountDestiny balance. ]! !

!TransferenceTest methodsFor: 'tests' stamp: 'LS 10/22/2019 16:40:52'!
test03ValueOfTransactionIsCorrect

	| accountSrc accountDst transactionValue deposit |
	
	accountSrc := ReceptiveAccount new.
	accountDst := ReceptiveAccount new.
	deposit := Deposit register: 100 on: accountSrc.
	transactionValue := 10.
	
	self assert: transactionValue equals: (Transference from: accountSrc to: accountDst of: transactionValue ) value
! !

!TransferenceTest methodsFor: 'tests' stamp: 'LS 10/22/2019 16:40:52'!
test04BalanceOfTransactionIsCorrect

	| accountSrc accountDst transactionValue deposit |
	
	accountSrc := ReceptiveAccount new.
	accountDst := ReceptiveAccount new.
	deposit := Deposit register: 100 on: accountSrc.
	transactionValue := 10.
	Transference from: accountSrc to: accountDst of: transactionValue.
	
	self assert: 90 equals: accountSrc balance.
	self assert: 10 equals: accountDst balance.! !

!TransferenceTest methodsFor: 'tests' stamp: 'cmmmm 10/21/2019 20:58:24'!
test05MakeAReportOfAnEmptyAccount

	| accountSrc |
	
	accountSrc := ReceptiveAccount new.
	
	self assert: 'Balance = 0' equals: accountSrc report.
	! !

!TransferenceTest methodsFor: 'tests' stamp: 'cmmmm 10/21/2019 21:01:03'!
test06MakeAReportOfAnAccountWithADeposit

	| deposit account |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.	
	
	self assert: 'Deposito por 100. Balance = 100' equals: account report.
	! !

!TransferenceTest methodsFor: 'tests' stamp: 'cmmmm 10/21/2019 21:24:48'!
test07MakeAReportOfAnAccountWithADepositAndAWithdraw

	| deposit account withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.	
	withdraw := Withdraw register: 20 on: account.	
	
	self assert: 'Deposito por 100. Extraccion por 20. Balance = 80' equals: account report.
	! !

!TransferenceTest methodsFor: 'tests' stamp: 'cmmmm 10/21/2019 21:30:28'!
test08MakeAReportOfAnEmptyPortfolio

	| portfolio deposit account withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.	
	withdraw := Withdraw register: 20 on: account.
	portfolio := Portfolio with: account.	
	
	self assert: 'Deposito por 100. Extraccion por 20. Balance = 80' equals: portfolio report.
	! !

!TransferenceTest methodsFor: 'tests' stamp: 'LS 10/22/2019 16:40:52'!
test09MakeAReportOfAnAccountWithADepositAndATransaction

	| deposit accountSrc accountDst transaction |
	
	accountSrc := ReceptiveAccount new.
	accountDst := ReceptiveAccount new.
	deposit := Deposit register: 100 on: accountSrc.
	Transference from: accountSrc to: accountDst of: 20.
	
	self assert: 'Deposito por 100. Salida por transferencia de 20. Balance = 80' equals: accountSrc report.
	self assert: 'Entrada por transferencia de 20. Balance = 20' equals: accountSrc report.
	! !

!TransferenceTest methodsFor: 'tests' stamp: 'LS 10/26/2019 11:22:20'!
test10TransferNetOfAnEmptyAccountIsZero

	| accountSrc |
	
	accountSrc := ReceptiveAccount new.
	
	self assert: 0 equals: accountSrc transferNet.
	! !

!TransferenceTest methodsFor: 'tests' stamp: 'LS 10/27/2019 18:45:12'!
test11TransferNetOfAnAccountsWithATransferenceIsCorrect

	| accountSrc accountDst deposit transactionValue |
	
	accountSrc := ReceptiveAccount new.
	accountDst := ReceptiveAccount new.
	
	deposit := Deposit register: 100 on: accountSrc.
	transactionValue := 10.
	Transference from: accountSrc to: accountDst of: transactionValue.
		
	self assert: -10 equals: accountSrc transferNet.
	self assert: 10 equals: accountDst transferNet.! !


!classDefinition: #Account category: #'Portfolio-Solucion'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !



!classDefinition: #Portfolio category: #'Portfolio-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Portfolio methodsFor: 'as yet unclassified' stamp: 'cmmmm 10/17/2019 19:18:37'!
addAccount: aReceptiveAccount 

	(accounts includes: aReceptiveAccount) ifFalse: [accounts add: aReceptiveAccount] ifTrue: [ self error: Portfolio accountAlreadyExists ]
	
	! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'cmmmm 10/17/2019 19:57:56'!
addPortfolio: aPortfolio 
	
	(portfolios includes: aPortfolio ) ifFalse: [portfolios add: aPortfolio ] ifTrue: [ self error: Portfolio portfolioAlreadyExists ]
	! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'cmmmm 10/21/2019 21:35:39'!
report

	| report |
	report := String new.
	report := accounts inject: ''
		into: [ :currentReport :account | currentReport, account report ].
	report := report,'Balance = ', self balance asString.
	^report! !


!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'Portfolio-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error handling' stamp: 'cmmmm 10/17/2019 19:15:20'!
accountAlreadyExists
	^'account Already Exists'! !

!Portfolio class methodsFor: 'error handling' stamp: 'cmmmm 10/17/2019 19:55:10'!
portfolioAlreadyExists
	^'portfolio alredy exists'! !


!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: #'Portfolio-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:24:46'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'cmmmm 10/21/2019 21:23:05'!
report

	| report |
	
	report := String new.
	report := transactions inject: ''
		into: [ :currentReport :transaction | transaction affectReport: currentReport ].
	report := report,'Balance = ', self balance asString.
	^report! !

!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'LS 10/27/2019 18:33:40'!
transferNet
	
	^transactions 
		inject: 0
		into: [ :currentTransference :transaction | transaction affectTransferNet: currentTransference ]! !


!classDefinition: #AccountTransaction category: #'Portfolio-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountTransaction methodsFor: 'value' stamp: 'cmmmm 10/17/2019 19:28:36'!
updateBalance: aBalance

	^self subclassResponsibility ! !

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'as yet unclassified' stamp: 'LS 10/27/2019 18:44:52'!
affectTransferNet: aTransference
	^self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'Portfolio-Solucion'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: #'Portfolio-Solucion'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

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


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'report' stamp: 'cmmmm 10/21/2019 21:22:18'!
affectReport: aReport 
	^aReport, 'Deposito por ', self value asString, '. '.! !


!Deposit methodsFor: 'as yet unclassified' stamp: 'LS 10/27/2019 18:44:43'!
affectTransferNet: aTransference
	^0.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'Portfolio-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferDeposit category: #'Portfolio-Solucion'!
AccountTransaction subclass: #TransferDeposit
	instanceVariableNames: 'transference'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferDeposit methodsFor: 'report' stamp: 'cmmmm 10/21/2019 21:50:51'!
affectReport: aReport 
	^aReport, 'Entrada por Transferencia de ', self value asString, '. '.! !


!TransferDeposit methodsFor: 'initialization' stamp: 'LS 10/22/2019 16:58:58'!
initializeFor: aTransfer

	transference := aTransfer ! !


!TransferDeposit methodsFor: 'value' stamp: 'LS 10/22/2019 17:01:37'!
updateBalance: aBalance

	^ aBalance + self value! !

!TransferDeposit methodsFor: 'value' stamp: 'LS 10/22/2019 17:04:18'!
valorParaBalance

	^ self value! !

!TransferDeposit methodsFor: 'value' stamp: 'LS 10/22/2019 16:59:14'!
value

	^ transference value.! !


!TransferDeposit methodsFor: 'balance' stamp: 'LS 10/22/2019 17:02:14'!
affectBalance: aBalance

	^aBalance + self value ! !


!TransferDeposit methodsFor: 'as yet unclassified' stamp: 'LS 10/27/2019 18:44:35'!
affectTransferNet: aTransference
	^aTransference + self value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferDeposit class' category: #'Portfolio-Solucion'!
TransferDeposit class
	instanceVariableNames: ''!

!TransferDeposit class methodsFor: 'as yet unclassified' stamp: 'cmmmm 10/21/2019 21:49:03'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferWithdraw category: #'Portfolio-Solucion'!
AccountTransaction subclass: #TransferWithdraw
	instanceVariableNames: 'transference'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferWithdraw methodsFor: 'report' stamp: 'cmmmm 10/21/2019 21:51:07'!
affectReport: aReport 
	^aReport, 'Salida por Transferencia de ', self value asString, '. '.! !


!TransferWithdraw methodsFor: 'value' stamp: 'LS 10/22/2019 17:04:40'!
updateBalance: aBalance

	^ aBalance - self value! !

!TransferWithdraw methodsFor: 'value' stamp: 'LS 10/22/2019 17:04:11'!
valorParaBalance
	^ self value negated ! !

!TransferWithdraw methodsFor: 'value' stamp: 'LS 10/22/2019 17:03:46'!
value

	^ transference value! !


!TransferWithdraw methodsFor: 'balance' stamp: 'LS 10/22/2019 17:05:03'!
affectBalance: aBalance

	^aBalance - self value! !


!TransferWithdraw methodsFor: 'initialization' stamp: 'LS 10/22/2019 17:00:25'!
initializeFor: aTransfer

	transference := aTransfer ! !


!TransferWithdraw methodsFor: 'as yet unclassified' stamp: 'LS 10/27/2019 18:44:07'!
affectTransferNet: aTransference
	^aTransference - self value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferWithdraw class' category: #'Portfolio-Solucion'!
TransferWithdraw class
	instanceVariableNames: ''!

!TransferWithdraw class methodsFor: 'as yet unclassified' stamp: 'cmmmm 10/21/2019 21:49:40'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: #'Portfolio-Solucion'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'cmmmm 10/17/2019 19:28:10'!
updateBalance: aBalance

	^ aBalance - value! !

!Withdraw methodsFor: 'value' stamp: 'cmmmm 10/17/2019 18:42:47'!
valorParaBalance
	^ value negated ! !

!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'report' stamp: 'cmmmm 10/21/2019 21:26:01'!
affectReport: aReport 
	^aReport, 'Extraccion por ', self value asString, '. '.! !


!Withdraw methodsFor: 'as yet unclassified' stamp: 'LS 10/27/2019 18:44:20'!
affectTransferNet: aTransference
	^0.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'Portfolio-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Transference category: #'Portfolio-Solucion'!
Object subclass: #Transference
	instanceVariableNames: 'value transferDeposit transferWithdraw'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transference methodsFor: 'as yet unclassified' stamp: 'cmmmm 10/21/2019 21:47:06'!
initializeFrom: anAccountSource to: anAccountDestiny of: anAmount 

	transferDeposit := TransferDeposit register: anAmount on: anAccountDestiny. 
	transferWithdraw := TransferWithdraw register: anAmount on: anAccountSource .
	value  := anAmount.! !

!Transference methodsFor: 'as yet unclassified' stamp: 'cmmmm 10/21/2019 19:52:25'!
value

	^value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transference class' category: #'Portfolio-Solucion'!
Transference class
	instanceVariableNames: ''!

!Transference class methodsFor: 'initialization' stamp: 'LS 10/22/2019 17:10:05'!
from: anAccountSource to: anAccountDestiny of: anAmount 
	self assertAmountPositive: anAmount.
	^Transference new initializeFrom: anAccountSource to: anAccountDestiny of: anAmount.! !

!Transference class methodsFor: 'initialization' stamp: 'cmmmm 10/21/2019 20:38:07'!
register: aValue from: anAccountSource to: anAccountDestiny

	| transaction |
	
	transaction := self from: anAccountSource to: anAccountDestiny of: aValue. 
	anAccountSource register: transaction.
	anAccountDestiny register: transaction.
		
	^ transaction! !


!Transference class methodsFor: 'error messages' stamp: 'LS 10/22/2019 17:18:49'!
cannotTransferNegativeAmount
	^'Cannot transfer negative amount'! !


!Transference class methodsFor: 'assertions' stamp: 'LS 10/22/2019 17:21:04'!
assertAmountPositive: anAmount
	anAmount <1 ifTrue: [self error: Transference cannotTransferNegativeAmount].! !
