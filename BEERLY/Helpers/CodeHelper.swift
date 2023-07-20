//
//  CodeHelper.swift
//  BEERLY
//
//  Created by Zhansuluu Kydyrova on 10/7/23.
//


import Foundation

final class CodeHelper {
    static func decodeDataToObject<T: Codable>(data: Data?) -> T? {
        if let data {
            do {
                return try JSONDecoder().decode(T.self, from: data)
            } catch let DecodingError.dataCorrupted(context) {
                print(context)
            } catch let DecodingError.keyNotFound(key, context) {
                print("🔑Key: '\(key)' not found:", context.debugDescription)
                print("Coding path:", context.codingPath)
            } catch let DecodingError.valueNotFound(value, context) {
                print("😭Value: '\(value)' not found:", context.debugDescription)
                print("Coding path:", context.codingPath)
            } catch let DecodingError.typeMismatch(type, context) {
                print("👻Type: '\(type)' mismatch:", context.debugDescription)
                print("Coding path:", context.codingPath)
            } catch {
                print("error: \(error.localizedDescription)")
            }
        }
        return nil
    }
    
    static func encodeObjectToData<T: Codable>(object: T) -> Data? {
        guard let jsonData = try? JSONEncoder().encode(object).toJSON()?.compactMapValues({ $0 }) else { return nil }
        if let theJSONData = try? JSONSerialization.data(
            withJSONObject: jsonData,
            options: [.sortedKeys]) {
            _ = String(data: theJSONData, encoding: .ascii)
            return Data(theJSONData)
        }
        return nil
    }
}

extension Data {
    func toJSON() -> [String: Any]? {
        do {
            return try JSONSerialization.jsonObject(with: self, options: .allowFragments) as? [String: Any]
        } catch let error as NSError{
            print("Data toJSON error:", error)
            return nil
        }
    }
}

