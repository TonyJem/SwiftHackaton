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
// Описание типов возможных операций:
//    Здесь должны лежать тексты всех возможных операций
//    "Вы запросили балланс ..."
//    "Вы запросили снять наличные ..."
//    "Вы запросили пополнить депозит ..."
    
//    Другими словами: В этом енуме содержатся все ответы на выбор пользователя
    
//    ЭТО я сюда вставил, ToDo: перекинуть в релевантное место
//    ToDo: Запрос баланса на банковском депозите:
//    1. Проверяется правильный ли:
//    номер карты
//    пинкод
//    2. Банк присылает сообщение: Здравствуйте Валерий Евгеньевич, Вы запросили балланс, Ваш балланс Х. Хорошего дня!
    
//    ToDo: Снятие наличных с банковского депозита:
    //    1. Проверяется правильный ли:
    //    номер карты
    //    пинкод
//    2. Пользователь должен ввести какую то сумму денег, эта сумма не должна превышать его депозитный счет, т.е. должна проходить проверка по колличеству денег находящихся на депозите, и если запрашиваемая сумма не превышает то банкомат дает пользователю наличные выводит информацию:
//    Здравствуйте Имя Польз вы выбрали снятие наличности, ваша сумма на депозите уменьшилась на Х и наличные увеличились на столько то...
    
    
//    ToDo: Пополнение банковского депозита наличными:
    //    1. Проверяется правильный ли:
    //    номер карты
    //    пинкод
//    2. Проверка наличие наличных. Можем ли столько внести ? Сумма которую вносим не должна превышать имеющуюся наличность.
//    3. Банк выдает сообщение: Имя пользователя, кнопка которую нажали, ваша сумма на депозите увеличилась на Х и наличные уменьшились на столько то...
    
    
//    ToDo: Пополнение баланса телефона наличными или с банковского депозита:
    //    1. Проверяется правильный ли:
    //    номер карты
    //    пинкод
    
    //    2. Проверяется коректно ли введен номер телефона:
    
    //    3. Уточняется от куда пополнить телефон: С депозита или с наличных:
    
    //    4. Вывести сообщение вы выбрали пополнить балланс телефона на Х сумму через наличные/с депозита. У вас списалось с депозита/с наличных и увеличилась на балансе телефона.
}
 
// Действия, которые пользователь может выбирать в банкомате (имитация кнопок)
enum UserActions {
    case userPressedBalanceBtn
    case userPressedCashWithdrawalBtn
    case userPressedTopUpBankDepositBtn
    case userPressedTopUpPhoneBalanceBtn
    
//    1. Запросить балланс
//    2. Пополнить счет не телефоне
//    3. Снять наличные
//    4. Положить на депозит
}
 
// Способ оплаты/пополнения наличными или через депозит
enum PaymentMethod {
// Наличка
// Депозит
    
//    (Всего эти два варианта)
    
//  Подсказка: Должно быть перечисление с определенным вложенным типом. Вложеный тип и будет, то что мы принимаем какое то действие.
}


// MARK: - Описание банкомата: -
// Банкомат, с которым мы работаем, имеет общедоступный интерфейс sendUserDataToBank
class ATM {
  private let userCardId: String
  private let userCardPin: Int
  private var someBank: BankApi
  private let action: UserActions
  private let paymentMethod: PaymentMethod?
 
  init(userCardId: String,
       userCardPin: Int,
       someBank: BankApi,
       action: UserActions,
       paymentMethod: PaymentMethod? = nil)
  {
    sendUserDataToBank(userCardId: userCardId,
                       userCardPin: userCardPin,
                       actions: action,
                       payment: paymentMethod )
  }
 
  public final func sendUserDataToBank(userCardId: String,
                                       userCardPin: Int,
                                       actions: UserActions,
                                       payment: PaymentMethod?)
  {
//    code here...
  }
}


// MARK: - Описание «сервера» : -
// Протокол по работе с банком предоставляет доступ к данным пользователя зарегистрированного в банке
//TODO: Этот протокол должен быть реализован моим классом "Банк"
protocol BankApi {
    
//    Функции выводящие сообщения (своей внутренней логикой не обладают!)
  func showUserBalance() // выводит сообщение о баллансе
//TODO: Найминг для моих переменных и функций брать отсюда:
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
//    ТуДу: Вспомнить что такое мутатинк методы и разобраться для чего они нужны здесь
// Вроде как мутатинг нужен если юзаем структуры, если все на классах, тогда мутатинг как бы и не причем здесь
  mutating func topUpPhoneBalanceCash(pay: Float) // Производится вычисление нового значения для балланса телефона и соответсвующего уменьшения колличества кеша
  mutating func topUpPhoneBalanceDeposit(pay: Float) // Производится вычисление нового значения для балланса телефона и соответсвующего уменьшения колличества средств на депозите
  mutating func getCashFromDeposit(cash: Float) // Производится уменьшение средств на депозите и увеличение кеша
  mutating func putCashDeposit(topUp: Float) // Производится уменьшение кеша и увеличение средств на депозите
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
