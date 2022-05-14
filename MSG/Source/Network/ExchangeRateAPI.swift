
import Moya

enum ExchangeRateAPI: TargetType{
    case getQuery(from: Query, to: Query, amount: Query)
    case getInfo
}

extension ExchangeRateAPI{
    var baseURL: URL{
        return URL(string:
            "https://api.apilayer.com/currency_data/convert?apikey=OGFqIhaxSrBt5plLpmgn0izoliqyd62t/")!
    }
    
    var path: String{
        switch self {
        case .getQuery(from: let from, to: let to,amount: let amount):
            return "&from=\(from)&to=\(to)&amount=\(amount)"
        case .getInfo:
            return "/"
        }
    }
    
    var method: Method{ 
        switch self {
        case .getQuery:
            return .get
        case .getInfo:
            return .get
        }
    }
    
    var task: Task{
        switch self {
        case .getQuery:
            return .requestPlain
        case .getInfo:
            return .requestPlain
        }
    }
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}
