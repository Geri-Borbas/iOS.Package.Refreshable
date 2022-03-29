# Refreshable
✳️ SwiftUI Pull to Refresh (for iOS 13 and iOS 14) package.

See complementary article at [SwiftUI Pull to Refresh (for iOS 13 and iOS 14)]. With this extension you can **backport the iOS 15 refreshable modifier to iOS 13 and iOS 14**, and use the exact same code across the board.

https://user-images.githubusercontent.com/1779614/160678139-6f16e4e5-2ec6-4dd6-8f79-87fcdcb05df6.mp4

```Swift
struct ContentView: View {
    
	...
    
    var body: some View {
        List {
            ...
        }
        .refreshable {
            await viewModel.fetch()
        }
    }
}
```

Alternatively, you can opt into the **closure-based API** below to spare using async await API.

```Swift
struct ContentView: View {
    
	...
    
    var body: some View {
        List {
            ...
        }
        .onRefresh { refreshControl in
            viewModel.fetch {
                refreshControl.endRefreshing()
            }
        }
    }
}
```


## License

> Licensed under the [**MIT License**](https://en.wikipedia.org/wiki/MIT_License).

[SwiftUI Pull to Refresh (for iOS 13 and iOS 14)]: https://blog.eppz.eu/swiftui-pull-to-refresh/
