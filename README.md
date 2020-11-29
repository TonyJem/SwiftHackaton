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

`<// Абстракция данных пользователя
protocol UserData {
  var userName: String { get }    //Имя пользователя
  var userCardId: String { get }   //Номер карты
  var userCardPin: Int { get }       //Пин-код
  var userCash: Float { get set}   //Наличные пользователя
  var userBankDeposit: Float { get set}   //Банковский депозит
  var userPhone: String { get }       //Номер телефона
  var userPhoneBalance: Float { get set}    //Баланс телефона
}>`
