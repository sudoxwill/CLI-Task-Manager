import 'dart:io';
import 'package:intl/intl.dart';
import 'package:task_manager/models/base_task.dart';
import 'package:task_manager/models/task.dart';
import 'package:task_manager/managers/task_manager.dart';
import 'package:task_manager/managers/task_manager_impl.dart';
import 'package:task_manager/services/file_service.dart';

class MenuHelper {
  final TaskManagerImpl taskManagerImpl;
  const MenuHelper(this.taskManagerImpl);

  void defaultMenu() {
    print('                                 ');
    print('*****************************************');
    print('*                                       *');
    print('*        BIENVENU(E) SUR TASKY          *');
    print('*                                       *');
    print('*****************************************');
    print('*                                       *');
    print('*          Que veux-tu faire ?          *');
    print('*                                       *');
    print('* 1. Afficher la liste de taches        *');
    print('* 2. Quitter                            *');
    print('*                                       *');
    print('                                 ');
  }

  void snapAndDisplayDefaultMenu() {
    stdout.write('Entre ta réponse ici : ');
    String? input = stdin.readLineSync();
    print('                                 ');

    switch (input) {
      case '1':
        print('-----------------------------------------');
        displayList(taskManagerImpl.getAllTasks());
        taskList();
      case '2':
        areYouSureMenu();
      default:
        defaultMenu();
        snapAndDisplayDefaultMenu();
    }
  }

  void areYouSureMenu() async {
    final fileService = FileService(taskManagerImpl);
    print('*****************************************');
    print('*                                       *');
    print('*     Tu veux vraiment quitter ?        *');
    print('*                                       *');
    print('* 1. Oui                                *');
    print('* 2. Non                                *');
    print('*                                       *');
    print('                                 ');
    stdout.write('Entre ta réponse ici : ');
    String? input = stdin.readLineSync();
    print('                                 ');

    switch (input) {
      case '1':
        print('-----------------------------------------');
        await fileService.saveAllToJson();
        print('Au revoir...');
        exit(0);

      default:
        defaultMenu();
        snapAndDisplayDefaultMenu();
    }
  }

  void displayList(List<Task> tasks) {
    print('         Liste de taches               ');
    print('                                 ');
    for (Task t in tasks) {
      if (t.isDone) {
        print(
          '             \x1B[9m#${tasks.indexOf(t) + 1} ${t.title}\x1B[0m           ',
        );
      } else {
        print(
          '             #${tasks.indexOf(t) + 1} ${t.title}                  ',
        );
      }
      print('                                 ');
    }
  }

  void taskList() {
    print('*****************************************');
    print('*                                       *');
    print('*   Que veux-tu faire de cette liste ?  *');
    print('*                                       *');
    print('* 1. Ajouter une tache                  *');
    print('* 2. Marquer une tache terminée         *');
    print('* 3. Supprimer une tache                *');
    print('* 4. Trier par priorité                 *');
    print('* 5. Trier par date                     *');
    print('* 6. Rien...Go back                     *');
    print('*                                       *');
    print('                                 ');
    stdout.write('Entre ta réponse ici : ');
    String? input = stdin.readLineSync();
    print('                                 ');

    switch (input) {
      case '1':
        addTaskProcess();
      case '2':
        markTaskAsReadOrDelete(false);
      case '3':
        markTaskAsReadOrDelete(true);
      case '4':
        displayList(taskManagerImpl.getAllTasks(TaskFilterType.byPriority));
        taskList();
      case '5':
        displayList(taskManagerImpl.getAllTasks(TaskFilterType.byDate));
        taskList();

      default:
        defaultMenu();
        snapAndDisplayDefaultMenu();
    }
  }

