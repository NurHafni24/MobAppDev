import 'dart:io';

double newPrice = 0;
double disc = 0; //Discount price
double totalAfterDiscount = 0;
double gstValue = 0.0;

class Item {
  //Nur Hafni (1913844)
  //late keyword is to tell the compiler to treat this variable as non-nullable and will be initialized later
  late String name;
  late double price;
  late double quantity;
  late double discTotal; //price after discount
  late DateTime created_at;

  Item(String name, double price, double quantity) {
    this.name = name;
    this.price = price;
    this.quantity = quantity;
    this.discTotal = 0;
    this.created_at = DateTime.now();
  }
}

void main() {
  //Nur Hafni (1913844), Farjana (1912190), Fatini (1911182)
  List<Item> itemList = []; //To store products inserted

  while (true) {
    //Let user choose
    print('\n');

    print("Point Of Sale System: \n");

    print("1. Insert product");

    //PART ASIMAH
    print("2. List of products"); //print product list with the detail

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
        //code Asimah
      }  else if (input == 3) {
        // stdout.write("Enter gst percent: ");
        // gstValue = double.parse(stdin.readLineSync()!);
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

void getGST(double productPrice) {
  //Farjana (1912190)
  gstValue == 0.0 ? gstValue = 0.06 : gstValue = gstValue;
  double totalGST = productPrice * (gstValue / (100 + gstValue));
  print("Total GST for 1 pack is: " + totalGST.toStringAsFixed(3));
}

void createItem(List<Item> items) {
  //Nur Hafni (1913844)
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

calcQuantity(List<Item> items) {
  //Nur Hafni (1913844)

  //double total = 0;

  for (int i = 0; i < items.length; i++) {

    items[i].discTotal = discount(items[i].name, items[i].price); //Discount price for specific item

  }

  for (int i = 0; i < items.length; i++) {

    totalAfterDiscount += (items[i].quantity * items[i].discTotal); //Total price with discount
  }
  
  getGST(totalAfterDiscount); //Farjana (1912190)

  print("Total price including GST is $totalAfterDiscount"); //Total price include gst

}

//Declare discount for few items
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


makePayment() {
  //Fatini (1911182)
  totalAfterDiscount.toStringAsFixed(2);
  print("TIME : ${DateTime.now()}");
  print("===========================");
  print("Your total is RM ${totalAfterDiscount.toStringAsFixed(2)}");
  print("===========================");
  stdout.write("Enter your money: ");
  double money = double.parse(stdin.readLineSync()!);

  if (money >= totalAfterDiscount) {
    double balance = money - totalAfterDiscount;
    balance.toStringAsFixed(2);
    print("===========================");
    print("TOTAL  : RM ${totalAfterDiscount.toStringAsFixed(2)}");
    print("CASH   : RM ${money}");
    print("CHANGE : RM ${balance.toStringAsFixed(2)}");
    print("===========================");
    print("Thank you! Have a nice day!");
  }

  while (money < totalAfterDiscount) {
    print("Not enough money T.T");
    stdout.write("Enter your money: ");
    double money = double.parse(stdin.readLineSync()!);

    if (money >= totalAfterDiscount) {
      double balance = money - totalAfterDiscount;
      balance.toStringAsFixed(2);
      print("===========================");
      print("TOTAL  : RM ${totalAfterDiscount.toStringAsFixed(2)}");
      print("CASH   : RM ${money}");
      print("CHANGE : RM ${balance.toStringAsFixed(2)}");
      print("===========================");
      print("Thank you! Have a nice day!");
      break;
    }
  }
}
