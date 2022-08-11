//
//  SearchPageViewController.swift
//  TaiwanArtionApp
//
//  Created by 羅承志 on 2022/8/11.
//

import UIKit
import SnapKit

class SearchPageViewController: UIViewController {
    
    var cellInfo: [CellInfo] = [
        CellInfo(
            url: "1",
            title: "會動的文藝復興 1",
            startDate: "2020/03/21",
            endDate: "04/20",
            city: "台南市",
            township: "仁德區",
            price: "300"
        ),
        CellInfo(
            url: "2",
            title: "會動的文藝復興 2",
            startDate: "2020/03/22",
            endDate: "04/20",
            city: "台南市",
            township: "仁德區",
            price: "300"
        ),
        CellInfo(
            url: "3",
            title: "會動的文藝復興 3",
            startDate: "2020/03/23",
            endDate: "04/20",
            city: "台南市",
            township: "仁德區",
            price: "300"
        ),
        CellInfo(
            url: "1",
            title: "會動的文藝復興 4",
            startDate: "2020/03/24",
            endDate: "04/20",
            city: "台南市",
            township: "仁德區",
            price: "300"
        ),
        CellInfo(
            url: "2",
            title: "會動的文藝復興 5",
            startDate: "2020/03/25",
            endDate: "04/20",
            city: "台南市",
            township: "仁德區",
            price: "300"
        ),
        CellInfo(
            url: "3",
            title: "會動的文藝復興 6",
            startDate: "2020/03/26",
            endDate: "04/20",
            city: "台南市",
            township: "仁德區",
            price: "300"
        )
    ]
    
    private var isShowSearchResult: Bool = false
    var searchRecord = [String]()
//    private var cellInfo = [CellInfo]()
    private var searchResult: [CellInfo] = []
    
    // MARK: - UIs
    private let searchPageTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(SearchResultsTableViewCell.self, forCellReuseIdentifier: SearchResultsTableViewCell.identifier)
        tableView.register(SearchRecordTableViewCell.self, forCellReuseIdentifier: SearchRecordTableViewCell.identifier)
        return tableView
    }()
    
    private let searchTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .cardBackgroundGray
        textField.font = .systemFont(ofSize: 14)
        textField.placeholder = "Search"
        textField.borderStyle = .none
        textField.clearButtonMode = .whileEditing
        textField.keyboardType = .default
        textField.layer.cornerRadius = 10
        let leftVeiwView = UIView(frame: CGRect(x: 10, y: 0, width: 40, height: 40))
        textField.leftView = leftVeiwView
        textField.leftViewMode = .always
        let iconImage = UIImageView(frame: CGRect(x: 12, y: 12, width: 16, height: 16))
        iconImage.image = UIImage(named: "magnifier")
        iconImage.tintColor = .gray
        leftVeiwView.addSubview(iconImage)
        return textField
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTextField()
        setupNavigation()
        setupTableView()
        searchTextField.addTarget(self, action: #selector(searchExhibition), for: .editingChanged)
    }
    
    // MARK: - Setup Navigation
    private func setupNavigation() {
        navigationItem.titleView = searchTextField
        
        // left Button
        let leftButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(backButton))
        leftButton.tintColor = .black
        self.navigationItem.leftBarButtonItem = leftButton
    }
    
    // MARK: - Setup TableView
    private func setupTableView() {
        searchPageTableView.dataSource = self
        searchPageTableView.delegate = self
    }
    
    // MARK: - Setup TextField
    private func setupTextField() {
        searchTextField.delegate = self
    }

    // MARK: - Setup UI
    private func setupUI() {
        view.backgroundColor = .backgroundColor
        
        searchTextField.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(40)
        }
        
        view.addSubview(searchPageTableView)
        searchPageTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Methods
    @objc
    private func searchExhibition() {
        if searchTextField.text?.isEmpty == true {
            isShowSearchResult = false
            
        } else {
            isShowSearchResult = true
            
        }
        self.searchPageTableView.reloadData()
    }
    
    @objc
    private func backButton() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - TableView DataSource
extension SearchPageViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isShowSearchResult == false {
            return 10 //searchRecord.count
        } else {
            return cellInfo.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isShowSearchResult == false {
            let cell = tableView.dequeueReusableCell(withIdentifier: SearchRecordTableViewCell.identifier, for: indexPath) as! SearchRecordTableViewCell
            cell.recordLabel.text = "Record \(indexPath.row + 1)"
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultsTableViewCell.identifier, for: indexPath) as! SearchResultsTableViewCell
            cell.resultLabel.text = "Results \(indexPath.row + 1)"

            return cell
        }
    }
}

// MARK: - TableView Delegate
extension SearchPageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if isShowSearchResult == false {
            return "最近搜尋紀錄"
        } else {
            return "搜尋結果"
        }
    }
}

extension SearchPageViewController: UITextFieldDelegate {
    
}
