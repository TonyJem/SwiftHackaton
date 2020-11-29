import UIKit

// MARK: - Task Description: -
//    1. Запрос баланса на банковском депозите:
//      a. Проверяется правильные ли: номер карты + пинкод
//      б. Банк выводит сообщение:
//          Здравствуйте Валерий Евгеньевич. Вы запросили баланс. Ваш баланс Х. Хорошего дня!

//    2. Снятие наличных с банковского депозита:
//      a. Проверяется правильные ли: номер карты + пинкод
//      б. Пользователь должен ввести какую то сумму денег, эта сумма не должна превышать его депозитный счет, т.е. должна проходить проверка по колличеству денег находящихся на депозите, и если запрашиваемая сумма не превышает то банкомат дает пользователю наличные.
//      в. Банк выводит сообщение:
//    Здравствуйте Имя Польз вы выбрали снятие наличности, ваша сумма на депозите уменьшилась на Х и наличные увеличились на столько то...
    
//    3. Пополнение банковского депозита наличными:
//      a. Проверяется правильные ли: номер карты + пинкод
//      б. Проверка наличия наличных. Можем ли столько внести? Сумма которую вносим не должна превышать имеющуюся наличность.
//      в. Банк выводит сообщение:
//      Имя пользователя, кнопка которую нажали, ваша сумма на депозите увеличилась на Х и наличные уменьшились на столько то...
    
//    4. Пополнение баланса телефона наличными или с банковского депозита:
//      a. Проверяется правильные ли: номер карты + пинкод
//      б. Проверяется корректно ли введен номер телефона:
//      в. Уточняется от куда пополнить телефон: С депозита или с наличных:
//      г. Банк выводит сообщение:
//          Вы выбрали пополнить баланс телефона на Х сумму через наличные/с депозита. У вас списалось с депозита/с наличных и увеличилось на балансе телефона.

// MARK: - Enums: -
// Действия, которые пользователь может выбирать в банкомате (имитация кнопок)
enum UserActions {
    case userPressedBalanceBtn           //Запросить баланс
    case userPressedCashWithdrawalBtn    //Снять наличные
    case userPressedTopUpBankDepositBtn  //Положить на депозит
    case userPressedTopUpPhoneBalanceBtn //Пополнить счет не телефоне
}

// Виды операций, выбранных пользователем (подтверждение выбора)
enum DescriptionTypesAvailableOperations: String {
    case queryBalance = "Вы запросили баланс на банковском депозите."
    case queryToppedUpMobilePhoneCash = "Вы запросили пополнение баланса телефона наличными."
    case queryToppedUpMobilePhoneDeposite = "Вы запросили пополнение баланса телефона с банковского депозита."
    case queryWithdrawalDeposit = "Вы запросили снятие наличных с банковского депозита."
    case queryTopUpAccount = "Вы запросили пополнение банковского депозита наличными."
}

// MARK: - Classes: -
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

class Bank: BankApi {
    
    private var user: User
    
    init(user: User){
        self.user = user
    }
    
    func showUserBalance() {
        let report = """
            Здравствуйте, \(user.userName),
            \(DescriptionTypesAvailableOperations.queryBalance.rawValue)
            Баланс вашего депозита составляет: \(user.userBankDeposit) рублей.
            Хорошего дня!
            """
        print(report)
    }
    
    func showUserToppedUpMobilePhoneCash(cash: Float) {
        let report = """
            Здравствуйте, \(user.userName),
            \(DescriptionTypesAvailableOperations.queryToppedUpMobilePhoneCash.rawValue)
            Вы пополнили баланс телефона наличными на сумму: \(cash) рублей.
            У вас осталось \(user.userCash) рублей наличными.
            Баланс вашего телефона составляет: \(user.userPhoneBalance) рублей.
            Хорошего дня!
            """
        print(report)
    }
    
    func showUserToppedUpMobilePhoneDeposite(deposit: Float) {
        let report = """
            Здравствуйте, \(user.userName),
            \(DescriptionTypesAvailableOperations.queryToppedUpMobilePhoneDeposite.rawValue)
            Вы пополнили баланс телефона с банковского депозита на сумму: \(deposit) рублей.
            На банковском депозите у Вас осталось \(user.userBankDeposit) рублей.
            Баланс вашего телефона составляет: \(user.userPhoneBalance) рублей.
            Хорошего дня!
            """
        print(report)
    }
    
    func showWithdrawalDeposit(cash: Float) {
        let report = """
            Здравствуйте, \(user.userName),
            \(DescriptionTypesAvailableOperations.queryWithdrawalDeposit.rawValue)
            Вам выдано \(cash) рублей наличными.
            На банковском депозите у Вас осталось \(user.userBankDeposit) рублей.
            Хорошего дня!
            """
        print(report)
    }
    
