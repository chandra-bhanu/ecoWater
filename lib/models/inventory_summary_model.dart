class ChilledJarsLog
{
  int? total;
  int? available;
  int? customerActive;
  int? customerInActive;
  int? totalCustomer;


  ChilledJarsLog({
    required this.total,
    required this.available,
    required this.customerActive,
    required this.customerInActive,
    required this.totalCustomer,
  });

  factory ChilledJarsLog.fromJson(Map<String, dynamic> json)
  {
    return ChilledJarsLog(
      total: json['total'],
      available: json['available'],
      customerActive: json['customerActive'],
      customerInActive: json['customerInActive'],
      totalCustomer: json['totalCustomer'],

    );
  }
}

class NormalJarsLog
{
  int? total;
  int? available;
  int? customerActive;
  int? customerInActive;
  int? totalCustomer;


  NormalJarsLog({
    required this.total,
    required this.available,
    required this.customerActive,
    required this.customerInActive,
    required this.totalCustomer,
  });

  factory NormalJarsLog.fromJson(Map<String, dynamic> json)
  {
    return NormalJarsLog(
      total: json['total'],
      available: json['available'],
      customerActive: json['customerActive'],
      customerInActive: json['customerInActive'],
      totalCustomer: json['totalCustomer'],

    );
  }
}




class AllInventoryLogs
{

  ChilledJarsLog chilledJarsLog;
  NormalJarsLog normalJarsLog;

  AllInventoryLogs({
    required this.chilledJarsLog,
    required this.normalJarsLog,
  });

  factory AllInventoryLogs.fromJson(Map<String, dynamic> json)
  {

    return AllInventoryLogs(
      chilledJarsLog: ChilledJarsLog.fromJson(json['chilled']),
      normalJarsLog: NormalJarsLog.fromJson(json['normal']),
    );
  }



}