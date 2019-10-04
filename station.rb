#класс для станции
class Station
    
  attr_reader :name, :trains
  @@stations = []
  #инициализация станции и массив поездов на ней.  
  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
  end
  #приход поезда. добавление поезда.  
  def take_train(train)
    @trains << train
  end
  #вывод списка поездов на станции.  
  def trains_list(type)
    @trains.select { |train|  train if train.type == type }
  end
  #отправление поезда со станции.  
  def depart_train(train)
    @trains.delete(train)
  end
  
  def self.all
    @@stations
  end
end
