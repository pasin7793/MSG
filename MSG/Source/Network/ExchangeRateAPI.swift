
import Moya

enum ExchangeRateAPI: TargetType{
    case fetchExchangeRate
}

extension ExchangeRateAPI{
    var baseURL: URL{
        return URL(string:
            "https://api.apilayer.com/currency_data/live"
        )!
    }
    
    var path: String{
        switch self {
        case .fetchExchangeRate:
            return "?apikey=WBth7zSqpJkYyNNRQ96D27pdif7AiNQB"
        }
    }
    
    var method: Method{
        switch self {
        case .fetchExchangeRate:
            return .get
        }
    }
    
    var task: Task{
        switch self {
        case .fetchExchangeRate:
            return .requestPlain
        }
    }
    var headers: [String : String]? {
        return nil
    }
}
