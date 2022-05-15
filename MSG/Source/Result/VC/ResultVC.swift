
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
    private var query: Query? = nil
    private var info: Info? = nil
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
    
    private let remitCountryValueLabel = UITextField().then{
        $0.text = "ASd"
        $0.font = UIFont(name: "SFPro-Regular", size: 16)
        $0.textColor = .black
        $0.textAlignment = .right
    }
    private let receiptCountryValueLabel = UITextField().then{
        $0.text = "asd"
        $0.font = UIFont(name: "SFPro-Regular", size: 16)
        $0.textColor = .black
        $0.textAlignment = .right
    }
    private let resultLabel = UILabel().then{
        $0.text = "수취금액은 1원입니다."
        $0.font = UIFont(name: "Inter-Regular", size: 24)
        $0.textColor = .black
        $0.textAlignment = .right
    }
    
    override func setUp() {
        view.backgroundColor = .white
        remitCountryValueLabel.text = query?.from
        receiptCountryValueLabel.text = query?.to
        resultLabel.text = "수취금액은 \(String(info?.quote ?? 0))원 입니다"
    }
    override func addView(){
        [mainLabel,receiptCountryLabel,remitCountryLabel,remitCountryValueLabel,receiptCountryValueLabel,resultLabel].forEach{ view.addSubview($0)
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
        remitCountryValueLabel.snp.makeConstraints { make in
            make.top.equalTo(remitCountryLabel)
            make.trailing.equalToSuperview().offset(rightMargin)
        }
        receiptCountryValueLabel.snp.makeConstraints { make in
            make.top.equalTo(receiptCountryLabel)
            make.trailing.equalToSuperview().offset(rightMargin)
        }
        resultLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(receiptCountryValueLabel.snp.bottom).offset(bottomMargin*3)
        }
    }
}
