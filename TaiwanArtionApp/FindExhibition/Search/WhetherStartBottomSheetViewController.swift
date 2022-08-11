//
//  WhetherStartBottomSheetViewController.swift
//  TaiwanArtionApp
//
//  Created by 羅承志 on 2022/8/11.
//

import UIKit
import SnapKit

class WhetherStartBottomSheetViewController: UIViewController {
    
    // MARK: - UIs
    private let rectanglesView: UIView = {
        let view = UIView()
        view.backgroundColor = .textGrayB0B0B0
        view.layer.cornerRadius = 3
        return view
    }()
    
    private let whetherStartTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "是否開展"
        label.textColor = .textBlack464646
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let noneButton: UIButton = {
        let button = UIButton()
        button.setTitle("不限", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.setTitleColor(UIColor.textBlack464646, for: .normal)
        return button
    }()
    
    private let alreadyButton: UIButton = {
        let button = UIButton()
        button.setTitle("已經開展", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.setTitleColor(UIColor.textBlack464646, for: .normal)

        return button
    }()
    
    private let notYetButton: UIButton = {
        let button = UIButton()
        button.setTitle("還沒開展", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.setTitleColor(UIColor.textBlack464646, for: .normal)
        return button
    }()
    
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        view.backgroundColor = .backgroundColor
        
        view.addSubview(rectanglesView)
        rectanglesView.snp.makeConstraints { make in
            make.height.equalTo(5)
            make.width.equalTo(40)
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(4)
        }
        
        view.addSubview(whetherStartTitleLabel)
        whetherStartTitleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(rectanglesView.snp.bottom).offset(26)
        }
        
        view.addSubview(noneButton)
        noneButton.snp.makeConstraints { make in
            make.height.equalTo(43)
            make.top.equalTo(whetherStartTitleLabel.snp.bottom).offset(26)
            make.leading.trailing.equalTo(0)
            
        }
        
        view.addSubview(alreadyButton)
        alreadyButton.snp.makeConstraints { make in
            make.height.equalTo(43)
            make.top.equalTo(noneButton.snp.bottom).offset(20)
            make.leading.trailing.equalTo(0)
        }
        
        view.addSubview(notYetButton)
        notYetButton.snp.makeConstraints { make in
            make.height.equalTo(43)
            make.top.equalTo(alreadyButton.snp.bottom).offset(20)
            make.leading.trailing.equalTo(0)
        }
    }
}
