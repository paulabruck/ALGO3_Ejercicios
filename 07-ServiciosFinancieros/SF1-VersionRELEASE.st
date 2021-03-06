!classDefinition: #PortfolioTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: 'portfolioWithNoAccounts receptiveAccountOne portfolioWithOneAccount receptiveAccountTwo receptiveAccountThree portfolioWithMultipleAccounts portfolioWithPorfolio depositOfAccountOne depositOfAccountTwo depositOfAccountThree transactionsOfMultipleAccounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!PortfolioTest methodsFor: 'tests' stamp: 'pb 11/26/2021 02:05:10'!
test01IfPorfolioHasNoAccountsBalanceIsZero
	
	self assert: 0*peso equals: portfolioWithNoAccounts balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'pb 11/26/2021 02:07:39'!
test02IfPortfolioHasOneAccountTheBalanceOfThePortfolioIsTheSameAsTheBalanceOfTheAccount
	
	self assert: 10*peso equals: portfolioWithOneAccount balance .! !

!PortfolioTest methodsFor: 'tests' stamp: 'pb 11/26/2021 02:11:26'!
test03IfPortfolioHasMultipleAccountsBalanceIsTheSumOfAllTheAcountsBalances

	self assert: 45*peso equals: portfolioWithMultipleAccounts balance .! !

!PortfolioTest methodsFor: 'tests' stamp: 'MV 11/28/2021 23:21:04'!
test04PortfolioWithNoAccountsDoesNotRegisterATransaction

	self deny: (portfolioWithNoAccounts hasRegistered: depositOfAccountOne ).! !

!PortfolioTest methodsFor: 'tests' stamp: 'MV 11/29/2021 03:47:01'!
test05PorfoliosWithAtLeastOneAccountHaveRegisteredTheirTransactions

	self assertThatPortfolio: portfolioWithOneAccount hasRegisteredAllOfTheTransactionsIndividually: receptiveAccountOne transactions .
 	self assertThatPortfolio: portfolioWithMultipleAccounts hasRegisteredAllOfTheTransactionsIndividually: transactionsOfMultipleAccounts . 

! !

!PortfolioTest methodsFor: 'tests' stamp: 'MV 11/29/2021 03:47:01'!
test06PortfolioWithPortfolioHasRegisteredItsTransactions

	self assertThatPortfolio: portfolioWithPorfolio  hasRegisteredAllOfTheTransactionsIndividually: transactionsOfMultipleAccounts .
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'pb 11/28/2021 02:57:13'!
test07PortfolioWithOneAccountKnowsAllTheAccountTransactions
	
	self assert: receptiveAccountOne transactions equals: portfolioWithOneAccount transactions.! !

!PortfolioTest methodsFor: 'tests' stamp: 'MV 11/29/2021 03:47:55'!
test08PortfolioWithMultipleAccountsKnowsAllTheAccountsTransactions
	
	self assert: transactionsOfMultipleAccounts equals: portfolioWithMultipleAccounts transactions .! !

!PortfolioTest methodsFor: 'tests' stamp: 'MV 11/29/2021 03:48:34'!
test09PortfolioWithPortfolioWithOneAccountKnowsAllTheAccountsTransactions

	self assert: transactionsOfMultipleAccounts equals: portfolioWithPorfolio transactions.! !

