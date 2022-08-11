//
//  AreaViewController.swift
//  TaiwanArtionApp
//
//  Created by 羅承志 on 2022/8/11.
//

import UIKit
import SnapKit

class AreaViewController: UIViewController {
    
    // MARK: - UIs
    private let areaScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = true
        scrollView.scrollsToTop = true
        scrollView.bounces = true
        scrollView.isPagingEnabled = false
        scrollView.isScrollEnabled = true
        return scrollView
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let currentMarkButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Vector"), for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.brown.cgColor
        button.layer.cornerRadius = 5
        return button
    }()
    
    private let currentTextButton: UIButton = {
        let button = UIButton()
        button.setTitle("目前所在位置", for: .normal)
        button.setTitleColor(UIColor.brown, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18)
        return button
    }()
    
    private let unlimitedMarkButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Vector"), for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.brown.cgColor
        button.layer.cornerRadius = 5
        return button
    }()
    
    private let unlimitedTextButton: UIButton = {
        let button = UIButton()
        button.setTitle("不限區域", for: .normal)
        button.setTitleColor(UIColor.brown, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18)
        return button
    }()
    
    
    private let northAreaButtons = NorthAreaButtons()
    private let northAreaLabel: UILabel = {
        let label = UILabel()
        label.text = "北部地區"
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    private let northSelectAllButton: UIButton = {
        let button = UIButton()
        button.setTitle("全選", for: .normal)
        button.setTitleColor(.brown, for: .normal)
        return button
    }()
    
    
    private let middleAreaButtons = MiddleAreaButtons()
    private let middleAreaLabel: UILabel = {
        let label = UILabel()
        label.text = "中部地區"
        label.font = .boldSystemFont(ofSize: 17)
        label.textColor = .black
        return label
    }()
    
    private let middleSelectAllButton: UIButton = {
        let button = UIButton()
        button.setTitle("全選", for: .normal)
        button.setTitleColor(.brown, for: .normal)
        return button
    }()
    
    
    private let southAreaButtons = SouthAreaButtons()
    private let southAreaLabel: UILabel = {
        let label = UILabel()
        label.text = "南部地區"
        label.font = .boldSystemFont(ofSize: 17)
        label.textColor = .black
        return label
    }()
    
    private let southSelectAllButton: UIButton = {
        let button = UIButton()
        button.setTitle("全選", for: .normal)
        button.setTitleColor(.brown, for: .normal)
        return button
    }()
    
    
    private let eastAreaButtons = EastAreaButtons()
    private let eastAreaLabel: UILabel = {
        let label = UILabel()
        label.text = "東部地區"
        label.font = .boldSystemFont(ofSize: 17)
        label.textColor = .black
        return label
    }()
    
    private let eastSelectAllButton: UIButton = {
        let button = UIButton()
        button.setTitle("全選", for: .normal)
        button.setTitleColor(.brown, for: .normal)
        return button
    }()
    
    
    private let outerIslandAreaButtons = OuterIslandAreaButtons()
    private let outerIslandAreaLabel: UILabel = {
        let label = UILabel()
        label.text = "離島地區"
        label.font = .boldSystemFont(ofSize: 17)
        label.textColor = .black
        return label
    }()
    
    private let outerIslandSelectAllButton: UIButton = {
        let button = UIButton()
        button.setTitle("全選", for: .normal)
        button.setTitleColor(.brown, for: .normal)
        return button
    }()
    
    private let confirmButton: UIButton = {
        let button = UIButton()
        button.setTitle("確定", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = .brownColor
        button.layer.cornerRadius = 10
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        confirmButton.addTarget(self, action: #selector(confirm), for: .touchUpInside)
        
//        areaScrollView.contentInsetAdjustmentBehavior = .never
        areaScrollView.delegate = self
    }
    
    @objc
    private func confirm() {
        let vc = SearchResultViewController(viewModel: SearchResultViewModel())
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        view.tag = 0
        view.backgroundColor = .backgroundColor
        
        view.addSubview(areaScrollView)
        areaScrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        areaScrollView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(areaScrollView)
//            make.bottom.equalTo(areaScrollView.snp.bottom)
            make.width.equalToSuperview()
            make.height.equalTo(800)
        }
        
        containerView.addSubview(currentMarkButton)
        currentMarkButton.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).offset(24)
            make.leading.equalTo(16)
            make.height.width.equalTo(44)
        }
        
        containerView.addSubview(currentTextButton)
        currentTextButton.snp.makeConstraints { make in
            make.centerY.equalTo(currentMarkButton.snp.centerY)
            make.leading.equalTo(currentMarkButton.snp.trailing).offset(8)
        }
        
        containerView.addSubview(unlimitedMarkButton)
        unlimitedMarkButton.snp.makeConstraints { make in
            make.top.equalTo(currentMarkButton.snp.bottom).offset(16)
            make.leading.equalTo(16)
            make.height.width.equalTo(44)
        }
        
        containerView.addSubview(unlimitedTextButton)
        unlimitedTextButton.snp.makeConstraints { make in
            make.centerY.equalTo(unlimitedMarkButton.snp.centerY)
            make.leading.equalTo(unlimitedMarkButton.snp.trailing).offset(8)
        }
        
        containerView.addSubview(northAreaLabel)
        northAreaLabel.snp.makeConstraints { make in
            make.top.equalTo(unlimitedMarkButton.snp.bottom).offset(27)
            make.leading.equalTo(16)
        }
        
        containerView.addSubview(northSelectAllButton)
        northSelectAllButton.snp.makeConstraints { make in
            make.centerY.equalTo(northAreaLabel.snp.centerY)
            make.trailing.equalTo(-26)
        }
        
        containerView.addSubview(northAreaButtons)
        northAreaButtons.snp.makeConstraints { make in
            make.top.equalTo(northAreaLabel.snp.bottom).offset(16)
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.height.equalTo(55)
        }
        
        containerView.addSubview(middleAreaLabel)
        middleAreaLabel.snp.makeConstraints { make in
            make.top.equalTo(northAreaButtons.snp.bottom).offset(27)
            make.leading.equalTo(16)
        }
        
        containerView.addSubview(middleSelectAllButton)
        middleSelectAllButton.snp.makeConstraints { make in
            make.centerY.equalTo(middleAreaLabel.snp.centerY)
            make.trailing.equalTo(-26)
        }
        
        containerView.addSubview(middleAreaButtons)
        middleAreaButtons.snp.makeConstraints { make in
            make.top.equalTo(middleAreaLabel.snp.bottom).offset(16)
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.height.equalTo(55)
        }
        
        containerView.addSubview(southAreaLabel)
        southAreaLabel.snp.makeConstraints { make in
            make.top.equalTo(middleAreaButtons.snp.bottom).offset(27)
            make.leading.equalTo(16)
        }
        
        containerView.addSubview(southSelectAllButton)
        southSelectAllButton.snp.makeConstraints { make in
            make.centerY.equalTo(southAreaLabel.snp.centerY)
            make.trailing.equalTo(-26)
        }
        
        containerView.addSubview(southAreaButtons)
        southAreaButtons.snp.makeConstraints { make in
            make.top.equalTo(southAreaLabel.snp.bottom).offset(16)
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.height.equalTo(25)
        }
        
        containerView.addSubview(eastAreaLabel)
        eastAreaLabel.snp.makeConstraints { make in
            make.top.equalTo(southAreaButtons.snp.bottom).offset(27)
            make.leading.equalTo(16)
        }
        
        containerView.addSubview(eastSelectAllButton)
        eastSelectAllButton.snp.makeConstraints { make in
            make.centerY.equalTo(eastAreaLabel.snp.centerY)
            make.trailing.equalTo(-26)
        }
        
        containerView.addSubview(eastAreaButtons)
        eastAreaButtons.snp.makeConstraints { make in
            make.top.equalTo(eastAreaLabel.snp.bottom).offset(16)
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.height.equalTo(25)
        }
        
        containerView.addSubview(outerIslandAreaLabel)
        outerIslandAreaLabel.snp.makeConstraints { make in
            make.top.equalTo(eastAreaButtons.snp.bottom).offset(27)
            make.leading.equalTo(16)
        }
        
        containerView.addSubview(outerIslandSelectAllButton)
        outerIslandSelectAllButton.snp.makeConstraints { make in
            make.centerY.equalTo(outerIslandAreaLabel.snp.centerY)
            make.trailing.equalTo(-26)
        }
        
        containerView.addSubview(outerIslandAreaButtons)
        outerIslandAreaButtons.snp.makeConstraints { make in
            make.top.equalTo(outerIslandAreaLabel.snp.bottom).offset(16)
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.height.equalTo(55)
        }
        
        containerView.addSubview(confirmButton)
        confirmButton.snp.makeConstraints { make in
            make.top.equalTo(outerIslandAreaButtons.snp.bottom).offset(29)
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.height.equalTo(36)
        }
    }
}

extension AreaViewController: UIScrollViewDelegate {
    
}
