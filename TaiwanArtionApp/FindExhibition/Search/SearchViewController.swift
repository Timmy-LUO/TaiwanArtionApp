//
//  SearchViewController.swift
//  TaiwanArtionApp
//
//  Created by 羅承志 on 2022/8/11.
//

import UIKit
import SnapKit

class SearchViewController: UIViewController {
    
    // MARK: - Properties
    private let pages = ["縣市", "展覽地點", "日期"]
    
    private var pageViewIndex: Int = 0
    
    private var viewControllers: [UIViewController] = [AreaViewController(), ExhibitionPlaceViewController(), DateViewController()]
    
    
    // MARK: - UIs
    private let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    private let whetherStartExhibitionButton = WhetherStartExhibitionButton()
    
    private let searchBarView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = .cardBackgroundGray
        return view
    }()
    
    private let magnifierImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "magnifier"))
        return imageView
    }()
    
    private let searchLabel: UILabel = {
        let label = UILabel()
        label.text = "Search"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    private let tabCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .backgroundColor
        collectionView.register(TabButtonCollectionViewCell.self, forCellWithReuseIdentifier: TabButtonCollectionViewCell.identifier)
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    private let backView: UIView = {
        let view = UIView()
        return view
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigation()
        setupCollectionView()
        configurePageViewController()
        whetherStartExhibitionViewTap()
        searchBarViewTap()
    }
    
    // MARK: - Set Navigation
    private func setupNavigation() {
        navigationItem.title = "Search"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        
        // left Button
        let leftButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(backButton))
        leftButton.tintColor = .black
        self.navigationItem.leftBarButtonItem = leftButton
    }
    
    //MARK: - Setup CollectionView
    private func setupCollectionView() {
        tabCollectionView.dataSource = self
        tabCollectionView.delegate = self
        tabCollectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .centeredHorizontally)
    }
    
    //MARK: - ConfigurePageVC
    private func configurePageViewController() {
        view.addSubview(pageViewController.view)
        addChild(pageViewController)
        pageViewController.didMove(toParent: self)
        
        pageViewController.view.snp.makeConstraints { make in
            make.edges.equalTo(backView)
        }
        
        pageViewController.dataSource = self
        pageViewController.delegate = self
        pageViewController.setViewControllers([viewControllers[pageViewIndex]], direction: .forward, animated: true)
    }
    
    //MARK: - Setup UI
    private func setupUI() {
        view.backgroundColor = .backgroundColor
                
        view.addSubview(searchBarView)
        searchBarView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.leading.equalTo(16)
            make.width.equalTo(270)
            make.height.equalTo(40)
        }
        
        searchBarView.addSubview(magnifierImageView)
        magnifierImageView.snp.makeConstraints { make in
            make.width.height.equalTo(16)
            make.centerY.equalTo(searchBarView.snp.centerY)
            make.leading.equalTo(20)
        }
        
        searchBarView.addSubview(searchLabel)
        searchLabel.snp.makeConstraints { make in
            make.leading.equalTo(magnifierImageView.snp.trailing).offset(8)
            make.centerY.equalTo(searchBarView.snp.centerY)
        }
        
        view.addSubview(whetherStartExhibitionButton)
        whetherStartExhibitionButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.leading.equalTo(searchBarView.snp.trailing).offset(8)
            make.trailing.equalTo(-16)
            make.height.equalTo(40)
        }
        
        view.addSubview(tabCollectionView)
        tabCollectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBarView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
        
        view.addSubview(backView)
        backView.snp.makeConstraints { make in
            make.top.equalTo(tabCollectionView.snp.bottom)
            make.bottom.leading.trailing.equalToSuperview()
        }
    }

    
    //MARK: - Methods
    private func pageViewChange(index: Int) -> UIViewController? {
        if index < 0 {
            return viewControllers.last
        } else if index > viewControllers.count - 1 {
            return viewControllers.first
        } else {
            return viewControllers[index]
        }
    }
    
    private func searchBarViewTap() {
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(searchViewTouch))
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1
        searchBarView.addGestureRecognizer(tap)
    }
    
    @objc
    private func searchViewTouch() {
        let vc = SearchPageViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func whetherStartExhibitionViewTap() {
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(whetherStartTouch))
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1
        whetherStartExhibitionButton.addGestureRecognizer(tap)
    }
    
    @objc
    private func whetherStartTouch(_ sender: UIView) {
        let vc = WhetherStartBottomSheetViewController()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .pageSheet
        if let sheet = nav.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
        }
        present(nav, animated: true, completion: nil)
    }
    
    @objc
    private func backButton() {
        navigationController?.popViewController(animated: true)
    }
}

//MARK: - CollectionView DataSource
extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TabButtonCollectionViewCell.identifier, for: indexPath) as! TabButtonCollectionViewCell
        cell.backgroundColor = .backgroundColor
        cell.pageLabel.text = pages[indexPath.row]
        return cell
    }
}

//MARK: - CollectionView Delegate
extension SearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item > pageViewIndex {
            pageViewIndex = indexPath.item
            pageViewController.setViewControllers([viewControllers[pageViewIndex]], direction: .forward, animated: true)
        }
        
        if indexPath.item < pageViewIndex {
            pageViewIndex = indexPath.item
            pageViewController.setViewControllers([viewControllers[pageViewIndex]], direction: .reverse, animated: true)
        }
    }
}

//MARK: - CollectionView FlowLayout
extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // (collectionView.邊界.寬 - 間距大小 * cell有幾幾個間距) / 想要幾個cell
        let width = (collectionView.bounds.width - 1 * 3) / 5
//        let height = width
//        let width = tabCollectionView.frame.width / 3
        let height = tabCollectionView.frame.height - 4
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}

//MARK: - PageVC DataSource
extension SearchViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
       
        return pageViewChange(index: pageViewIndex - 1)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        return pageViewChange(index: pageViewIndex + 1)
    }
}

//MARK: - PageVC Delegate
extension SearchViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {

        if finished {
            if completed {
                guard let vc = pageViewController.viewControllers?.first else { return }
                pageViewIndex = vc.view.tag
                tabCollectionView.selectItem(at: IndexPath(item: pageViewIndex, section: 0), animated: true, scrollPosition: .centeredVertically)
            }
        }
    }
}

