#класс пассажирских поездов включает в себя класс поездов.
class PassengerTrain < Train
  def initialize(number, type = :passenger)
  	#передаем переменные выше стоящему классу.
    super
  end
  
  def add_carriage(carriage)
  	#использую instance_of? вместо is_a?, т.к. в данном случае одобнее произвордить проверку,
  	#проверяем что объект является экземпляром именно конкретного класса.
    super if carriage.instance_of? PassengerCarriage
  end
end