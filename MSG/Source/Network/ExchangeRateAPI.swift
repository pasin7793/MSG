
import Moya

enum ExchangeRateAPI: TargetType{
    case getQuery(query:Query)
    case getInfo
}

extension ExchangeRateAPI{
    var baseURL: URL{
        return URL(string:
            "https://api.apilayer.com/currency_data/convert?apikey=ABW116RopnNOXBj4B95rbC7LKdOL7AJM")!
    }
    
    var path: String{
        switch self {
        case .getQuery(query: let query):
            return "&from=\(query)&to=\(query)&amount=\(query)"
        case .getInfo:
            return ""
        }
    }
    
    var method: Moya.Method{ 
        switch self {
        case .getQuery:
            return .get
        case .getInfo:
            return .get
        }
    }
    
    var task: Task{
        switch self {
        case .getQuery(let query):
            return .requestParameters(parameters: ["from": query.from, "to": query.to, "amount": query.amount], encoding: JSONEncoding.default)
                
        case .getInfo:
            return .requestPlain
        }
    }
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    var validationType: ValidationType{
        return .successCodes
    }
}
