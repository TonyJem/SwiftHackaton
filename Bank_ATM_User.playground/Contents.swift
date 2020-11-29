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

//ToDo: Необходимо разобраться с неймингом: Переименовать все сложные или двусмыслнные названия. (Осуществимо если начать переиминовывать названия переменных и методов данных в задании из начала)

// MARK: - Protocols: -
// MARK: Описание «пользователя» :
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
    
//    TODO: Перенести протоколы на верх, навести в них порядок чтоб уборать лишние коментарии а те что надо расположить красиво и читабельно
  mutating func topUpPhoneBalanceCash(pay: Float) // Производится вычисление нового значения для баланса телефона и соответсвующего уменьшения колличества кеша
  mutating func topUpPhoneBalanceDeposit(pay: Float) // Производится вычисление нового значения для баланса телефона и соответсвующего уменьшения колличества средств на депозите
  mutating func getCashFromDeposit(cash: Float) // Производится уменьшение средств на депозите и увеличение кеша
  mutating func putCashDeposit(topUp: Float) // Производится уменьшение кеша и увеличение средств на депозите
}

// MARK: - Enums: -
// Действия, которые пользователь может выбирать в банкомате (имитация кнопок)
enum UserActions {
    case userPressedBalanceBtn //Запросить баланс
    case userPressedCashWithdrawalBtn(cash: Float)   //Снять наличные
    case userPressedTopUpBankDepositBtn(cash: Float) //Положить на депозит
    case userPressedTopUpPhoneBalanceBtn(phoneNumber: String,
                                         payment: PaymentMethod,
                                         amount: Float) //Пополнить счет на телефоне
}

// Виды операций, выбранных пользователем (подтверждение выбора)
enum DescriptionTypesAvailableOperations: String {
    case queryBalance = "Вы запросили баланс на банковском депозите."
    case queryToppedUpMobilePhoneCash = "Вы запросили пополнение баланса телефона наличными."
    case queryToppedUpMobilePhoneDeposite = "Вы запросили пополнение баланса телефона с банковского депозита."
    case queryWithdrawalDeposit = "Вы запросили снятие наличных с банковского депозита."
    case queryTopUpAccount = "Вы запросили пополнение банковского депозита наличными."
}

// Тексты ошибок
enum TextErrors: String {
    case wrongLogin = "❗️Здравствуйте, Вы неправильно ввели номер карты или PIN. 🟣"
    case wrongPhoneNr = "❗️Здравствуйте, Вы неправильно ввели номер телефона. 🔵"
    case notEnoughtCash = "❗️Здравствуйте, у Вас недостаточно наличных. 🟡"
    case tooLowDeposite = "❗️Здравствуйте, у Вас нехватает средств на депозите. 🟠"
    case notEnoughtCashForPhone = "❗️Здравствуйте, у Вас недостаточно наличных для пополнения баланса телефона. 🔴"
    case tooLowDepositeForPhone = "❗️Здравствуйте, у Вас нехватает средств на депозите для пополнения баланса телефона. 🟤"
}

