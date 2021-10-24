//
//  HomeViewModel.swift
//  CodeChallenge
//
//  Created by Tendai Maswaya on 10/24/21.
//

import Foundation
import UIKit
import Combine
import RxSwift

enum Result<T, E: Error> {
    case Success(T)
    case Failure(E)
}

class HomeViewModel{
    
    var apiService:ApiService!
    
    init(apiService: ApiService) { //inject ApiService
        self.apiService = apiService
    }
    
    private var cancellableSet: Set<AnyCancellable> = []
    var selectedCell:Item!
    let cellSubject = PublishSubject<Item>()
    var disposeBag = DisposeBag()
    
    
    func fetchContent(_ completion : @escaping (Result<Collection, Error>)->())  {
         apiService.getNASAContent()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { status in
                switch status{
                case .failure(let _error): completion(Result.Failure(_error))
                case .finished: print("completed")
                }
            }) { response in
                 completion(Result.Success(response.collection))
        }.store(in: &self.cancellableSet)
    }
    
    func cancelRequests(){
        for item in cancellableSet {
            item.cancel()
        }
    }
    
}
