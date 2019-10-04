#класс грузовых поездов включает в себя класс поездов.
class CargoTrain < Train
  def initialize(number, type = :cargo)
  	#передаем переменные выше стоящему классу.
    super
  end
  
  def add_carriage(carriage)
  	#проверяем что объект является экземпляром именно конкретного класса.
    super if carriage.instance_of? CargoCarriage
  end
end
