!classDefinition: #PortfolioTest category: #'Portfolio-Solucion'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

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

!TransferenceTest methodsFor: 'tests' stamp: 'LS 10/28/2019 15:45:56'!
test05MakeAReportOfAnEmptyAccount

	| accountSrc report |
	
	accountSrc := ReceptiveAccount new.
	report := Report with: accountSrc.
	
	self assert: 'Balance = 0' equals: report makeReport.
	! !

!TransferenceTest methodsFor: 'tests' stamp: 'LS 10/28/2019 15:46:40'!
test06MakeAReportOfAnAccountWithADeposit

	| deposit account report |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	report := Report with: account.	
	
	self assert: 'Deposito por 100. Balance = 100' equals: report makeReport.
	! !

!TransferenceTest methodsFor: 'tests' stamp: 'LS 10/28/2019 15:50:45'!
test07MakeAReportOfAnAccountWithADepositAndAWithdraw

	| deposit account withdraw report|
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.	
	withdraw := Withdraw register: 20 on: account.
	report := Report with: account.	
	
	self assert: 'Deposito por 100. Extraccion por 20. Balance = 80' equals: report makeReport.
	! !

!TransferenceTest methodsFor: 'tests' stamp: 'LS 10/28/2019 15:47:47'!
test08MakeAReportOfAnEmptyPortfolio

	| portfolio account report |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.	
	report := Report with: portfolio.
	
	self assert: 'Balance = 0' equals: report makeReport.
	! !

!TransferenceTest methodsFor: 'tests' stamp: 'LS 10/28/2019 15:49:23'!
test09MakeAReportOfAnAccountWithADepositAndATransaction

	| deposit accountSrc accountDst transaction reportSrc reportDst |
	
	accountSrc := ReceptiveAccount new.
	accountDst := ReceptiveAccount new.
	deposit := Deposit register: 100 on: accountSrc.
	Transference from: accountSrc to: accountDst of: 20.
	
	reportSrc := Report with: accountSrc.
	reportDst := Report with: accountDst.
	
	self assert: 'Deposito por 100. Salida por Transferencia de 20. Balance = 80' equals: reportSrc makeReport.
	self assert: 'Entrada por Transferencia de 20. Balance = 20' equals: reportDst makeReport.
	! !

!TransferenceTest methodsFor: 'tests' stamp: 'LS 10/28/2019 15:49:57'!
test10MakeAReportOfAPortfolioWithOneAccountWithADepositAndWithdraw

	| portfolio deposit account withdraw report |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.	
	withdraw := Withdraw register: 20 on: account.
	portfolio := Portfolio with: account.
	
	report := Report with: portfolio .	
	
	self assert: 'Deposito por 100. Extraccion por 20. Balance = 80' equals: report makeReport.
	! !

!TransferenceTest methodsFor: 'tests' stamp: 'LS 10/28/2019 16:35:10'!
test11TransferNetOfAnEmptyAccountIsZero

	| account transferNet |
	
	account := ReceptiveAccount new.
	transferNet := TransferNet with: account.
	
	self assert: 0 equals: transferNet printTransferNet.
	! !

!TransferenceTest methodsFor: 'tests' stamp: 'LS 10/28/2019 16:36:34'!
test12TransferNetOfAnAccountsWithATransferenceIsCorrect

	| accountSrc accountDst deposit transactionValue transferNetSrc transferNetDst |
	
	accountSrc := ReceptiveAccount new.
	accountDst := ReceptiveAccount new.
	
	deposit := Deposit register: 100 on: accountSrc.
	transactionValue := 10.
	Transference from: accountSrc to: accountDst of: transactionValue.
	
	transferNetSrc := TransferNet with: accountSrc.
	transferNetDst := TransferNet with: accountDst.
		
	self assert: transactionValue negated equals: transferNetSrc printTransferNet .
	self assert: transactionValue equals: transferNetDst printTransferNet .! !

