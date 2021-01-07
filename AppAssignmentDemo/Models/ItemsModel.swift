//
//  ItemsModel.swift
//  AppAssignmentDemo
//
//  Created by Piyush Naredi on 06/01/21.
//

import Foundation

///ITems Model
class ItemsModel: Codable {
    var image: String?
    var description: String?
    var title: String?
    
    ///gets paresed items data from response object
  static func getParsedItemsData(from response: AnyObject?) -> [ItemsModel]? {
        if let responseData = response {
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: responseData, options: .prettyPrinted)
                let jsonDecoder = JSONDecoder()
                let itemsData = try jsonDecoder.decode([ItemsModel].self, from: jsonData)
                return itemsData
            } catch {
                debugPrint("Error occured while parsing data:- \(error.localizedDescription)")
            }
        }
        return nil
    }
}