// Способ оплаты/пополнения наличными или через депозит
enum PaymentMethod {
    case byCash
    case fromDeposite
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
            (🔸DoubleCheck: В кармане на данный момент: \(user.userCash) рублей)
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
            (🔹DoubleCheck: В кармане на данный момент: \(user.userCash) рублей)
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
        case .notEnoughtCashForPhone:
            print(TextErrors.notEnoughtCashForPhone.rawValue)
        case .tooLowDepositeForPhone:
            print(TextErrors.tooLowDepositeForPhone.rawValue)
        }
    }
    
    func checkCurrentUser(userCardId: String, userCardPin: Int) -> Bool {
        return userCardId == user.userCardId && userCardPin == user.userCardPin
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
    
    func topUpPhoneBalanceCash(pay: Float) {
        user.userPhoneBalance += pay
        user.userCash -= pay
    }
    
    func topUpPhoneBalanceDeposit(pay: Float) {
        user.userPhoneBalance += pay
        user.userBankDeposit -= pay
    }
    
    func getCashFromDeposit(cash: Float) {
        user.userCash += cash
        user.userBankDeposit -= cash
    }
    
    func putCashDeposit(topUp: Float) {
        user.userBankDeposit += topUp
        user.userCash -= topUp
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
         )
    {
        self.userCardId = userCardId
        self.userCardPin = userCardPin
        self.someBank = someBank
        self.action = action
        self.paymentMethod = paymentMethod
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
        guard someBank.checkCurrentUser(userCardId: userCardId,
                                        userCardPin: userCardPin) else {
            someBank.showError(error: .wrongLogin)
            return
        }
        
        switch actions {
        case .userPressedBalanceBtn:
            someBank.showUserBalance()
            
        case let.userPressedCashWithdrawalBtn(cash: cash):
            guard someBank.checkMaxAccountDeposit(withdraw: cash) else {
                someBank.showError(error: .tooLowDeposite)
                return
            }
            someBank.getCashFromDeposit(cash: cash)
            someBank.showWithdrawalDeposit(cash: cash)
        
        case let.userPressedTopUpBankDepositBtn(cash: cash):
            guard someBank.checkMaxUserCash(cash: cash) else {
                someBank.showError(error: .notEnoughtCash)
                return
            }
            someBank.putCashDeposit(topUp: cash)
            someBank.showTopUpAccount(cash: cash)
            
        case let.userPressedTopUpPhoneBalanceBtn(phoneNumber: phoneNumber,
                                                 payment: payment,
                                                 amount: amount):
            guard someBank.checkUserPhone(phone: phoneNumber) else {
                someBank.showError(error: .wrongPhoneNr)
                return
            }
            
            switch payment {
            case .byCash:
                if someBank.checkMaxUserCash(cash: amount) {
                    someBank.topUpPhoneBalanceCash(pay: amount)
                    someBank.showUserToppedUpMobilePhoneCash(cash: amount)
                } else {
                    someBank.showError(error: .notEnoughtCashForPhone)
                }

            case .fromDeposite:
                if someBank.checkMaxAccountDeposit(withdraw: amount) {
                    someBank.topUpPhoneBalanceDeposit(pay: amount)
                    someBank.showUserToppedUpMobilePhoneDeposite(deposit: amount)
                } else {
                    someBank.showError(error: .tooLowDepositeForPhone)
                }
            }
        }
    }
}


// MARK: - Instances: -
let egor_pupkin: User = User(userName: "Egor Pupkin",
                                 userCardId: "3339 0039 3312 2222",
                                 userCardPin: 1234,
                                 userCash: 2234.34,
                                 userBankDeposit: 4994.40,
                                 userPhone: "+7(889)-393-43-44",
                                 userPhoneBalance: -34.44)

let bankClient = Bank(user: egor_pupkin)



// MARK: - RUN Tests: -
//MARK: -Tests for: .userPressedBalanceBtn is Selected:
print("🏁Test0️⃣ for: Normal User, .userPressedBalanceBtn is Selected with: Acceptable userData:")
print("🏁Should print: Deposit balans: 4994.4\n")
let atm443 = ATM(userCardId: "3339 0039 3312 2222",
                 userCardPin: 1234,
                 someBank: bankClient,
                 action: .userPressedBalanceBtn
                 )

print("\n🏁Test1️⃣ for: Wrong User's userCardId, .userPressedBalanceBtn is Selected with: Wrong userCardId:")
print("🏁Should print Error: .wrongLogin 🟣\n")
let atm445 = ATM(userCardId: "3339 0039 3312 222X",
                 userCardPin: 1234,
                 someBank: bankClient,
                 action: .userPressedBalanceBtn
                 )

print("\n🏁Test2️⃣ for: Wrong User's userCardPin, .userPressedBalanceBtn is Selected with: Wrong PIN:")
print("🏁Should print Error: .wrongLogin 🟣\n")
let atm444 = ATM(userCardId: "3339 0039 3312 2222",
                 userCardPin: 1238,
                 someBank: bankClient,
                 action: .userPressedBalanceBtn
                 )

//MARK: -Tests for: .userPressedCashWithdrawalBtn is Selected:
print("\n🏁Test3️⃣ for: .userPressedCashWithdrawalBtn is Selected with: Acceptable amount of cash queried.")
print("🏁Should print: Deposit balans: 4994.4 - 994 = 4000.4 :")
print("🏁Should print: Cash balans 🔸DoubleCheck: 2234.34 + 994 = 3228.34 :\n")
let atm450 = ATM(userCardId: "3339 0039 3312 2222",
                 userCardPin: 1234,
                 someBank: bankClient,
                 action: .userPressedCashWithdrawalBtn(cash: 994)
                 )

