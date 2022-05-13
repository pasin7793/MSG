
enum Country: String, CaseIterable{
    case krw = "KRW"
    case usd = "USD"
    case jpy = "JPY"
    case php = "php"
}

extension Country{
    var display: String{
        switch self {
        case .krw:
            return "KRW"
        case .usd:
            return "UDS"
        case .jpy:
            return "JPY"
        case .php:
            return "JPY"
        }
    }
}
