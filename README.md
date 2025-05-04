## 🚀 What has been added since the last submission ##


### 1) Offline-First Architecture Verified with 100% Test Coverage

The `NewsListLocalDataSource`, built using Hive for local persistence,  
has been thoroughly verified through a dedicated test suite.  
This suite confirms reliable offline-first behavior across all edge cases.

During this process, several areas of business logic were  
refined, cleaned up, and improved as part of the test-driven development flow.

![App Demo](Tablet-view-final.gif)


## ✅ What I cared most about in development

- 🧩 App Architecture  
- ⚙️ Functionality of the app  
- 📄 Documentation  
- 🖌️ Design  
- 📱 Responsiveness  
- 🧪 Test Strategy  

---

## 🚫 Not implemented

- 🔐 Secure storage of API key  
- 💻 Responsive design (Only master–detail layout on tablets is supported)  
- 🧪 Complete test strategy  
- 🔀 Routing library  
- 🎨 Theming policy  

---

## 🧠 Things to keep in mind

- 🧪 The app is testable, and I started development using TDD principles.  
- 🏛️ Domain layer is isolated and holds business rules.  
- 📦 A data layer exists to fetch and cache remote data.  
- 🧱 I defined three packages:
  - `domain_layer`: Pure Dart
  - `data_layer`: Depends on domain
  - `injection_layer`: Manages DI
- 📱 The main app depends only on the domain and injection

---

## 🔌 API Integration

- 🔗 Used NewsAPI to fetch top US news headlines  
- ⏰ Time range: from yesterday until now  
- 🔍 Queried: Microsoft, Apple, Google, Tesla  
- 📚 Endpoint: `/v2/everything`  
- ✅ Aggregated via 4 API calls (one per company)  
- ⚙️ Used `sortBy=publishedAt`, `language=en`, `pageSize=25`

```dart
@GET('/everything')
Future<GetTopHeadlineResponse> getTopHeadlinesUS(
  @Query('apiKey') String apiKey,
  @Query('page') int page,
  @Query('pageSize') int pageSize,
  @Query('q') String query,
  @Query('from') String fromDate,
  @Query('to') String toDate,
  @Query('language') String language,
);
```

---

## 🖼️ User Interface

- 📋 `NewsListPage` displays headlines  
- 🚀 On launch, `GetTopHeadlinesUS` is triggered  
- 🔁 Uses `infinite_scroll_pagination`  
- 🎨 Query type shown visually  
- 📄 `NewsDetailPage` displays full article  
- 📱 Responsive:
  - Mobile: navigates to detail screen
  - Tablet: master–detail layout  

---

## 📦 Caching & Offline Handling

- 🗂️ Uses `hive` for local cache  
- 🌐 Uses `connectivity_plus` to detect connection  
- 🔄 If offline, loads from cache  
- ❗ Shows error if no cache and offline  

---

## 🧱 Architecture

- ✅ Clean Architecture  
- 🧼 Proper layering and isolation  
- 🔗 No cross-layer dependency leaks  
- 📦 Follows package-based modular design  
- 🧩 Uses Cubit for business logic and state  

---

## 🧪 Testing

- ✅ Domain models are tested  
- 🚧 Full testing not implemented  
- 🧪 Architecture supports testability  
- ✅ Used Equatable, Either, Failure patterns  

---

## 📌 Additional Notes

- 📍 `query` is preserved and shown with each article  
- 📑 Detail screen is clean and scalable  
- 🧰 Only minimal third-party dependencies used
- 📍Splash page added to make app more like a real app.
