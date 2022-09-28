//
//  DateViewController.swift
//  TaiwanArtionApp
//
//  Created by 羅承志 on 2022/8/11.
//

import UIKit
import SnapKit
import JTAppleCalendar

class DateViewController: UIViewController {
    
    // MARK: - UIs
    private let monthCollectionView = MonthCollectionView()
    private let calendarView = CalendarView()
    
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
    }
    
    @objc
    private func confirm() {
        let vc = SearchResultViewController(viewModel: FindExhibitionViewModel())
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        view.tag = 2
        view.backgroundColor = .systemGray6
        
        view.addSubview(monthCollectionView)
        monthCollectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
            make.leading.equalTo(10)
            make.trailing.equalTo(-10)
            make.height.equalTo(70)
        }
        
        view.addSubview(calendarView)
        calendarView.snp.makeConstraints { make in
            make.top.equalTo(monthCollectionView.snp.bottom).offset(24)
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.height.equalTo(310)
        }
        
        view.addSubview(confirmButton)
        confirmButton.snp.makeConstraints { make in
            make.top.equalTo(calendarView.snp.bottom).offset(24)
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.height.equalTo(35)
        }
    }
    
    // MARK: - Methods
    
    
    
}
