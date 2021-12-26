

 String countAge(int birthday){
  var today = DateTime.now();
  var birthdayDate = DateTime.fromMillisecondsSinceEpoch(birthday);
  var newDate = DateTime(today.year - birthdayDate.year, today.month - birthdayDate.month, today.day- birthdayDate.day);
  return "${newDate.year}  ${newDate.month}";
 }