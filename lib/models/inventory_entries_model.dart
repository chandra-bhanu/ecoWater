class InventoryJarEmpty
{
  int normal;
  int chilled;


  InventoryJarEmpty({required this.normal,required this.chilled});

  factory InventoryJarEmpty.fromJson(Map<String, dynamic> json)
  {
    return InventoryJarEmpty(
      normal: json['Normal'],
      chilled: json['Chilled'],

    );
  }
}

class InventoryJarFilled
{
  int? normal;
  int? chilled;
  int? nc;
  InventoryJarFilled({required this.normal,required this.chilled,required this.nc});

  factory InventoryJarFilled.fromJson(Map<String, dynamic> json)
  {
    return InventoryJarFilled(
      normal: json['Normal'],
      chilled: json['Chilled'],
      nc: json['Nc'],
    );
  }

}


class InventoryListData
{
  int id;
  String date;
  String name;
  String time;
  String type;
  InventoryJarFilled inventoryJarFilled;
  InventoryJarEmpty inventoryJarEmpty;

  InventoryListData({
    required this.id,
    required this.date,
    required this.name,
    required this.time,
    required this.type,
    required this.inventoryJarFilled,
    required this.inventoryJarEmpty
  });

  factory InventoryListData.fromJson(Map<String, dynamic> json)
  {
    return InventoryListData(
      id: json['id'],
      date: json['date'] ?? '',
      name: json['name'] ?? '',
      time: json['Time'] ?? '',
      type: json['type'] ?? '',
      inventoryJarFilled: InventoryJarFilled.fromJson(json['filled']),
      inventoryJarEmpty: InventoryJarEmpty.fromJson(json['empty']),
    );
  }

}

class AllInventory
{
  List<InventoryListData> inventoryList;
  AllInventory({required this.inventoryList});

  factory AllInventory.fromJson(List<dynamic> json)
  {
    List<InventoryListData> inventoryList =  List<InventoryListData>.empty(growable: true);
    inventoryList = json.map((c) => InventoryListData.fromJson(c)).toList();

    return AllInventory(
      inventoryList:inventoryList,
    );
  }

}