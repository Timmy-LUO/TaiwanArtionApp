//
//  FilterExhibitionButtonCell.swift
//  TaiwanArtionApp
//
//  Created by 羅承志 on 2022/8/11.
//

import UIKit
import SnapKit

class FilterExhibitionButtonsCell: UICollectionViewCell {
    
    static let identifier = "FilterButtonCollectionViewCell"
    
    //MARK: - UIs
    private let backView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 5
        return view
    }()
    
    let rangeLabel: UILabel = {
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
                    self.backView.backgroundColor = self.isSelected ? UIColor.brown : UIColor.systemGray6
                    self.rangeLabel.textColor = self.isSelected ? UIColor.white : UIColor.gray
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
        
        backView.addSubview(rangeLabel)
        rangeLabel.snp.makeConstraints { make in
            make.edges.equalTo(backView.snp.edges)
        }
    }
}
