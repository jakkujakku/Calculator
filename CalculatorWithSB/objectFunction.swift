//
//  objectFunction.swift
//  CalculatorWithSB
//
//  Created by (^ㅗ^)7 iMac on 2023/07/21.
//

import UIKit

extension MainViewController {
    //MARK: - 기능 구현 코드
        
        // 더하기
        @objc func add() {
            if self.displayNumber.count > 9 {
                showAlert()
            } else {
                self.operation(.Add)
                changeToggle()
            }
        }
        
        // 빼기
        @objc func minus(_ button: UIButton) {
            self.operation(.Subtract)
            changeToggle()
        }
        
        // 곱하기
        @objc func multiple(_ button: UIButton) {
            self.operation(.Multiple)
            changeToggle()
            
            if self.result.count > 9 {
                showAlert()
            }
        }
        
        // 나누기
        @objc func divide(_ button: UIButton) {
            if self.displayNumber.count > 9 {
                showAlert()
            } else {
                self.operation(.Divide)
                changeToggle()
            }
        }
        
        // .
        @objc func dot(_ button: UIButton) {
            if self.displayNumber.count < 8, !self.displayNumber.contains(".") {
                self.displayNumber += self.displayNumber.isEmpty ? "0." : "."
                self.resultLabel.text = self.displayNumber
            }
        }
        
        // =
        @objc func equal(_ button: UIButton) {
            self.operation(.None)
        }
        
        // +/- -> 미구현
        @objc func signChange(_ button: UIButton) {
            // sign: true => 음수
            // sign: false => 양수
            sign.toggle()
            self.resultLabel.text = sign ? "-" + self.displayNumber : self.displayNumber
        }
        
        func change(number: Double) -> Double {
            var result = number
            return sign ? number * -1 : result
        }
        
        // AC
        @objc func AC(_ button: UIButton) {
            self.displayNumber = ""
            self.firstInput = ""
            self.secondInput = ""
            self.result = ""
            self.current = .None
            self.resultLabel.text = "0"
            self.sign = false
        }
        
        // 키패드
        @objc func tapNumber(_ button: UIButton) {

            guard var number = button.title(for: .normal) else { return }
            
            if self.displayNumber.count < 9 {
                // sign 여부 > sign = true 인데, - 한번만 나와 있어야 함.
                self.displayNumber += number
                
                print("626번 코드 : \(sign ? "-" + self.displayNumber : self.displayNumber)")
                self.resultLabel.text = sign ? "-" + self.displayNumber : self.displayNumber
                print("628번 코드 : \(self.resultLabel.text)")
            }
        }
        
        func changeToggle() {
            if sign == true {
                sign = false
            }
        }
        
        // 기능별 작동사항
        func operation(_ operation: Operation) {
            if self.current != .None {
                if !self.displayNumber.isEmpty { // 디스플레이 값 있는 상태
                    // 처음 값 -> 기호 -> 둘째 값 -> 결과
                    
                    self.secondInput = self.displayNumber
                    self.displayNumber = ""

                    var firstInput = self.firstValue
                    print("646번 코드: \(firstInput)")
                    guard var secondInput = Double(self.secondInput) else { return }
                    secondInput = change(number: secondInput)
                    print("649번 코드 : \(secondInput)")
                    
                    switch self.current {
                    case .Add: // 더하기
                        let addResult = AddOperation().CalculatorAdd(firstInput, secondInput)
                        self.result = addResult
                    case .Subtract: // 빼기
                        let subtractResult = SubtractOperation().CalculatorSubtract(firstValue: firstInput, secondValue: secondInput)
                        self.result = subtractResult
                        
                    case .Multiple: // 곱하기
                        let multipleResult = MultiplyOperation().CalculatorMultiply(firstValue: firstInput, secondValue: secondInput)
                        self.result = multipleResult
                        
                    case .Divide: // 나누기
                        let divideResult = DivideOperation().CalculatorDivide(firstValue: firstInput, secondValue: secondInput)
                        if secondInput != 0 {
                            self.result = divideResult
                        } else {
                            NoDivideAlert()
                        }

                    default:
                        break
                    }
                    
                    if let result = Double(self.result), result.truncatingRemainder(dividingBy: 1) == 0 {
                        self.result = String(Int(result))
                    }
                    
                    self.firstInput = self.result
                    self.resultLabel.text = self.result

                    
                    if self.result.count > 9 {
                        showAlert()
                    }
                }
                
                self.current = operation
                
            } else {
                // 디스플레이에 값 없는 상태
                self.firstInput = self.displayNumber
                guard var firstInput = Double(self.firstInput) else { return }
                self.firstValue = sign ? -1 * firstInput : firstInput
                print("696번 코드 : \(firstInput)")
                self.current = operation
                self.displayNumber = ""
            }
            print("700번 코드 First Value: \(self.firstInput)")
            print("701번 코드 Second Value: \(self.secondInput)")
            print("702번 코드 Result : \(self.result)")
        }
        
        func showAlert() {
            let alert = UIAlertController(title: "ERROR", message: "자릿수 10자리를 초과했습니다", preferredStyle: .alert)
            let confirmAlert = UIAlertAction(title: "확인", style: .default) { _ in
                self.resultLabel.text = String(0)
            }
            alert.addAction(confirmAlert)
            self.present(alert, animated: true)
        }
        
        func NoDivideAlert() {
            let alert = UIAlertController(title: "ERROR", message: "0으로 나눌 수 없습니다", preferredStyle: .alert)
            let confirmAlert = UIAlertAction(title: "확인", style: .default) { _ in
                self.resultLabel.text = String(0)
            }
            alert.addAction(confirmAlert)
            self.present(alert, animated: true)
        }
}
