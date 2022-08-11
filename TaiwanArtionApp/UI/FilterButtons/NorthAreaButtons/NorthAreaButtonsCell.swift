//
//  NorthAreaButtonsCollectionViewCell.swift
//  TaiwanArtionApp
//
//  Created by 羅承志 on 2022/8/11.
//

import UIKit
import SnapKit

class NorthAreaButtonsCell: UICollectionViewCell {
    
    static let identifier = "NorthAreaCell"
    
    //MARK: - UIs
    private let backView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 5
        return view
    }()

    let areaLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = NSTextAlignment.center
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .gray

        return label
    }()
    
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
//                    self.backView.backgroundColor = self.isSelected ? UIColor.brown : UIColor.systemGray6
                    self.backView.layer.borderWidth = self.isSelected ? 1.5 : 0
                    self.backView.layer.borderColor = self.isSelected ? UIColor.brownColor.cgColor : UIColor.clear.cgColor
                    self.areaLabel.textColor = self.isSelected ? UIColor.brownColor : UIColor.gray
                    self.layoutIfNeeded()
                }
            }
        }
    }
    
    private func setupUI() {
        contentView.backgroundColor = .backgroundColor
        
        contentView.addSubview(backView)
        backView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        backView.addSubview(areaLabel)
        areaLabel.snp.makeConstraints { make in
            make.edges.equalTo(backView.snp.edges)
        }
    }
}
