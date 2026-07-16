# Dart Task Manager CLI

A command-line task management application built with **Dart**, demonstrating core Object-Oriented Programming (OOP) concepts, file persistence, exception handling, generics, and unit testing.

The application allows users to manage their daily tasks directly from the terminal while persisting data in a JSON file between executions.

---

# Features

- Add a new task
- Display all tasks
- Filter completed and pending tasks
- Mark a task as completed
- Delete a task
- Store tasks in a local JSON file
- Automatically reload saved tasks
- Custom exception handling
- Generic task manager abstraction
- Unit tests

---

# Project Architecture

The project follows a **layered architecture**, where each layer has a single responsibility.

```
lib/
│
├── models/
│   ├── base_task.dart
│   ├── task.dart
│   └── priority_type.dart
│
├── managers/
│   ├── task_manager.dart
│   └── task_manager_impl.dart
│
│
├── exceptions/
│   └── task_range_exception.dart
│
├── helpers/
│   └── menu_helper.dart
│
├── services/
│   └── file_service.dart
│
└──
```

The application is organized so that each component has a clear responsibility, making the code easier to understand, maintain, and extend.

---

# Design Choices

## Object-Oriented Programming

The project follows Object-Oriented Programming principles.

### Abstraction

The `BaseTask` abstract class defines the common behavior shared by every task.

It centralizes the properties and methods that every task must implement while allowing future specialized task types.

---

### Inheritance

The concrete `Task` class extends `BaseTask`.

This separation allows new task types to be introduced later without modifying the rest of the application.

Example:

```
BaseTask
    │
    ▼
   Task
```

---

### Generics

The task manager is defined as a generic abstraction.

```dart
abstract class TaskManager<T extends BaseTask>
```

This design allows the manager to operate on any object extending `BaseTask`, making the application reusable for future task implementations.

---

### Exception Handling

Custom exceptions are used instead of generic exceptions whenever appropriate.

Example:

```
TaskRangeException
```

Using dedicated exception classes makes error messages clearer and improves debugging.

---

# Data Persistence

Tasks are stored inside a local JSON file.

When the application starts:

1. The JSON file is loaded.
2. Tasks are deserialized.
3. The application runs normally.
4. Every modification is automatically saved.

This approach keeps the application lightweight while preserving user data between sessions.

---

# Application Workflow

```
User
  │
  ▼
MenuHelper
  │
  ▼
TaskManager
  │
  ▼
FileService
  │
  ▼
tasks.json
```

Each layer communicates only with the layer directly below it.

This separation improves readability and maintainability.

---

# Testing Strategy

Unit tests verify the application's core functionality.

The tests cover:

- Task creation
- Task deletion
- Task completion
- Task Filter
- Exception handling

The goal is to ensure that business logic behaves as expected independently of the user interface.

Run the tests with:

```bash
dart test
```

---

# Technologies

- Dart
- JSON
- Git
- dart:io
- package:test
- intl

---

# Installation

Clone the repository:

```bash
git clone https://github.com/sudoxwill/CLI-Task-Manager
```

Move into the project:

```bash
cd dart-task-manager
```

Install dependencies:

```bash
dart pub get
```

---

# Running the Application

Start the CLI:

```bash
dart run
```

---

# Running Tests

Execute all unit tests:

```bash
dart test
```

Analyze the code:

```bash
dart analyze
```


---

# Author

This project was developed as part of a Dart CLI certification project to demonstrate proficiency in:

- Object-Oriented Programming
- Generics
- Exception Handling
- JSON Serialization
- File I/O
- Unit Testing