//
//  Network.swift
//  bc
//
//  Created by Evgeny Hailov on 30.06.2023.
//

import Foundation
import Alamofire

public typealias HttpConnectionResult = (Any?, NSError?) -> Void

public class HttpConnection {
    
    public func execute(_ address: String, parameters: [String: String]?, method: String, result: @escaping HttpConnectionResult) {
        var af: DataRequest
        
        if method == "GET" {
            let address = String(format: "%@%@", address, getStringParameters(parameters))
            af = AF.request(address, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: getHTTPHeaders())
        } else if method == "POST" {
            af = AF.request(address, method: .post, parameters: parameters, encoding: URLEncoding.httpBody, headers: getHTTPHeaders())
        } else {
            return
        }
        
        af.validate(contentType: ["text/html", "application/json", "application/octet-stream"])
        af.response { [self] data in
            if data.error != nil {
                result(nil, getError(data.error!.errorDescription))
                return
            }
            let statusCode = data.response?.statusCode
            if statusCode == 200 {
                result(parceJson(data.data!), nil)
            } else {
                result(nil, getError("statusCode != 200"))
            }
        }
    }
    
    private func getError(_ errorDescription: String?) -> NSError {
        if errorDescription == nil {
            let userInfo = [NSLocalizedDescriptionKey : "unknown error"]
            return NSError(domain: "BC_Error", code: 1, userInfo: userInfo)
        }
        let userInfo = [NSLocalizedDescriptionKey : errorDescription!]
        return NSError(domain: "BC_Error", code: 1, userInfo: userInfo)
    }
    
    private func getStringParameters(_ parameters: [String: Any]?) -> String {
        var requestString = ""
        if parameters != nil {
            for (key, value) in parameters! {
                requestString = requestString.appending(String(format: "?%@=%@&", key, value as? String ?? "-"))
            }
        }
        return requestString
    }
    
    private func getHTTPHeaders() -> HTTPHeaders {
        var headers = HTTPHeaders()
        headers.add(HTTPHeader(name: "Content-Type", value: "application/x-www-form-urlencoded"))
        return headers
    }
    
    func parceJson(_ data: Data) -> Any? {
        do {
            return try JSONSerialization.jsonObject(with: data)
        } catch {
            print("Model is error: ", (error))
            return nil
        }
    }
    
}
