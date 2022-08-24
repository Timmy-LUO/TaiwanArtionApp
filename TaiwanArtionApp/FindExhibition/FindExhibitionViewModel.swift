//
//  FindExhibitionViewModel.swift
//  TaiwanArtionApp
//
//  Created by 羅承志 on 2022/8/11.
//

import Foundation
import Alamofire
import RxCocoa
import RxSwift
import RxRelay
import MapKit

protocol FindExhibitionViewModelInputs: AnyObject {
    var viewDidLoad: PublishRelay<()> { get }
    var onExhibitionTap: AnyObserver<CellInfo> { get }
}

protocol FindExhibitionViewModelOutputs: AnyObject {
    var scrollPhotoList: Signal<[ScrollPhoto]> { get }
    var cellInfoList: Signal<[AllCategories]> { get }
    var artsHumanitiesData: Signal<[ArtsHumanities]> { get }
}

protocol FindExhibitionViewModelType: AnyObject {
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
    public var onExhibitionTap: AnyObserver<CellInfo>
    
    
    // MARK: - outputs
    public var scrollPhotoList: Signal<[ScrollPhoto]>
    public var cellInfoList: Signal<[AllCategories]>
//    public var artsHumanitiesData: Signal<[ArtsHumanities]>
    public var artsHumanitiesData: Signal<[ArtsHumanities]>
    
    public var inputs: FindExhibitionViewModelInputs { self }
    public var outputs: FindExhibitionViewModelOutputs { self }
    
    private let disposeBag = DisposeBag()
    
    init() {
        // inputs
        let viewDidLoad = PublishRelay<()>()
        self.viewDidLoad = viewDidLoad
        
        let _onExhibitionTap = PublishSubject<CellInfo>()
        self.onExhibitionTap = _onExhibitionTap.asObserver()
        
        // outputs
        let scrollPhotoList = PublishRelay<[ScrollPhoto]>()
        self.scrollPhotoList = scrollPhotoList.asSignal()
        
        let cellInfoList = PublishRelay<[AllCategories]>()
        self.cellInfoList = cellInfoList.asSignal()
        
        let _artsHumanitiesData = PublishRelay<[ArtsHumanities]>()
        self.artsHumanitiesData = _artsHumanitiesData.asSignal()
        
//        viewDidLoad
//            .subscribe(onNext: { [weak self] in
//                self?.loadScrollPhoto(scrollPhotoList: scrollPhotoList)
//                self?.loadCellInfo(cellInfoList: cellInfoList)
//                self?.getData(_artsHumanitiesData: _artsHumanitiesData)
//            })
//            .disposed(by: disposeBag)
        
        _onExhibitionTap
            .subscribe(onNext: { info in
                print("Cell info: \(info)")
            })
            .disposed(by: disposeBag)
        
        viewDidLoad
            .flatMap { AllCategoriesService.getData() }
            .subscribe(onNext: { categories in
                var scrollPhotos = [ScrollPhoto]()
                categories.forEach { category in
                    scrollPhotos.append(
                        ScrollPhoto(
                            url: category.imageUrl,
                            title: category.title,
                            startDate: category.startDate,
                            endDate: category.endDate
                        )
                    )
                    
                    if let lat = category.showInfo.first?.latitude, let lon = category.showInfo.first?.longitude {
                        self.getCityName(lat: Double(lat)!, lon: Double(lon)!)
                    }
                }
//                scrollPhotoList.accept(scrollPhotos)
                cellInfoList.accept(categories)
                
            })
            .disposed(by: disposeBag)
    }
    
    private func getCityName(lat: Double, lon: Double) {
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(CLLocation(latitude: lat , longitude: lon)) { (placemarks: [CLPlacemark]?, error: Error?) in
//           (placemarks:[AnyObject]!, error: NSError!) -> Void in
           if error != nil{
              print(error)
              return
           }

           //name         街道地址
           //country      國家
           //province     省
           //locality     市
           //sublocality  縣.區
           //route        街道、路
           //streetNumber 門牌號碼
           //postalCode   郵遞區號
           if let placemarks = placemarks, placemarks.count > 0 {
              let placemark = placemarks[0] as CLPlacemark
              //這邊拼湊轉回來的地址
              //placemark.name
               
               print("\(placemark.locality) \(placemark.country)")
           }
        }
    }
    
