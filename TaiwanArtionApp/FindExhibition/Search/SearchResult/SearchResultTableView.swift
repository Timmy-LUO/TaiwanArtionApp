//
//  SearchResultTableView.swift
//  TaiwanArtionApp
//
//  Created by 羅承志 on 2022/8/11.
//

import UIKit

protocol SearchResultCellDelegate: AnyObject {
    func pushToExhibitionDetail(category: AllCategories)
}

class SearchResultTableView: UITableView {
    
    // MARK: - Properties
    var cellInfo = [AllCategories]()
    weak var cellDelegate: SearchResultCellDelegate?
    
    
    // MARK: - Init
    convenience init() {
        self.init(frame: .zero, style: .plain)
        register(TotalExhibitionTableViewCell.self, forCellReuseIdentifier: TotalExhibitionTableViewCell.identifier)
        register(SearchResultListTableViewCell.self, forCellReuseIdentifier: SearchResultListTableViewCell.identifier)
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
    
    // MARK: - Set CellInfo
    func setCellInfo(list: [AllCategories]) {
        cellInfo = list
        reloadData()
    }
}

// MARK: - DataSource
extension SearchResultTableView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return cellInfo.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = dequeueReusableCell(withIdentifier: TotalExhibitionTableViewCell.identifier, for: indexPath) as! TotalExhibitionTableViewCell
            return cell
        } else {
            let cell = dequeueReusableCell(withIdentifier: SearchResultListTableViewCell.identifier, for: indexPath) as! SearchResultListTableViewCell
            cell.cellDelegate = cellDelegate
            cell.bind(data: cellInfo[indexPath.row])
            return cell
        }
    }
}

// MARK: - Delegate
extension SearchResultTableView: UITableViewDelegate {

}
