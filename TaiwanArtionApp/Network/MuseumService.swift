//
//  MuseumService.swift
//  TaiwanArtionApp
//
//  Created by 羅承志 on 2022/8/22.
//

import Alamofire
import RxSwift

class MuseumService {
    
    func getData() -> Observable<[Museum]> {
        return Observable.create({ observer -> Disposable in
            let url: String = "https://cloud.culture.tw/frontsite/trans/emapOpenDataAction.do?method=exportEmapJson&typeId=H"
            AF.request(url, method: .get, encoding: JSONEncoding.default, headers: nil)
                .response { response in
                    if response.response?.statusCode == 400 {
                        print("statusCode: \(String(describing: response.response?.statusCode))")
                        return observer.onCompleted()
                    }
                    
                    if let error = response.error {
                        print("Error: \(error)")
                        return observer.onCompleted()
                    }
                    
                    guard let responseData = response.data else {
                        return observer.onCompleted()
                    }
                    
                    do {
                        let data = try JSONDecoder().decode([Museum].self, from: responseData)
                        observer.onNext(data)
                        observer.onCompleted()
                        print("Data: \(data)")
                    } catch {
                        observer.onError(error)
                        observer.onCompleted()
                        print("Error: \(error)")
                    }
                }
            return Disposables.create()
        })
    }
}
