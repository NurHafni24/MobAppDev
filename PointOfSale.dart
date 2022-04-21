import 'dart:io';

double newPrice = 0;
double disc = 0; //Discount price
double totalAfterDiscount = 0;

class Item {
  //late keyword is to tell the compiler to treat this variable as non-nullable and will be initialized later
  late String name;
  late double price;
  late double quantity;
  late DateTime created_at;

  Item(String name, double price, double quantity) {
    this.name = name;
    this.price = price;
    this.quantity = quantity;
    this.created_at = DateTime.now();
  }
}

void main() {
  List<Item> itemList = []; //To store products inserted

  while (true) { //Let user choose
    print('\n');

    print("Point Of Sale System: \n");

    print("1. Insert product");

    //PART ASIMAH
    print("2. List of products"); //print product list with the detail

    print("3. Total amount after discount");

    print("4. Make Payment \n");

    stdout.write("Enter your choice: ");
    int input = int.parse(stdin.readLineSync()!);
    print("\n");

    if (input == 1) {
      createItem(itemList);
    } else if (input == 2) {
      //code Asimah
    } else if (input == 3){
      afterDiscountPrice();
    } else {
      makePayment();
      break;
    }
  }
}

void createItem(List<Item> items) {

  stdout.write("Enter product description:");

  print('\n');

  stdout.write("Name: ");
  String input1 = stdin.readLineSync()!;

  stdout.write("Price: ");
  double input2 = double.parse(stdin.readLineSync()!);

  stdout.write("Quantity: ");
  double input3 = double.parse(stdin.readLineSync()!);

  var newItem = Item(input1, input2, input3);

  items.add(newItem);

  calcQuantity(newItem.price, input3, newItem.name);

  print("Product inserted at ${newItem.created_at}");
}

void calcQuantity(double price, double quantity, String productName) {

  var payment = discount(productName, price); //Total price after calculate with quantity inserted

  totalAfterDiscount = totalAfterDiscount + (payment * quantity);

}

//Declare discount for few items
discount(String prodName, double prodPrice) {
  if (prodName == "Milo" || prodName == "milo") {

    disc = prodPrice * 0.15;
    newPrice = prodPrice - disc;
    print("Price After Discount for 1 pack ${newPrice}");

  } else if (prodName == "Downy" || prodName == "downy") {

    disc = prodPrice * 0.3;
    newPrice = prodPrice - disc;
    print("Price After Discount for 1 bottle ${newPrice}");

  } else if (prodName == "Chipsmore" || prodName == "chipsmore") {

    disc = prodPrice * 0.1;
    newPrice = prodPrice - disc;
    print("Price After Discount for 1 pack ${newPrice}");

  } else if (prodName == "Bowl" || prodName == "bowl") {

    disc = prodPrice * 0.7;
    newPrice = prodPrice - disc;
    print("Price After Discount for 1 bowl ${newPrice}");

  } else {

    newPrice = prodPrice;

  }
  return newPrice;
}

afterDiscountPrice() {
  print("The total amount after the discount is RM ${totalAfterDiscount} \n");
}

makePayment() {
  totalAfterDiscount.toStringAsFixed(2);
  print("TIME : ${DateTime.now()}");
  print("===========================");
  print("Your total is RM ${totalAfterDiscount}");
  print("===========================");
  stdout.write("Enter your money: ");
  double money = double.parse(stdin.readLineSync()!);

  while (money<totalAfterDiscount) {
    print("Not enough money T.T");
    stdout.write("Enter your money: ");
    double money = double.parse(stdin.readLineSync()!);

    if (money>=totalAfterDiscount) {
      double balance = money - totalAfterDiscount;
      balance.toStringAsFixed(2);
      print("TOTAL  : RM ${totalAfterDiscount}");
      print("CASH   : RM ${money}");
      print("CHANGE : RM ${balance}");
      print("===========================");
      print("Thank you! Have a nice day!");
      break;
    }
  }

}
