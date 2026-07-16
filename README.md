# Dart Task Manager CLI

A simple Command Line Interface (CLI) task manager built with Dart.

## Features

- ✅ Add a task
- 📋 List all tasks
- ✔️ Mark a task as completed
- ❌ Delete a task
- 💾 Save tasks to a JSON file
- 📂 Load tasks from a JSON file
- ⚠️ Custom exception handling
- 🧩 Object-Oriented Programming principles
- 🧪 Unit tests
- 🚀 Continuous Integration (CI)

---

## Project Structure

```
lib/
├── models/
├── managers/
├── exceptions/
├── services/
└── main.dart

test/
└── task_manager_test.dart

.github/
└── workflows/
    └── dart.yml
```

---

## Requirements

- Dart SDK 3.x or later

Check your version:

```bash
dart --version
```

---

## Installation

Clone the repository:

```bash
git clone https://github.com/your-username/dart-task-manager.git
cd dart-task-manager
```

Install dependencies:

```bash
dart pub get
```

---

## Run the application

```bash
dart run
```

---

## Run the tests

```bash
dart test
```

---

## Continuous Integration (CI)

This project uses **GitHub Actions** for Continuous Integration.

Every push and pull request automatically triggers the following workflow:

- Checkout the repository
- Install the Dart SDK
- Download dependencies
- Analyze the code
- Run all unit tests

This ensures that new code changes do not introduce compilation errors or failing tests.

---

## GitHub Actions Workflow

Workflow location:

```
.github/workflows/dart.yml
```

Example workflow:

```yaml
name: Dart CI

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  test:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v4

      - uses: dart-lang/setup-dart@v1

      - run: dart pub get

      - run: dart analyze

      - run: dart test
```

---

## Technologies

- Dart
- JSON
- Git
- GitHub Actions

---

## Author

Certification project created with Dart.