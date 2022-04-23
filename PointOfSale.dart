import 'dart:io';

double newPrice = 0;
double disc = 0; //Discount price
double totalAfterDiscount = 0;
double gstValue = 0.0;

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

  while (true) {
    //Let user choose
    print('\n');

    print("Point Of Sale System: \n");

    print("1. Insert product");

    //PART ASIMAH
    print("2. List of products"); //print product list with the detail

    print("3. Total amount after discount");
    
    print("4. Set GST percent (default = 0.6% )");

    print("5. Make Payment \n");

    stdout.write("Enter your choice: ");

    try {
      int input = int.parse(stdin.readLineSync()!);

      if (input > 5 || input < 1) {
        print("ERROR: Please select a number between 1 - 5");
        continue;
      }
      if (input == 1) {
        createItem(itemList);
      } else if (input == 2) {
        //code Asimah
      } else if (input == 3) {
        afterDiscountPrice();
      } else if (input == 4) {
        stdout.write("Enter gst percent: ");
        gstValue = double.parse(stdin.readLineSync()!);
      } else if (input == 5) {
        makePayment();
        break;
      }
    } on FormatException {
      print("ERROR: Please enter an interger number");
    }
  }
}

void getGST(double productPrice) {
  gstValue == 0.0 ? gstValue = 0.6 : gstValue = gstValue;
  double totalGST = productPrice * (gstValue / (100 + gstValue));
  // double finalAmount = totalGST + productPrice;
  print("Total GST for 1 pack is: " + totalGST.toStringAsFixed(3));
}

void createItem(List<Item> items) {
  stdout.write("Enter product description:");

  print('\n');

  stdout.write("Name: ");
  String productName = stdin.readLineSync()!;

  stdout.write("Price: ");
  double productPrice = double.parse(stdin.readLineSync()!);

  stdout.write("Quantity: ");
  double productQuantity = double.parse(stdin.readLineSync()!);

  var newItem = Item(productName, productPrice, productQuantity);

  items.add(newItem);

  calcQuantity(newItem.price, productQuantity, newItem.name);

  print("Product inserted at ${newItem.created_at}");
}

void calcQuantity(double price, double quantity, String productName) {
  var payment = discount(
      productName, price); //Total price after calculate with quantity inserted

  totalAfterDiscount = totalAfterDiscount + (payment * quantity);
}

//Declare discount for few items
discount(String prodName, double prodPrice) {
  prodName = prodName.toLowerCase();

 switch (prodName) {
    case "milo":
      {
        disc = prodPrice * 0.15;
        newPrice = prodPrice - disc;
        print("Price After Discount for 1 pack ${newPrice}");
      }
      break;

    case "downy":
      {
        disc = prodPrice * 0.3;
        newPrice = prodPrice - disc;
        print("Price After Discount for 1 bottle ${newPrice}");
      }
      break;

    case "chipsmore":
      {
        disc = prodPrice * 0.1;
        newPrice = prodPrice - disc;
        print("Price After Discount for 1 pack ${newPrice}");
      }
      break;

    case "bowl":
      {
        disc = prodPrice * 0.7;
        newPrice = prodPrice - disc;
        print("Price After Discount for 1 bowl ${newPrice}");
      }
      break;

    default:
      {
        newPrice = prodPrice;
        break;
      }
  }
  getGST(prodPrice);
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

   if (money < totalAfterDiscount) {
    print("Not enough money T.T");
    stdout.write("Enter your money: ");
    money = double.parse(stdin.readLineSync()!);
  }
    else  {
      double balance = money - totalAfterDiscount;
      balance.toStringAsFixed(2);
      print("TOTAL  : RM ${totalAfterDiscount}");
      print("CASH   : RM ${money}");
      print("CHANGE : RM ${balance}");
      print("===========================");
      print("Thank you! Have a nice day!");
    } 
}
