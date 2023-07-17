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
        // Do any additional setup after loading the view.
    }

}

extension MainViewController {
    
//    var resultLabel: UILabel!
    // 소스트리 연동 확인 중
    
    
    func configureView() {
        
    }
    
    
}
