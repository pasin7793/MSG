
import RxFlow

enum TestStep: Step{
    
    case alert(title: String?, message: String?)
    case dismiss
    
    case exchangeRateIsRequired
    case countryIsRequired
}
