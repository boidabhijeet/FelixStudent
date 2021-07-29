//
//  BatchCellViewModel.swift
//  Felix Student
//
//  Created by Mac on 21/04/21.
//

import Foundation
import Combine

class BatchCellViewModel: ObservableObject, Identifiable {
    
    @Published var batchRepository = BatchRepository()
    var id: String = ""
    @Published var batch: Batch
    
    private var cancellables = Set<AnyCancellable>()
    
    init(batch: Batch) {
        self.batch = batch
    }
}
