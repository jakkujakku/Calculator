//
//  ViewController.swift
//  CalculatorWithSB
//
//  Created by (^ㅗ^)7 iMac on 2023/07/17.
//

import UIKit

// 해야하는 과정
// 1. UI 구성
// 2. Calculator 구현 -> 더하기(+), 빼기(-), 곱하기(*), 나누기(/), 소수점 표시(.), 양/음 표시(+/-), 결과 출력
// 3. 스위치 구문 사용해서 추상화 -> AbstractOperation
// 4. 조건 1: SB 사용 금지
//    조건 2: 프로토콜 사용
//    조건 3: 유지보수 용이하게 UI와 기능 분리 + 각 기능들 코드 분리할 것
//    조건 4: 소스트리 쓰기 -> 터미널 사용 X (불편하게 왜 씀?)

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(resultLabel)
    }
    
    // 결과값 도출 Label 코드
    lazy var resultLabel: UILabel = {
       
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(label)
        label.text = "0"
        label.textAlignment = .right
        label.numberOfLines = 1
        label.layer.borderWidth = 1
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
    
    // StackView - 제일 큰 스택뷰
    // 큰 스택뷰(Vertical) -> 1차 작은 스택뷰(Horizontal)*4 -> 버튼
    lazy var stackView: UIStackView = {
       
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    // 버튼
    lazy var button: UIButton = {
        
        let button = UIButton()
        
        return button
    }()
}

