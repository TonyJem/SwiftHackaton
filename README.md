# On-line hackaton. Swift
Swift Section Final Assignment (iOS development cource)
 
[Description](#task-description)

[User Data](#user-data)

## Task Description:

Необходимо написать программу для работы банкомата.

Банкомат будет взаимодействовать с пользователем и должен реализовывать четыре операции:
- запрос баланса на банковском депозите,
- снятие наличных с банковского депозита,
- пополнение банковского депозита наличными,
- пополнение баланса телефона наличными или с банковского депозита.

 
##  User Data:

Как представлены пользовательские данные:
```swift
// Абстракция данных пользователя
protocol UserData {
  var userName: String { get }    //Имя пользователя
  var userCardId: String { get }   //Номер карты
  var userCardPin: Int { get }       //Пин-код
  var userCash: Float { get set}   //Наличные пользователя
  var userBankDeposit: Float { get set}   //Банковский депозит
  var userPhone: String { get }       //Номер телефона
  var userPhoneBalance: Float { get set}    //Баланс телефона
}
```
Что должно быть реализовано:

```swift
// Тексты ошибок
enum TextErrors: String {
 
}
 
// Виды операций, выбранных пользователем (подтверждение выбора)
enum DescriptionTypesAvailableOperations: String {
 
}
 
// Действия, которые пользователь может выбирать в банкомате (имитация кнопок)
enum UserActions {
 
}
 
// Способ оплаты/пополнения наличными или через депозит
enum PaymentMethod {
 
}
```
Описание банкомата:

```swift
// Банкомат, с которым мы работаем, имеет общедоступный интерфейс sendUserDataToBank
class ATM {
  private let userCardId: String
  private let userCardPin: Int
  private var someBank: BankApi
  private let action: UserActions
  private let paymentMethod: PaymentMethod?
 
  init(userCardId: String, userCardPin: Int, someBank: BankApi, action: UserActions, paymentMethod: PaymentMethod? = nil) {
 
 
    sendUserDataToBank(userCardId: userCardId, userCardPin: userCardPin, actions: action, payment: paymentMethod )
  }
 
 
  public final func sendUserDataToBank(userCardId: String, userCardPin: Int, actions: UserActions, payment: PaymentMethod?) {
 
  }
}
```

Описание «сервера» :

```swift
// Протокол по работе с банком предоставляет доступ к данным пользователя зарегистрированного в банке
protocol BankApi {
  func showUserBalance()
  func showUserToppedUpMobilePhoneCash(cash: Float)
  func showUserToppedUpMobilePhoneDeposite(deposit: Float)
  func showWithdrawalDeposit(cash: Float)
  func showTopUpAccount(cash: Float)
  func showError(error: TextErrors)
 
  func checkUserPhone(phone: String) -> Bool
  func checkMaxUserCash(cash: Float) -> Bool
  func checkMaxAccountDeposit(withdraw: Float) -> Bool
  func checkCurrentUser(userCardId: String, userCardPin: Int) -> Bool
 
  mutating func topUpPhoneBalanceCash(pay: Float)
  mutating func topUpPhoneBalanceDeposit(pay: Float)
  mutating func getCashFromDeposit(cash: Float)
  mutating func putCashDeposit(topUp: Float)
}
```