!PortfolioTest methodsFor: 'tests' stamp: 'MV 11/29/2021 02:33:39'!
test10PortfolioCanNotAddTheSameAccountTwice

	self 
		should: [ portfolioWithOneAccount addToPortfolio: receptiveAccountOne ] 
		raise: Error withExceptionDo: [:anError | self assert: anError messageText equals: Portfolio unableToAddToPortfolioErrorDescription ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'MV 11/29/2021 02:33:39'!
test11PortfolioCanNotAddAnAccountThatIsAlreadyContainedInAPortfolioInsideOfIt

	self 
		should: [ portfolioWithPorfolio addToPortfolio: receptiveAccountOne ] 
		raise: Error withExceptionDo: [:anError | self assert: anError messageText equals: Portfolio unableToAddToPortfolioErrorDescription ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'MV 11/29/2021 02:33:39'!
test12PortfolioCanNotBeAddedToItself

	self 
		should: [ portfolioWithNoAccounts addToPortfolio: portfolioWithNoAccounts ] 
		raise: Error withExceptionDo: [:anError | self assert: anError messageText equals: Portfolio unableToAddToPortfolioErrorDescription ]! !


!PortfolioTest methodsFor: 'setUp' stamp: 'MV 11/29/2021 03:47:01'!
setUp

	receptiveAccountOne:= ReceptiveAccount new.
	receptiveAccountTwo := ReceptiveAccount new.
	receptiveAccountThree := ReceptiveAccount new.
	
	depositOfAccountOne := RegularDeposit register: 10*peso on: receptiveAccountOne .
	depositOfAccountTwo := RegularDeposit register: 30*peso on: receptiveAccountTwo.
	depositOfAccountThree := RegularDeposit register: 5*peso on: receptiveAccountThree .
	
	transactionsOfMultipleAccounts := OrderedCollection with: depositOfAccountOne  with: depositOfAccountTwo with: depositOfAccountThree .
	
	portfolioWithNoAccounts := Portfolio new.
	
	portfolioWithOneAccount:= Portfolio new addToPortfolio: receptiveAccountOne.

	portfolioWithMultipleAccounts := Portfolio new addToPortfolio: receptiveAccountOne ; addToPortfolio: receptiveAccountTwo ; addToPortfolio: receptiveAccountThree.

	portfolioWithPorfolio := Portfolio new addToPortfolio: portfolioWithMultipleAccounts .
	
	
	! !


!PortfolioTest methodsFor: 'test - helper' stamp: 'MV 11/29/2021 03:38:53'!
assertThatPortfolio: aPortfolio hasRegisteredAllOfTheTransactionsIndividually: aCollectionOfTransactions

	aCollectionOfTransactions do: [:eachTransaction | self assert: (aPortfolio hasRegistered: eachTransaction) ].! !


!classDefinition: #ReceptiveAccountTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: 'receptiveAccount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'MV 11/29/2021 03:08:59'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	self assert: 0 equals: receptiveAccount balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'MV 11/29/2021 03:09:20'!
test02DepositIncreasesBalanceOnTransactionValue 

	RegularDeposit register: 100 * peso on: receptiveAccount .
		
	self assert: 100 * peso equals: receptiveAccount balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'MV 11/29/2021 03:09:45'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	RegularDeposit register: 100 * peso on: receptiveAccount .
	RegularWithdraw register: 50 * peso on: receptiveAccount .
		
	self assert: 50 * peso equals: receptiveAccount balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'MV 11/29/2021 03:10:03'!
test04WithdrawValueMustBePositive 

	| withdrawValue |

	withdrawValue := 50 * peso.
	
	self assert: withdrawValue equals: (RegularWithdraw register: withdrawValue on: receptiveAccount ) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'MV 11/29/2021 03:10:32'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| deposit withdraw |
	
	deposit := RegularDeposit register: 100 * peso on: receptiveAccount .
	withdraw := RegularWithdraw register: 50 * peso on: receptiveAccount .
		
	self assert: (receptiveAccount hasRegistered: deposit).
	self assert: (receptiveAccount hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'MV 11/29/2021 03:10:57'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw |
	
	deposit :=  RegularDeposit for: 100 * peso.
	withdraw := RegularWithdraw for: 50 * peso.
		
	self deny: (receptiveAccount hasRegistered: deposit).
	self deny: (receptiveAccount hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'MV 11/29/2021 03:11:20'!
test07AccountKnowsItsTransactions 

	| deposit |
	
	deposit := RegularDeposit register: 50 * peso on: receptiveAccount.
		
	self assert: 1 equals: receptiveAccount transactions size.
	self assert: (receptiveAccount transactions includes: deposit).
! !


!ReceptiveAccountTest methodsFor: 'setUp' stamp: 'MV 11/29/2021 03:08:47'!
setUp

	receptiveAccount := ReceptiveAccount new.! !


!classDefinition: #TransferenceTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #TransferenceTest
	instanceVariableNames: 'originReceptiveAccount destinationReceptiveAccount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferenceTest methodsFor: 'tests' stamp: 'pb 11/25/2021 02:17:42'!
test01ATrasferedAmountFromOneAccountToAnotherWasMadeCorrectly
	
	self assertThatOriginAndDestinationAccountsHaveTheExpectedBalanceAfterATransferenceFor: 10*peso.! !

!TransferenceTest methodsFor: 'tests' stamp: 'pb 11/25/2021 02:17:18'!
test02TheTransferenceWasMadeWithTheExpectedAmount

	| transference |
	transference := self assertThatOriginAndDestinationAccountsHaveTheExpectedBalanceAfterATransferenceFor: 1000*peso.
	self assert:  1000*peso equals: transference value.! !

!TransferenceTest methodsFor: 'tests' stamp: 'pb 11/26/2021 01:55:35'!
test03TheWithdrawOfATransferenceKnowsItsCounterpart
	
	self assertThatAskingforTheCounterpartOfTheAsocciatedTransactionFromTransference: #associatedWithdraw  resultsIn: #associatedDeposit .! !

!TransferenceTest methodsFor: 'tests' stamp: 'pb 11/26/2021 01:55:10'!
test04TheDepositOfATransferenceKnowsItsCounterpart

	self assertThatAskingforTheCounterpartOfTheAsocciatedTransactionFromTransference: #associatedDeposit  resultsIn:  #associatedWithdraw .
	! !

!TransferenceTest methodsFor: 'tests' stamp: 'pb 11/25/2021 01:57:13'!
test05TranferenceIsInvalidIfOriginAccountAndDestinationAccountAreTheSame
	
	self should: [Transference from: originReceptiveAccount to: originReceptiveAccount for: 1000*peso.] raise: Error withExceptionDo: [:anError | self assert: anError messageText equals: Transference invalidTransferenceErrorDescription].! !

!TransferenceTest methodsFor: 'tests' stamp: 'pb 11/25/2021 01:56:49'!
test06TransferenceOfANegativeAmountIsInvalid
	
	self should: [Transference from: originReceptiveAccount to: destinationReceptiveAccount for: -1000*peso.] raise: Error withExceptionDo: [:anError | self assert: anError messageText equals: Transference invalidTransferenceErrorDescription].! !

!TransferenceTest methodsFor: 'tests' stamp: 'MV 11/29/2021 00:04:24'!
test07TransferenceOfAZeroAmountIsInvalid
	
	self 
		should: [Transference from: originReceptiveAccount to: destinationReceptiveAccount for: 0*peso.] 
		raise: Error withExceptionDo: [:anError | self assert: anError messageText equals: Transference invalidTransferenceErrorDescription].! !


!TransferenceTest methodsFor: 'setUp' stamp: 'pb 11/25/2021 01:53:36'!
setUp

	originReceptiveAccount := ReceptiveAccount new.
	destinationReceptiveAccount := ReceptiveAccount new.! !


!TransferenceTest methodsFor: 'test - helper' stamp: 'MV 11/29/2021 02:58:48'!
assertThatAskingforTheCounterpartOfTheAsocciatedTransactionFromTransference: associatedTransaction resultsIn: expectedAssociatedCounterpart

	| transference |
	
	transference := Transference from: originReceptiveAccount to: destinationReceptiveAccount for: 1000*peso.
	
	self assert: (expectedAssociatedCounterpart asMessage sendTo: transference)  equals: (associatedTransaction asMessage sendTo: transference) counterpart .
	! !

!TransferenceTest methodsFor: 'test - helper' stamp: 'pb 11/25/2021 02:18:15'!
assertThatOriginAndDestinationAccountsHaveTheExpectedBalanceAfterATransferenceFor: anAmount 
	
	| expectedOriginAccountBalance expectedDestinationAccountBalance transference |

	expectedOriginAccountBalance := anAmount negated.
	expectedDestinationAccountBalance := anAmount .
	
	transference :=Transference from: originReceptiveAccount to: destinationReceptiveAccount for: anAmount .
	
	self assert: expectedOriginAccountBalance equals: originReceptiveAccount balance.
	self assert: expectedDestinationAccountBalance equals: destinationReceptiveAccount balance .
	
	^transference! !


!classDefinition: #AccountTransaction category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!AccountTransaction methodsFor: 'accessing' stamp: 'MV 11/24/2021 17:01:36'!
value 

	^ value.! !


!AccountTransaction methodsFor: 'informating' stamp: 'pb 11/25/2021 01:31:30'!
handleHowDoesThisTransactionAffectBalance

	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'MV 11/24/2021 16:22:00'!
register: aValue on: aReceptiveAccount

	| transaction |
	
	transaction := self for: aValue.
	aReceptiveAccount register: transaction.
		
	^ transaction! !

!AccountTransaction class methodsFor: 'instance creation' stamp: 'MV 11/24/2021 16:30:01'!
register: aValue on: aReceptiveAccount thatComesFromTransference: aTransference 
	
	| transaction |
	
	transaction := self for: aValue associatedTo: aTransference .
	aReceptiveAccount register: transaction.
		
	^ transaction! !


!classDefinition: #DepositFromTransference category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #DepositFromTransference
	instanceVariableNames: 'associatedTransference'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!DepositFromTransference methodsFor: 'initialize' stamp: 'MV 11/24/2021 16:28:26'!
initializeFor: aValue associatedTo: aTransference

	value := aValue .
	associatedTransference := aTransference .


	
	
! !


!DepositFromTransference methodsFor: 'informating' stamp: 'pb 11/25/2021 01:06:02'!
counterpart
		
	^ associatedTransference associatedWithdraw.! !

!DepositFromTransference methodsFor: 'informating' stamp: 'pb 11/25/2021 01:31:30'!
handleHowDoesThisTransactionAffectBalance

	^ self value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DepositFromTransference class' category: 'ServiciosFinancieros-Ejercicio'!
DepositFromTransference class
	instanceVariableNames: ''!

!DepositFromTransference class methodsFor: 'instance creation' stamp: 'pb 11/25/2021 01:24:37'!
for: aValue associatedTo: aTransference

	^ DepositFromTransference new initializeFor: aValue associatedTo: aTransference .! !


!classDefinition: #RegularDeposit category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #RegularDeposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!RegularDeposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!RegularDeposit methodsFor: 'informating' stamp: 'pb 11/25/2021 01:31:30'!
handleHowDoesThisTransactionAffectBalance

	^ self value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RegularDeposit class' category: 'ServiciosFinancieros-Ejercicio'!
RegularDeposit class
	instanceVariableNames: ''!

!RegularDeposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #RegularWithdraw category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #RegularWithdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!RegularWithdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!RegularWithdraw methodsFor: 'informating' stamp: 'pb 11/25/2021 01:31:30'!
handleHowDoesThisTransactionAffectBalance

	^ value negated! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RegularWithdraw class' category: 'ServiciosFinancieros-Ejercicio'!
RegularWithdraw class
	instanceVariableNames: ''!

!RegularWithdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #WithdrawFromTransference category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #WithdrawFromTransference
	instanceVariableNames: 'associatedTransference'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!WithdrawFromTransference methodsFor: 'initialize' stamp: 'MV 11/24/2021 16:28:14'!
initializeFor: aValue associatedTo: aTransference

	value := aValue .
	associatedTransference := aTransference .


	
	! !


!WithdrawFromTransference methodsFor: 'informating' stamp: 'MV 11/24/2021 16:41:35'!
counterpart
	
	^ associatedTransference associatedDeposit. ! !

!WithdrawFromTransference methodsFor: 'informating' stamp: 'pb 11/25/2021 01:31:30'!
handleHowDoesThisTransactionAffectBalance

	^ value negated! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'WithdrawFromTransference class' category: 'ServiciosFinancieros-Ejercicio'!
WithdrawFromTransference class
	instanceVariableNames: ''!

!WithdrawFromTransference class methodsFor: 'instance creation' stamp: 'pb 11/25/2021 01:25:06'!
for: aValue associatedTo: aTransference

	^ WithdrawFromTransference new initializeFor: aValue associatedTo: aTransference .
	! !


!classDefinition: #FinancialContract category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #FinancialContract
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!FinancialContract methodsFor: 'main protocol' stamp: 'MV 11/29/2021 02:10:21'!
balance

	self subclassResponsibility.! !

!FinancialContract methodsFor: 'main protocol' stamp: 'MV 11/29/2021 02:10:39'!
hasRegistered: aTransaction

	self subclassResponsibility.! !

!FinancialContract methodsFor: 'main protocol' stamp: 'MV 11/29/2021 02:11:41'!
transactions

	self subclassResponsibility.! !


!FinancialContract methodsFor: 'private protocol' stamp: 'MV 11/29/2021 02:11:51'!
includes: aFinancialContract

	self subclassResponsibility.! !


!classDefinition: #Portfolio category: 'ServiciosFinancieros-Ejercicio'!
FinancialContract subclass: #Portfolio
	instanceVariableNames: 'financialContractsContainer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Portfolio methodsFor: 'initialization' stamp: 'MV 11/29/2021 02:57:19'!
initialize
	
	financialContractsContainer := OrderedCollection new.
	
	! !


!Portfolio methodsFor: 'main protocol' stamp: 'MV 11/29/2021 02:57:19'!
addToPortfolio: aFinancialContract 

	self verifyThatThereIsNoPreviousInclusionOf: aFinancialContract .

	financialContractsContainer add: aFinancialContract .! !

!Portfolio methodsFor: 'main protocol' stamp: 'MV 11/29/2021 02:57:19'!
balance

	financialContractsContainer ifEmpty: [^ 0*peso ].
	^ financialContractsContainer sum: [:eachFinancialContract | eachFinancialContract balance].! !

!Portfolio methodsFor: 'main protocol' stamp: 'MV 11/29/2021 02:57:19'!
hasRegistered: aTransaction 
	
	^ financialContractsContainer anySatisfy: [:eachFinancialContract | eachFinancialContract hasRegistered: aTransaction ].
	! !

!Portfolio methodsFor: 'main protocol' stamp: 'MV 11/29/2021 02:57:19'!
transactions
	
	| allOfTheContainedTransactions |
	
	allOfTheContainedTransactions := OrderedCollection new.
	financialContractsContainer do: [:eachFinancialContract | allOfTheContainedTransactions addAll: eachFinancialContract transactions ].
	
	^allOfTheContainedTransactions! !


!Portfolio methodsFor: 'private protocol' stamp: 'MV 11/29/2021 02:57:19'!
includes: aFinancialContract

	^ financialContractsContainer includes: aFinancialContract .! !

!Portfolio methodsFor: 'private protocol' stamp: 'MV 11/29/2021 02:57:19'!
verifyThatThereIsNoPreviousInclusionOf: aFinancialContract

	self = aFinancialContract ifTrue: [ self error: self class unableToAddToPortfolioErrorDescription ].
	
	financialContractsContainer do: [:eachFinancialContract | 
		(eachFinancialContract includes: aFinancialContract) ifTrue: [ self error: self class unableToAddToPortfolioErrorDescription ].
	 ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'ServiciosFinancieros-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'errors' stamp: 'MV 11/29/2021 02:33:39'!
unableToAddToPortfolioErrorDescription

	^ 'No se puede a�adir una cuenta repetida o al portafolio en s� mismo'! !


!classDefinition: #ReceptiveAccount category: 'ServiciosFinancieros-Ejercicio'!
FinancialContract subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'main protocol' stamp: 'pb 11/26/2021 02:37:48'!
balance

	^transactions sum: [ :aTransaction | aTransaction handleHowDoesThisTransactionAffectBalance ] ifEmpty: [ 0 ]
	
	
	! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'pb 11/18/2021 21:33:47'!
register: aTransaction

	transactions add: aTransaction .
	
	
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'private protocol' stamp: 'MV 11/29/2021 02:36:47'!
includes: aFinancialContract
	
	"Una cuenta est� inclu�da en otra s� y solo s� son la misma cuenta. Si el contrato financiero es un Portfolio, no van a ser iguales"
	^ self = aFinancialContract .
	! !


!classDefinition: #Transference category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #Transference
	instanceVariableNames: 'transferedAmount associatedWithdraw associatedDeposit'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Transference methodsFor: 'initialization' stamp: 'MV 11/24/2021 16:00:25'!
initializeWithValue: amountToTransfer thatComesFromWithdraw: aWithdrawFromTransference toDeposit: aDepositFromTransference 

	transferedAmount := amountToTransfer .
	associatedWithdraw := aWithdrawFromTransference .
	associatedDeposit := aDepositFromTransference .
! !


!Transference methodsFor: 'accessing' stamp: 'MV 11/29/2021 03:03:42'!
associatedDeposit
	
	^ associatedDeposit.! !

!Transference methodsFor: 'accessing' stamp: 'MV 11/29/2021 03:03:47'!
associatedWithdraw
	
	^ associatedWithdraw.! !

!Transference methodsFor: 'accessing' stamp: 'MV 11/22/2021 21:49:00'!
value

	^ transferedAmount .
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transference class' category: 'ServiciosFinancieros-Ejercicio'!
Transference class
	instanceVariableNames: 'associatedWithdraw associatedDeposit'!

!Transference class methodsFor: 'instance creation' stamp: 'MV 11/29/2021 03:01:45'!
from: anOriginReceptiveAccount to: aDestinationReceptiveAccount for: amountToTransfer

	| transference depositFromTransference withdrawFromTransference |
	
	(anOriginReceptiveAccount = aDestinationReceptiveAccount) | (amountToTransfer<=0) ifTrue: [self error: self invalidTransferenceErrorDescription].
	
	transference := self new .
	
	withdrawFromTransference := WithdrawFromTransference register: amountToTransfer on: anOriginReceptiveAccount thatComesFromTransference: transference.
	depositFromTransference := DepositFromTransference register: amountToTransfer on: aDestinationReceptiveAccount thatComesFromTransference: transference.
	
	transference initializeWithValue: amountToTransfer thatComesFromWithdraw: withdrawFromTransference toDeposit: depositFromTransference .
	
	^ transference.! !


!Transference class methodsFor: 'errors' stamp: 'pb 11/25/2021 01:20:13'!
invalidTransferenceErrorDescription
	^'Tranferencia invalida'! !
