
import Moya
import ReactorKit

enum ExchangeRateAPI: TargetType{
    case getQuery(query:Query)
    case exchange(_ remitCountry: String? = nil, _ receiptCountry: String? = nil, _ amount: String? = nil)
    case getInfo
}

extension ExchangeRateAPI{
    var baseURL: URL{
        return URL(string:
            "https://api.apilayer.com/currency_data/convert?apikey=ABW116RopnNOXBj4B95rbC7LKdOL7AJM&from=PHP&to=KRW&amount=1&info=timestamp&info=quote")!
    }
    
    var path: String{
        switch self {
        case .getQuery(query: let query):
            return "&from=\(query)&to=\(query)&amount=\(query)"
        case .getInfo:
            return ""
        case .exchange(_, _, _):
            return ""
        }
    }
    
    var method: Moya.Method{ 
        switch self {
        case .getQuery:
            return .get
        case .getInfo:
            return .get
        case .exchange(_, _, _):
            return .get
        }
    }
    
    var task: Task{
        switch self {
        case .exchange(let remitCountry, let receiptCountry, let amount):
            let param : [String: Any] = [
                "remitCountry": remitCountry as Any,
                "receiptCountry": receiptCountry as Any,
                "amount": amount as Any,
            ]
            return .requestParameters(parameters: param, encoding: URLEncoding.default)
                
        case .getInfo:
            return .requestPlain
        case .getQuery(query: let query):
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
