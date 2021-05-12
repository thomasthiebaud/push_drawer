# push_drawer

A sliding drawer, pushing the main view away

Simply use it with 

```
PushDrawer(
    drawerRatio: 0.9,
    drawer: MyDrawerView(),
    child: ContentView(),
),
```

You might want `ContentView` to be a nested Navigator