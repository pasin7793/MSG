
public enum Country: String, CaseIterable{
    case KRW = "KRW"
    case USD = "USD"
    case JPY = "JPY"
    case PHP = "PHP"
}

public extension Country{
    var display: String{
        switch self {
        case .KRW:
            return "KRW"
        case .USD:
            return "USD"
        case .JPY:
            return "JPY"
        case .PHP:
            return "PHP"
        }
    }
}
