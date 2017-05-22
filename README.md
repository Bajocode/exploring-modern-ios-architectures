# Exploring Modern iOS Architectures

#### Project
In this project I'm structuring my knowledge about modern architectural patterns,
showcasing the main features through a simple Movie app. The app makes use of
the [Tmdb API](https://www.themoviedb.org/documentation/api) which requires an API key. However, static
`JSON` files are also included for quick usage.

#### Setup

###### With static JSON
1. In Xcode, choose a target / architecture
2. Build and run!

###### With real requests
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

## MVC
<p align = "middle">
    <img src="RepoMedia/MVC.png" alt="MVC"  width="350"/>
</p>

###### Project setup
* UI: 1 Storyboard with segues
* Model / flow: a `movieManager` dependency is
  * injected through property injection starting at app launch
  * makes all requests including images and storage

###### Experiences
<table style="width:100%">
  <tr>
    <th>Orthogonality</th>
    <th>Ease of use</th>
    <th>Testability</th>
  </tr>
  <tr>
    <td>The View and the Model are separated, but the View and the Controller are tightly coupled.</td>
    <td>Very quick easy to set up, probably the least amount of code among other patterns.</td>
    <td>The bad distribution and quickly growing View Controllers make it difficult to test.</td>
  </tr>
</table>

###### ToDo
* Add extra tests


<!-- MVVM BEGIN -->

## MVVM
<p align="middle">
    <img src="RepoMedia/MVVM.png" alt="MVC" width="550"/>
</p>

###### Project setup
* UI: Xibs
* Model / flow: a `DataManager Singleton` ...
  * makes all network requests  
  * is the only entry-point for anything related to data
  * has a reference to ImageManager and ImageStore

###### Experiences
<table style="width:100%">
  <tr>
    <th>Orthogonality</th>
    <th>Ease of use</th>
    <th>Testability</th>
  </tr>
  <tr>
    <td>The View and the Model are separated, but the View and the Controller are tightly coupled.</td>
    <td>Needs more code than MVC, but would probably be lighter when combined with a reactive framework.</td>
    <td>Not yet added</td>
  </tr>
</table>

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
