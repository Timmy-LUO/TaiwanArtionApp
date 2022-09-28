//
//  ChangePhotoTableView.swift
//  TaiwanArtionApp
//
//  Created by 羅承志 on 2022/8/25.
//

import UIKit

class ChangePhotoTableView: UITableView {
    
    private var scrollPhoto = [AllCategories]()
//    weak var viewModel: FindExhibitionViewModelType?
    
    private var photos = ["1", "2", "3"]
    
    // MARK: - Init
    convenience init() {
        self.init(frame: .zero, style: .plain)
        register(ChangePhotoTableViewCell.self, forCellReuseIdentifier: ChangePhotoTableViewCell.identifier)
        self.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi/2))
        layer.cornerRadius = 20
        backgroundColor = .red
        separatorStyle = .none
        separatorColor = .clear
        isPagingEnabled = true
        allowsSelection = false
        dataSource = self
        delegate = self
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    func setChangePhoto(list: [AllCategories]) {
//        scrollPhoto = list
//        reloadData()
//    }
}

// MARK: - DataSource
extension ChangePhotoTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeueReusableCell(withIdentifier: ChangePhotoTableViewCell.identifier, for: indexPath) as! ChangePhotoTableViewCell
        cell.photoImageView.image = UIImage(named: photos[indexPath.row])
//        cell.bind(data: scrollPhoto)
//        print("TableView: \(cell.bind(data: scrollPhoto))")
        return cell
    }
}

extension ChangePhotoTableView: UITableViewDelegate {
    
}
