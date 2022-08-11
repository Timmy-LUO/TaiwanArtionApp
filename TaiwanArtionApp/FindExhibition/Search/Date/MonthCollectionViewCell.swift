//
//  MonthCollectionViewCell.swift
//  TaiwanArtionApp
//
//  Created by 羅承志 on 2022/8/11.
//

import UIKit
import SnapKit

class MonthCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MonthCell"
    
    // MARK: - UIs
    let englishMonthLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        return label
    }()
    
    let chineseMonthLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let chineseMonthView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.backgroundColor = .backgroundColor
        return view
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool {
        didSet {
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.1) {
                    self.englishMonthLabel.textColor = self.isSelected ? UIColor.brownColor : UIColor.black
                    self.chineseMonthLabel.textColor = self.isSelected ? UIColor.brownColor : UIColor.black
                    self.chineseMonthView.layer.borderWidth = self.isSelected ? 1 : 0
                    self.chineseMonthView.layer.borderColor = self.isSelected ? UIColor.brownColor.cgColor : UIColor.clear.cgColor
                    self.layoutIfNeeded()
                }
            }
        }
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        addSubview(englishMonthLabel)
        englishMonthLabel.snp.makeConstraints { make in
            make.top.equalTo(5)
            make.centerX.equalTo(self.snp.centerX)
        }
        
        addSubview(chineseMonthView)
        chineseMonthView.snp.makeConstraints { make in
            make.top.equalTo(englishMonthLabel.snp.bottom).offset(5)
            make.leading.equalTo(5)
            make.trailing.equalTo(-5)
            make.height.equalTo(35)
        }
        
        chineseMonthView.addSubview(chineseMonthLabel)
        chineseMonthLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
}
