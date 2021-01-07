//
//  NetworkManager.swift
//  AppAssignmentDemo
//
//  Created by Piyush Naredi on 06/01/21.
//

import Foundation
import Alamofire

///Network Manager class to get data from server
class NetworkManager {
    
    private init() {}
    
    static let instance = NetworkManager()
    
    let apiUrlStr = "https://gist.githubusercontent.com/ashwini9241/6e0f26312ddc1e502e9d280806eed8bc/raw/7fab0cf3177f17ec4acd6a2092fc7c0f6bba9e1f/saltside-json-data"
    
    func callWebServiceAlamofire(completionHandler: @escaping((Swift.Result<AnyObject?, Error>) -> Void)) {
        let network = NetworkReachabilityManager.init(host: "https://www.google.com")
        
        guard (network?.isReachable ?? false) else {
            completionHandler(.failure(NetworkError.internetError))
            debugPrint("\n No Network Connection")
            return
        }
        
        let request = AF.request(apiUrlStr, method: .get)
        
        request.validate(statusCode: 200..<600).responseJSON(completionHandler: { response in
            let statusCode = response.response?.statusCode ?? 0
            print("\n Response Data: \(response)")
            switch response.result {
            case .success(let data):
                if statusCode == 200 {
                    completionHandler(.success(data as AnyObject))
                } else {
                    completionHandler(.failure(NetworkError.unknownError))
                }

            case .failure(let error):
                debugPrint("\n Failure: \(error.localizedDescription)")
                completionHandler(.failure(error))
            }
        })
    }
}


///Enum for Network Error
enum NetworkError: String, Error {
    case unknownError = "Unknown Error"
    case internetError = "Internet Error"
}

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .unknownError:
            return NSLocalizedString("An error occured while processing your data", comment: self.rawValue)
            
        case .internetError:
            return NSLocalizedString("No Internet Available!!", comment: self.rawValue)
        }
    }
}
