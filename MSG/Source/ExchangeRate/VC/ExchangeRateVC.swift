//
//  ExchangeRateVC.swift
//  MSG_Test
//
//  Created by 임준화 on 2022/05/13.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Then
import Moya
import ReactorKit
import RxRelay

final class ExchangeRateVC: baseVC<ExchangeRateReactor>,UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource{
    
    //MARK: -Properties
    
    var exchangeRate: [ExchangeRateItem]?
    private let mainLabel = UILabel().then{
        $0.text = "환율 계산"
        $0.font = UIFont(name: "Helvetica-bold", size: 28)
        $0.textColor = .black
    }
    private let bottomMargin: Int = 32
    private let rightMargin: Int = -80
    
    private let bounds = UIScreen.main.bounds
    
    private let pickerView = UIPickerView()
    private var pickerData = ["\(Country.USD)","\(Country.KRW)","\(Country.JPY)","\(Country.PHP)"]
    
    private let toolBar = UIToolbar()
    private let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(DoneButton(_:)))
    
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
    
    private let exchangeRateLabel = UILabel().then{
        $0.text = "환율 :"
        $0.font = UIFont(name: "SFPro-Regular", size: 16)
        $0.textColor = .black
        $0.textAlignment = .right
    }
    
    private let timeLabel = UILabel().then{
        $0.text = "조회 시간 :"
        $0.font = UIFont(name: "SFPro-Regular", size: 16)
        $0.textColor = .black
        $0.textAlignment = .right
    }
    
    private let costLabel = UILabel().then{
        $0.text = "송금액 :"
        $0.font = UIFont(name: "SFPro-Regular", size: 16)
        $0.textColor = .black
        $0.textAlignment = .right
    }
    
    private let remitCountryValue = UITextField().then{
        
        $0.font = UIFont(name: "SFPro-Regular", size: 16)
        $0.textColor = .black
        $0.textAlignment = .right
    }
    
    private let receiptCountryValue = UITextField().then{
        $0.font = UIFont(name: "SFPro-Regular", size: 16)
        $0.textColor = .black
        $0.textAlignment = .right
    }
    
    private let exchangeRateValueLabel = UILabel().then{
        $0.font = UIFont(name: "SFPro-Regular", size: 16)
        $0.textColor = .black
        $0.textAlignment = .right
    }
    
    private let timeValueLabel = UILabel().then{
        $0.text = "123"
        $0.font = UIFont(name: "SFPro-Regular", size: 16)
        $0.textColor = .black
        $0.textAlignment = .right
    }
    let timeInterval = NSDate().timeIntervalSince1970
    
    private let costValueUnit = UILabel().then{
        
        $0.font = UIFont(name: "SFPro-Regular", size: 16)
        $0.textColor = .black
        $0.textAlignment = .right
    }
    private let costValueTextField = UITextField().then{
        $0.text = "0"
        $0.font = UIFont(name: "SFPro-Regular", size: 16)
        $0.textColor = .black
        $0.textAlignment = .center
    }
    
    private let exchangeRateButton = UIButton().then{
        $0.setTitle("환율 계산", for: .normal)
        $0.layer.backgroundColor = UIColor(red: 0, green: 0.478, blue: 1, alpha: 1).cgColor
        $0.layer.cornerRadius = 10
        $0.setTitleColor(UIColor.white, for: .normal)
    }
    override func setUp() {
        pickerView.delegate = self
        pickerView.dataSource = self
        
        remitCountryValue.delegate = self
        remitCountryValue.inputView = pickerView
        remitCountryValue.inputAccessoryView = toolBar
        
        receiptCountryValue.delegate = self
        receiptCountryValue.inputView = pickerView
        receiptCountryValue.inputAccessoryView = toolBar
        
        toolBar.sizeToFit()
        toolBar.setItems([doneButton], animated: true)
    }
    override func addView(){
        [mainLabel,remitCountryLabel,remitCountryValue,receiptCountryLabel,receiptCountryValue,exchangeRateLabel,exchangeRateValueLabel,timeLabel,timeValueLabel,costLabel,costValueTextField,costValueUnit,exchangeRateButton].forEach{ view.addSubview($0)
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
        exchangeRateLabel.snp.makeConstraints { make in
            make.top.equalTo(receiptCountryLabel.snp.bottom).offset(bottomMargin)
            make.leading.equalTo(remitCountryLabel)
            make.width.equalTo(remitCountryLabel)
        }
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(exchangeRateLabel.snp.bottom).offset(bottomMargin)
            make.leading.equalTo(remitCountryLabel)
        }
        costLabel.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom).offset(bottomMargin)
            make.leading.equalTo(remitCountryLabel)
            make.width.equalTo(remitCountryLabel)
        }
        exchangeRateButton.snp.makeConstraints { make in
            make.top.equalTo(costLabel.snp.bottom).offset(bounds.height*0.4)
            make.width.equalTo(197)
            make.height.equalTo(49)
            make.centerX.equalToSuperview()
        }
        remitCountryValue.snp.makeConstraints { make in
            make.top.equalTo(remitCountryLabel)
            make.trailing.equalToSuperview().offset(rightMargin)
        }
        receiptCountryValue.snp.makeConstraints { make in
            make.top.equalTo(receiptCountryLabel)
            make.trailing.equalToSuperview().offset(rightMargin)
        }
        exchangeRateValueLabel.snp.makeConstraints { make in
            make.top.equalTo(exchangeRateLabel)
            make.trailing.equalToSuperview().offset(rightMargin)
        }
        timeValueLabel.snp.makeConstraints { make in
            make.top.equalTo(timeLabel)
            make.trailing.equalToSuperview().offset(rightMargin)
        }
        costValueTextField.snp.makeConstraints { make in
            make.top.equalTo(costLabel)
            make.centerX.equalToSuperview()
            make.width.equalTo(135)
        }
        costValueUnit.snp.makeConstraints { make in
            make.top.equalTo(costValueTextField)
            make.trailing.equalToSuperview().offset(rightMargin)
        }
    }
    //MARK: - Reactor
    override func bindView(reactor: ExchangeRateReactor) {
        
        UserDefaults.standard.rx.observe(String.self, UserDefaultsLocal.forKeys.remitCountry)
            .compactMap{ $0 }
            .map { Country(rawValue: $0) ?? .USD}
            .map (Reactor.Action.updateRemitCountry)
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        UserDefaults.standard.rx.observe(String.self, UserDefaultsLocal.forKeys.receiptCountry)
            .compactMap{ $0 }
            .map { Country(rawValue: $0) ?? .USD}
            .map (Reactor.Action.updateReceiptCountry)
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
    }
    override func bindAction(reactor: ExchangeRateReactor) {
        exchangeRateButton.rx.tap
            .map{ Reactor.Action.exchangeRateButtonDidTap}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        remitCountryValue.rx.controlEvent(.editingDidEnd)
            .withUnretained(self)
            .subscribe(onNext: { text in
                self.costValueUnit.text = "\(self.remitCountryValue.text!)"
            }).disposed(by: disposeBag)
    }
    override func bindState(reactor: ExchangeRateReactor) {
        let sharedState = reactor.state.share(replay: 1).observe(on: MainScheduler.asyncInstance)
        
       
    }
    func bind(_ model: Query) {
        remitCountryValue.text = model.from
        receiptCountryValue.text = model.to
        
    }
    //MARK: -Action
    @objc func DoneButton(_ sender: Any){
        self.view.endEditing(true)
        
    }
}

extension ExchangeRateVC{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }


    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if remitCountryValue.isFirstResponder{
            return pickerData.count
        }
        else if receiptCountryValue.isFirstResponder{
            return pickerData.count
        }
        return 0
    }


    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if remitCountryValue.isFirstResponder{
            return pickerData[row]
        }
        else if receiptCountryValue.isFirstResponder{
            return pickerData[row]
        }
        return nil
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if remitCountryValue.isFirstResponder{
            let itemSelected = pickerData[row]
            remitCountryValue.text = itemSelected
        }
        if receiptCountryValue.isFirstResponder{
            let itemSelected = pickerData[row]
            receiptCountryValue.text = itemSelected
        }
    }
}
