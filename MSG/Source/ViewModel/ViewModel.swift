//
//  ViewModel.swift
//  MSG
//
//  Created by 임준화 on 2022/05/14.
//

import RxSwift
import RxRelay
import UIKit

class ViewModel{
    struct Input{
        var from: Observable<String>
        var to: Observable<String>
    }
    struct Output{
        var isFilled: Observable<Bool>
    }
    func transform(_ input: Input) -> Output{
        let valid = Observable.combineLatest(input.from, input.to).map{self.isValidation($0, $1)}
        return Output(isFilled: valid)
    }
    
    func isValidation(_ from: String, _ to: String) -> Bool {
        return from.isEmpty == false && to.isEmpty == false
    }
}
