//
//  AllCategoriesService.swift
//  TaiwanArtionApp
//
//  Created by 羅承志 on 2022/8/22.
//

import Alamofire
import RxSwift

class AllCategoriesService {
    
    static func getData() -> Observable<[AllCategories]> {
        return Observable.create({ observer -> Disposable in
            let url: String = "https://cloud.culture.tw/frontsite/trans/SearchShowAction.do?method=doFindTypeJ&category=all"
            AF.request(url, method: .get, encoding: JSONEncoding.default, headers: nil)
                .response { response in
                    if response.response?.statusCode == 400 {
                        print("statusCode: \(String(describing: response.response?.statusCode))")
                    }
                    
                    if let error = response.error {
                        print("Error: \(error)")
                    }
                    
                    guard let responseData = response.data else {
                        return observer.onCompleted()
                    }
                    
                    do {
                        let data = try JSONDecoder().decode([AllCategories].self, from: responseData)
                        observer.onNext(data)
//                        print("Data: \(data)")
                    } catch {
                        observer.onError(error)
                        print("Error: \(error)")
                    }
                }
            return Disposables.create()
        })
    }
}
