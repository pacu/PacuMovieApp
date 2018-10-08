# Yet Another Demo MovieDB client App

![YADMDBCA](/readme/v1-iPhone6.png)


In order to meet evaluators' criteria the App must:
* Use [MovieDB APIv3](https://developers.themoviedb.org/3) for Movies and Tv Shows 
* must have show 3 categories from movies or TV Shows (popular, top rated, upcoming)
* must show a Movie or show detail's 
* offline capabilities
* offline search by category


## Extra perks
1. Play videos on movie o show's detail
2. Animations, Transitions, Nice UI/UX 
3. Online Search 
4. Unit Tests

## Important Notice
I did not commit my apikey, so you have to put your own plist on the project 
![how](/readme/plist-location.png)

your file should look like this
![plistmagic](/readme/plist-sample.png)

you either respect the "naming convention" or modify the source code of the AppEnvironment helper
```swift
class AppEnvironment {
    
    
    private struct Constants {
        static let configFileName = "dontCommitThis"
```

# v1 
checkout tag "v1" to see this stage
V1 of the app uses Mocked APIs to build a basic results page

## What's on V1

- [x] Use [MovieDB APIv3](https://developers.themoviedb.org/3) for Movies and Tv Shows 
- [x] must have show 3 categories from movies or TV Shows (popular, top rated, upcoming)


## Project Structure
![project structure](/readme/v1-structure.png)

* Resources
  Anything including: Storyboards, Xib files, json files, plist files 
* movieDb the code itself
  * Navigation: empty, if there is any navigation functionality that must be coded aside from view controller this will be the place to look for them
  * Views: 
    standalone views
    * Components: 
      reusable view components like the description view
    * Cells: 
      conceptually, cells can be single views too and I place them there
  * Utils: 
    utility classes, handy extensions and more awesome swifty perks can be found here
  * ViewControllers: 
    all the view controllers are here.
    * components: 
    these are components that are thought to be used in [ViewController containment](https://developer.apple.com/library/archive/featuredarticles/ViewControllerPGforiPhoneOS/ImplementingaContainerViewController.html)
  * Config: 
    all source code meant to act as configuration of the app will be placed here
  * Model: 
    models for the data we show to the user in our views
  * Client: 
    the "API" that will bring that from the movie db API
    * Services: service implementations
    * Target Types: kind of targets we can make resquests to.
  * DataSources:
    The good old reusable data sources for our table or collection views. 


# API Client arquitecture
The idea behind this API is to make it as Simple and Swifty as possible. KISaSS (Keep It Simple and Swifty Stupid, wait...that did not come out as expected)

We have two basic components: Services and TargetTypes. 

A Target Type is a protocol 
```swift
public protocol TargetType {
    
    /// The target's base `URL`.
    var baseURL: URL { get }
    
    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String { get }
    
    /// The HTTP method used in the request.
    var method: String{ get }
    
    /// The parameters to be encoded in the request.
    var parameters: [String: Any]? { get }
    
    // mock file name to serve
    var mockFileName: String? { get }

}
``` 

TargetType implementors will determine which URL, HTTP Method and Parameters will be used to make requests against the API we want to call 
**for example:** movies and tv show results, use different REST URLs but, but except for a few differences, they bring almost the same response type.   

I created a *Movie Target Type* and a *TV Target Type*, so that I can choose from movie categories which are all three, and TV Shows that actually has two.

```swift

extension TargetType {
    public var baseURL: URL { get {
        return URL(string: "https://api.themoviedb.org/3")!
        }
    }
}

public enum MovieTargetType: TargetType {
    
    
    
    case popular
    case topRated
    case upcoming
    
    public var path: String {
        get {
            switch self {
            case .popular:
                return "/movie/popular"
            case .topRated:
                return "/movie/top_rated"
            case .upcoming:
                return "/movie/upcoming"
            }
        }
    }
    
   public var method: String {
        get {
            return "GET"
        }
    }
    public var parameters: [String : Any]? {
        get {
            return AppEnvironment.shared.defaultParameters()
        }
    }
    
    public var mockFileName: String? {
        get {
            switch self {
            case .popular:
                return "popularity_page_1.json"
            case .topRated:
                return "top_rated_page_1.json"
            case .upcoming:
                return "upcoming_page_1.json"
            }
        }
    }
    
}

public enum TVTargetType: TargetType {
    
    case popular
    case topRated
    
    public var path: String {
        get {
            switch self {
            case .popular:
                return "/tv/popular"
            case .topRated:
                return "/tv/top_rated"
            
            }
        }
    }
    
    public var method: String {
        get {
            return "GET"
        }
    }
    public var parameters: [String : Any]? {
        get {
            return AppEnvironment.shared.defaultParameters()
        }
    }
    
    public var mockFileName: String? {
        get {
            switch self {
            case .popular:
                return "tv_shows_popularity_page_1.json"
            case .topRated:
                return "tv_shows_top_rated_page_1.json"
            }
        }
    }
}
```

Target Types do not do anything on their own. They need a Service to feed from their knowledge on the API and make the requests through the network layer. 

Thanks to Target Types, Result Services are as simple as implementing it's protocol.


```swift
public typealias ResultBlock =  (_ result: ResultsResponse?, _ error: Error?) -> Void

public protocol MovieDBResultService: class {
    static func fetchResult(apiTarget: TargetType, page: Int?, resultBlock: @escaping ResultBlock) -> Void
}
```

then when calling a service from a datasource you would do the following:
```swift 
service.fetchResult(apiTarget: targetType, page: page) { [weak self](response, error) in
...
```

Is up to you whether your services reaches out the web or a cache for contents. In this case, we are using a mocked API. But our View and Controllers do not need to know about it. Don't be rude, don't tell them ;-). This is a basic principle called **separation of concern**.

In *MovieDbCollectionViewDataSource
* I hard coded the mock api and everything works as expected. 

```swift
public class MovieDbCollectionViewDataSource: PagedResultCollectionViewDataSource {
    
    private struct PagingData {
        var totalPages: Int?
        var totalResults: Int?
        var page: Int?
    }
    
    public var targetType: TargetType
    public var delegate: ResultDataSourceDelegate
    private var service: MovieDBResultService.Type = MovieDBResultAPIMock.self
```

# Results by category 
One controller to rule them all

I build my CollectionView Data Source around Target Types. By using composition with builder objects and factory methods, I can build 'complex' objects that perform different tasks based on the capabilites of the parts that compose them. 

A *ResultViewController* receives a target type enum to that will tell it's data source object what to load. This can be managed in a more fine grained way but, this type of granularity is enough to be *easy to understand* and *flexible* enough to use on different cases

```swift 
public static func create(targetType: TargetType) -> ResultViewController? {
        guard let resultController = ResultViewController.create() else { return nil }
        let dataSource = MovieDbCollectionViewDataSource(targetType: targetType, delegate: resultController)
        resultController.collectionViewDataSource = dataSource
        return resultController
    }
```

# Cocoa Pods 
I try to keep the usage of third party libraries to the bare minimum. A good checklist to decide whether to use a pod or create your own
- [x] last commit is recent
- [x] project is well documented and supports last language version 
- [x] has been starred and/or forked by many people
- [x] it's usage is not intrusive
- [x] it's not overkill (importing heavy library for a small feature in return)
- [x] does not have tons of dependencies
- [x] learn to master it won't take as long as implementing your own


# Why didn't you use one of those MovieDB cocoa pods?
well, it did not meet the checklist's criteria, plus, anyone can build an App around pods. It's not the goal of this demo App to proof myself I can be a newbie iOS developer all over again.

# Some basic ground rules to build ~great~ decent software

## Single Responsibility Principle
[Wikipedia](https://en.wikipedia.org/wiki/Single_responsibility_principle)
Avoid "god objects" at all costs. Balance every class to 'mind its own business' and to 'to work with others'. Compose functionality with small, well delimited classes that perform different aspects that build that functionality. It does not matter whether you want to achieve it Top-Down or Bottom-Up.

## Clean Code

*- Clean code is simple and direct. Clean code reads like well-written prose. Clean code never obscures the designer’s intent but rather is full of crisp abstractions and straightforward lines of control*, **Grady Booch**, author of Object Oriented Analysis and Design with Applications 

**Kent Beck’s rules of simple code. In priority order, simple code:**
* Runs all the tests;
* Contains no duplication;
* Expresses all the design ideas that are in the system;
* Minimizes the number of entities such as classes, methods, functions, and the like.
