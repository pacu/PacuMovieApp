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
    private var service: MovieDBResultService.Type = MovieDBResultAPIMock.self
    private var paging = PagingData(totalPages: 0,totalResults: 0,page: 0)
    private var results: [ResultItem]?
    
    
    
    public func load() {
        load(page: paging.page ?? 0)
    }
    
    private func append(results: [ResultItem]) {
        
        if var _results = self.results {
            _results.append(contentsOf: results)
        }
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
    
    init(targetType: TargetType, delegate: ResultDataSourceDelegate) {
        self.targetType = targetType
        self.delegate = delegate
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results?.count ?? 0
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}



