
class Deliveries
{
  int id;
  int count;
  String day;
  List<DeliveryList> delivery;

  Deliveries({required this.id,required this.count,required this.day, required this.delivery});

  factory Deliveries.fromJson(Map<String, dynamic> json)
  {

    var list= json['deliveries'] as List;
    List<DeliveryList> deliveryList= list.map((delivery) => DeliveryList.fromJson(delivery)).toList();


    return Deliveries(
      id: json['id'],
      count: json['count'],
      day: json['day'],
      delivery:deliveryList,
    );
  }

}

class DeliveryList
{
  DeliveryDetails deliveryDetails;
  DeliveryJarIn deliveryJarIn;
  DeliveryJarOut deliveryJarOut;
  DeliveryPayments deliveryPayments;

    DeliveryList({required this.deliveryDetails,required this.deliveryJarIn,required this.deliveryJarOut,required this.deliveryPayments});

    factory DeliveryList.fromJson(Map<String, dynamic> json)
    {
      return DeliveryList(
        deliveryDetails: DeliveryDetails.fromJson(json['details']),
        deliveryJarIn: DeliveryJarIn.fromJson(json['jarIn']),
        deliveryJarOut: DeliveryJarOut.fromJson(json['jarOut']),
        deliveryPayments: DeliveryPayments.fromJson(json['payments']),
      );
    }

}

class DeliveryDetails
{
  String time;
  String deliveryPerson;

  DeliveryDetails({required this.time,required this.deliveryPerson});

  factory DeliveryDetails.fromJson(Map<String, dynamic> json)
  {
    return DeliveryDetails(
        time: json['time'],
        deliveryPerson: json['deliveryPerson'],
    );
  }
}

class DeliveryJarIn
{
  int normal;
  int chilled;
  int nc;

  DeliveryJarIn({required this.normal,required this.chilled,required this.nc});

  factory DeliveryJarIn.fromJson(Map<String, dynamic> json)
  {
    return DeliveryJarIn(
      normal: json['Normal'],
      chilled: json['Chilled'],
      nc: json['Nc'],
    );
  }


}

class DeliveryJarOut
{
  int normal;
  int chilled;

  DeliveryJarOut({required this.normal,required this.chilled});

  factory DeliveryJarOut.fromJson(Map<String, dynamic> json)
  {
    return DeliveryJarOut(
      normal: json['Normal'],
      chilled: json['Chilled'],
    );
  }

}

class DeliveryPayments
{
  String status;
  double amount;
  String mode;

  DeliveryPayments({required this.status,required this.amount,required this.mode});

  factory DeliveryPayments.fromJson(Map<String, dynamic> json)
  {
    return DeliveryPayments(
      status: json['status'],
      amount: double.parse(json['amount']),
      mode: json['via'],
    );
  }

}

class All
{

  List<Deliveries> deliveries;
  All({required this.deliveries});

  factory All.fromJson(List<dynamic> json)
  {
    List<Deliveries> deliveries =  List<Deliveries>.empty(growable: true);
    deliveries = json.map((c) => Deliveries.fromJson(c)).toList();

    return All(
      deliveries:deliveries,
    );
  }
}