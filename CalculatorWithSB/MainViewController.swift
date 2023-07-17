//
//  ViewController.swift
//  CalculatorWithSB
//
//  Created by (^ㅗ^)7 iMac on 2023/07/17.
//

import UIKit

// 해야하는 과정 && 조건
// 1. UI 구성
// 2. Calculator 구현 -> 더하기(+), 빼기(-), 곱하기(*), 나누기(/), 소수점 표시(.), 양/음 표시(+/-), 결과 출력
// 3. 스위치 구문 사용해서 추상화 -> AbstractOperation
// 4. 조건 1: SB 사용 금지
//    조건 2: 프로토콜 사용
//    조건 3: 유지보수 용이하게 UI와 기능 분리 + 각 기능들 코드 분리할 것
//    조건 4: 소스트리 쓰기 -> 터미널 사용 X (불편하게 왜 씀?)

//MARK: - 결과 레이블 패딩 값

class PaddingLabel: UILabel {

    var topInset: CGFloat = 0
    var bottomInset: CGFloat = 0
    var leftInset: CGFloat = 0
    var rightInset: CGFloat = 10
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets.init(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }

    override var intrinsicContentSize: CGSize {
    let size = super.intrinsicContentSize
    return CGSize(width: size.width + leftInset + rightInset, height: size.height + topInset + bottomInset)
    }
}

