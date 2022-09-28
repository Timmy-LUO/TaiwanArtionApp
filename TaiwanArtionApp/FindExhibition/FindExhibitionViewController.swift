//
//  FindExhibitionViewController.swift
//  TaiwanArtionApp
//
//  Created by 羅承志 on 2022/8/11.
//

import UIKit
import SnapKit
import SideMenu
import RxSwift

class FindExhibitionViewController: UIViewController {
    
    // MARK: Properties
    private let viewModel: FindExhibitionViewModelType
    private let disposeBag = DisposeBag()
    
    
    // MARK: - UIs
    private let changePhotoTableVIew = ChangePhotoTableView()
    private let tableView = FindExhibitionTableView()
    private let sideMenu = UISideMenuNavigationController(rootViewController: SideMenuViewController())
    
    
    init(viewModel: FindExhibitionViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
           
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.buttonDelegate = self
        tableView.cellDelegate = self
        tableView.viewModel = viewModel
        
        setupUI()
        setupSideMenu()
        setupNavigation()
        setupBinding()
        viewModel.inputs.viewDidLoad.accept(())
    }
    
    // MARK: - Set SideMenu
    private func setupSideMenu() {
        sideMenu.leftSide = true
        sideMenu.menuWidth = 200
        SideMenuManager.default.menuLeftNavigationController = sideMenu
        SideMenuManager.default.menuAddPanGestureToPresent(toView: view)
    }
    
    // MARK: - Set NavigationItem
    private func setupNavigation() {
        navigationItem.title = "Main"
        //leftBarButtonItem
        let leftButton = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal"), style: .plain, target: self, action: #selector(leftButton))
        leftButton.tintColor = .black
        self.navigationItem.leftBarButtonItem = leftButton
        
        //rightBarButtonItem
        let rightButton = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(rightButton))
        rightButton.tintColor = .black
        self.navigationItem.rightBarButtonItem = rightButton
    }
    
    // MARK: - SetupUI
    private func setupUI() {
        view.backgroundColor = .backgroundColor
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setupBinding() {
        viewModel.outputs
            .scrollPhotoList
            .emit(onNext: { [weak self] list in
                self?.tableView.setScrollPhoto(list: list)
            })
            .disposed(by: disposeBag)
        
        viewModel.outputs
            .cellInfoList
            .emit(onNext: { [weak self] info in
                self?.tableView.setCellInfo(list: info)
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Methods
    @objc
    func leftButton(_ sender: UIBarButtonItem) {
        present(sideMenu, animated: true, completion: nil)
    }
    
    @objc
    func rightButton(_ sender: UIBarButtonItem) {
        let searchVC = SearchViewController()
        self.navigationController?.pushViewController(searchVC, animated: true)
    }
}

extension FindExhibitionViewController: TableViewCellDelegate {
    func didButtonPressed() {
        let vc = SeeAllExhibitionViewController(viewModel: FindExhibitionViewModel())
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension FindExhibitionViewController: SearchResultCellDelegate {
    func pushToExhibitionDetail(category: AllCategories) {
        print("category: \(category)")
        let vc = ExhibitionDetailViewController(data: category)
        navigationController?.pushViewController(vc, animated: true)
    }
}
