//
//  FilterExhibitionButton.swift
//  TaiwanArtionApp
//
//  Created by 羅承志 on 2022/8/11.
//

import UIKit

final public class FilterExhibitionButton: UICollectionView {
    
    let filterDate: [String] = ["不限", "一週", "一個月", "三個月"]
    
    convenience init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        self.init(frame: .zero, collectionViewLayout: layout)
        backgroundColor = .backgroundColor
        register(FilterExhibitionButtonsCell.self, forCellWithReuseIdentifier: FilterExhibitionButtonsCell.identifier)
        isScrollEnabled = false
        dataSource = self
        delegate = self
        self.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .centeredHorizontally)
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Data Source
extension FilterExhibitionButton: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterDate.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterExhibitionButtonsCell.identifier, for: indexPath) as! FilterExhibitionButtonsCell
        cell.rangeLabel.text = filterDate[indexPath.row]
        return cell
    }
}

//MARK: - Delegate
extension FilterExhibitionButton: UICollectionViewDelegate {
    
}

//MARK: - FlowLayout
extension FilterExhibitionButton: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // (collectionView.邊界.寬 - 間距大小 * cell有幾幾個間距) / 想要幾個cell
        let width = (collectionView.bounds.width - 2 * 3) / 4
//        let height = width
//        let width = self.frame.width / 4
        let height = self.frame.height - 4
        return CGSize(width: width, height: height)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
}
