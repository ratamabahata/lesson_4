#класс поезда

class Train
    
  attr_reader :number, :type
  attr_accessor :speed, :carriages
  #инициализация переменных номер вагона и его тип. Назначение нулевой скорости. и создание пустого массива поезда. 
  def initialize(number, type)
    @number = number
    @type = type
    @speed = 0
    @carriages = []
  end
    
  def gather_speed(new_speed)
    @speed = new_speed
  end
  #состояние покоя поезда  
  def stop
    @speed = 0
  end
  #метод добавление вагонов при стоянке.
  def add_carriage(carriage)
      @carriages << carriage if @speed.zero?
  end
  #удаление вагонов при стоянке
  def remove_carriage
    @carriages.pop if @carriages.size > 0 && @speed.zero?
  end
  #метод подсчета кол. вагонов
  def count_carriages
    @carriages.size
  end
  #cоздание маршрута
  def take_route(route)
    @route = route
    @at_station = 0
    @route.stations.first.take_train(self)
  end
  #увеличение маршрута  
  def forward
    return unless next_station
    
    current_station.depart_train(self)
    next_station.take_train(self)
    @at_station += 1
  end
  #уменьшение маршрута  
  def backward
    return unless previous_station
    
    current_station.depart_train(self)
    previous_station.take_train(self)
    @at_station -= 1
  end
  
  private
  # Эти методы не используются за переделами этого класса и привязаны к поезду.
  #показать маршрут. вывести его.
  def show_route
    [previous_station, current_station, next_station]
  end
  
  def last_station?
    @route.stations.last == current_station
  end

  def first_station?
    @route.stations.first == current_station
  end
  
  def current_station
    @route.stations[@at_station]
  end
  
  def previous_station
    @route.stations[@at_station - 1] unless first_station?
  end
  
  def next_station
    @route.stations[@at_station + 1] unless last_station?
  end
end
