//
//  FindExhibitionViewModel.swift
//  TaiwanArtionApp
//
//  Created by 羅承志 on 2022/8/11.
//

import Foundation
import RxCocoa
import RxSwift
import RxRelay

protocol FindExhibitionViewModelInputs {
    var viewDidLoad: PublishRelay<()> { get }
}

protocol FindExhibitionViewModelOutputs {
    var scrollPhotoList: Signal<[ScrollPhoto]> { get }
    var cellInfoList: Signal<[CellInfo]> { get }
}

protocol FindExhibitionViewModelType {
    var inputs: FindExhibitionViewModelInputs { get }
    var outputs: FindExhibitionViewModelOutputs { get }
}

final class FindExhibitionViewModel:
    FindExhibitionViewModelInputs,
    FindExhibitionViewModelOutputs,
    FindExhibitionViewModelType
{
    // MARK: - inputs
    public var viewDidLoad: PublishRelay<()>
    
    
    // MARK: - outputs
    public var scrollPhotoList: Signal<[ScrollPhoto]>
    public var cellInfoList: Signal<[CellInfo]>
    
    public var inputs: FindExhibitionViewModelInputs { self }
    public var outputs: FindExhibitionViewModelOutputs { self }
    
    private let disposeBag = DisposeBag()
    
    init() {
        let viewDidLoad = PublishRelay<()>()
        self.viewDidLoad = viewDidLoad
        
        let scrollPhotoList = PublishRelay<[ScrollPhoto]>()
        self.scrollPhotoList = scrollPhotoList.asSignal()
        
        let cellInfoList = PublishRelay<[CellInfo]>()
        self.cellInfoList = cellInfoList.asSignal()
        
        viewDidLoad
            .subscribe(onNext: { [weak self] in
                self?.loadScrollPhoto(scrollPhotoList: scrollPhotoList)
                self?.loadCellInfo(cellInfoList: cellInfoList)
            })
            .disposed(by: disposeBag)
    }
    
    private func loadScrollPhoto(scrollPhotoList: PublishRelay<[ScrollPhoto]>) {
        let mock = [
            ScrollPhoto(
                url: "1",
                title: "Photo 1",
                startDate: "7/1",
                endDate: "7/3"
            ),
            ScrollPhoto(
                url: "2",
                title: "Photo 2",
                startDate: "7/4",
                endDate: "7/6"
            ),
            ScrollPhoto(
                url: "1",
                title: "Photo 3",
                startDate: "7/7",
                endDate: "7/9"
            ),
            ScrollPhoto(
                url: "2",
                title: "Photo 4",
                startDate: "7/10",
                endDate: "7/12"
            )
        ]
        scrollPhotoList.accept(mock)
    }
    
    private func loadCellInfo(cellInfoList: PublishRelay<[CellInfo]>) {
        let info = [
            CellInfo(
                url: "1",
                title: "會動的文藝復興 1",
                startDate: "2020/03/21",
                endDate: "04/20",
                city: "台南市",
                township: "仁德區",
                price: "300"
            ),
            CellInfo(
                url: "2",
                title: "會動的文藝復興 2",
                startDate: "2020/03/22",
                endDate: "04/20",
                city: "台南市",
                township: "仁德區",
                price: "300"
            ),
            CellInfo(
                url: "3",
                title: "會動的文藝復興 3",
                startDate: "2020/03/23",
                endDate: "04/20",
                city: "台南市",
                township: "仁德區",
                price: "300"
            ),
            CellInfo(
                url: "1",
                title: "會動的文藝復興 4",
                startDate: "2020/03/24",
                endDate: "04/20",
                city: "台南市",
                township: "仁德區",
                price: "300"
            ),
            CellInfo(
                url: "2",
                title: "會動的文藝復興 5",
                startDate: "2020/03/25",
                endDate: "04/20",
                city: "台南市",
                township: "仁德區",
                price: "300"
            ),
            CellInfo(
                url: "3",
                title: "會動的文藝復興 6",
                startDate: "2020/03/26",
                endDate: "04/20",
                city: "台南市",
                township: "仁德區",
                price: "300"
            ),
        ]
        
        cellInfoList.accept(info)
    }
}
