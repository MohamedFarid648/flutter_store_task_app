
Publish App to github:

1.Create new repository (ex:flutter_store_web)
2.Build your project: 
flutter build web --release --base-href /flutter_store_web/
3.Copy build/web folder to your repository main director

4.In Your repository go to Settings/Pages 
choose (main branch) and click save then refresh to get the url

Ex:
Project Web URL:

https://mohamedfarid648.github.io/flutter_store_web/

***********************************************************
To create clean architecture structure or to create new feature:
ctr+shift+p ,,,then type (Onyxsio),, then choose

****************************************************************
Clean Architecture:

1. Data:
	Deals with data fetching (APIs, Local DB) and data models.	Implements the abstract contracts defined in the Domain layer.	Separates how data is retrieved from what data is needed.

2. Domain:
	Contains the core business logic: Entities, Use Cases, and Repositories (abstract interfaces).
    The core, pure business logic, independent of any framework.	Keeps the core logic reusable and testable without Flutter/API dependencies

3. Presentation:
	Houses the UI (Widgets) and the State Management logic (BLoC/Cubit).
    Manages user interaction and displays data fetched via the Domain layer.
	Separates UI rendering from business logic and data handling
********************************************************************
Features(Auth Ex:):
* Use DI in config/di.dart
* Then Use it in main.dart

In Domain Layer:(Entities , Abstract Logic classes)
1. Create domain/entities/login_entity.dart , register_entity.dart


2. Create domain/repositories/auth_repository.dart
3. Create domain/usecases/login_usecase.dart , register_usecase.dart (that will use the repository)


In Data Layer : (Implement the Logic)
1. Create data/models/login_model.dart , register_model.dart(that has fromJson,toJson)

2. Create data/sources/auth_remote_data_source.dart (that will use  the Dio to call the APIs , use models in data layer that have fromJson,toJson )

3. Create data/repositories/auth_repository_impl.dart (that implement auth_repository.dart in Domain Layer , and use AuthRemoteDataSource )

In Presentation Layer:
1. Create presentation/pages/login_page.dart (use login form , _emailController , _passwordController , _onLoginPressed logic that use the LoginUseCase)

2. Create presentation/pages/register_page.dart (use Form Controllers , RegisterUseCase)
********************************************************************
Project Description:

lib/
├── core/             # Common utilities (e.g., constants, theme, error handling)
├── data/
│   ├── datasources/  # Remote (API) and Local data sources
│   ├── models/       # Data transfer objects (DTOs) from API
│   └── repositories/ # Concrete implementation of Domain Repository
├── domain/
│   ├── entities/     # Core business objects (e.g., `ProductEntity`)
│   ├── repositories/ # Abstract interfaces (e.g., `ProductRepository`)
│   └── usecases/     # Business rules (e.g., `GetProductsUseCase`)
└── presentation/
    ├── bloc/         # BLoC/Cubit files for state management
    ├── pages/        # Full screen pages (e.g., `LoginPage`)
    └── widgets/      # Reusable UI components


***********************
Dio:
A powerful HTTP networking package for Dart/Flutter, supports Global configuration, Interceptors, FormData, Request cancellation, File uploading/downloading, Timeout, Custom adapters, Transformers, etc.

