//
//  FindExhibitionTableView.swift
//  TaiwanArtionApp
//
//  Created by 羅承志 on 2022/8/11.
//

import UIKit

class FindExhibitionTableView: UITableView {
    
    // MARK: - Properties
    weak var buttonDelegate: TableViewCellDelegate?
    weak var cellDelegate: SearchResultCellDelegate?
    
    weak var viewModel: FindExhibitionViewModelType?
    
    private var scrollPhotoList = [ScrollPhoto]()
    private var cellInfo = [AllCategories]()
    
    // MARK: - Init
    convenience init() {
        self.init(frame: .zero, style: .plain)
        register(ScrollPhotoTableViewCell.self, forCellReuseIdentifier: ScrollPhotoTableViewCell.identifier)
        register(FilterTableViewCell.self, forCellReuseIdentifier: FilterTableViewCell.identifier)
        register(FindExhibitionTableViewCell.self, forCellReuseIdentifier: FindExhibitionTableViewCell.identifier)
        backgroundColor = .backgroundColor
        separatorStyle = .none
        separatorColor = .clear
        allowsSelection = false
        dataSource = self
        delegate = self
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setScrollPhoto(list: [ScrollPhoto]) {
        scrollPhotoList = list
        reloadData()
    }
    
    func setCellInfo(list: [AllCategories]) {
        cellInfo = list
        reloadData()
    }
}

// MARK: - TableView DataSource
extension FindExhibitionTableView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 || section == 1 {
            return 1
        } else {
            return cellInfo.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ScrollPhotoTableViewCell.identifier, for: indexPath) as! ScrollPhotoTableViewCell
            cell.bind(data: scrollPhotoList)
            
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: FilterTableViewCell.identifier, for: indexPath) as! FilterTableViewCell
            cell.buttonDelegate = buttonDelegate
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: FindExhibitionTableViewCell.identifier, for: indexPath) as! FindExhibitionTableViewCell
            cell.cellDelegate = cellDelegate
            cell.bind(data: cellInfo[indexPath.row])
            return cell
        }
    }
}

// MARK: - TableView Delegate
extension FindExhibitionTableView: UITableViewDelegate {
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.section == 0 {
//            return UITableView.automaticDimension
//        } else if indexPath.section == 1 {
//            return UITableView.automaticDimension
//        } else {
//            return UITableView.automaticDimension
//        }
//    }
}