//MARK: - UI 코드

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.resultLabel)
        self.view.addSubview(self.bigStackView)
    }
    
    //MARK: - resultLabel
    // 결과값 도출 Label 코드
    lazy var resultLabel: UILabel = {
       
        let label = PaddingLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(label)
        label.text = "0"
        label.textAlignment = .right
        label.numberOfLines = 1
        label.layer.borderWidth = 2
        label.layer.borderColor = UIColor.white.cgColor
        label.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        
        
        let labelAnchor: Void = NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0), // X축
            label.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20), // Top
            label.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20), // Leading
            label.heightAnchor.constraint(equalToConstant: 150), // Height
        ])
        
        label.layer.cornerRadius = 8 // CornerRadius
        
        return label
    }()
    
    //MARK: - 전체 스택뷰
    // bigStackView - 전체 포함하는 스택뷰
    // 큰 스택뷰(Vertical) -> 1차 작은 스택뷰(Horizontal)*4 -> 버튼
    lazy var bigStackView: UIStackView = {
       
        let bigStackView = UIStackView(arrangedSubviews: [smallStackView01, smallStackView02, smallStackView03, smallStackView04, smallStackView05])
        bigStackView.translatesAutoresizingMaskIntoConstraints = false
        
//        bigStackView.layer.borderWidth = 1
//        bigStackView.layer.borderColor = UIColor.white.cgColor
        
        bigStackView.axis = .vertical
        bigStackView.alignment = .fill
        bigStackView.distribution = .fillEqually
        bigStackView.spacing = 10
        
        self.view.addSubview(bigStackView)
        
        let stackViewAnchor: Void = NSLayoutConstraint.activate([
            bigStackView.topAnchor.constraint(equalTo: self.resultLabel.bottomAnchor, constant: 20),
            bigStackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            bigStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            bigStackView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            
            bigStackView.heightAnchor.constraint(equalToConstant: 150),
        ])
        
        return bigStackView
    }()
    
    // AC, 나누기
    lazy var smallStackView01: UIStackView = {
        let smallStackView01 = UIStackView(arrangedSubviews: [buttonAC, buttonDivide])

        smallStackView01.translatesAutoresizingMaskIntoConstraints = false
        
//        smallStackView01.layer.borderWidth = 1
//        smallStackView01.layer.borderColor = UIColor.white.cgColor
        
        smallStackView01.axis = .horizontal
        smallStackView01.alignment = .fill
        smallStackView01.distribution = .fill
        smallStackView01.spacing = 10
        
        buttonAC.widthAnchor.constraint(equalToConstant: 263).isActive = true
        
        return smallStackView01
    }()
    
    // 7, 8, 9, 곱하기
    lazy var smallStackView02: UIStackView = {
        let smallStackView02 = UIStackView(arrangedSubviews: [buttonSeven, buttonEight, buttonNine, buttonMultiple])
        
        smallStackView02.translatesAutoresizingMaskIntoConstraints = false
        
//        smallStackView02.layer.borderWidth = 1
//        smallStackView02.layer.borderColor = UIColor.white.cgColor
        
        smallStackView02.axis = .horizontal
        smallStackView02.alignment = .fill
        smallStackView02.distribution = .fillEqually
        smallStackView02.spacing = 10
        
        let stackViewAnchor: Void = NSLayoutConstraint.activate([
            
        ])
        
        return smallStackView02
    }()
    
    // 4, 5, 6, 빼기
    lazy var smallStackView03: UIStackView = {
        let smallStackView03 = UIStackView(arrangedSubviews: [buttonFour, buttonFive, buttonSix, buttonMinus])
        
        smallStackView03.translatesAutoresizingMaskIntoConstraints = false
        
//        smallStackView03.layer.borderWidth = 1
//        smallStackView03.layer.borderColor = UIColor.white.cgColor
        
        smallStackView03.axis = .horizontal
        smallStackView03.alignment = .fill
        smallStackView03.distribution = .fillEqually
        smallStackView03.spacing = 10
        
        let stackViewAnchor: Void = NSLayoutConstraint.activate([
            
        ])
        return smallStackView03
    }()
    
    // 1, 2, 3, 곱하기
    lazy var smallStackView04: UIStackView = {
        let smallStackView04 = UIStackView(arrangedSubviews: [buttonOne,buttonTwo,buttonThree,buttonAdd])
        
        smallStackView04.translatesAutoresizingMaskIntoConstraints = false
        
//        smallStackView04.layer.borderWidth = 1
//        smallStackView04.layer.borderColor = UIColor.white.cgColor
        
        smallStackView04.axis = .horizontal
        smallStackView04.alignment = .fill
        smallStackView04.distribution = .fillEqually
        smallStackView04.spacing = 10
        
        
        let stackViewAnchor: Void = NSLayoutConstraint.activate([
            
        ])
        
        return smallStackView04
    }()
    
    // 0, (. , =)
    lazy var smallStackView05: UIStackView = {
        let smallStackView05 = UIStackView(arrangedSubviews: [buttonZero, smallStackView06])
        
        smallStackView05.translatesAutoresizingMaskIntoConstraints = false
        
//        smallStackView05.layer.borderWidth = 1
//        smallStackView05.layer.borderColor = UIColor.white.cgColor
//
        smallStackView05.axis = .horizontal
        smallStackView05.alignment = .fill
        smallStackView05.distribution = .equalSpacing
        smallStackView05.spacing = 10

        
        buttonZero.widthAnchor.constraint(equalToConstant: 170).isActive = true
        
        return smallStackView05
    }()
    
    // ., /
    lazy var smallStackView06: UIStackView = {
        let smallStackView06 = UIStackView(arrangedSubviews: [buttonDot, buttonEqual])
        
        smallStackView06.translatesAutoresizingMaskIntoConstraints = false
        
//        smallStackView06.layer.borderWidth = 1
//        smallStackView06.layer.borderColor = UIColor.white.cgColor
        
        smallStackView06.axis = .horizontal
        smallStackView06.alignment = .fill
        smallStackView06.distribution = .fillEqually
        smallStackView06.spacing = 10
        
        smallStackView06.widthAnchor.constraint(equalToConstant: 175).isActive = true
        
        return smallStackView06
    }()
    
    // AC버튼
    lazy var buttonAC: UIButton = {
        
        let buttonAC = UIButton()
        
        buttonAC.backgroundColor = UIColor.lightGray
        buttonAC.titleLabel!.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        buttonAC.layer.cornerRadius = 10
        
        buttonAC.translatesAutoresizingMaskIntoConstraints = false
        
        buttonAC.setTitle("AC", for: .normal)
        buttonAC.setTitleColor(.black, for: .normal)
        
        NSLayoutConstraint.activate([
//            buttonAC.trailingAnchor.constraint(equalTo: self.buttonNine.trailingAnchor, constant: 0)
        ])
        
        return buttonAC
    }()
    
    // ÷버튼
    lazy var buttonDivide: UIButton = {
        
        let buttonDivide = UIButton()
        
        buttonDivide.backgroundColor = .systemOrange
        buttonDivide.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        buttonDivide.layer.cornerRadius = 10
        
        buttonDivide.translatesAutoresizingMaskIntoConstraints = false
        
        buttonDivide.setTitle("÷", for: .normal)
        
        return buttonDivide
    }()
    
    // X버튼
    lazy var buttonMultiple: UIButton = {
        
        let buttonMultiple = UIButton()
        
        buttonMultiple.backgroundColor = .systemOrange
        buttonMultiple.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        buttonMultiple.layer.cornerRadius = 10
        
        buttonMultiple.translatesAutoresizingMaskIntoConstraints = false
        
        buttonMultiple.setTitle("X", for: .normal)
        
        return buttonMultiple
    }()
    
    // -버튼
    lazy var buttonMinus: UIButton = {
        
        let buttonMinus = UIButton()
        
        buttonMinus.backgroundColor = .systemOrange
        buttonMinus.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        buttonMinus.layer.cornerRadius = 10
        
        buttonMinus.translatesAutoresizingMaskIntoConstraints = false
        
        buttonMinus.setTitle("-", for: .normal)
        
        return buttonMinus
    }()
    
    // +버튼
    lazy var buttonAdd: UIButton = {
        
        let buttonAdd = UIButton()
        
        buttonAdd.backgroundColor = .systemOrange
        buttonAdd.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        buttonAdd.layer.cornerRadius = 10
        
        buttonAdd.translatesAutoresizingMaskIntoConstraints = false
        
        buttonAdd.setTitle("+", for: .normal)
        
        return buttonAdd
    }()
    
    // =버튼
    lazy var buttonEqual: UIButton = {
        
        let buttonEqual = UIButton()
        
        buttonEqual.backgroundColor = .systemPink
        buttonEqual.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        buttonEqual.layer.cornerRadius = 10
        
        buttonEqual.translatesAutoresizingMaskIntoConstraints = false
        
        buttonEqual.setTitle("=", for: .normal)
        
        return buttonEqual
    }()
    
    // .버튼
    lazy var buttonDot: UIButton = {
        
        let buttonDot = UIButton()
        
        buttonDot.backgroundColor = .gray
        buttonDot.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        buttonDot.layer.cornerRadius = 10
        
        buttonDot.translatesAutoresizingMaskIntoConstraints = false
        
        buttonDot.setTitle(".", for: .normal)
        
        return buttonDot
    }()
    
    // 0버튼
    lazy var buttonZero: UIButton = {
        
        let buttonZero = UIButton()
        
        buttonZero.backgroundColor = .gray
        buttonZero.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        buttonZero.layer.cornerRadius = 10
        
        buttonZero.translatesAutoresizingMaskIntoConstraints = false
        
        buttonZero.setTitle("0", for: .normal)
        buttonZero.setTitleColor(.white, for: .normal)
        
//        smallStackView04.addSubview(buttonThree)
        
        NSLayoutConstraint.activate([
//            buttonZero.trailingAnchor.constraint(equalTo: self.buttonTwo.trailingAnchor)
        ])
        
        return buttonZero
    }()
    
    // 1버튼
    lazy var buttonOne: UIButton = {
        
        let buttonOne = UIButton()
        
        buttonOne.backgroundColor = .gray
        buttonOne.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        buttonOne.layer.cornerRadius = 10
        
        buttonOne.translatesAutoresizingMaskIntoConstraints = false
        
        buttonOne.setTitle("1", for: .normal)
        buttonOne.setTitleColor(.white, for: .normal)
        return buttonOne
    }()
    
    // 2버튼
    lazy var buttonTwo: UIButton = {
        
        let buttonTwo = UIButton()
        
        buttonTwo.backgroundColor = .gray
        buttonTwo.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        buttonTwo.layer.cornerRadius = 10
        
        buttonTwo.translatesAutoresizingMaskIntoConstraints = false
        
        buttonTwo.setTitle("2", for: .normal)
        buttonTwo.setTitleColor(.white, for: .normal)
        return buttonTwo
    }()
    
    // 3버튼
    lazy var buttonThree: UIButton = {
        
        let buttonThree = UIButton()
        
        buttonThree.backgroundColor = .gray
        buttonThree.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        buttonThree.layer.cornerRadius = 10
        
        buttonThree.translatesAutoresizingMaskIntoConstraints = false
        
        buttonThree.setTitle("3", for: .normal)
        buttonThree.setTitleColor(.white, for: .normal)
        return buttonThree
    }()
    
    // 4버튼
    lazy var buttonFour: UIButton = {
        
        let buttonFour = UIButton()
        
        buttonFour.backgroundColor = .gray
        buttonFour.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        buttonFour.layer.cornerRadius = 10
        
        buttonFour.translatesAutoresizingMaskIntoConstraints = false
        
        buttonFour.setTitle("4", for: .normal)
        buttonFour.setTitleColor(.white, for: .normal)
        return buttonFour
    }()
    
    // 5버튼
    lazy var buttonFive: UIButton = {
        
        let buttonFive = UIButton()
        
        buttonFive.backgroundColor = .gray
        buttonFive.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        buttonFive.layer.cornerRadius = 10
        
        buttonFive.translatesAutoresizingMaskIntoConstraints = false
        
        buttonFive.setTitle("5", for: .normal)
        buttonFive.setTitleColor(.white, for: .normal)
        return buttonFive
    }()
    
    // 6버튼
    lazy var buttonSix: UIButton = {
        
        let buttonSix = UIButton()
        
        buttonSix.backgroundColor = .gray
        buttonSix.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        buttonSix.layer.cornerRadius = 10
        
        buttonSix.translatesAutoresizingMaskIntoConstraints = false
        
        buttonSix.setTitle("6", for: .normal)
        buttonSix.setTitleColor(.white, for: .normal)
        return buttonSix
    }()
    
    // 7버튼
    lazy var buttonSeven: UIButton = {
        
        let buttonSeven = UIButton()
        
        buttonSeven.backgroundColor = .gray
        buttonSeven.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        buttonSeven.layer.cornerRadius = 10
        
        buttonSeven.translatesAutoresizingMaskIntoConstraints = false
        
        buttonSeven.setTitle("7", for: .normal)
        buttonSeven.setTitleColor(.white, for: .normal)
        return buttonSeven
    }()
    
    // 8버튼
    lazy var buttonEight: UIButton = {
        
        let buttonEight = UIButton()
        
        buttonEight.backgroundColor = .gray
        buttonEight.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        buttonEight.layer.cornerRadius = 10
        
        buttonEight.translatesAutoresizingMaskIntoConstraints = false
        
        buttonEight.setTitle("8", for: .normal)
        buttonEight.setTitleColor(.white, for: .normal)
        return buttonEight
    }()
    
    // 9버튼
    lazy var buttonNine: UIButton = {
        
        let buttonNine = UIButton()
        
        buttonNine.backgroundColor = .gray
        buttonNine.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        buttonNine.layer.cornerRadius = 10
        
        buttonNine.translatesAutoresizingMaskIntoConstraints = false
        
        buttonNine.setTitle("9", for: .normal)
        buttonNine.setTitleColor(.white, for: .normal)
        return buttonNine
    }()
    
//    func configureButton() {
//        button.setTitle(Array01[0], for: .normal)
//    }
    
    //MARK: - 기능 구현 코드
    

}


