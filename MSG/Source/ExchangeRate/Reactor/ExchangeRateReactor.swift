
import ReactorKit
import RxSwift
import RxFlow
import RxRelay

final class ExchangeRateReactor: Reactor,Stepper{
    
    private let disposeBag: DisposeBag = .init()
    var steps: PublishRelay<Step> = .init()
    
    enum Action{
        case remitCountryButtonDidTap(Country)
        case receiptCountryButtonDidTap(Country)
        case updateRemitAmount(Int)
        case exchangeRateButtonDidTap
    }
    enum Mutation{
        case setRemitCountry(Country)
        case setReceiptCountry(Country)
        case setRemitAmount(Int)
        case setExchangeItem(_ exchangeItem: [ExchangeRateItem])
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
        case let .remitCountryButtonDidTap(remit):
            UserDefaultsLocal.shared.remitCountry = remit
            steps.accept(TestStep.countryIsRequired)
        case let .receiptCountryButtonDidTap(receipt):
            UserDefaultsLocal.shared.receiptCountry = receipt
            steps.accept(TestStep.countryIsRequired)
        case let .updateRemitAmount(remitAmount):
            return .just(.setRemitAmount(remitAmount))
        case .exchangeRateButtonDidTap:
            steps.accept(TestStep.exchangeRateIsRequired)
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
        newState.isFilled = checkIsFilled(newState)
        return newState
    }
}
private extension ExchangeRateReactor{
    func checkIsFilled(_ state: State) -> Bool{
        guard !state.remitCountry.display.isEmpty,
              !state.receiptCountry.display.isEmpty
        else {
            return false
        }
        return true
    }
}
                 
