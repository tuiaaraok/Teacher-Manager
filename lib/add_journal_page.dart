import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:teacher/data/boxes.dart';
import 'package:teacher/data/journal.dart';

class AddJournalPage extends StatefulWidget {
  AddJournalPage({
    Key? key,
  }) : super(key: key);

  @override
  _AddJournalPageState createState() => _AddJournalPageState();
}

class _AddJournalPageState extends State<AddJournalPage> {
  late EmployeeDataSource _employeeDataSource;
  List<Employee> _employees = <Employee>[];
  late DataGridController _dataGridController;
  DateTime now = DateTime.now();
  TextEditingController notesController = TextEditingController();
  Map<String, Map<String, List<String>>> hiveDate = {};

  @override
  void initState() {
    super.initState();

    _employees.add(Employee("", List.filled(daysInMonth(), "")));

    createDataSource(); // Создаем источник данных
  }

  void elementsTable() {
    for (int i = 0; i < _employees.length; i++) {
      for (int j = 0; j < _employees[i].days.length; j++) {
        print("${j} elem:${_employees[i].days[j]}");
      }
    }
  }

  void createDataSource() {
    _employeeDataSource =
        EmployeeDataSource(_employees, addEmployee: addNewEmployee);
    _dataGridController = DataGridController();
  }

  void addNewEmployee() {
    final newEmployee = Employee("", List.filled(daysInMonth(), ""));
    setState(() {
      _employees.add(newEmployee);
      _employeeDataSource = EmployeeDataSource(_employees,
          addEmployee: addNewEmployee); // Обновляем источник данных
    });
  }

  int daysInMonth() {
    DateTime lastDayOfMonth = DateTime(now.year, now.month + 1, 0);
    return lastDayOfMonth.day;
  }

  List<Employee> getEmployeeData() {
    return []; // Начальные данные
  }

