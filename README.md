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
- [x] offline support for images (cache)

## What's on V1.0.1
![detail view](/readme/Detail-iPhone6.png)
- [x] Use [MovieDB APIv3](https://developers.themoviedb.org/3) for Movies and Tv Shows 
- [x] must have show 3 categories from movies or TV Shows (popular, top rated, upcoming)
- [x] offline support for images (cache)
- [x] must show a Movie or show detail's
 
## What's on V1.1.0
- [x] Use [MovieDB APIv3](https://developers.themoviedb.org/3) for Movies and Tv Shows 
- [x] must have show 3 categories from movies or TV Shows (popular, top rated, upcoming)
- [x] offline support for images (cache)
- [x] must show a Movie or show detail's
- [x] Connect to real services using Alamofire 
## What's pending?

- [ ] offline support for models
- [ ] offline categorized search 
- [ ] online search
- [ ] UITests


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

# View Architecture: Lightweight MVC with UIViewController containment
Complaining about MVC is a mistake. A long time ago in a galaxy far far away Apple Biased iOS Developers with clunky sample code which everyone took way too seriously. Old Apple Docs had Massive View Controllers Everywhere. Code Quality was in decay and Apple reacted soon but maybe not enough. Bad implementations of MVC were everywhere and the pattern was going to be the one to blame. Shame on us Developers! 


Some patterns gained momentum quickly, specially MVVM and VIPER. Personally I had setbacks with MVVM because the lack of widespread adoption of Reactive Cocoa/Swift. Many Developers adopted MVVM without Reactive because the latter can be a debugging madness, but there's no much to gain without it. ViewModes turn into massive mediator objects and code Reusability  affected. VIPER is a nice pattern to adopt on Apps with complex navigation paths, although if that's your situation, you should tune it up a little more before jumping to the VIPER ship.

I like to achive lightweight MVC with ViewController containment. The containment code is pretty reusable by adopting protocols and mixins. Plus it helps enforcing two positive aspects: Protocol Oriented Programming and Atomic Design. This means: Think of your screens as a collection of components with simple and unique responsibilities. DetailViewController is a quick implementation of it. 

## Cutting the Storyboard sugar
Storyboards are great, but they turn into clunky beach ball generators as soon as you reach a few complex view controllers. Furthermore it's impossible to collaborate on them. Storyboard references are an improvement, but linking XML files within XML files, is error prone. It only takes one typo to get a cryptic runtime error and start loosing time and your mind on it.
That's why I use separate storyboards and nib files for my view controllers and views.

## when to use xib and storyboard
nib files practical for small views tha do not involve controller containment and just display simple stuff. Storyboards for all the rest of the use cases. 

# API Client Architecture
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

public enum MovieTargetType: TargetType, Detailable {
    
    case popular
    case topRated
    case upcoming
    case detail(id: Int)
    
    public func detailify(id: Int) -> DetailTargetType {
        return MovieTargetType.detail(id: id)
    }
    
    public var path: String {
        get {
            switch self {
            case .popular:
                return "/movie/popular"
            case .topRated:
                return "/movie/top_rated"
            case .upcoming:
                return "/movie/upcoming"
            case .detail(let id):
                return "/movie/\(id)"
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
            case .detail( _):
                return "venom_detail.json"
            }
        }
    }
    
}

public enum TVTargetType: TargetType, Detailable {
    
    case popular
    case topRated
    case detail(id: Int)
    
    public var path: String {
        get {
            switch self {
            case .popular:
                return "/tv/popular"
            case .topRated:
                return "/tv/top_rated"
            case .detail(let id):
                return "/tv/\(id)"
            }
        }
    }
    public func detailify(id: Int) -> DetailTargetType{
        return TVTargetType.detail(id: id)
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
            case .detail( _):
                return "venom_detail.json"
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

Is up to you whether your services reaches out the web or a cache for contents. In this case, we can use a network or a mocked API. But our View and Controllers do not need to know about it. Don't be rude, don't tell them ;-). This is a basic principle called **separation of concern**.

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

## Network Layer
Believe it or not, out network layer only a few lines of code

```swift
class NetworkConnector {
    
    static func performRequest<T: Decodable>(responseType: T.Type, target: TargetType, responseBlock: @escaping (_ response: T?, _ error: Error?) ->()) {
        
        target.request.validate(statusCode: 200..<300).responseDecodable {
            (r:DataResponse<T>) in
            
            switch r.result {
            case .success(let value):
                responseBlock(value, nil)
                return
            case .failure(let error):
                responseBlock(nil, error)
            }
            
        }
        
    }
}
```
*How did you pull that one out? the dust must be under some other rag* 

Well... actually no. The service layer it's pretty small as well
```swift
public class MovieDBResultAPI: MovieDBResultService {
    
    public static func fetchResult(apiTarget: TargetType, page: Int?, resultBlock: @escaping ResultBlock) {
        NetworkConnector.performRequest(responseType: ResultsResponse.self ,target: apiTarget) { (result, error) in
            resultBlock(result,error)
        }
    }
    
    public static func fetchDetail(id: Int?, apiTarget: TargetType, resultBlock: @escaping DetailBlock) {
        NetworkConnector.performRequest(responseType: ItemDetail.self, target: apiTarget) { (detail, error) in
            resultBlock(detail,error)
        }
    }
}
```

First, I moved all Alamofire wrappers and data type helpers to a TargetType *protocol extension* in a separate file.

```swift
extension TargetType {
    
    var request: DataRequest {
        return Alamofire.request(self.url, method: HTTPMethod.init(rawValue: self.method) ?? .get, parameters: self.af_parameters, encoding: URLEncoding.default, headers: self.af_headers)
    }

    var af_parameters: Parameters? {
        return self.parameters
    }
    var af_headers: HTTPHeaders? {
        return self.headers
    }
    var url: URL {
        return self.baseURL.appendingPathComponent(self.path)
    }
}
```
By doing so, you can actually choose to make this private to your client classes and detach your code from your network layer implementation of choice.

Alamofire Response Mapping and Swift Generics work all the magic for us. I grab this snippet from this [medium.com blog](https://medium.com/@mhacnagbani/alamofire-generic-response-object-serialization-using-codable-13db342347b2) which is a lightweight refactor of what can be found on [the official documentation](https://github.com/Alamofire/Alamofire/blob/master/Documentation/AdvancedUsage.md#response-mapping)
```swift
extension DataRequest {
    
    private func decodableResponseSerializer<T: Decodable>() -> DataResponseSerializer<T> {
        return DataResponseSerializer { _, response, data, error in
            guard error == nil else { return .failure(error!) }
            
            guard let data = data else {
                return .failure(AFError.responseSerializationFailed(reason: .inputDataNil))
            }
            
            return Result { try JSONDecoder().decode(T.self, from: data) }
        }
    }
    
    @discardableResult
    func responseDecodable<T: Decodable>(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
        return response(queue: queue, responseSerializer: decodableResponseSerializer(), completionHandler: completionHandler)
    }
}
```

What it does is to use Decodable protocol as a "Custom response type" to DataResponse<_> 

It seems a little bit of a long shot from the compiler's point of view and we need to tip him off a little by being redundant on the method signature of NetworkConnector like this 

```swift
class NetworkConnector {
    
    static func performRequest<T: Decodable>(responseType: T.Type, target: TargetType, responseBlock: @escaping (_ response: T?, _ error: Error?) ->()) {
```

If this is the first time you've seen this pattern, it might seem quite an overkill. Trust me on this. I worked on Inheritance based Client APIs and you end up having the same amount of LoCs, but **mutiplied by the amount of responses urls** 🙀

If you are curious and want to know more about it, all the credit corresponds to @Moya [Moya](https://github.com/Moya/Moya)

## putting Network client in action
Just one line of code in the data source
```swift
private var service: MovieDBResultService.Type = MovieDBResultAPI.self
```
that's it
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

# UI Testing 

User Interface testing follows a Controller - Validator pattern

Controllers have the responsibility of accessing and navigating through the app.

Common behavior is made available through protocols for the different controllers to adopt as needed

``` swift 
protocol AppController {
    var app: XCUIApplication { get }
}

protocol MainScreenController: AppController {
    
    func tapMoviesTab()
    func tapShowsTab()
    
}

extension MainScreenController {
    
    func tapMoviesTab() {
        app.buttons["Movies"].tap()
    }
    
    func tapShowsTab() {
        app.buttons["Shows"].tap()
    }
    
}

```

**Validators** are the ones in charge of testing each screen consistency.

``` swift 
struct MovieTabValidator {
    
    static func validateSegments(app: XCUIApplication) {
        let topRatedSegment = app.buttons["Top Rated"]
        let upcomingSegment = app.buttons["Upcoming"]
        let popularSegment = app.buttons["Popular"]
        
        XCTAssertTrue(topRatedSegment.isHittable)
        XCTAssertTrue(upcomingSegment.isHittable)
        XCTAssertTrue(popularSegment.isHittable)
    }
    
    static func validatePopularSegment(isSelected: Bool, on app: XCUIApplication){
        
        let popularSegment = app.buttons["Popular"]
        XCTAssert(popularSegment.isSelected == isSelected)
    }
}
```

Consequently, UI Test are composed simply by articulating **controllers** to emulate application usage and **validators** to make the corresponding assertions

``` swift 
 func testMainControls() {      
        let movieTab = app.buttons["Movies"]
        let showsTab = app.buttons["Shows"]
       
        
        // all controls are hittable
        XCTAssertTrue(movieTab.isHittable)
        XCTAssertTrue(showsTab.isHittable)
      
        // validate Movie Tab
        
        MovieTabValidator.validateSegments(app: app)
        
        // on launch first tab should be selected and popular
        // should be the segment selected
        
        XCTAssert(movieTab.isSelected)
        MovieTabValidator.validatePopularSegment(isSelected: true, on: app)
    }
```