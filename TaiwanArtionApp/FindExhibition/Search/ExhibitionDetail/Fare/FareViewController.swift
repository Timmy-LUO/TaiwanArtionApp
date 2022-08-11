//
//  FareViewController.swift
//  TaiwanArtionApp
//
//  Created by 羅承志 on 2022/8/11.
//

import UIKit
import SnapKit

class FareViewController: UIViewController {
    
    //MARK: - UIs
    private let buyTicketMethodLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 12)
        label.textColor = .textGrayB0B0B0
        label.text = "購票方式"
        return label
    }()
    
    private let showBuyTicketMethodLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = .textBlack636363
        label.text = "KKTIX及全台全家便利商店"
        return label
    }()
    
    private let buyTicketInfoLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 12)
        label.textColor = .textGrayB0B0B0
        label.text = "購票資訊"
        return label
    }()
    
    private let showBuyTicketInfoLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = .textBlack636363
        label.text = "全票380元／優待票350元／愛心票190元"
        return label
    }()
        
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        view.tag = 1
        view.backgroundColor = .backgroundColor
        
        view.addSubview(buyTicketMethodLabel)
        buyTicketMethodLabel.snp.makeConstraints { make in
            make.top.equalTo(24)
            make.leading.equalTo(16)
        }
        
        view.addSubview(showBuyTicketMethodLabel)
        showBuyTicketMethodLabel.snp.makeConstraints { make in
            make.top.equalTo(buyTicketMethodLabel.snp.bottom).offset(16)
            make.leading.equalTo(16)
        }
        
        view.addSubview(buyTicketInfoLabel)
        buyTicketInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(showBuyTicketMethodLabel.snp.bottom).offset(24)
            make.leading.equalTo(16)
        }
        
        view.addSubview(showBuyTicketInfoLabel)
        showBuyTicketInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(buyTicketInfoLabel.snp.bottom).offset(16)
            make.leading.equalTo(16)
        }
        
        
    }
}
