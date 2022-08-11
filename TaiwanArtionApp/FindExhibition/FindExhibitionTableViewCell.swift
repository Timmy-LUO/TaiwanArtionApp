//
//  FindExhibitionTableViewCell.swift
//  TaiwanArtionApp
//
//  Created by 羅承志 on 2022/8/11.
//

import UIKit
import SnapKit

class FindExhibitionTableViewCell: UITableViewCell {
    
    static let identifier = "FindExhibitionTableViewCell"
    
    weak var cellDelegate: SearchResultCellDelegate?
    
    var cellInfo = [CellInfo]()
    
    // MARK: - UIs
    private let backView: UIView = {
        let view = UIView()
        view.backgroundColor = .backgroundColor
        view.layer.shadowRadius = 7
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        view.layer.shadowOpacity = 0.1
        view.layer.cornerRadius = 20
        return view
    }()
    
    private let recentExhibitionImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "3"))
        imageView.backgroundColor = .white
        imageView.layer.cornerRadius = 23
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private
    lazy var nameAndDateStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [exhibitionName, exhibitionDate])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 0
        return stackView
    }()
    
    private let exhibitionName: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    private let exhibitionDate: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 12)
        label.textColor = .gray
        return label
    }()
        
    private let mapMarkImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Map"))
        return imageView
    }()
    
    private let exhibitionPrice: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 12)
        label.backgroundColor = .brownColor
        label.textAlignment = .center
        label.textColor = .white
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        return label
    }()
    
    private let exhibitionCity: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 12)
        label.textColor = .gray
        return label
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
        contentView.backgroundColor = .backgroundColor
        
        contentView.addSubview(backView)
        backView.snp.makeConstraints { make in
            make.top.leading.equalTo(10)
            make.bottom.trailing.equalTo(-10)
        }
        
        let width = UIScreen.main.bounds.width - 283
        let height = width / 107 * 87
        
        backView.addSubview(recentExhibitionImageView)
        recentExhibitionImageView.snp.makeConstraints { make in
            make.height.equalTo(height)
            make.width.equalTo(width)
            make.top.equalTo(16)
            make.bottom.equalTo(-16)
            make.leading.equalTo(16)
        }
        
        backView.addSubview(nameAndDateStackView)
        nameAndDateStackView.snp.makeConstraints { make in
            make.top.equalTo(16)
            make.leading.equalTo(recentExhibitionImageView.snp.trailing).offset(13)
        }
        
        backView.addSubview(mapMarkImageView)
        mapMarkImageView.snp.makeConstraints { make in
            make.bottom.equalTo(-18)
            make.leading.equalTo(recentExhibitionImageView.snp.trailing).offset(13)
        }
        
        backView.addSubview(exhibitionCity)
        exhibitionCity.snp.makeConstraints { make in
            make.bottom.equalTo(-16)
            make.leading.equalTo(mapMarkImageView.snp.trailing).offset(2)
            make.centerY.equalTo(mapMarkImageView.snp.centerY)
        }
        
        backView.addSubview(exhibitionPrice)
        exhibitionPrice.snp.makeConstraints { make in
            make.bottom.trailing.equalTo(-16)
            make.height.equalTo(16)
            make.width.equalTo(46)
        }
    }
    
    func bind(data: CellInfo) {
        recentExhibitionImageView.image = UIImage(named: data.url)
        exhibitionName.text = data.title
        exhibitionDate.text = "\(data.startDate) ~ \(data.endDate)"
        exhibitionCity.text = "\(data.city)，\(data.township)"
        exhibitionPrice.text = data.price
    }
}
