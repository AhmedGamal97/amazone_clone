class OrderRequesModel{
  final String orderName;
  final String buyerAddress;

  OrderRequesModel({required this.orderName,required this.buyerAddress});

  Map<String ,dynamic>getJson()=>{
    'orderName':orderName,
    'buyerAddress':buyerAddress
  };

  factory OrderRequesModel.getModelFromJson({required Map<String,dynamic>json}){
    return OrderRequesModel(orderName: json["orderName"], buyerAddress: json["buyerAddress"]);
  }
}