    func showTopUpAccount(cash: Float) {
        let report = """
            Здравствуйте, \(user.userName),
            \(DescriptionTypesAvailableOperations.queryTopUpAccount.rawValue)
            От Вас принято \(cash) рублей наличными.
            На банковском депозите у Вас на данный момент \(user.userBankDeposit) рублей.
            Хорошего дня!
            """
        print(report)
    }
    
    func showError(error: TextErrors) {
        switch error {
        case .wrongLogin:
            print(TextErrors.wrongLogin.rawValue)
        case .wrongPhoneNr:
            print(TextErrors.wrongPhoneNr.rawValue)
        case .notEnoughtCash:
            print(TextErrors.notEnoughtCash.rawValue)
        case .tooLowDeposite:
            print(TextErrors.tooLowDeposite.rawValue)
        }
    }
    
    }
    
    func checkUserPhone(phone: String) -> Bool {
        return phone == user.userPhone
    }
    
    func checkMaxUserCash(cash: Float) -> Bool {
        return cash <= user.userCash
    }
    
    func checkMaxAccountDeposit(withdraw: Float) -> Bool {
        return withdraw <= user.userBankDeposit
    }
    
    func checkCurrentUser(userCardId: String, userCardPin: Int) -> Bool {
        return userCardId == user.userCardId && userCardPin == user.userCardPin
    }
    
    func topUpPhoneBalanceCash(pay: Float) {
        
    }
    
    func topUpPhoneBalanceDeposit(pay: Float) {
        
    }
    
    func getCashFromDeposit(cash: Float) {
        
    }
    
    func putCashDeposit(topUp: Float) {
        
    }
    
    
}

// Банкомат, с которым мы работаем, имеет общедоступный интерфейс sendUserDataToBank
class ATM {
    private let userCardId: String
    private let userCardPin: Int
    private var someBank: BankApi
    private let action: UserActions
    private let paymentMethod: PaymentMethod?
    private var requiredAmount: Float?
    
    init(userCardId: String,
         userCardPin: Int,
         someBank: BankApi,
         action: UserActions,
         paymentMethod: PaymentMethod? = nil
//         requiredAmount: Float
         )
    {
        self.userCardId = userCardId
        self.userCardPin = userCardPin
        self.someBank = someBank
        self.action = action
        self.paymentMethod = paymentMethod
//        self.requiredAmount = requiredAmount
        self.sendUserDataToBank(userCardId: userCardId,
                                userCardPin: userCardPin,
                                actions: action,
                                payment: paymentMethod)
    }
 
  public final func sendUserDataToBank(userCardId: String,
                                       userCardPin: Int,
                                       actions: UserActions,
                                       payment: PaymentMethod?)
  {
//   ToDO: Add code here...
  }
}

// MARK: - Not finished Enums: -
enum TextErrors: String { // Тексты ошибок
    case wrongLogin = "❗️ Здравствуйте, Вы неправильно ввели номер карты или PIN."
    case wrongPhoneNr = "❗️ Здравствуйте, Вы неправильно ввели номер телефона."
    case notEnoughtCash = "❗️ Здравствуйте, у Вас недостаточно наличных."
    case tooLowDeposite = "❗️ Здравствуйте, у Вас нехватает средств на депозите."
}

//    ToDo: Можно придумать массу других ошибок, но помимнимум важно обработать все 4 действия... Подумать что может быть в них вронг
//    Даже на кнопку "запросить баланс" можно придумать ошибку:
//    1.  "запросить баланс"
//    2. ввести номер телефона
//    3. пополнить депозит
//    4. снять наличные

 

 
// Способ оплаты/пополнения наличными или через депозит
enum PaymentMethod {
    case payWithCash
    case payFromDeposite
    
//  ToDo: Подсказка: Должно быть перечисление с определенным вложенным типом. Вложеный тип и будет, то что мы принимаем какое то действие.
}

// MARK: - Protocols: -
protocol UserData {
  var userName: String { get }           //Имя пользователя
  var userCardId: String { get }         //Номер карты
  var userCardPin: Int { get }           //Пин-код
  var userCash: Float { get set}         //Наличные пользователя
  var userBankDeposit: Float { get set}  //Банковский депозит
  var userPhone: String { get }          //Номер телефона
  var userPhoneBalance: Float { get set} //баланс телефона
}

