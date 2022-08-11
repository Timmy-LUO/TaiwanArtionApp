//
//  InfoViewController.swift
//  TaiwanArtionApp
//
//  Created by 羅承志 on 2022/8/11.
//

import UIKit
import SnapKit

class InfoViewController: UIViewController {
    
    // MARK: - UIs
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 12)
        label.textColor = .textGrayB0B0B0
        label.text = "展覽日期"
        return label
    }()
    
    private let showDateLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = .textBlack636363
        label.text = "2022/01/22 ~ 05/02"
        return label
    }()
    
    private let addressLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 12)
        label.textColor = .textGrayB0B0B0
        label.text = "地址"
        return label
    }()
    
    private let showAddressLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = .textBlack636363
        label.text = "臺中市40453 臺中市北區館前路一號"
        return label
    }()
    
    private let showLocationNameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = .textBlack636363
        label.text = "人類文化廳二樓"
        return label
    }()
    
    private let officialWebsiteLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 12)
        label.textColor = .textGrayB0B0B0
        label.text = "官網"
        return label
    }()
    
    private let showOfficialWebsiteLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 12)
        label.textColor = .textBlack636363
        label.text = "http://www.xxxxxxx.edu.tw/ch/visit/price.htm"
        return label
    }()
    
    

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        view.tag = 0
        view.backgroundColor = .backgroundColor
        
        view.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(24)
            make.leading.equalTo(16)
        }
        
        view.addSubview(showDateLabel)
        showDateLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(16)
            make.leading.equalTo(16)
        }
        
        view.addSubview(addressLabel)
        addressLabel.snp.makeConstraints { make in
            make.top.equalTo(showDateLabel.snp.bottom).offset(24)
            make.leading.equalTo(16)
        }
        
        view.addSubview(showAddressLabel)
        showAddressLabel.snp.makeConstraints { make in
            make.top.equalTo(addressLabel.snp.bottom).offset(16)
            make.leading.equalTo(16)
        }
        
        view.addSubview(officialWebsiteLabel)
        officialWebsiteLabel.snp.makeConstraints { make in
            make.top.equalTo(showAddressLabel.snp.bottom).offset(24)
            make.leading.equalTo(16)
        }
        
        view.addSubview(showOfficialWebsiteLabel)
        showOfficialWebsiteLabel.snp.makeConstraints { make in
            make.top.equalTo(officialWebsiteLabel.snp.bottom).offset(8)
            make.leading.equalTo(16)
        }
    }
}
