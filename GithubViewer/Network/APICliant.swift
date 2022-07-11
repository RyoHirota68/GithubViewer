//
//  APIClient.swift
//  GithubViewer
//
//  Created by 弘田諒 on 2022/07/07.
//

import Foundation
import Alamofire
import RxSwift

enum APIResult {
    case success(Codable)
    case failure(Error)
}

struct APICliant {
    private static let successRange = 200..<400
    private static let contentType = ["application/json"]
    
    
    /// 通信を行う際はこの関数を呼び出す
    /// - Parameters:
    ///   - request: BaseRequestProtocolに準拠
    ///   - disposeBag: DisposeBag()
    ///   - onSuccess: 成功
    ///   - onError: 失敗
    static func call<T, V>(_ request: T,
                           _ disposeBag: DisposeBag,
                           onSuccess: @escaping (V) -> Void,
                           onError: @escaping (Error) -> Void)
    where T: BaseRequestProtocol, T.ResponseType == V {
        
        _ = observe(request)
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { onSuccess($0) },
                       onFailure: { onError($0) })
            .disposed(by: disposeBag)
    }
    
    static func observe<T,V>(_ request: T) -> Single<V>
    where T: BaseRequestProtocol, T.ResponseType == V {
        
        return Single<V>.create { observer in
            let calling = callForData(request) { response in
                switch response {
                    //既にsuccessで返ってきているので強制キャスト
                case .success(let result):
                    observer(.success(result as! V))
                case .failure(let error):
                    observer(.failure(error))
                }
            }
            
            return Disposables.create{
                calling.cancel()
            }
        }
    }
    
    private static func callForData<T, V>(_ request: T, completion: @escaping(APIResult) -> Void) -> DataRequest
    where T: BaseRequestProtocol, T.ResponseType == V {
        
        return afRequest(request).responseData { response in
            switch response.result {
            case .success(_):
                let data: T.ResponseType = try! JSONDecoder().decode(T.ResponseType.self, from: response.data!)
                completion(.success(data))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    
    /// 実際の通信部分
    /// - Parameter request: <#request description#>
    /// - Returns: <#description#>
    private static func afRequest<T>(_ request: T) -> DataRequest
    where T: BaseRequestProtocol {
        
        return AF
            .request(request)
            .validate(statusCode: successRange)
            .validate(contentType: contentType)
    }
}
