//
//  SectionModel.swift
//  RxSwift_Beginners_TableViewFoodApp
//
//  Created by 邱慧珊 on 3/31/25.
//

import Foundation
import RxDataSources

struct SectionModel {
    var header: String
    var items: [Food]
}

extension SectionModel: SectionModelType {
    init(original: SectionModel, items: [Food]) {
        self = original
        self.items = items
    }
}
    
    

