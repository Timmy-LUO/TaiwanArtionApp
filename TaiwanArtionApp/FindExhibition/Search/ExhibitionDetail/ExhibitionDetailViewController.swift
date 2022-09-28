//
//  ExhibitionDetailViewController.swift
//  TaiwanArtionApp
//
//  Created by 羅承志 on 2022/8/11.
//

import UIKit
import SnapKit
import RxSwift

class ExhibitionDetailViewController: UIViewController {
    
    // MARK: - Properties
//    private let viewModel: FindExhibitionViewModelType
    private let data: AllCategories
    private var disposeBag = DisposeBag()
    private var allCategories = [AllCategories]()
    
    private let pages = ["展覽資訊", "票價", "展覽介紹"]
    
    private var pageViewIndex: Int = 0
    
    var viewControllers: [UIViewController] = [InfoViewController(), FareViewController(), IntroduceViewController()]
    
    
    // MARK: - UIs
    private let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    private let photosCollectionView = PhotosCollectionView()
    
    private let backScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .backgroundColor
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = true
        scrollView.scrollsToTop = true
        scrollView.bounces = true
        scrollView.isPagingEnabled = false
        scrollView.isScrollEnabled = true
        return scrollView
    }()
    
    private let backContainerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var photoScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .black
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = true
        scrollView.isPagingEnabled = true
        return scrollView
    }()
    
    private lazy var photoScrollViewContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.spacing = 0
        return stackView
    }()
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "3"))
        return imageView
    }()
    
    private let imagePageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 3
        pageControl.pageIndicatorTintColor = .gray
        pageControl.currentPageIndicatorTintColor = .brownColor
        pageControl.preferredIndicatorImage = UIImage(named: "BrownPageControl")
        return pageControl
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "會動的文藝復興"
        label.textColor = .brownColor
        label.font = .boldSystemFont(ofSize: 24)
        return label
    }()
    
    private let onSaleLabel: UILabel = {
        let label = UILabel()
        label.text = "開賣中"
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 14)
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 4
        label.textColor = .white
        label.backgroundColor = .onSale7D3E35
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
    
    private let pageBackView: UIView = {
        let view = UIView()
        return view
    }()
    
    // MARK: - Init
    init(data: AllCategories ) {
        self.data = data
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
        setupCollectionView()
        configurePageViewController()
        print("Detail: \(data)")
//        backScrollView.delegate = self
    }
    
//    func setupBinding() {
//        viewModel.outputs
//            .cellInfoList
//            .emit(onNext: { [weak self] list in
//                self?.photosCollectionView.setCellInfo(list: list)
//            })
//            .disposed(by: disposeBag)
//    }
    
    private func setupNavigation() {
        // left Button
        let leftButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(backButton))
        leftButton.tintColor = .black
        self.navigationItem.leftBarButtonItem = leftButton
        
        // right Button
        let rightCalendarButton = UIBarButtonItem(image: UIImage(systemName: "calendar"), style: .plain, target: self, action: #selector(rightCalendarButton))
        rightCalendarButton.tintColor = .black
        
        let rightShareButton = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(rightShareButton))
        rightShareButton.tintColor = .black
        self.navigationItem.rightBarButtonItems = [rightShareButton, rightCalendarButton]
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        view.backgroundColor = .backgroundColor
        
        view.addSubview(backScrollView)
        backScrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.leading.trailing.equalToSuperview()
        }
        
        backScrollView.addSubview(backContainerView)
        backContainerView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalTo(backScrollView)
            make.width.equalToSuperview()
            make.height.equalTo(980)
        }
        
        backContainerView.addSubview(photoScrollView)
        photoScrollView.snp.makeConstraints { make in
            make.top.equalTo(backContainerView.snp.top)
            make.leading.trailing.equalTo(0)
            make.height.equalTo(300)
        }
        
        photoScrollView.addSubview(photoScrollViewContainer)
        photoScrollViewContainer.snp.makeConstraints { make in
            make.edges.equalTo(photoScrollView)
            make.width.equalToSuperview()
            make.height.equalTo(photoScrollView)
        }
        
        photoScrollViewContainer.addSubview(photoImageView)
        photoImageView.snp.makeConstraints { make in
            make.edges.equalTo(photoScrollViewContainer)
        }
        
        photoImageView.addSubview(imagePageControl)
        imagePageControl.snp.makeConstraints { make in
            make.bottom.equalTo(-16)
            make.centerX.equalTo(photoImageView.snp.centerX)
        }
        
        backContainerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(photoImageView.snp.bottom).offset(24)
            make.leading.equalTo(16)
        }

        backContainerView.addSubview(onSaleLabel)
        onSaleLabel.snp.makeConstraints { make in
            make.height.equalTo(24)
            make.width.equalTo(65)
            make.trailing.equalTo(-4)
            make.centerY.equalTo(titleLabel.snp.centerY)
        }

        backContainerView.addSubview(photosCollectionView)
        photosCollectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.height.equalTo(60)
        }

        backContainerView.addSubview(tabCollectionView)
        tabCollectionView.snp.makeConstraints { make in
            make.top.equalTo(photosCollectionView.snp.bottom).offset(34)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
        }

        backContainerView.addSubview(pageBackView)
        pageBackView.snp.makeConstraints { make in
            make.top.equalTo(tabCollectionView.snp.bottom)
            make.bottom.leading.trailing.equalToSuperview()
        }
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
            make.edges.equalTo(pageBackView)
        }
        
        pageViewController.dataSource = self
        pageViewController.delegate = self
        pageViewController.setViewControllers([viewControllers[pageViewIndex]], direction: .forward, animated: true)
    }
    
    // MARK: - Methods
    @objc
    private func backButton(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func rightCalendarButton(_ sender: UIBarButtonItem) {
        
    }
    
    @objc
    private func rightShareButton(_ sender: UIBarButtonItem) {
        
    }
    
    private func pageViewChange(index: Int) -> UIViewController? {
        if index < 0 {
            return viewControllers.last
        } else if index > viewControllers.count - 1 {
            return viewControllers.first
        } else {
            return viewControllers[index]
        }
    }
}

//MARK: - CollectionViewDataSource
extension ExhibitionDetailViewController: UICollectionViewDataSource {
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

//MARK: - CollectionViewDelegate
extension ExhibitionDetailViewController: UICollectionViewDelegate {
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

//MARK: - CollectionViewFlowLayout
extension ExhibitionDetailViewController: UICollectionViewDelegateFlowLayout {
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
extension ExhibitionDetailViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
       
        return pageViewChange(index: pageViewIndex - 1)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        return pageViewChange(index: pageViewIndex + 1)
    }
}

//MARK: - PageVC Delegate
extension ExhibitionDetailViewController: UIPageViewControllerDelegate {
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

extension ExhibitionDetailViewController: UIScrollViewDelegate {
    
}
