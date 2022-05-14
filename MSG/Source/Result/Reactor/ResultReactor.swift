
import ReactorKit
import RxSwift
import RxFlow
import RxRelay

final class ResultReactor: Reactor,Stepper{
    
    private let disposeBag: DisposeBag = .init()
    var steps: PublishRelay<Step> = .init()
    
    enum Action{
        
    }
    enum Mutation{
        case setRemitCountry(Country)
        case setReceiptCountry(Country)
        case setExchangeItem(_ exchangeItem: [Info])
    }
    struct State{
        var remitCountry: Country
        var receiptCountry: Country
        var exchangeItems: [Info]
    }
    let initialState: State
    
    init(){
        initialState = State(
            remitCountry: UserDefaultsLocal.shared.remitCountry,
            receiptCountry: UserDefaultsLocal.shared.remitCountry,
            exchangeItems: []
        )
    }
}

extension ResultReactor{
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        }
        return .empty()
    }
}
extension ResultReactor{
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setRemitCountry(country):
            newState.remitCountry = country
        case let .setReceiptCountry(country):
            newState.receiptCountry = country
        case let .setExchangeItem(items):
            newState.exchangeItems = items
        }
        return newState
    }
}
private extension ResultReactor{
    
}
                 
