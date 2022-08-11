//
//  TabButtonCollectionViewCell.swift
//  TaiwanArtionApp
//
//  Created by 羅承志 on 2022/8/11.
//

import UIKit
import SnapKit

class TabButtonCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TabButtonCollectionViewCell"
    
    // MARK: - UIs
    let pageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = NSTextAlignment.center
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = .textGrayB0B0B0
        return label
    }()
    
    let currentView: UIView = {
        let view = UIView()
        return view
    }()
    
    //  MARK: - Init
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
                UIView.animate(withDuration: 0.3) {
                    self.currentView.backgroundColor = self.isSelected ? UIColor.brownColor : UIColor.clear
                    self.pageLabel.textColor = self.isSelected ? UIColor.brownColor : UIColor.textGrayB0B0B0
                    self.layoutIfNeeded()
                }
            }
        }
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        addSubview(pageLabel)
        pageLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        addSubview(currentView)
        currentView.snp.makeConstraints { make in
            make.top.equalTo(pageLabel.snp.bottom)
            make.width.equalTo(60)
            make.centerX.equalTo(pageLabel.snp.centerX)
            make.height.equalTo(4)
        }
    }
}
