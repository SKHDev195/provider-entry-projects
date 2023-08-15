# Dart Learning

This repository contains several `Provider` projects made for personal learning purposes.

## Structure

The repository has the following structure.

`./fb_auth_provider`. This project is a simple app allowing users to authenticate via Firebase and access their profile information. It uses `Provider`` for state management.

`./fb_statenf_auth`. The project is a refactor of `fb_auth_provider` using the `StateNofifier` for state management.

`./open_weather_provider`. The project is a simple weather app that allows users to search for a city and receive weather information for it. A Celsius/Fahrenheit switch is also given. The project uses `Provider` for state management.

`./open_weather_provider_refactor`. The project is a refactor of `open_weather_provider` similarly using `Provider` for state management; however, `ProxyProvider` is used to simplify how multiple providers work.

`./open_weather_provider_state_refactor`. The project is a refactor of `open_weather_provider` using `StateNotifier` for state management.

`./provider_overview`. The folder contains several entry-level projects created for learning various aspects of the `Provider` framework.

`./state_notifier_ex`. An example project of using `StateNotifier` for state management.

`./todo_provider`. Another variation of a ToDo app using `Provider` for state management.

`./todo_provider_refactor`. A refactor of `todo_provider` using `ProxyProvider`.

`./todo_provider_state`. A refactor of `todo_provider` using `StateNotifier`.
