//
//  SearchResultViewController.swift
//  TaiwanArtionApp
//
//  Created by 羅承志 on 2022/8/11.
//

import UIKit
import SnapKit
import RxSwift

class SearchResultViewController: UIViewController {
    
    // MARK: - Properties
    weak var viewModel: FindExhibitionViewModelType!
//    private let viewModel: SearchResultViewModelType
    private let disposeBag = DisposeBag()

    
    // MARK: - UIs
    private let tableView = SearchResultTableView()
    
    
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
        setupUI()
        setupNavigation()
        setupBinding()
        tableView.cellDelegate = self
        viewModel.inputs.viewDidLoad.accept(())
    }
    
    // MARK: - Setup Navigation
    private func setupNavigation() {
        navigationItem.title = "SearchResult"
        
        // left Button
        let leftButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(backButton))
        leftButton.tintColor = .black
        self.navigationItem.leftBarButtonItem = leftButton
    }
    
    
    // MARK: - Setup UI
    private func setupUI() {
        view.backgroundColor = .backgroundColor
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: Setup Binding
    private func setupBinding() {
        viewModel.outputs
            .cellInfoList
            .emit(onNext: { [weak self] info in
                self?.tableView.setCellInfo(list: info)
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Methods
    @objc
    private func backButton() {
        navigationController?.popViewController(animated: true)
    }
}

extension SearchResultViewController: SearchResultCellDelegate {
    func pushToExhibitionDetail(category: AllCategories) {
        print("Search Result: \(category)")
        let vc = ExhibitionDetailViewController(data: category)
        navigationController?.pushViewController(vc, animated: true)
    }
}
