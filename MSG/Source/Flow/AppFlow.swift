
import RxRelay
import RxFlow
import RxSwift

struct AppStepper: Stepper{
    let steps: PublishRelay<Step> = .init()
    private let disposeBag: DisposeBag = .init()
    
    func readyToEmitSteps() {
        steps.accept(TestStep.exchangeRateIsRequired)
    }
}

final class AppFlow: Flow{
    var root: Presentable{
        return self.rootWindow
    }
    private let rootWindow: UIWindow
    
    init(
        with window: UIWindow
    ){
        self.rootWindow = window
    }
    deinit{
        print("\(type(of: self)): \(#function)")
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step.asTestStep else {return .none}
        
        switch step {
        case .exchangeRateIsRequired:
            return coordinateToExchange()
        default:
            return .none
        }
    }
}

private extension AppFlow{
    func coordinateToExchange() -> FlowContributors{
        let flow = ExchangeRateFlow(with: .init())
        Flows.use(flow, when: .created){ [unowned self] root in
            self.rootWindow.rootViewController = root
        }
        let nextStep = OneStepper(withSingleStep: TestStep.exchangeRateIsRequired)
        return .one(flowContributor: .contribute(withNextPresentable: flow, withNextStepper: nextStep))
    }
}