// MARK: Описание «сервера» :
// Протокол по работе с банком предоставляет доступ к данным пользователя зарегистрированного в банке
protocol BankApi {
    
//    Функции выводящие сообщения (своей внутренней логикой не обладают!)
  func showUserBalance() // выводит сообщение о балансе
  func showUserToppedUpMobilePhoneCash(cash: Float) // сколько кеша положили на телефон, банк обрабатывает данные и выводит соответствующее сообщение
  func showUserToppedUpMobilePhoneDeposite(deposit: Float) // сколько положили на телефон через депозит банка, банк обрабатывает данные и выводит соответствующее сообщение
  func showWithdrawalDeposit(cash: Float) // Показать сколько пользователь снял с депозита
  func showTopUpAccount(cash: Float) // Показать на сколько пользователь пополнил депозит
  func showError(error: TextErrors) // Метод который отвечает за ошибки. Обернуть Все ошики в один метод.
 
//    Функции со своей внутренней логикой:
  func checkUserPhone(phone: String) -> Bool // Банк проверяет правильный прислали номер телефона, если неправилный то фолс
  func checkMaxUserCash(cash: Float) -> Bool // Проверяем доступные средства в кармане. Можем ли заплатить столько сколько указываем в переменной кэш
  func checkMaxAccountDeposit(withdraw: Float) -> Bool // Проверяем доступные средства на депозите. Можем ли снять указанную сумму
  func checkCurrentUser(userCardId: String, userCardPin: Int) -> Bool // Метод отвечает за проверку самого пользователя

//    Методы отвечающие за получение данных после всех удачно пройденых проверок, и они отвечаю за изменения первичных данных  начальных настройках конкретного Юзера, то есть фиксируются результаты манипулирования с его данными.
//    ToDo: Вспомнить что такое мутатинк методы и разобраться для чего они нужны здесь
// Вроде как мутатинг нужен если юзаем структуры, если все на классах, тогда мутатинг как бы и не причем здесь
  mutating func topUpPhoneBalanceCash(pay: Float) // Производится вычисление нового значения для баланса телефона и соответсвующего уменьшения колличества кеша
  mutating func topUpPhoneBalanceDeposit(pay: Float) // Производится вычисление нового значения для баланса телефона и соответсвующего уменьшения колличества средств на депозите
  mutating func getCashFromDeposit(cash: Float) // Производится уменьшение средств на депозите и увеличение кеша
  mutating func putCashDeposit(topUp: Float) // Производится уменьшение кеша и увеличение средств на депозите
}



// MARK: - Пример проверки работы : -
// For more description, watch video at: 28:30
// Пользовательские данные, которые хранятся на сервере банка (данные были внесены, когда пользователь зарегестрировался в банке)
//let egor_pupkin: UserData = User(userName: "Egor Pupkin",
//                                 userCardId: "3339 0039 3312 2222",
//                                 userCardPin: 1234,
//                                 userCash: 2234.34,
//                                 userBankDeposit: 4994.4,
//                                 userPhone: "+7(889)-393-43-44",
//                                 userPhoneBalance: -34.44)

//Какой-то банк, в котором зарегистрирован пользователь (в этом банке хранятся данные пользователя)
//let bankClient = BankServer(user: egor_pupkin)

//Текущий банкомат, с которым мы работаем в данный момент / пользователь вводит данные и пытается выполнить некоторую операцию.
//let atm443 = ATM(userCardId: "3339 0039 3312 2222",
//                 userCardPin: 1234,
//                 someBank: bankClient,
//                 action: .userPressedBalanceBtn) // Сюда так же передавать тип оплаты (при помощи чего пополнить при помощи налички или с депозита, а так же передавать сумму на какю хотим проихвести операцию)

//ToDo: Проявить Свое видение, подумать какие могут возникнуть ошибки при выполнении, расписать как это все реализовать



// MARK: - Instances: -
let egor_pupkin: User = User(userName: "Egor Pupkin",
                                 userCardId: "3339 0039 3312 2222",
                                 userCardPin: 1234,
                                 userCash: 2234.34,
                                 userBankDeposit: 4994.4,
                                 userPhone: "+7(889)-393-43-44",
                                 userPhoneBalance: -34.44)

let bankClient = Bank(user: egor_pupkin)

// MARK: - RUN Tests: -
let atm443 = ATM(userCardId: "3339 0039 3312 2222",
                 userCardPin: 1234,
                 someBank: bankClient,
                 action: .userPressedBalanceBtn
//                 paymentMethod: .payFromDeposite,
//                 requiredAmount: 15.0
                 )

let atm445 = ATM(userCardId: "3339 0039 3312 222X",
                 userCardPin: 1234,
                 someBank: bankClient,
                 action: .userPressedBalanceBtn
//                 paymentMethod: .payFromDeposite,
//                 requiredAmount: 15.0
                 )
