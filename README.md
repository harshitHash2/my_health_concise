# my_health_concise

A new Flutter project:

- Clean architecture (Domain → Data → Presentation)
- Riverpod state management
- Hive persistent local storage
- UI/UX with Material 3 design
- Charts using fl_chart
- Light/Dark mode theme switching
- Search & filter functionality
- Smooth & Simple UI animations

---

## 1. Setup

####  Clone the repository
```bash
git clone 
cd MY_HEALTH_CONCISE
```

#### Install dependencies

```bash
flutter pub get

```

#### Generate Hive TypeAdapters

```bash
flutter pub run build_runner build --delete-conflicting-outputs

```

#### Run the App

```bash
flutter run
```



## Features

### Health Dashboard  
- Shows a list of health metrics in clean, easy-to-read cards  
- Cards include:
  - Metric name  
  - Value & unit  
  - Status
  - Normal range  
  - Color-coded background (adaptive to light/dark mode)

### Metric Details Screen  
Each metric opens a detail view that includes:
- Large value card with status badge  
- Interactive trend chart using `fl_chart`

### Filters by Status
- Filter metrics by:
  - All  
  - Normal  
  - High  
  - Low  

### Search  
- Search metrics by name in real-time

### Dark Mode Support  
- One-tap switch from the AppBar  
- Colors automatically adapt for dark mode  
- Uses Riverpod to store theme mode

### Local Persistence Using Hive
- All data stored in Hive box  
- Custom models using short annotation-based Hive models  
- Automatically generated TypeAdapters

