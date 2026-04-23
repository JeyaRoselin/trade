# 📊 Watchlist Reordering App (Flutter + Bloc)

## 🧭 Objective

To design a scalable watchlist system that supports **drag-and-drop reordering with insertion behavior**, using a clean **Bloc-based architecture** and modular UI components.

---

## ⚙️ Key Features

* **Drag & Drop Reordering**

  * Built using `ReorderableListView`
  * Implements **insertion logic** (not swap)

* **State Management (Bloc)**

  * Event-driven updates
  * Immutable state handling
  * Clear separation of business logic and UI

* **Modular UI Design**

  * Reusable widgets for rows, charts, and actions
  * Feature-based folder structure

* **Lightweight Data Visualization**

  * Sparkline charts for stock trends

---

## 🏗️ Architecture Overview

The application follows the **Bloc pattern**:

```text
User Action → Event → Bloc → State → UI
```

### Example Flow:

* User drags a stock
* `WatchlistReordered` event is triggered
* Bloc updates list order
* New state emitted → UI rebuilds

---

## 🔄 Reordering Logic (Core Implementation)

The system uses **insertion-based reordering**, ensuring elements shift correctly:

```dart
final updatedStocks = List<Stock>.from(state.stocks);
final item = updatedStocks.removeAt(oldIndex);

final newIndex =
    newIndex > oldIndex ? newIndex - 1 : newIndex;

updatedStocks.insert(newIndex, item);

emit(state.copyWith(stocks: updatedStocks));
```

### Example:

```text
Before:
[1, 2, 3, 4, 5]

Drag: 2 → position 5

After:
[1, 3, 4, 5, 2]
```

---

## 📂 Project Structure

```bash
lib/
├── blocs/watchlist/
│   ├── watchlist_bloc.dart
│   ├── watchlist_event.dart
│   └── watchlist_state.dart
│
├── models/
│   └── stock.dart
│
├── screens/
│   ├── swap/
│   │   ├── swap_screen.dart
│   │   └── swap_widgets/
│   │       ├── reorder_list.dart
│   │       ├── stock_row.dart
│   │       ├── sparkline_chart.dart
│   │       └── ...
│   │
│   └── watch_list/
│       ├── watchlist_screen.dart
│       └── watch_list_widget/
│           ├── watch_list_app_bar.dart
│           ├── swap_button.dart
│           └── ...
│
└── theme/
    └── app_theme.dart
```

---

## 🧠 Design Decisions

* **Bloc over setState**
  Ensures scalability and predictable state flow

* **Immutable State Updates**
  Prevents side effects and improves debugging

* **Feature-Based Structure**
  Enhances maintainability and team collaboration

* **Separation of UI & Logic**
  UI handles rendering, Bloc handles behavior

---

## 🛠️ Tech Stack

* Flutter (UI)
* Dart
* flutter_bloc

---



