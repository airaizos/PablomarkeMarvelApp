//
//  Key.swift
//  MarvelApp
//
//  Created by Adrian Iraizos Mendoza on 25/4/24.
//

import Foundation

extension URL{
    static let MRVL = URL.documentsDirectory.appending(path: "MV.json")
}

var mrvl:(String,String,String) {
if let data = try? Data(contentsOf: .MRVL),
   let keys = try? JSONDecoder().decode([MARVL].self, from: data),
   let first = keys.first(where: { $0.name == "MRVL"}) {
    return (first.ts, first.AK,first.HS)
}
return ("","","")
}

struct MARVL:Codable {
let name: String
let ts:String
let AK:String
let HS:String
}
