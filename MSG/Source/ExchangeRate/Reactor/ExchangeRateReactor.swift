
import ReactorKit
import RxSwift
import RxFlow
import RxRelay

final class ExchangeRateReactor: Reactor,Stepper{
    
    private let disposeBag: DisposeBag = .init()
    var steps: PublishRelay<Step> = .init()
    
    enum Action{
        //case remitCountryButtonDidTap
        case updateRemitCountry(Country)
        //case remitReceiptButtonDidTap
        case updateReceiptCountry(Country)
        case updateRemitAmount(Int)
        case exchangeRateButtonDidTap
    }
    enum Mutation{
        case setRemitCountry(Country)
        case setReceiptCountry(Country)
        case setRemitAmount(Int)
        case setExchangeItem([ExchangeRateItem])
    }
    struct State{
        var remitCountry: Country
        var receiptCountry: Country
        var exchangeItems: [ExchangeRateItem]
        var remitAmount: Int
        var isFilled: Bool
    }
    let initialState: State
    
    init(){
        initialState = State(
            remitCountry: UserDefaultsLocal.shared.remitCountry,
            receiptCountry: UserDefaultsLocal.shared.remitCountry,
            exchangeItems: [],
            remitAmount: 0,
            isFilled: false)
    }
}

extension ExchangeRateReactor{
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        /*case .remitCountryButtonDidTap:
            steps.accept(TestStep.countryIsRequired)
        case let .updateRemitCountry(country):
            return .just(.setRemitCountry(country))
        case .remitReceiptButtonDidTap:
            steps.accept(TestStep.countryIsRequired)*/
        case let .updateReceiptCountry(country):
            return .just(.setReceiptCountry(country))
        case let .updateRemitAmount(remitAmount):
            return .just(.setRemitAmount(remitAmount))
        case .exchangeRateButtonDidTap:
            steps.accept(TestStep.exchangeRateIsRequired)
        default:
            return .empty()
        }
        return .empty()
    }
}
extension ExchangeRateReactor{
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setRemitCountry(country):
            newState.remitCountry = country
        case let .setReceiptCountry(country):
            newState.receiptCountry = country
        case let .setRemitAmount(remitAmount):
            newState.remitAmount = remitAmount
        case let .setExchangeItem(items):
            newState.exchangeItems = items
        }
        newState.isFilled = checkValidation(newState)
        return newState
    }
}
private extension ExchangeRateReactor{
    func checkValidation(_ state: State) -> Bool{
        guard !state.remitAmount.words.isEmpty
        else {
            return false
        }
        return true
    }
}
