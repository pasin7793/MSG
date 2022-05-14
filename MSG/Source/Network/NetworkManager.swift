
import Moya
import RxSwift

protocol NetworkManagerType: class{
    func fetchExchangeRate(exchangeRate: Query) -> Single<Response>
    var provider: MoyaProvider<ExchangeRateAPI> { get }
}

final class NetworkManager: NetworkManagerType{
    static let shared = NetworkManager()
    
    var provider = MoyaProvider<ExchangeRateAPI>()
    func fetchExchangeRate(exchangeRate: Query) -> Single<Response> {
        return provider.rx.request(.getQuery(from: exchangeRate, to: exchangeRate, amount: exchangeRate), callbackQueue: .global())
    }
}
