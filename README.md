# Task Manager CLI

A simple command-line task management application built with pure Dart.

## Features

- Add a task
- List all tasks
- Sort tasks by priority or due date
- Mark a task as completed
- Delete a task
- Save and load tasks from a local JSON file

## Requirements

- Dart SDK 3.x or later

Check your Dart version:

```bash
dart --version
```

## Install dependencies

```bash
dart pub get
```

## Run the application

From the project root, execute:

```bash
dart run
```

or, if your entry point is inside `bin`:

```bash
dart run bin/main.dart
```

## Run the tests

Execute all unit tests with:

```bash
dart test
```

To run a specific test file:

```bash
dart test test/task_manager_test.dart
```

## Project structure

```
bin/
    main.dart

lib/
    models/
    services/
    repositories/
    exceptions/

test/
    task_manager_test.dart
```

## Technologies

- Dart
- dart:io
- JSON serialization
- package:test

## Author

Developed as a Dart object-oriented programming practice project.