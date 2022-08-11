//
//  SearchResultTableViewCell.swift
//  TaiwanArtionApp
//
//  Created by 羅承志 on 2022/8/11.
//

import UIKit
import SnapKit

class SearchResultListTableViewCell: UITableViewCell {

    static let identifier = "SearchResultCell"
    
    weak var cellDelegate: SearchResultCellDelegate?
        
    // MARK: - UIs
    private let backView: UIView = {
        let view = UIView()
        view.backgroundColor = .cardBackgroundGray
        view.layer.cornerRadius = 20
        return view
    }()
    
    private let exhibitionImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "3"))
        imageView.backgroundColor = .white
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 1
        imageView.layer.cornerRadius = 23
        imageView.clipsToBounds = true
        return imageView
    }()
        
    private let exhibitionName: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.text = "會動的文藝復興"
        return label
    }()
    
    private let exhibitionDate: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 11)
        label.textColor = .gray
        label.text = "2020/3/21～04/20"
        return label
    }()
    
    private
    lazy var landmarkAndCityStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [landmarkImageView, exhibitionCity])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.spacing = 2
        return stackView
    }()
    
    private let exhibitionCity: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .boldSystemFont(ofSize: 12)
        label.text = "台南市，仁德區"
        return label
    }()
    
    private let exhibitionPrice: UILabel = {
        let label = UILabel()
        label.layer.borderColor = UIColor.black.cgColor
        label.backgroundColor = .brownColor
        label.font = .boldSystemFont(ofSize: 12)
        label.textAlignment = .center
        label.textColor = .white
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.text = "$300"
        return label
    }()
    
    private let landmarkImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Map"))
        return imageView
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        viewTap()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    private func viewTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(touch))
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1
        backView.addGestureRecognizer(tap)
    }
    
    @objc
    private func touch() {
        cellDelegate?.pushToExhibitionDetail()
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        selectionStyle = .none
        
        contentView.addSubview(backView)
        backView.snp.makeConstraints { make in
            make.top.equalTo(16)
            make.bottom.equalTo(-16)
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
        }
        
        let width = UIScreen.main.bounds.width - 64
        let height = width / 326 * 169
        
        backView.addSubview(exhibitionImageView)
        exhibitionImageView.snp.makeConstraints { make in
            make.height.equalTo(height)
//            make.width.equalTo(width)
            make.top.equalTo(18)
            make.bottom.equalTo(-77)
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
        }
        
        backView.addSubview(exhibitionName)
        exhibitionName.snp.makeConstraints { make in
            make.top.equalTo(exhibitionImageView.snp.bottom).offset(18)
            make.leading.equalTo(backView.snp.leading).offset(16)
        }

        backView.addSubview(exhibitionDate)
        exhibitionDate.snp.makeConstraints { make in
            make.top.equalTo(exhibitionName.snp.bottom).offset(8)
            make.leading.equalTo(backView.snp.leading).offset(16)
        }

        backView.addSubview(landmarkAndCityStackView)
        landmarkAndCityStackView.snp.makeConstraints { make in
            make.trailing.equalTo(backView.snp.trailing).offset(-16)
            make.centerY.equalTo(exhibitionName.snp.centerY)
        }

        landmarkImageView.snp.makeConstraints { make in
            make.height.equalTo(12)
            make.width.equalTo(9)
        }

        backView.addSubview(exhibitionPrice)
        exhibitionPrice.snp.makeConstraints { make in
            make.trailing.equalTo(backView.snp.trailing).offset(-20)
            make.centerY.equalTo(exhibitionDate.snp.centerY)
        }

        exhibitionPrice.snp.makeConstraints { make in
            make.width.equalTo(55)
        }
    }
    
    func bind(data: CellInfo) {
        exhibitionImageView.image = UIImage(named: data.url)
        exhibitionName.text = data.title
        exhibitionDate.text = "\(data.startDate) ~ \(data.endDate)"
        exhibitionCity.text = "\(data.city)，\(data.township)"
        exhibitionPrice.text = data.price
    }
}
