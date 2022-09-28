//
//  PhotosCollectionViewCell.swift
//  TaiwanArtionApp
//
//  Created by 羅承志 on 2022/8/11.
//

import UIKit
import SnapKit
import Kingfisher

class PhotosCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PhotoCollectionViewCell"
    
    //MARK: - UIs
    private let photoColumnImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "3"))
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Bind
//    func bind(data: AllCategories) {
//        photoColumnImageView.kf.setImage(with: URL(string: data.imageUrl))
//        print("PhotosCollection: \(data.imageUrl)")
//    }
    
    // MARK: - Setup UI
    private func setupUI() {
        layer.borderColor = UIColor.black.cgColor
        
        contentView.addSubview(photoColumnImageView)
        photoColumnImageView.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY)
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(53)
            make.height.equalTo(52)
        }
    }
}