print("\n🏁Test4️⃣ for: .userPressedCashWithdrawalBtn is Selected with: TooBIG amount of cash queried.")
print("🏁Should print Error: .tooLowDeposite 🟠\n")
let atm550 = ATM(userCardId: "3339 0039 3312 2222",
                 userCardPin: 1234,
                 someBank: bankClient,
                 action: .userPressedCashWithdrawalBtn(cash: 5000)
                 )

//MARK: -Tests for: .userPressedTopUpBankDepositBtn is Selected:
print("\n🏁Test5️⃣ for: .userPressedTopUpBankDepositBtn is Selected with: Acceptable amount of cash queried.")
print("🏁Should print: Balans: 4000.40 + 234.34 = 4234.74 :")
print("🏁Should print: Cash balans 🔹DoubleCheck: Cash: 3228.34 - 234.34 = 2994.00 :\n")
let atm560 = ATM(userCardId: "3339 0039 3312 2222",
                 userCardPin: 1234,
                 someBank: bankClient,
                 action: .userPressedTopUpBankDepositBtn(cash: 234.34)
                 )

print("\n🏁Test6️⃣ for: .userPressedTopUpBankDepositBtn is Selected with: TooBIG amount of cash queried.")
print("🏁Should print Error: .notEnoughtCash 🟡\n")
let atm660 = ATM(userCardId: "3339 0039 3312 2222",
                 userCardPin: 1234,
                 someBank: bankClient,
                 action: .userPressedTopUpBankDepositBtn(cash: 10000)
                 )

//MARK: -Tests for: .userPressedTopUpPhoneBalanceBtn is Selected:
print("\n🏁Test7️⃣ for: .userPressedTopUpPhoneBalanceBtn is Selected with: Wrong Phone number.")
print("🏁Should print Error: .wrongPhoneNr 🔵\n")
let atm760 = ATM(userCardId: "3339 0039 3312 2222",
                 userCardPin: 1234,
                 someBank: bankClient,
                 action: .userPressedTopUpPhoneBalanceBtn(phoneNumber: "Wrong_phoneNr_Here", payment: .byCash, amount: 30)
                 )

print("\n🏁Test8️⃣ for: .userPressedTopUpPhoneBalanceBtn is Selected")
print("🏁with: Payment byCash and NOT enought Cash in pocket")
print("🏁Should print Error: .notEnoughtCashForPhone 🔴\n")
let atm860 = ATM(userCardId: "3339 0039 3312 2222",
                 userCardPin: 1234,
                 someBank: bankClient,
                 action: .userPressedTopUpPhoneBalanceBtn(phoneNumber: "+7(889)-393-43-44", payment: .byCash, amount: 5000)
                 )

print("\n🏁Test9️⃣ for: .userPressedTopUpPhoneBalanceBtn is Selected")
print("🏁with: Payment byCash and IS enought Cash in pocket")
print("🏁Should print: Cash balans: 2994.00 - 100 = 2894.00 :")
print("🏁Should print: Phone balans: -34.44 + 100 = 65.56 :\n")
let atm960 = ATM(userCardId: "3339 0039 3312 2222",
                 userCardPin: 1234,
                 someBank: bankClient,
                 action: .userPressedTopUpPhoneBalanceBtn(phoneNumber: "+7(889)-393-43-44", payment: .byCash, amount: 100)
                 )

print("\n🏁Test1️⃣0️⃣ for: .userPressedTopUpPhoneBalanceBtn is Selected")
print("🏁with: Payment fromDeposite and NOT enought assets on Deposit")
print("🏁Should print Error: .tooLowDepositeForPhone 🟤\n")
let atm1000 = ATM(userCardId: "3339 0039 3312 2222",
                 userCardPin: 1234,
                 someBank: bankClient,
                 action: .userPressedTopUpPhoneBalanceBtn(phoneNumber: "+7(889)-393-43-44", payment: .fromDeposite, amount: 10000)
                 )
//
print("\n🏁Test1️⃣1️⃣ for: .userPressedTopUpPhoneBalanceBtn is Selected")
print("🏁with: Payment fromDeposite and IS enought assets on Deposit")
print("🏁Should print: Deposit balans: 4234.74 - 100 = 4134.74 :")
print("🏁Should print: Phone balans: 65.56 + 100 = 165.56 :\n")
let atm1100 = ATM(userCardId: "3339 0039 3312 2222",
                 userCardPin: 1234,
                 someBank: bankClient,
                 action: .userPressedTopUpPhoneBalanceBtn(phoneNumber: "+7(889)-393-43-44", payment: .fromDeposite, amount: 100)
                 )