  void changeMonth(int delta) {
    setState(() {
      now = DateTime(now.year, now.month + delta, now.day);

      // Проверка, есть ли данные для выбранного месяца
      if (hiveDate.containsKey(DateFormat("MMMM, yyyy").format(now))) {
        // Загружаем существующие значения
        Map<String, List<String>> existingData =
            hiveDate[DateFormat("MMMM, yyyy").format(now)]!;

        _employees.forEach((employee) {
          if (existingData.containsKey(employee.name)) {
            employee.days = existingData[employee.name]!;
          } else {
            employee.days = List.filled(
                daysInMonth(), ""); // Сброс, если данных для сотрудника нет
          }
        });
      } else {
        // Если данных нет, сбрасываем для всех сотрудников
        _employees.forEach((employee) {
          employee.days =
              List.filled(daysInMonth(), ""); // Обновляем количество дней
        });
      }

      // Обновляем источник данных
      _employeeDataSource =
          EmployeeDataSource(_employees, addEmployee: addNewEmployee);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Journall",
                          style:
                              TextStyle(color: Colors.white, fontSize: 24.sp),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: 100.w,
                            height: 32.h,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.r))),
                            child: Center(
                              child: Text(
                                "Back",
                                style: TextStyle(
                                    color: Color(0xFF6E02C3), fontSize: 18.sp),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Container(
                    width: 310.w,
                    child: Text(
                      "Class name",
                      style: TextStyle(
                          fontSize: 18.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    height: 60.h,
                    width: 310.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        color: Color(0xFFC2B0FF).withOpacity(0.3),
                        border: Border.all(color: Colors.white, width: 2.h)),
                    child: Center(
                      child: TextField(
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        controller: notesController,
                        decoration: InputDecoration(
                            border: InputBorder.none, // Убираем обводку
                            focusedBorder:
                                InputBorder.none, // Убираем обводку при фокусе
                            hintText: 'Name',
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white.withOpacity(0.5),
                                fontSize: 18.sp)),
                        keyboardType: TextInputType.text,
                        cursorColor: Colors.transparent,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.sp),
                        onChanged: (text) {
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                  Container(
                    width: 310.w,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: GestureDetector(
                          onTap: () {
                            Map<String, List<String>> newTable = {};
                            _employees.forEach(
                              (element) {
                                if (element.name != "") {
                                  newTable[element.name] = element.days;
                                }
                              },
                            );
                            hiveDate[DateFormat("MMMM, yyyy").format(now)] =
                                newTable;
                            hiveDate.values.forEach((action) {
                              action.forEach((key, value) {
                                print("${key}, ${value}");
                              });
                            });
                            if (notesController.text.isNotEmpty) {
                              Box<Journal> contactsBox =
                                  Hive.box<Journal>(HiveBoxes.journal);
                              Journal addJournal = Journal(
                                  className: notesController.text.toString(),
                                  journal: hiveDate);
                              contactsBox.add(addJournal);
                              print("object");
                              Navigator.pop(context);
                            }
                          },
                          child: Container(
                            width: 100.w,
                            height: 32.h,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.r))),
                            child: Center(
                              child: Text(
                                "Save",
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    color: notesController.text.isNotEmpty
                                        ? Color(0xFF6E02C3)
                                        : Color(0xFF6E02C3).withOpacity(0.5)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: Container(
                  height: 50.h,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0xFF7D49F4), Color(0xFF5225C1)]),
                      borderRadius: BorderRadius.all(Radius.circular(18.r))),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: GestureDetector(
                            onTap: () {
                              Map<String, List<String>> newTable = {};
                              _employees.forEach(
                                (element) {
                                  if (element.name != "") {
                                    newTable[element.name] = element.days;
                                  }
                                },
                              );
                              hiveDate[DateFormat("MMMM, yyyy").format(now)] =
                                  newTable;
                              changeMonth(-1);
                            }, // Изменяем месяц на один назад
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            )),
                      ),
                      Text(
                        DateFormat("MMMM, yyyy").format(now),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: GestureDetector(
                          onTap: () {
                            Map<String, List<String>> newTable = {};
                            _employees.forEach(
                              (element) {
                                if (element.name != "") {
                                  newTable[element.name] = element.days;
                                }
                              },
                            );
                            hiveDate[DateFormat("MMMM, yyyy").format(now)] =
                                newTable;
                            changeMonth(1);
                          }, // Изменяем месяц на один вперед
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: 70.h + _employees.length * 50.h,
                child: SfDataGrid(
                  verticalScrollPhysics: NeverScrollableScrollPhysics(),
                  source: _employeeDataSource,
                  defaultColumnWidth: 40,
                  allowEditing: true,
                  selectionMode: SelectionMode.single,
                  navigationMode: GridNavigationMode.cell,
                  columnWidthMode: ColumnWidthMode.fill,
                  controller: _dataGridController,
                  columns: [
                    GridColumn(
                      columnName: 'Name',
                      width: 148.w,
                      label: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white)),
                        alignment: Alignment.centerLeft,
                        child: Center(
                          child: Text('Name',
                              style: TextStyle(
                                  color: Colors.red, fontSize: 14.sp),
                              overflow: TextOverflow.ellipsis),
                        ),
                      ),
                    ),
                    ...List.generate(daysInMonth(), (index) {
                      return GridColumn(
                        width: 32.h,
                
                        columnName: '${index + 1}', // День месяца
                        label: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white)),
                          alignment: Alignment.center,
                          child: Text(
                            '${index + 1}',
                            style:
                                TextStyle(color: Colors.red, fontSize: 14.sp),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Employee {
  Employee(this.name, this.days);

  String name; // Имя сотрудника
  List<String> days; // Дни месяца

  DataGridRow getDataGridRow() {
    return DataGridRow(cells: <DataGridCell>[
      DataGridCell<String>(columnName: 'Name', value: name),
      ...days
          .map((dayValue) =>
              DataGridCell<String>(columnName: dayValue, value: dayValue))
          .toList(),
    ]);
  }
}

class EmployeeDataSource extends DataGridSource {
  final Function addEmployee;

  EmployeeDataSource(this._employees, {required this.addEmployee}) {
    dataGridRows = _employees
        .map<DataGridRow>((dataGridRow) => dataGridRow.getDataGridRow())
        .toList();
  }

  List<Employee> _employees = [];
  List<DataGridRow> dataGridRows = [];
  dynamic newCellValue;
  TextEditingController editingController = TextEditingController();

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    if (dataGridRows.last == row) {
      // Если это последний ряд, то показываем иконку вместо данных
      return DataGridRowAdapter(cells: [
        Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.white)),
          alignment: Alignment.center,
          child: CircleAvatar(
            backgroundColor: Color(0xFFC2B0FF).withOpacity(0.3),
            child: IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                addEmployee(); // Вызываем функцию для добавления нового сотрудника
              },
            ),
          ),
        ),
        ...row.getCells().sublist(1).map<Widget>((dataGridCell) {
          return Container(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.white)),
              alignment: (dataGridCell.columnName == 'Name')
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                dataGridCell.value.toString(),
                overflow: TextOverflow.ellipsis,
              ));
        }).toList(),
      ]);
    }
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((dataGridCell) {
        return Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              color: Color(0xFF6E02C3)),
          alignment: (dataGridCell.columnName == 'Name')
              ? Alignment.centerLeft
              : Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(dataGridCell.value.toString(),
              style: TextStyle(color: Colors.white, fontSize: 18.sp),
              overflow: TextOverflow.ellipsis),
        );
      }).toList(),
    );
  }

  @override
  Future<void> onCellSubmit(DataGridRow dataGridRow,
      RowColumnIndex rowColumnIndex, GridColumn column) async {
    final dynamic oldValue = dataGridRow
        .getCells()
        .firstWhereOrNull((DataGridCell dataGridCell) =>
            dataGridCell.columnName == column.columnName)
        ?.value;

    final int dataRowIndex = dataGridRows.indexOf(dataGridRow);

    if (newCellValue == null || oldValue == newCellValue) {
      return;
    }

    if (column.columnName == 'Name') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(columnName: 'Name', value: newCellValue);
      _employees[dataRowIndex].name = newCellValue.toString();
    } else {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(
              columnName: column.columnName, value: newCellValue);
      _employees[dataRowIndex].days[rowColumnIndex.columnIndex - 1] =
          newCellValue.toString(); // -1, так как первая колонка - имя
    }
  }

  @override
  Future<bool> canSubmitCell(DataGridRow dataGridRow,
      RowColumnIndex rowColumnIndex, GridColumn column) async {
    return Future.value(true);
  }

  @override
  Widget? buildEditWidget(DataGridRow dataGridRow,
      RowColumnIndex rowColumnIndex, GridColumn column, CellSubmit submitCell) {
    final String displayText = dataGridRow
            .getCells()
            .firstWhereOrNull((DataGridCell dataGridCell) =>
                dataGridCell.columnName == column.columnName)
            ?.value
            ?.toString() ??
        '';

    newCellValue = null;

    return Container(
      padding: const EdgeInsets.all(8.0),
      alignment: Alignment.centerLeft,
      child: (dataGridRows.last == dataGridRow)
          ? Text(displayText)
          : TextField(
              autofocus: true,
              controller: editingController..text = displayText,
              textAlign: TextAlign.left,
              autocorrect: false,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 16.0)),
              onChanged: (String value) {
                newCellValue = value; // Сохраняем новое значение
              },
              onSubmitted: (String value) {
                submitCell(); // Подтверждаем изменения
              },
            ),
    );
  }
}
