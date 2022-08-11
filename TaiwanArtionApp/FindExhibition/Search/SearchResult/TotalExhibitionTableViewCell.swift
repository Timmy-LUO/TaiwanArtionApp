//
//  TotalExhibitionTableViewCell.swift
//  TaiwanArtionApp
//
//  Created by 羅承志 on 2022/8/11.
//

import UIKit

import UIKit
import SnapKit

class TotalExhibitionTableViewCell: UITableViewCell {

    static let identifier = "TotalExhibitionCell"
    
    // MARK: - UIs
    private let totalExhibitionLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .textGrayB0B0B0
        label.text = "共 500 件展覽"
        return label
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        selectionStyle = .none
        
        contentView.addSubview(totalExhibitionLabel)
        totalExhibitionLabel.snp.makeConstraints { make in
//            make.centerY.equalTo(self.snp.centerY)
            make.top.equalTo(24)
            make.bottom.equalTo(-16)
            make.leading.equalTo(16)
            make.height.equalTo(20)
        }
    }
}
