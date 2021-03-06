//
//  SearchViewController.swift
//  Splash
//
//  Created by Running Raccoon on 2020/07/13.
//  Copyright © 2020 Running Raccoon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
class SearchViewController: UIViewController, BindableType {
    
    typealias SearchSectionModel = SectionModel<String, SearchResultCellModelType>
    
    //MARK: - ViewModel -
    var viewModel: SearchViewModelType!
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var noResultView: UIView!
    
    private var searchBar: UISearchBar!
    private var datasource: RxTableViewSectionedReloadDataSource<SearchSectionModel>!
    private var tableViewDataSource: RxTableViewSectionedReloadDataSource<SearchSectionModel>.ConfigureCell {
        return { _, tableView, indexPath, cellModel in
            var cell = tableView.dequeueResuableCell(withCellType: SearchResultCell.self, forIndexPath: indexPath)
            cell.accessoryType = .disclosureIndicator
            cell.bind(to: cellModel)
            return cell
        }
    }
    
    private let disposeBag = DisposeBag()
    
    //MARK: Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSearchBar()
        configureTableView()
        configureBouncyView()
    }
    
    //MARK: Override
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.searchBar.endEditing(true)
    }
    
    //MARK: UI
    private func configureSearchBar() {
        searchBar = UISearchBar()
        searchBar.searchBarStyle = .default
        searchBar.placeholder = "Search Splash"
        navigationItem.titleView = searchBar
        searchBar.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    private func configureTableView() {
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 56
        tableView.register(cellType: SearchResultCell.self)
        datasource = RxTableViewSectionedReloadDataSource<SearchSectionModel>(configureCell: tableViewDataSource
        )
    }
    
    private func configureBouncyView() {
        let bouncyView = BouncyView(frame: noResultView.frame)
        bouncyView.configure(emoji: "🏞", message: "Search Splash")
        bouncyView.clipsToBounds = true
        bouncyView.add(to: noResultView).pinToEdges()
    }
    
    //MARK: BindableType
    func bindViewModel() {
        let inputs = viewModel.inputs
        let outputs = viewModel.outputs
        
        searchBar.rx.text
        .unwrap()
            .bind(to: inputs.searchString)
        .disposed(by: disposeBag)
        
        searchBar.rx.text
        .unwrap()
            .map { $0.count == 0 }
            .bind(to: tableView.rx.isHidden)
        .disposed(by: disposeBag)
        
        searchBar.rx.text
        .unwrap()
            .map { $0.count > 0 }
            .bind(to: noResultView.rx.isHidden)
        .disposed(by: disposeBag)
        
        outputs.searchResultCellModel
            .map { [SearchSectionModel(model: "", items: $0)] }
            .bind(to: tableView.rx.items(dataSource: datasource))
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .execute { [unowned self] _ in
                self.searchBar.endEditing(true)
        }.map { $0.row }
        .bind(to: inputs.searchTrigger)
        .disposed(by: disposeBag)
    }
}
