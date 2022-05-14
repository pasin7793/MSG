
import Moya

enum ExchangeRateAPI: TargetType{
    case postQuery(query:Query)
    case getInfo
    
}

extension ExchangeRateAPI{
    var baseURL: URL{
        return URL(string:
            "https://api.apilayer.com/currency_data/convert?apikey=OGFqIhaxSrBt5plLpmgn0izoliqyd62t")!
    }
    
    var path: String{
        switch self {
        case .postQuery(query: let query):
            return "&from=\(query)&to=\(query)&amount=\(query)"
        case .getInfo:
            return "/"
        }
    }
    
    var method: Method{ 
        switch self {
        case .postQuery:
            return .post
        case .getInfo:
            return .get
        }
    }
    
    var task: Task{
        switch self {
        case .postQuery(let query):
            return .requestParameters(parameters: ["from": query.from, "to": query.to, "amount": query.amount], encoding: JSONEncoding.default)
        case .getInfo:
            return .requestPlain
        }
    }
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}
