class Transactions {
  int? id;
  TransactionType type;
  double amount;
  String description;

  Transactions({
      this.id,
      required this.type,
      required this.amount, 
      required this.description,
      });

      Map<String, dynamic> toMap(){
        return{
          'id': id,
          'type': type == TransactionType.income ? 'income' : 'expense',
          'amount': amount,
          'description': description,
        };
      }


      factory Transactions.fromMap(Map<String, dynamic> map){
        return Transactions(
          id: map["id"],
          type: map["type"] == 'income' ? TransactionType.income : TransactionType.expense, 
          amount: map["amount"], 
          description: map["description"],
          );
      }


}

enum TransactionType {income, expense}