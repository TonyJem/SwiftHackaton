import UIKit

// MARK: - Как представлены пользовательские данные: -
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

// MARK: - User Class: -
class User: UserData {
    var userName: String
    var userCardId: String
    var userCardPin: Int
    var userCash: Float
    var userBankDeposit: Float
    var userPhone: String
    var userPhoneBalance: Float
    
    init(userName: String,
         userCardId: String,
         userCardPin: Int,
         userCash: Float,
         userBankDeposit: Float,
         userPhone: String,
         userPhoneBalance: Float) {
        self.userName = userName
        self.userCardId = userCardId
        self.userCardPin = userCardPin
        self.userCash = userCash
        self.userBankDeposit = userBankDeposit
        self.userPhone = userPhone
        self.userPhoneBalance = userPhoneBalance
    }
}

let egor_pupkin: User = User(userName: "Egor Pupkin",
                                 userCardId: "3339 0039 3312 2222",
                                 userCardPin: 1234,
                                 userCash: 2234.34,
                                 userBankDeposit: 4994.4,
                                 userPhone: "+7(889)-393-43-44",
                                 userPhoneBalance: -34.44)


// MARK: - Что должно быть реализовано: -
// Тексты ошибок
enum TextErrors: String {
//  Wrong card Nr -> Print text: Здравствуйте Вы неправильно ввели номер карты
//  Wrong Pin -> Print text: Здравствуйте Вы неправильно ввели ПИН
//  Недостаточно наличных -> У Вас недостаточно наличных
//  Недостаточно средств на депозите -> У Вас нехватает средств на депозите
    
//    Можно придумать массу других ошибок, но помимнимум важно обработать все 4 действия... Подумать что может быть в них вронг
//    Даже на кнопку "запросить балланс" можно придумать ошибку:
//    1.  "запросить балланс"
//    2. ввести номер телефона
//    3. пополнить депозит
//    4. снять наличные
}
 
// Виды операций, выбранных пользователем (подтверждение выбора)
enum DescriptionTypesAvailableOperations: String {
//    ToDo: Запрос баланса на банковском депозите:
    
//    ToDo: Снятие наличных с банковского депозита:
    
//    ToDo: Пополнение банковского депозита наличными:
    
//    ToDo: Пополнение баланса телефона наличными или с банковского депозита:
    
    
}
 
// Действия, которые пользователь может выбирать в банкомате (имитация кнопок)
enum UserActions {
}
 
// Способ оплаты/пополнения наличными или через депозит
enum PaymentMethod {
}


// MARK: - Описание банкомата: -
// Банкомат, с которым мы работаем, имеет общедоступный интерфейс sendUserDataToBank
class ATM {
  private let userCardId: String
  private let userCardPin: Int
  private var someBank: BankApi
  private let action: UserActions
  private let paymentMethod: PaymentMethod?
 
  init(userCardId: String, userCardPin: Int, someBank: BankApi, action: UserActions, paymentMethod: PaymentMethod? = nil) {
  }
 
  public final func sendUserDataToBank(userCardId: String, userCardPin: Int, actions: UserActions, payment: PaymentMethod?) {
  }
}


// MARK: - Описание «сервера» : -
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

// MARK: - Пример проверки работы : -
// Пользовательские данные, которые хранятся на сервере банка (данные были внеены, когда пользователь зарегестрировался в банке)
let egor_pupkin: UserData = User(userName: "Egor Pupkin",
                                 userCardId: "3339 0039 3312 2222",
                                 userCardPin: 1234,
                                 userCash: 2234.34,
                                 userBankDeposit: 4994.4,
                                 userPhone: "+7(889)-393-43-44",
                                 userPhoneBalance: -34.44)

//Какой-то банк, в котором зарегистрирован пользователь (в этом банке хранятся данные пользователя)
let bankClient = BankServer(user: egor_pupkin)

//Текущий банкомат, с которым мы работаем в данный момент / пользователь вводит данные и пытается выполнить некоторую операцию.
let atm443 = ATM(userCardId: "3339 0039 3312 2222",
                 userCardPin: 1234,
                 someBank: bankClient,
                 action: .userPressedBalanceBtn)
