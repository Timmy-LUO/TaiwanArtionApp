//
//  WhetherStartExhibitionButton.swift
//  TaiwanArtionApp
//
//  Created by 羅承志 on 2022/8/11.
//

import UIKit
import SnapKit

class WhetherStartExhibitionButton: UIView {
    
    convenience init() {
        self.init(frame: .zero)
        backgroundColor = .backgroundColor
        layer.borderWidth = 1
        layer.borderColor = UIColor.whetherStartBorderGray.cgColor
        layer.cornerRadius = 7
        setupUI()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UIs
    private let whetherStartLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 13)
        label.textColor = .textGrayB0B0B0
        label.text = "是否開展"
        return label
    }()
    
    let arrowImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "chevron.down")) //chevron.up
        imageView.tintColor = .systemGray3
        return imageView
    }()
    
    //MARK: - Setup UI
    private func setupUI() {
        addSubview(whetherStartLabel)
        whetherStartLabel.snp.makeConstraints { make in
            make.leading.equalTo(4)
            make.centerY.equalTo(self.snp.centerY)
        }
        
        addSubview(arrowImageView)
        arrowImageView.snp.makeConstraints { make in
            make.leading.equalTo(whetherStartLabel.snp.trailing).offset(2)
            make.centerY.equalTo(self.snp.centerY)
        }
    }
}
