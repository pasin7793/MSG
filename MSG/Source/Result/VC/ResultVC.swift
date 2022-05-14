
import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Then
import Moya
import ReactorKit
import RxRelay

final class ResultVC: baseVC<ResultReactor>{
    
    //MARK: -Properties

    private let mainLabel = UILabel().then{
        $0.text = "환율 계산"
        $0.font = UIFont(name: "Helvetica-bold", size: 28)
        $0.textColor = .black
    }
    private var data: ExchangeRateItem!
    private let viewModel = ViewModel()
    private let bottomMargin: Int = 32
    private let rightMargin: Int = -80
    
    private let bounds = UIScreen.main.bounds
    private let remitCountryLabel = UILabel().then{
        $0.text = "송금 국가 :"
        $0.font = UIFont(name: "SFPro-Regular", size: 16)
        $0.textColor = .black
        $0.textAlignment = .right
    }
    
    private let receiptCountryLabel = UILabel().then{
        $0.text = "수취 국가 :"
        $0.font = UIFont(name: "SFPro-Regular", size: 16)
        $0.textColor = .black
        $0.textAlignment = .right
    }
    let provider = MoyaProvider<ExchangeRateAPI>()
    
    override func setUp() {
        view.backgroundColor = .white
    }
    override func addView(){
        [mainLabel,receiptCountryLabel,remitCountryLabel].forEach{ view.addSubview($0)
        }
    }
    override func setLayout() {
        mainLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(112)
        }
        remitCountryLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(50)
            make.top.equalTo(mainLabel.snp.bottom).offset(40)
        }
        receiptCountryLabel.snp.makeConstraints { make in
            make.top.equalTo(remitCountryLabel.snp.bottom).offset(bottomMargin)
            make.leading.equalTo(remitCountryLabel)
        }
    }
}
