//
//  ResultItemDataSource.swift
//  movieDB
//
//  Created by Francisco Gindre on 6/10/18.
//  Copyright © 2018 Francisco Gindre. All rights reserved.
//

import Foundation
import UIKit

public protocol ResultDataSourceDelegate {
    func willBeginLoading(_ dataSource: ResultDataSource)
    func didFinishLoading(_ dataSource: ResultDataSource)
    func didFinishLoadingNoResults(_ dataSource: ResultDataSource)
    func didFinishLoading(_ dataSource: ResultDataSource, withError: Error?)
}

public protocol ResultDataSource {
    var targetType: TargetType { get set }
    var delegate: ResultDataSourceDelegate { get set }
    func item(at indexPath: IndexPath) -> ResultItem?
    func load()
}

public protocol PagedDataSource {
    func loadNextPage()
}

public typealias PagedResultCollectionViewDataSource = NSObject & ResultDataSource & PagedDataSource & UICollectionViewDataSource

public class MovieDbCollectionViewDataSource: PagedResultCollectionViewDataSource {
    
    private struct PagingData {
        var totalPages: Int?
        var totalResults: Int?
        var page: Int?
    }
    
    public var targetType: TargetType
    public var delegate: ResultDataSourceDelegate
    private var service: MovieDBResultService.Type = AppEnvironment.shared.useMocks ? MovieDBResultAPIMock.self :  MovieDBResultAPI.self
    
    private var paging = PagingData(totalPages: 0,totalResults: 0,page: 0)
    private var results: [ResultItem]?
    
    init(targetType: TargetType, delegate: ResultDataSourceDelegate) {
        self.targetType = targetType
        self.delegate = delegate
    }
    
    
    public func load() {
        self.delegate.willBeginLoading(self)
        load(page: paging.page ?? 0)
    }
    
    private func append(results: [ResultItem]) {
        
        if var _results = self.results {
            _results.append(contentsOf: results)
            return
        }
        
        self.results = [ResultItem](results)
        
    }
    
    private func noResults(resultResponse: ResultsResponse) -> Bool {
        guard let results = resultResponse.results, let page = resultResponse.page else {
            return false
        }
        
        return results.count > 0 && page == 0
    }
    
    private func load(page: Int) {
        service.fetchResult(apiTarget: targetType, page: page) { [weak self](response, error) in
            
            guard let `self` = self else {
                print("no self, who am I")
                assert(false)
                return
                
            }
            guard let resultResponse = response else {
                self.delegate.didFinishLoading(self, withError: error)
                return
            }
            
            if self.noResults(resultResponse: resultResponse) {
                self.delegate.didFinishLoadingNoResults(self)
                return
            }
            
            guard let results = resultResponse.results else {
                self.delegate.didFinishLoading(self, withError: nil)
                return
            }
            
            self.paging = PagingData(totalPages: resultResponse.totalPages, totalResults: resultResponse.page, page: resultResponse.totalPages)
            self.append(results: results)
            self.delegate.didFinishLoading(self)
            
        }
    }
    
    public func loadNextPage() {
        guard let currentPage = paging.page, let totalPages = paging.totalPages,
            (0 ..< totalPages).contains(currentPage + 1) else { return }
    }
    
    public func item(at indexPath: IndexPath) -> ResultItem? {
        guard let results = results,
            (0 ..< results.count).contains(indexPath.row) else {
                print("no results")
                assert(false)
                return nil}
        
        return results[indexPath.row]
    }
    
    // Mark: CollectionView Delegate
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let item = results?[indexPath.row] else {
            print("no results but the datasource is trying to paint rows")
            assert(false)
            return UICollectionViewCell()
        }
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResultItemCollectionViewCell._reuseIdentifier, for: indexPath) as? ResultItemCollectionViewCell else {
            print("Could not dequeue ResultItemCollectionViewCell")
            assert(false)
            return UICollectionViewCell()
        }
        
        cell.setUp(model: item)
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results?.count ?? 0
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}



