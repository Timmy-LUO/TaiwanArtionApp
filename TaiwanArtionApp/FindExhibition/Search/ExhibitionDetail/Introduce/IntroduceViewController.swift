//
//  IntroduceViewController.swift
//  TaiwanArtionApp
//
//  Created by 羅承志 on 2022/8/11.
//

import UIKit

import UIKit
import SnapKit

class IntroduceViewController: UIViewController {
    
    //MARK: - UIs
    private let introduceLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 12)
        label.textColor = .textGrayB0B0B0
        label.text = "展覽介紹"
        return label
    }()
    
    private let introduceTextView: UITextView = {
        let textView = UITextView()
        textView.font = .boldSystemFont(ofSize: 14)
        textView.textColor = .textBlack636363
        textView.isEditable = false
        textView.text = "Test"
        return textView
    }()
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        view.tag = 2
        view.backgroundColor = .backgroundColor
        
        view.addSubview(introduceLabel)
        introduceLabel.snp.makeConstraints { make in
            make.top.equalTo(24)
            make.leading.equalTo(16)
        }
        
        view.addSubview(introduceTextView)
        introduceTextView.snp.makeConstraints { make in
            make.top.equalTo(introduceLabel.snp.bottom).offset(16)
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.height.equalTo(300)
        }
    }
}
