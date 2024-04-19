import Foundation

func numberWordInAlphabet(Alphabet alphabet: Array<String>, Word word: String, Position position: Int) -> Int {
    //print(alphabet)
    //print("Буква под индексом \(position): \(word[word.index(word.startIndex, offsetBy: position-1)])")
    let wordd = String(word[word.index(word.startIndex, offsetBy: position-1)])
    for i in 0..<alphabet.count {
        if alphabet[i] == wordd {
            //print("Возвращаю \(i + 1)")
            return i + 1
        }
    }
    return 0
}
//Проверка на дубликаты в алфавите при вводе буквы
func checkDublicates(Array array: Array<String>, Value value: String) -> Bool {
    for i in (0..<array.count) {
        if value == array[i] {
            print("🚨 Повторите ввод. Вы ввели повторяющийся символ 🚨")
            return false
        }
    }
    return true
}

//Создание алфавита
func createArray() -> Array<String> {
    print("""
==============================================================================================
Правила ввода алфавита:
1. Вводятся только одиночные символы.
2. Количество введенных символов должно быть больше двух.
3. Не должно быть повторных символов в алфавите
==============================================================================================
Система управления:
Чтобы добавить символ в алфавит, необходимо его написать и нажать Enter.
Чтобы прекратить добавление символов в алфавит, при предложении ввести символ - нажать Enter.
==============================================================================================
""")
    var array: Array<String> = []
    while true {
        print("Введите букву в алфавит: ")
        let input = readLine()
        if let input = input {
            
            if input == " " {
                print("🚨 Повторите ввод. Вы ввели пробел 🚨")
                continue
            }
            //Если введен Enter и элементов меньше двух
            if input == "" && array.count < 2 {
                print("🚨 Повторите ввод. Вы ввели меньше двух буквы 🚨")
                continue
            }
            //Если введен Enter и элементов больше двух
            if input == "" && array.count >= 2 {
                print("==================================================")
                print("✅ Алфавит создан: \(array) ✅")
                print("==================================================")
                break
            }
            //Если строка из нескольких символов
            if input.count > 1 {
                print("🚨 Повторите ввод. Вы ввели несколько символов 🚨")
                continue
            }
            //Проверка на дубликаты в алфавите
            if checkDublicates(Array: array, Value: input) {
                array.append(input)
            }
            
        }
    }
    return array
}

//Меню
func actionMenu() -> Int{
    print("""
==============================================================================================
Выберите действие:
1. По слову найти номер (введите 1)
2. По номеру найти слово (введите 2)
==============================================================================================
""")
    while true {
        let input = readLine()
        if let input = Int(input!) {
            
            if input == 1 {
                return 1
            }else if input == 2 {
                return 2
            }
            else {
                print("🚨 Повторите ввод. Введено неверное число 🚨")
                continue
            }
            
        }else {
            print("🚨 Повторите ввод. Введено неверное число 🚨")
            continue
        }
    }
}

//Перевод к степени
func valueToPower(Value a: Int) -> String {
    let dictionary = [0: "⁰", 1: "¹", 2: "²", 3: "³", 4: "⁴", 5: "⁵", 6: "⁶", 7: "⁷", 8: "⁸", 9: "⁹"]
    
    if a >= 0 && a <= 9 {
        return dictionary[a] ?? "nil"
    }else if a > 9 {
        let temp = String(a)
        var export: String = ""
        for i in temp {
            let power = dictionary[Int(String(i))!]
            export.append(power!)
        }
        return export
        
    }else{
        print("🚨 Error occured! Степень меньше 0 🚨")
        exit(0)
    }
}

//Ввод слова
func inputWord(Alphabet alphabet: Array<String>) -> String {
    var array: String = ""
    while true {
        print("Введите букву: ")
        let input = readLine()
        if let input = input {
            
            //Если введен Enter и количество букв меньше 1
            if input == "" && array.count < 1 {
                print("🚨 Повторите ввод. Вы ввели меньше одной буквы 🚨")
                continue
            }
            //Если введен Enter и элементов больше 1
            if input == "" && array.count > 1 {
                print("==================================================")
                print("✅ Слово создано:\(array) ✅")
                print("==================================================")
                break
            }
            //Если строка из нескольких символов
            if input.count > 1 {
                print("🚨 Повторите ввод. Вы ввели несколько символов 🚨")
                continue
            }
            
            if !alphabet.contains(input) {
                print("Вы ввели букву, которая не содержится в алфавите")
                continue
            }
            
            array.append(input)
            
        }else {
            continue
        }
    }
    return array
}
func taskOne(Alphabet alphabet: Array<String>, Word word: String) {
    print("Алфавит: \(alphabet), Слово:\(word), n = \(alphabet.count), k = \(word.count)")
    print("==================================================")
    print("""
          N = nᴷ⁻¹ * i₁ + nᴷ⁻² * i₂ + nᴷ⁻³ * i₃ + ... + iₖ
          """)

//Создаем строку Один
    var formulaOne: String = "N = "
    let counter = 1
    for i in (0..<word.count) {
        formulaOne.append("\(alphabet.count)\(valueToPower(Value: word.count))⁻\(valueToPower(Value: counter + i)) ∙ \(numberWordInAlphabet(Alphabet: alphabet, Word: word, Position: i + 1)) + ")
    }
    formulaOne.removeLast()
    formulaOne.removeLast()
    
    //Создаем строку Два
    var formulaTwo: String = "N = "
    for i in (0..<word.count) {
        formulaTwo.append("\(alphabet.count)\(valueToPower(Value: word.count - (i + 1))) ∙ \(numberWordInAlphabet(Alphabet: alphabet, Word: word, Position: i + 1)) + ")
    }
    
    formulaTwo.removeLast()
    formulaTwo.removeLast()
    
    print(formulaOne)
    print(formulaTwo)
    
    //считаем
    var result:Decimal = 0
    for i in (0..<word.count) {
        let part = pow(Decimal(alphabet.count), word.count - (i + 1)) * Decimal(numberWordInAlphabet(Alphabet: alphabet, Word: word, Position: i + 1))
        result += part
    }
    print("N = \(result)")
}