    func getData(_artsHumanitiesData: PublishRelay<[ArtsHumanities]>) {
        let url: String = "https://memory.culture.tw/openapi/api/v1/json?subject=art"
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: nil)
            .response { [weak self] response in
//                    if response.response?.statusCode == 400 {
//                        print("statusCode: \(String(describing: response.response?.statusCode))")
//                        return observer.onCompleted()
//                    }
//
//                    if let error = response.error {
//                        print("Error: \(error)")
//                        return observer.onError(error)
//                    }
                
                guard let responseData = response.data else {
//                        return observer.onCompleted()
                    return
                }
                
                do {
                    let data = try JSONDecoder().decode([ArtsHumanities].self, from: responseData)
//                        observer.onNext(data)
                    _artsHumanitiesData.accept(data)
//                        print("Data: \(data)")
                } catch {
//                        observer.onError(error)
                    print("Error: \(error)")
                }
            }
    }
    
    private func getData() -> Observable<[ArtsHumanities]> {
        return Observable<[ArtsHumanities]>.create { emitter in
            let url: String = "https://memory.culture.tw/openapi/api/v1/json?subject=art"
            AF.request(url, method: .get, encoding: JSONEncoding.default, headers: nil)
                .response { response in
                    guard let responseData = response.data else {
                        return
                    }
                    do {
                        let data = try JSONDecoder().decode(
                            [ArtsHumanities].self,
                            from: responseData
                        )
                        emitter.onNext(data)
                    } catch {
                        print("Error: \(error)")
                    }
                }
            return Disposables.create()
        }
    }

    
//    private func loadScrollPhoto(scrollPhotoList: PublishRelay<[ScrollPhoto]>) {
//        let mock = [
//            ScrollPhoto(
//                url: "1",
//                title: "Photo 1",
//                startDate: "7/1",
//                endDate: "7/3"
//            ),
//            ScrollPhoto(
//                url: "2",
//                title: "Photo 2",
//                startDate: "7/4",
//                endDate: "7/6"
//            ),
//            ScrollPhoto(
//                url: "1",
//                title: "Photo 3",
//                startDate: "7/7",
//                endDate: "7/9"
//            ),
//            ScrollPhoto(
//                url: "2",
//                title: "Photo 4",
//                startDate: "7/10",
//                endDate: "7/12"
//            )
//        ]
//        scrollPhotoList.accept(mock)
//    }
//
//    private func loadCellInfo(cellInfoList: PublishRelay<[CellInfo]>) {
//        let info = [
//            CellInfo(
//                url: "1",
//                title: "會動的文藝復興 1",
//                startDate: "2020/03/21",
//                endDate: "04/20",
//                city: "台南市",
//                township: "仁德區",
//                price: "300"
//            ),
//            CellInfo(
//                url: "2",
//                title: "會動的文藝復興 2",
//                startDate: "2020/03/22",
//                endDate: "04/20",
//                city: "台南市",
//                township: "仁德區",
//                price: "300"
//            ),
//            CellInfo(
//                url: "3",
//                title: "會動的文藝復興 3",
//                startDate: "2020/03/23",
//                endDate: "04/20",
//                city: "台南市",
//                township: "仁德區",
//                price: "300"
//            ),
//            CellInfo(
//                url: "1",
//                title: "會動的文藝復興 4",
//                startDate: "2020/03/24",
//                endDate: "04/20",
//                city: "台南市",
//                township: "仁德區",
//                price: "300"
//            ),
//            CellInfo(
//                url: "2",
//                title: "會動的文藝復興 5",
//                startDate: "2020/03/25",
//                endDate: "04/20",
//                city: "台南市",
//                township: "仁德區",
//                price: "300"
//            ),
//            CellInfo(
//                url: "3",
//                title: "會動的文藝復興 6",
//                startDate: "2020/03/26",
//                endDate: "04/20",
//                city: "台南市",
//                township: "仁德區",
//                price: "300"
//            ),
//        ]
//
//        cellInfoList.accept(info)
//    }
}
