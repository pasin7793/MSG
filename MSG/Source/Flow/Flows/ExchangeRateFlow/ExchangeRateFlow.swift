//
//  ExchangeRateFlow.swift
//  MSG_Mobile_Project
//
//  Created by 임준화 on 2022/05/12.
//

import RxSwift
import RxFlow
import RxCocoa
import RxRelay
import ReactorKit

struct ExchangeRateStepper: Stepper{
    let steps: PublishRelay<Step> = .init()
    
    var initialStep: Step{
        return TestStep.exchangeRateIsRequired
    }
}

final class ExchangeRateFlow: Flow{
    var root: Presentable{
        return self.rootVC
    }
    let stepper: ExchangeRateStepper
    private let rootVC = UINavigationController()
    init(
        with stepper: ExchangeRateStepper
    ){
        self.stepper = stepper
    }
    deinit{
        print("\(type(of: self)): \(#function)")
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step.asTestStep else { return .none }
        
        switch step{
        case .exchangeRateIsRequired:
            return coordinateToExchangeRateVC()
        default:
            return .none
        }
    }
}
private extension ExchangeRateFlow{
    func coordinateToExchangeRateVC() -> FlowContributors{
        let reactor = ExchangeRateReactor()
        let vc = ExchangeRateVC(reactor: reactor)
        self.rootVC.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: reactor))
    }
}
