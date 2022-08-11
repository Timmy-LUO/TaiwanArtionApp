//
//  SearchRecordTableViewCell.swift
//  TaiwanArtionApp
//
//  Created by 羅承志 on 2022/8/11.
//

import UIKit
import SnapKit

class SearchRecordTableViewCell: UITableViewCell {

    static let identifier = "SearchRecordTableViewCell"
    
    // MARK: - UIs
    let recordLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .textBlack636363
        return label
    }()
    
    private let shareButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        button.tintColor = .whetherStartBorderGray
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        contentView.addSubview(recordLabel)
        recordLabel.snp.makeConstraints { make in
            make.top.equalTo(21)
            make.bottom.equalTo(-5)
            make.leading.equalTo(16)
        }
        
        contentView.addSubview(shareButton)
        shareButton.snp.makeConstraints { make in
            make.width.height.equalTo(18)
            make.trailing.equalTo(-16)
            make.centerY.equalTo(recordLabel.snp.centerY)
        }
    }
}
