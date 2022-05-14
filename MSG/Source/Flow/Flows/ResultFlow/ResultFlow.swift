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

struct ResultStepper: Stepper{
    let steps: PublishRelay<Step> = .init()
    
    var initialStep: Step{
        return TestStep.resultIsRequired
    }
}

final class ResultFlow: Flow{
    var root: Presentable{
        return self.rootVC
    }
    let stepper: ResultStepper
    private let rootVC = UINavigationController()
    init(
        with stepper: ResultStepper
    ){
        self.stepper = stepper
    }
    deinit{
        print("\(type(of: self)): \(#function)")
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step.asTestStep else { return .none }
        
        switch step{
        case .resultIsRequired:
            return coordinateToResultVC()
        default:
            return .none
        }
    }
}
private extension ResultFlow{
    func coordinateToResultVC() -> FlowContributors{
        let reactor = ResultReactor()
        let vc = ResultVC(reactor: reactor)
        self.rootVC.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: reactor))
    }
}
