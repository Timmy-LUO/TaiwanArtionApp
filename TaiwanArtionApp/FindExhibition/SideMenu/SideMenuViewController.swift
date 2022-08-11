//
//  SideMenuViewController.swift
//  TaiwanArtionApp
//
//  Created by 羅承志 on 2022/8/11.
//

import UIKit
import SnapKit
import SideMenu

class SideMenuViewController: UIViewController {
    
    // MARK: UIs
    private let sideMenuTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SideMenuView")
        tableView.isScrollEnabled = false
        return tableView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
    }
    
    // MARK: Setup TableView
    private func setupTableView() {
        sideMenuTableView.dataSource = self
        sideMenuTableView.delegate = self
        sideMenuTableView.reloadData()
    }
    
    // MARK: - SetupUI
    private func setupUI() {
        view.addSubview(sideMenuTableView)
        sideMenuTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - DataSource
extension SideMenuViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuView", for: indexPath)
        cell.textLabel?.text = "Button \(indexPath.row + 1)"
        
        return cell
    }
}

// MARK: - Delegate
extension SideMenuViewController: UITableViewDelegate {
    
}
