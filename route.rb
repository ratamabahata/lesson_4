#класс маршрут
class Route
    
  attr_reader :stations
  #инициализация маршурута.  
  def initialize(first, last)
    @stations = [first, last]
  end
   #добавление стацний 
  def add_station(station)
    @stations.insert(-2, station)
  end
   #удаление станций
  def delete_station(station)
    @stations.delete(station)
  end
  #вывод списка станций для поезда.
  protected
  def station_list
    @stations.each do |r|
      p r
    end
  end
end