func inputNumber(Alphabet: Array<String>) -> Int {
    print("Введите номер слова: ")
    while true {
        let input = readLine()
        if let input = Int(input!) {
            
            //Если ввод соотвествует номеру буквы алфавита
            for i in 0..<Alphabet.count {
                if i == input {
                    print(Alphabet[i-1])
                    exit(0)
                }
            }
            
            //Если ввод не соответсвует номеру буквы алфавита
            if input > Alphabet.count {
                return input
            }
            
            //Если введено 0
            if input == 0 {
                print("ε")
                exit(0)
            }
        }else {
            print("🚨 Повторите ввод. Введено неверное число 🚨")
        }
    }
}
func divs(value: Double, delitel: Double) -> Array<Int> {
    var value = value
    var divs: Array<Int> = []
    while value >= delitel {
        if Int(value) % Int(delitel) == 0 {
            divs.append(Int(Int(value) / Int(delitel)) - 1)
            value = value / delitel
        }else if Int(value) % Int(delitel) != 0 {
            value = value / delitel
            divs.append(Int(trunc(Double(value))))
        }else {
            value = value / delitel
            divs.append(Int(floor(value)))
        }
    }
    //print(divs)
    for i in 0..<divs.count {
        if divs[i] == 0 {
            divs.remove(at: i)
        }
    }
    return divs
}
func ostatki(value: Int, delitel: Int, divs: Array<Int>) -> Array<Int> {
    var ostatki: Array<Int> = []
    var value = value
    for i in divs {
        let temp = value - (i * delitel)
        value = i
        ostatki.append(temp)
    }
    return ostatki
}

//task two
func expression(ostatki: Array<Int>, div: Array<Int>, delitel: Int, Alphabet: Array<String>) {
    var array: [String] = []
    for (_,j) in zip(div, ostatki) {
        let stroka = "( * \(delitel) + \(j))"
        array.append(stroka)
    }
    var result: String = ""
    for (i,j) in zip(array, 0..<array.count) {
        result.insert(contentsOf: i, at: result.index(result.startIndex, offsetBy: j))
    }
    for i in (0..<result.count) {
        if result[result.index(result.startIndex, offsetBy: i)] != "(" {
            result.insert(Character(String(div.last!)), at: result.index(result.startIndex, offsetBy: i))
            break
        }
    }
    
    let reversedOstat = Array<Int>(ostatki.reversed())
    var emptyString = ""
    let start = "\(div.last!)*\(delitel)\(valueToPower(Value: div.count)) + "
    emptyString.append(contentsOf: start)
    for i in 0..<div.count {
        let temp = "\(reversedOstat[i])*\(delitel)\(valueToPower(Value: div.count - i - 1)) + "
        emptyString.append(contentsOf: temp)
    }
    for _ in 0..<6 {
        emptyString.removeLast()

    }
    //Решение
    var arrayForWord: [Int] = []
    arrayForWord.append(div.last!)
    
    for i in reversedOstat {
        arrayForWord.append(i)
    }
    
    var slovo = ""
    print("arrayForWord: \(arrayForWord)")
    for i in arrayForWord{
        if i == 0 {
            continue
        }
        slovo.append(Alphabet[i - 1])
    }
    print("==================================================")
    print("""
\(result) = \(emptyString) = \(slovo)
""")
}


let choose = actionMenu()
switch choose {
case 1:
    let alphabet = createArray()
    let word = inputWord(Alphabet: alphabet)
    
    taskOne(Alphabet: alphabet, Word: word)
case 2:
    let alphabet = createArray()
    let number = inputNumber(Alphabet: alphabet)
    
    let div = divs(value: Double(number), delitel: Double(alphabet.count))
    let ostatki = ostatki(value: number, delitel: alphabet.count, divs: div)
    
    expression(ostatki: ostatki, div: div, delitel: alphabet.count, Alphabet: alphabet)
default:
    print("Error")
}

