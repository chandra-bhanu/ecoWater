class InventoryDetails
{
  int? loaded;
  int? delivered;
  int? returnFilled;
  int? emptyJars;
  int? calculatedUnload;
  int? actualUnload;

  InventoryDetails({this.loaded, this.delivered, this.returnFilled, this.emptyJars, this.calculatedUnload, this.actualUnload});

  factory InventoryDetails.fromJson(Map<String, dynamic> json)
  {
    return InventoryDetails(
      loaded: json['loaded'],
      delivered: json['delivered'],
      returnFilled: json['returnFilled'],
      emptyJars: json['emptyJars'],
      calculatedUnload: json['calculatedUnload'],
      actualUnload: json['actualUnload'],
    );
  }
}

class Deliveries
{
  int? id;
  String name;
  String day;
  InventoryDetails inventoryDetails;

  Deliveries({
    this.id, required this.name,  required this.day,  required this.inventoryDetails
  });

  factory Deliveries.fromJson(Map<String, dynamic> json)
  {
    return Deliveries(
      id: json['id'],
      name: json['employee'],
      day: json['date'],
      inventoryDetails: InventoryDetails.fromJson(json['details']),
    );
  }
}

class AllReports
{
  List<Deliveries> deliveries;

  AllReports({required this.deliveries});

  factory AllReports.fromJson(List<dynamic> json)
  {
    List<Deliveries> deliveries =  List<Deliveries>.empty(growable: true);
    deliveries = json.map((c) => Deliveries.fromJson(c)).toList();

    return AllReports(
      deliveries:deliveries,
    );
  }
}