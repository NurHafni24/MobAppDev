import 'dart:io';

double newPrice = 0;
double disc = 0; //Discount price
double totalAfterDiscount = 0;
double gstValue = 0.0;
double totalIncGST = 0;

class Item {
  //Nur Hafni (1913844)
  //late keyword is to tell the compiler to treat this variable as non-nullable and will be initialized later
  late String name;
  late double price;
  late double quantity;
  late double discTotal; //price after discount
  late DateTime created_at;

  Item(String name, double price, double quantity) { //To store product description
    this.name = name;
    this.price = price;
    this.quantity = quantity;
    this.discTotal = 0;
    this.created_at = DateTime.now();
  }
}

void main() {
  //Nur Hafni (1913844), Farjana (1912190), Fatini (1911182), Nur Asimah(1813212)
  List<Item> itemList = []; //To store products inserted in the list

  while (true) {
    //Let user choose
    print('\n');

    print("Point Of Sale System: \n");

    print("1. Insert product");

    print("2. List of products");

    print("3. Total price include GST");

    print("4. Make Payment \n");

    stdout.write("Enter your choice: ");

    try {
      int input = int.parse(stdin.readLineSync()!);

      if (input > 4 || input < 1) {
        print("ERROR: Please select a number between 1 - 5");
        continue;
      }
      if (input == 1) {
        createItem(itemList);
      } else if (input == 2) {
        displayProducts(itemList) ; 
      }  else if (input == 3) {
        calcQuantity(itemList);
      } else if (input == 4) {
        makePayment();
        break;
      }
    } on FormatException {
      print("ERROR: Please enter an integer number");
    }
  }
}

//Nur Hafni (1913844)
void createItem(List<Item> items) { //Ask user input and store in the list
  
  stdout.write("Enter product description:");

  print('\n');

  stdout.write("Name: ");
  String productName = stdin.readLineSync()!;

  stdout.write("Price: ");
  double productPrice = double.parse(stdin.readLineSync()!);

  stdout.write("Quantity: ");
  double productQuantity = double.parse(stdin.readLineSync()!);

  // double disc = 0;

  var newItem = Item(productName, productPrice, productQuantity);

  items.add(newItem);

  print("Product inserted at ${newItem.created_at}");

}

displayProducts(List<Item> items) { //Display products list
  //Nur Asimah 1813212

  print("List of Products");
  print("=================");

  for (int i = 0; i < items.length; i++) {
    print("#${i + 1} ${items[i].name}\tRM ${items[i].price}\t x${items[i].quantity}");


  }
}

//Calculate total price including GST
getGST() { //Farjana (1912190)
  double countGST = totalAfterDiscount * 0.06;
  totalIncGST = totalAfterDiscount + countGST;
}

calcQuantity(List<Item> items) { //Calculate final price (With GST and discount)
  //Nur Hafni (1913844)
  //Nuridah (1828074)

  for (int i = 0; i < items.length; i++) {

    items[i].discTotal = discount(items[i].name, items[i].price); //Discount price for specific item

  }

  for (int i = 0; i < items.length; i++) {

    totalAfterDiscount += (items[i].quantity * items[i].discTotal); //Total price with discount
  }
  getGST(); //Farjana (1912190)
  print("Total price including GST is RM${totalIncGST.toStringAsFixed(2)}"); //Total price include gst

}

//Declare discount price for specific items
discount(String disName, double disPrice) { //Nur Hafni (1913844)

  switch (disName.toLowerCase()) {
    case "milo":
      {
        disc = disPrice * 0.15;
        newPrice = disPrice - disc;
      }
      break;

    case "downy":
      {
        disc = disPrice * 0.3;
        newPrice = disPrice - disc;
      }
      break;

    case "chipsmore":
      {
        disc = disPrice * 0.1;
        newPrice = disPrice - disc;
      }
      break;

    case "bowl":
      {
        disc = disPrice * 0.7;
        newPrice = disPrice - disc;
      }
      break;

    default:
      {
        newPrice = disPrice;
        break;
      }
  }
  return newPrice;
}


makePayment() { //Calculate balance money from total payment made
  //Fatini (1911182)
  totalIncGST.toStringAsFixed(2);
  print("TIME : ${DateTime.now()}");
  print("===========================");
  print("Your total is RM ${totalIncGST.toStringAsFixed(2)}");
  print("===========================");
  stdout.write("Enter your money: ");
  double money = double.parse(stdin.readLineSync()!);

  if (money >= totalIncGST) {
    double balance = money - totalIncGST;
    balance.toStringAsFixed(2);
    print("===========================");
    print("TOTAL  : RM ${totalIncGST.toStringAsFixed(2)}");
    print("CASH   : RM ${money}");
    print("CHANGE : RM ${balance.toStringAsFixed(2)}");
    print("===========================");
    print("Thank you! Have a nice day!");
  }

  while (money < totalIncGST) {
    print("Not enough money T.T");
    stdout.write("Enter your money: ");
    double money = double.parse(stdin.readLineSync()!);

    if (money >= totalIncGST) {
      double balance = money - totalIncGST;
      balance.toStringAsFixed(2);
      print("===========================");
      print("TOTAL  : RM ${totalIncGST.toStringAsFixed(2)}");
      print("CASH   : RM ${money}");
      print("CHANGE : RM ${balance.toStringAsFixed(2)}");
      print("===========================");
      print("Thank you! Have a nice day!");
      break;
    }
  }
}
