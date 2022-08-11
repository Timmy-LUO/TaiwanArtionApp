//
//  SeeAllExhibitionTableView.swift
//  TaiwanArtionApp
//
//  Created by 羅承志 on 2022/8/11.
//

import UIKit

class SeeAllExhibitionTableView: UITableView {
    
    private var cellInfo = [CellInfo]()
    
    weak var cellDelegate: SearchResultCellDelegate?

    // MARK: - Init
    convenience init() {
        self.init(frame: .zero, style: .plain)
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
    
    func setCellInfo(list: [CellInfo]) {
        cellInfo = list
        reloadData()
    }
}

// MARK: - TableView DataSource
extension SeeAllExhibitionTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellInfo.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FindExhibitionTableViewCell.identifier, for: indexPath) as! FindExhibitionTableViewCell
        cell.cellDelegate = cellDelegate
        cell.bind(data: cellInfo[indexPath.row])
        return cell
    }
}

// MARK: - TableView Delegate
extension SeeAllExhibitionTableView: UITableViewDelegate {
    
}
