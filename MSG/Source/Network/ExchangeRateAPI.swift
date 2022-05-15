
import Moya

enum ExchangeRateAPI: TargetType{
    case getQuery(query:Query)
    case exchange(remitCountry: String, receiptCountry: String, amount: Int)
    case getInfo(quote: Double)
}

extension ExchangeRateAPI{
    var baseURL: URL{
        return URL(string:
            "https://api.apilayer.com/currency_data/convert")!
    }
    
    var path: String{
        switch self {
        case .getQuery(query: let query):
            return "from=\(query)&to=\(query)&amount=\(query)"
        case .getInfo:
            return ""
        case .exchange(remitCountry: let remitCountry, receiptCountry: let receiptCountry, amount: let amount):
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
            return .requestParameters(parameters: [
                "from": remitCountry,
                "to": receiptCountry,
                "amount": amount
            ], encoding: URLEncoding.queryString)
                
        case .getInfo(let quote):
            return .requestParameters(parameters: [
                "quote": quote
            ], encoding: URLEncoding.queryString)
        case .getQuery(query: let query):
            return .requestPlain
        }
    }
    var headers: [String : String]? {
        return [
            "Content-Type": "application/json",
            "apikey": "0QgtcHeJoGSPjH40Z4FDNZ3MqhjuZO8A"
        ]
    }
    
}