!TransferenceTest methodsFor: 'tests' stamp: 'LS 10/28/2019 16:37:16'!
test13TransferNetOfAnEmptyPortfolioIsZero

	| portfolio transferNet |
	
	portfolio := Portfolio new.
	transferNet := TransferNet with: portfolio .
	
	self assert: 0 equals: transferNet printTransferNet.
	! !

!TransferenceTest methodsFor: 'tests' stamp: 'LS 10/28/2019 16:45:33'!
test14TransferNetOfAPortfolioWithAnAccountsWithATransferenceIsCorrect

	| accountSrc accountDst deposit transactionValue portfolioSrc portfolioDst transferNetAccSrc transferNetAccDst transferNetPortSrc transferNetPortDst |
	
	accountSrc := ReceptiveAccount new.
	accountDst := ReceptiveAccount new.
	
	deposit := Deposit register: 100 on: accountSrc.
	transactionValue := 10.
	Transference from: accountSrc to: accountDst of: transactionValue.
	
	portfolioSrc := Portfolio with: accountSrc.
	portfolioDst := Portfolio with: accountDst.
	
	transferNetAccSrc  := TransferNet with: accountSrc .
	transferNetAccDst := TransferNet with: accountDst .
	transferNetPortSrc := TransferNet with: portfolioSrc .
	transferNetPortDst := TransferNet with: portfolioDst .
	
	self assert: transferNetAccSrc printTransferNet equals: transferNetPortSrc printTransferNet .
	self assert: transferNetAccDst printTransferNet equals: transferNetPortDst printTransferNet.! !


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

!Account methodsFor: 'transactions' stamp: 'LS 10/28/2019 16:56:39'!
transferNet: aTransferNet
	^self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: #'Portfolio-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Portfolio methodsFor: 'transFernet' stamp: 'LS 10/28/2019 16:41:45'!
transferNet: aTransferNet
	^accounts do: [ :anAccount | anAccount transferNet: aTransferNet ]! !


!Portfolio methodsFor: 'report' stamp: 'LS 10/28/2019 17:21:11'!
reportOperations: aReport
	
	accounts do: [ :anAccount | anAccount reportOperations: aReport ].
! !


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

!ReceptiveAccount methodsFor: 'transactions' stamp: 'LS 10/28/2019 17:07:37'!
transferNet: aTransferNet
	transactions do: [:aTransaction | aTransaction doTransferNet: aTransferNet]
	! !


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


!ReceptiveAccount methodsFor: 'report' stamp: 'LS 10/28/2019 17:19:47'!
reportOperations: aReport
	
	transactions do:[ :aTransaction | aTransaction addToReport: aReport ].! !


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


!AccountTransaction methodsFor: 'balance' stamp: 'LS 10/28/2019 17:01:51'!
addToReport: aReport
	^self subclassResponsibility ! !

!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'transferNet' stamp: 'LS 10/28/2019 16:27:48'!
doTransferNet: aTranferNet
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


!Deposit methodsFor: 'report' stamp: 'LS 10/28/2019 17:00:40'!
addToReport: aReport
	^aReport addDeposit: self.! !


!Deposit methodsFor: 'transferNet' stamp: 'LS 10/28/2019 16:47:37'!
doTransferNet: aTransFernet
	^aTransFernet countDeposit: self.! !

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

!TransferDeposit methodsFor: 'report' stamp: 'LS 10/28/2019 17:00:59'!
addToReport: aReport
	^aReport addTransferDeposit: self.! !


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


!TransferDeposit methodsFor: 'tranferNet' stamp: 'LS 10/28/2019 16:47:41'!
doTransferNet: aTransFernet
	^aTransFernet countTransferDeposit: self.! !

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

!TransferWithdraw methodsFor: 'report' stamp: 'LS 10/28/2019 17:01:17'!
addToReport: aReport
	^aReport addTransferWithdraw: self.! !


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


!TransferWithdraw methodsFor: 'tranferNet' stamp: 'LS 10/28/2019 16:47:46'!
doTransferNet: aTransFernet
	^aTransFernet countTransferWithdraw: self.! !

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


!Withdraw methodsFor: 'report' stamp: 'LS 10/28/2019 17:01:30'!
addToReport: aReport
	^aReport addWithdraw: self.! !


