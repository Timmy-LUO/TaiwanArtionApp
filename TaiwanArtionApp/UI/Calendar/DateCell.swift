//
//  DateCell.swift
//  TaiwanArtionApp
//
//  Created by 羅承志 on 2022/8/11.
//

import UIKit
import SnapKit
import JTAppleCalendar

class DateCell: JTACDayCell {
    
    static let identifier = "DateCell"
    
    let dateLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let selectedView: UIView = {
        let view = UIView()
        view.backgroundColor = .brownColor
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(selectedView)
        selectedView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
}
