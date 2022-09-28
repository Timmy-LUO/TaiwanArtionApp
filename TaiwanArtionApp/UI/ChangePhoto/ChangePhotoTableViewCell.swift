//
//  ChangePhotoTableViewCell.swift
//  TaiwanArtionApp
//
//  Created by 羅承志 on 2022/8/25.
//

import UIKit
import SnapKit
import Kingfisher

class ChangePhotoTableViewCell: UITableViewCell {

    static let identifier = "ChangePhotoTableViewCell"
    
    // MARK: - Proterties
//    private var photoData = [ScrollPhoto]()
    
    
    // MARK: - UIs
    let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(data: [AllCategories]) {
        let data = data[0]
        photoImageView.kf.setImage(with: URL(string: data.imageUrl))
        print("Cell image: \(data.imageUrl)")
//        data.map { $0.url }.forEach { [weak self] url in
//            self?.createPhoto(url: url)
//        }
    }
    
//    private func createPhoto(url: String) {
//        let imageView = UIImageView()
//        imageView.contentMode = .scaleAspectFit
//        imageView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
//
//        imageView.kf.setImage(with: URL(string: url))
//    }
    
    // MARK: - Setup UI
    private func setupUI() {
        self.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/2))
        
        contentView.addSubview(photoImageView)
        photoImageView.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.leading.equalTo(10)
            make.bottom.equalTo(-10)
            make.trailing.equalTo(-10)
            make.centerX.equalTo(self.snp.centerX)
//            make.centerY.equalTo(self.snp.centerY)
            make.height.equalTo(500)
//            make.width.equalTo(500)
        }
    }
}
