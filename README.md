# Exploring Modern iOS Architectures

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

###### Approach
* UI: 1 Storyboard with segues
* Model / flow: a `movieManager` dependency is
  * injected through property injection starting at app launch
  * makes all requests including images and storage

###### ToDo
* Add extra tests


<!-- MVVM BEGIN -->

## MVVM + POP
<p align="middle">
    <img src="RepoMedia/MVVM.png" alt="MVC" width="550"/>
</p>

###### Approach
* UI: Xibs
* Model / flow: a `DataManager Singleton` ...
  * makes all network requests  
  * is the only entry-point for anything related to data
  * has a reference to ImageManager and ImageStore

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
