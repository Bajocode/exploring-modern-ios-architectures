# Exploring Modern iOS Architectures

![Alamofire: Elegant Networking in Swift](RepoMedia/Header.png)

#### Project
In this project I'm structuring my knowledge about modern architectural patterns,
showcasing the main features through a simple Movie app. The app makes use of
the [Tmdb API](https://www.themoviedb.org/documentation/api) which requires an API key. However, static
`JSON` files are also included for quick usage.

#### Setup

###### Static JSON
1. In Xcode, choose a target / architecture
2. Build and run!

###### Tmdb requests
1. [Request an API key](http://https://www.themoviedb.org/faq/api) :key:
2. Insert your key in `TmdbAPIKey.plist` located at the root of `/Architectures`
3. In Xcode, choose a target / architecture
4. Build and run!

#### Architectural Questions
As I work through the architectures I will experiment with different setups while keeping the core principles of the architectures in mind. Some important aspects to consider:

:small_blue_diamond: **Orthogonality:** responsibilities, distribution, coupling etc.

:small_blue_diamond: **Ease of use:** how easy is it to set up and implement?

:small_blue_diamond: **Testability:** is it easy and convenient to test?

---

<!-- MVC BEGIN -->

## MVC-S
<p align = "middle">
    <img src="RepoMedia/MVC.png" alt="MVC"  width="350"/>
</p>

###### Approach for this project
* **Model**
  * Business logic, data transformation and store
  * `movieManager` dependency is injected through property injection starting at app launch
  * It makes all requests including images and has a reference to the `imageStore`
* **View**
  * The cell configured directly with the Model
  * UI presentation flow: UIStoryboard with segues
* **Controller**
  * Mediator between view and Model
  * Delegate and datasource
  * Dispatching and canceling network requests


###### ToDo
* Add networking tests


<!-- MVVM BEGIN -->

## MVVM + POP
<p align="middle">
    <img src="RepoMedia/MVVM.png" alt="MVC" width="550"/>
</p>

###### Approach
* **Model**
  * A raw representation of the data
* **View**
  * (MVC) ViewControllers are the views
  * Updates it’s state from the View Model by setting up bindings
  * UI presentation flow: individual Xibs
* **ViewModel**
  * Invokes changes in Model and updates itself + binding View
  * This project implements bindings through callbacks instead of reactive binds (RXSwift etc.)
  * Triggers all network call through a `DataManager singleton`

*A tabBarController is added as a presenter of generic viewControllers*


###### ToDo
* Add tests

## MVP

## VIPER

---
#### References
* [The Pragmatic Programmer](https://pragprog.com/book/tpp/the-pragmatic-programmer)
* [iOS Architecture Patterns (Medium)](https://medium.com/ios-os-x-development/ios-architecture-patterns-ecba4c38de52)
* [Protocols and MVVM in Swift to avoid repetition](https://sudo.isl.co/swift-mvvm-protocols/)
* [Introduction to Protocol-Oriented MVVM](https://news.realm.io/news/doios-natasha-murashev-protocol-oriented-mvvm/)