  void markTaskAsReadOrDelete(bool delete) {
    print('*****************************************');
    print('*                                       *');
    print('*  Quel est le numéro de cette tache ?  *');
    print('                                 ');

    // Recup au clavier
    stdout.write('Entre ta réponse ici : ');
    String? input = stdin.readLineSync();
    print('                                 ');

    // Blocage choix valide
    while (input == null ||
        int.tryParse(input) == null ||
        int.tryParse(input) == 0) {
      print('Choix invalide, reéssaye!');
      print('                                 ');
      stdout.write('Entre ta réponse ici : ');
      input = stdin.readLineSync();
      print('                                 ');
    }

    // valeur absolue pour entiers negatifs au cas ou
    int number = (int.tryParse(input)!.abs()) - 1;

    print('');

    try {
      taskManagerImpl.deleteOrMarkTask(number, delete);
      print('Opération éffectuée avec succès!');
    } catch (e) {
      print(e);
    }
    // Message de retour peut importe l'issue
    print('');
    print('Appuie sur n\'importe quelle touche pour revenir en arriere...');
    stdin.readLineSync(); // pour attendre une valeur
    displayList(taskManagerImpl.getAllTasks());
    taskList();
  }

  void addTaskProcess() {
    // Confirmation ajout
    print('*****************************************');
    print('*                                       *');
    print('*  Le processus d\'ajout va commencer   *');
    print('*          Tu veux continuer ?          *');
    print('* 1. Oui                                *');
    print('* 2. Non                                *');
    print('                                         ');

    // Recup au clavier
    stdout.write('Entre ta réponse ici : ');
    String? input = stdin.readLineSync();
    print('                                 ');

    if (input == '1') {
      addTask();
    } else {
      // Message de confirm
      print('Processus annulé !');

      // Message de retour
      print('Appuie sur n\'importe quelle touche pour revenir en arriere...');
      stdin.readLineSync();
      displayList(taskManagerImpl.getAllTasks());
      taskList();
    }
  }

  void addTask() {
    Map<String, dynamic> taskMap = {};
    String? input;
    final dateRegex = RegExp(r'^\d{2}/\d{2}/\d{4}$');

    // Titre

    print('*****************************************');
    print('*                                       *');
    print('*     Tout d\'abord, entre le titre     *');
    print('                                         ');
    stdout.write('Entre ta réponse ici : ');
    input = stdin.readLineSync();
    print('                                 ');
    taskMap['title'] = input;

    // Cas titre null
    while (input == null) {
      print('                                 ');
      print('*****************************************');
      print('*                                       *');
      print('* Ce champs est obligatoire, remplis-le *');
      print('                                         ');
      stdout.write('Entre ta réponse ici : ');
      input = stdin.readLineSync();
      print('                                 ');
      taskMap['title'] = input;
    }

    // Priorité
    print('*****************************************');
    print('*                                       *');
    print('*    Ensuite, choisis une priorité      *');
    print('* 1. Priorité basse                     *');
    print('* 2. Priorité moyenne                   *');
    print('* 3. Priorité haute                     *');
    print('                                         ');
    stdout.write('Entre ta réponse ici : ');
    input = stdin.readLineSync();
    print('                                 ');
    taskMap['priority'] = switch (input) {
      '1' => PriorityType.low,
      '2' => PriorityType.medium,
      _ => PriorityType.high,
    };

    // Date Limite

    print('*****************************************');
    print('*                                       *');
    print('*  Entre une date limite (Optionnel)    *');
    print('*        au format (JJ/MM/AAAA)         *');
    print('                                         ');
    stdout.write('Entre ta réponse ici : ');
    input = stdin.readLineSync();
    print('                                 ');

    taskMap['date'] = (input != null && dateRegex.hasMatch(input))
        ? DateFormat('dd/MM/yyyy').parse(input)
        : null;

    // Cas date nulle ou ne correspondant pas au pattern
    if (input == null || !dateRegex.hasMatch(input)) {
      print('La date saisie est invalide. Sa valeur a été définie sur null');
    }

    try {
      // AJout proprement dit
      taskManagerImpl.addTask(
        Task(
          title: taskMap['title'],
          priority: taskMap['priority'],
          date: taskMap['date'],
        ),
      );

      print('Tache ajoutée !');
    } catch (e) {
      print('Ta tache n\'a pas pu etre ajoutée, reéessaye!');
    }

    // Message de retour
    print('Appuie sur n\'importe quelle touche pour revenir en arriere...');
    stdin.readLineSync();
    displayList(taskManagerImpl.getAllTasks());
    taskList();
  }
}
