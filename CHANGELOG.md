## 1.0.0+1

* **BREAKING**: fix: route aware modals when using MaterialApp.router
  * Instead of `navigatorObservers: [RouteObserver<ModalRoute<dynamic>>()]` use `navigatorObservers: [modalsRouteObserver]`
* fix: remove optional bang operators (Thanks @Maatteogekko)
* fix: linter warnings


## 0.0.3

* feat: add more tests
* fix: allow using setState within onRemove callback


## 0.0.2+2

* fix: readme

## 0.0.2+1

* fix: changelog

## 0.0.2

* feat: position modals by alignment
* feat: dismiss by tapping modal barrier
* docs: update readme
* docs: add example gifs

## 0.0.1+1

* fix: package description

## 0.0.1

* Initial Version of the Library
