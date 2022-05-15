
import Moya
import RxSwift

protocol NetworkManagerType: class{
    func fetchExchangeRate(query: Query) -> Single<Response>
    var provider: MoyaProvider<ExchangeRateAPI> { get }
}

final class NetworkManager: NetworkManagerType{
    static let shared = NetworkManager()
    
    var provider: MoyaProvider<ExchangeRateAPI> = .init()
    func fetchExchangeRate(query: Query) -> Single<Response> {
        return provider.rx.request(.getQuery(query: query),callbackQueue: .global())
    }
}

