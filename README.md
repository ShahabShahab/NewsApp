# 📄 Project README – Code Challenge

## 📚 Project Summary

This project demonstrates a clean, scalable Flutter architecture based on Clean Architecture principles.  
The app fetches and displays news articles from NewsAPI, strictly separating domain, data, and presentation layers.

---

## ⚙️ Technical Stack

| Layer         | Details |
|---------------|---------|
| Domain Layer  | Entities, Repositories (abstract), Use Cases (business logic) |
| Data Layer    | API integrations using Dio and Retrofit, Models, Repository implementations |
| Injection Layer | Dependency setup using GetIt (singleton, lazy singleton, factory) |
| Main App      | UI scaffolding, consumes domain-only |

---

## 📊 Code Metrics

| Metric                 | Value  |
|-------------------------|--------|
| **Total Dart Files**     | XX |
| **Total Lines of Code**  | XXXX |
| **Total Test Files**     | XX |
| **Unit Tests Written**   | XX |
| **Test Coverage**        | XX.X% (using LCOV) |
| **Data Layer Coverage**  | XX.X% |
| **Domain Layer Coverage**| XX.X% |
| **Total Packages Used**  | XX |

---

## 🧪 Testing Strategy

- **Domain Layer**  
  - 100% unit-tested (entities, use cases, Either/Failure helpers)

- **Data Layer**  
  - Repository logic unit-tested (mocking ApiService)
  - Models and API services manually validated

| Layer        | Tests Approach |
|--------------|----------------|
| Domain       | Pure unit tests |
| Data Layer   | Mock-based tests (mocktail) |
| Injection    | Minimal bootstrapping verification |
| Main App UI  | Manual smoke tests (no widget tests) |

---

## 🏗️ Implemented Modules / Features

| Module | Status | Notes |
|--------|--------|-------|
| **Domain Layer** | ✅ Completed | Fully decoupled, pure Dart |
| **Data Layer** | ✅ Completed | Retrofit, Dio, Models |
| **Injection Layer** | ✅ Completed | Centralized GetIt setup |
| **Main App** | 🛠️ In Progress | Basic ListView and UI |
| **Testing** | ✅ Completed | Domain + Data layer unit-tested |

---

## 🔒 Dependency Rules Followed
domain/ → No dependencies data_layer/ → Depends only on domain injection/ → Depends on domain + data_layer main_app/ → Depends only on domain + injection


✅ No direct coupling between the main app and data layer.

---

## 📅 Timeline

| Milestone | Date Achieved |
|-----------|---------------|
| Architecture Design Finalized | April 28 |
| Domain Layer Complete + Tested | April 29 |
| Data Layer Complete + Tested | April 30 |
| UI Layer + Submission | May 2 (planned) |

---

## 🔥 Highlights

- First-time applying **package-based Clean Architecture** for Flutter.
- Strict boundary enforcement between layers.
- High code coverage to ensure robustness.
- Focus on maintainability, scalability, and testability.

---

# ✅ Ready for Final Submission by **Friday, May 2nd, 9:00 AM**


