class EmployeeList
{
  int? id;
  String? name;

  EmployeeList({this.id, this.name});

  factory EmployeeList.fromJson(Map<String, dynamic> json)
  {
    return EmployeeList(
      id: json['id'],
      name: json['name'],
    );
  }
}

class VehiclesList
{
  int? id;
  String? name;

  VehiclesList({this.id, this.name});

  factory VehiclesList.fromJson(Map<String, dynamic> json)
  {
    return VehiclesList(
      id: json['id'],
      name: json['name'],
    );
  }
}



class AllbaseData
{
  List<EmployeeList> employeeList;
  List<VehiclesList> vehiclesList;


  AllbaseData({required this.employeeList, required this.vehiclesList});

  factory AllbaseData.fromJson(Map<String, dynamic> json)
  {

    var list= json['employees'] as List;
    List<EmployeeList> employeeListData= list.map((employeeList) => EmployeeList.fromJson(employeeList)).toList();


    var alist= json['vehicles'] as List;
    List<VehiclesList> vehiclesListData= alist.map((vehiclesList) => VehiclesList.fromJson(vehiclesList)).toList();

    return AllbaseData(
      employeeList: employeeListData,
      vehiclesList: vehiclesListData,
    );
  }

}