!Withdraw methodsFor: 'tranferNet' stamp: 'LS 10/28/2019 16:47:52'!
doTransferNet: aTransFernet
	^aTransFernet countWithdraw: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'Portfolio-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Report category: #'Portfolio-Solucion'!
Object subclass: #Report
	instanceVariableNames: 'account stream'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Report methodsFor: 'report' stamp: 'LS 10/28/2019 17:28:49'!
addDeposit: aDeposit

	^stream := stream, 'Deposito por ', aDeposit value asString, '. '.! !

!Report methodsFor: 'report' stamp: 'LS 10/28/2019 17:29:06'!
addTransferDeposit: aTransferDeposit

	^stream := stream, 'Entrada por Transferencia de ', aTransferDeposit value asString, '. '.! !

!Report methodsFor: 'report' stamp: 'LS 10/28/2019 17:29:10'!
addTransferWithdraw: aTransferWithdraw

	^stream := stream, 'Salida por Transferencia de ', aTransferWithdraw value asString, '. '.! !

!Report methodsFor: 'report' stamp: 'LS 10/28/2019 17:29:14'!
addWithdraw: aWithdraw

	^stream := stream, 'Extraccion por ', aWithdraw value asString, '. '.! !

!Report methodsFor: 'report' stamp: 'LS 10/28/2019 17:18:11'!
makeReport

	account reportOperations: self.
	stream := stream,'Balance = ', account balance asString.
	^stream! !


!Report methodsFor: 'initialization' stamp: 'LS 10/28/2019 16:55:21'!
initializeWith: anAccount

	stream _ String new.
	account _ anAccount.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Report class' category: #'Portfolio-Solucion'!
Report class
	instanceVariableNames: ''!

!Report class methodsFor: 'class initialization' stamp: 'LS 10/28/2019 14:16:31'!
with: anAccount

	^self new initializeWith: anAccount.! !


!classDefinition: #TransferNet category: #'Portfolio-Solucion'!
Object subclass: #TransferNet
	instanceVariableNames: 'account net'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNet methodsFor: 'initialize' stamp: 'LS 10/28/2019 16:51:38'!
initializeWith: anAccount

	net := 0.
	account := anAccount.! !


!TransferNet methodsFor: 'counts dispatch' stamp: 'LS 10/28/2019 16:31:31'!
countDeposit: aDeposit

	^0.
	! !

!TransferNet methodsFor: 'counts dispatch' stamp: 'LS 10/28/2019 16:32:05'!
countTransferDeposit: aDeposit

	^net := net + aDeposit value.
	! !

!TransferNet methodsFor: 'counts dispatch' stamp: 'LS 10/28/2019 16:32:26'!
countTransferWithdraw: aWithdraw

	^net := net - aWithdraw value.
	! !

!TransferNet methodsFor: 'counts dispatch' stamp: 'LS 10/28/2019 16:31:20'!
countWithdraw: aWithdraw

	^0.
	! !


!TransferNet methodsFor: 'printing' stamp: 'LS 10/28/2019 16:53:41'!
printTransferNet
	
	account transferNet: self.
	^net! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferNet class' category: #'Portfolio-Solucion'!
TransferNet class
	instanceVariableNames: ''!

!TransferNet class methodsFor: 'class initialization' stamp: 'LS 10/28/2019 16:22:04'!
with: anAccount
	^self new initializeWith: anAccount.! !


!classDefinition: #Transference category: #'Portfolio-Solucion'!
Object subclass: #Transference
	instanceVariableNames: 'value transferDeposit transferWithdraw'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transference methodsFor: 'initialization' stamp: 'cmmmm 10/21/2019 21:47:06'!
initializeFrom: anAccountSource to: anAccountDestiny of: anAmount 

	transferDeposit := TransferDeposit register: anAmount on: anAccountDestiny. 
	transferWithdraw := TransferWithdraw register: anAmount on: anAccountSource .
	value  := anAmount.! !


!Transference methodsFor: 'value' stamp: 'cmmmm 10/21/2019 19:52:25'!
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
