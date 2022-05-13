
import Moya
import RxSwift

protocol NetworkManagerType: class{
    func fetchExchangeRate() -> Single<Response>
}

final class NetworkManager: NetworkManagerType{
    
    static let shared = NetworkManager()
    
    private let provider = MoyaProvider<ExchangeRateAPI>()
    func fetchExchangeRate() -> Single<Response> {
        return provider.rx.request(.fetchExchangeRate, callbackQueue: .global())
    }
}
