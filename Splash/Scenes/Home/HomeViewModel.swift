//
//  HomeViewModel.swift
//  Splash
//
//  Created by Running Raccoon on 2020/05/21.
//  Copyright © 2020 Running Raccoon. All rights reserved.
//

import Foundation
import RxSwift

enum OrderBy {
    case latest
    case oldest
    case popular
}

protocol HomeViewModelInput {
    //Call when the pull-to-refresh is invoked
    var refreshProperty: BehaviorSubject<Bool> { get }
    
    //Call when the bottom of the list is reached
    var loadMoreProperty: BehaviorSubject<Bool> { get }
    
    //Call when an OrderBy value is invoked
    var orderByProperty: BehaviorSubject<OrderBy> { get }
}

protocol HomeViewModelOutput {
    //Emits a boolean when the pull-to-refresh control is refreshing or not.
    var isRefreshing: Observable<Bool> { get }
    
    //Emits a boolean when the content is loading or not.
    var isLoadingMore: Observable<Bool> { get }
    
    //Emits an OrderBy value when an OrderBy option is chosen
    var isOrderBy: Observable<OrderBy> { get }
    
    //Emits a boolean  when the first page is requested
    var isFirstPageRequested: Observable<Bool> { get }
    //Emites the child viewModels
    //var homeViewCellModelTypes: Observable<[HomeViewController]
}

protocol HomeViewModelType {
    var inputs: HomeViewModelInput { get }
    var outputs: HomeViewModelInput { get }
}

class HomeViewModel {
    
    //MARK: - Inputs & Outputs -
    
    //MARK: - Input -
    let refreshProperty = BehaviorSubject<Bool>(value: true)
    let loadMoreProperty = BehaviorSubject<Bool>(value: false)
    let orderByProperty = BehaviorSubject<OrderBy>(value: .latest)
    
    //Mark: - Output -
    let isRefreshing: Observable<Bool>
    let isLoadingMore: Observable<Bool>
    let isOrderBy: Observable<Bool>
    let isFirstPageRequested: Observable<Bool>
//    let homeViewCellModelTypes: Observable<[HomeViewCellModelType]>
}