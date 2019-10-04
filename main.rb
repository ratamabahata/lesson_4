#загрузка созданных классов
require_relative './train.rb'
require_relative './route.rb'
require_relative './passenger_carriage.rb'
require_relative './cargo_carriage.rb'
require_relative './passenger_train.rb'
require_relative './cargo_train.rb'
require_relative './station.rb'

class Main
  attr_reader :stations, :trains, :routes
   #инициализация массива станций, поездов и маршрутов. 
  def initialize
    @stations = []
    @trains = []
    @routes = []
  end
#интерфейс и выбор
  def main_menu
    loop do
      puts 'Enter \'1\' to create station.'
      puts 'Enter \'2\' to show_stations.'
      puts 'Enter \'3\' to create route.'
      puts 'Enter \'4\' to edit_route.'
      puts 'Enter \'5\' create_train.'
      puts 'Enter \'6\' train_actions.'
      puts 'Enter \'0\' to exit.'
      choice = gets.chomp.to_i

      break if choice.zero?

      case choice
      when 1 then create_station
      when 2 then show_stations
      when 3 then create_route
      when 4 then edit_route
      when 5 then create_train
      when 6 then train_actions
      when 0 then abort('Stop the program.')
      else puts 'It is not an option. Try again.'
      end
    end
  end

#создание станции.
  def create_station
    puts 'Enter the station name'
    @stations << Station.new(gets.chomp.to_s)
  end

#создание поезда. выбора типа поезда.
  def create_train
    puts 'Enter \'1\' to create passenger train.'
    puts 'Enter \'2\' to create cargo train.'
    input = gets.chomp.to_i
    case input
    when 1 then
      puts 'Enter number of train.'
      @trains << PassengerTrain.new(gets.chomp)
    when 2 then
      puts 'Enter number of train.'
      @trains << CargoTrain.new(gets.chomp)
    end
  end

#создание маршрута.
  def create_route
    start_station = select_station('start station')
    end_station = select_station('end station')
    @routes << Route.new(start_station, end_station)
    puts @routes
  end
end
#добавление и удаление станций в маршрут
def edit_route_menu_options
    [
      '1 - add station',
      '2 - remove station'
    ]
  end

  def edit_route
    route = choiced_route
    render_options('route actions', edit_route_menu_options)
    case option_choice
    when 1 then route.add_station(select_station)
    when 2 then route.remove_station(select_station)
    end
  end

#удаление и добавление вагонов в поезд
def train_actions_menu_options
    [
      '1 - set route',
      '2 - add wagon',
      '3 - remove wagon',
      '4 - move forward',
      '5 - move backward'
    ]
  end
#метод добавления и удаления вагонов в поезд.
 def train_actions
    if @trains.empty?
      print_error('Not a single train was created')
      return
    end

    train = choiced_train
    render_options('train actions', train_actions_menu_options)

    case option_choice
    when 1 then train.define_route(choiced_route)
    when 2 then train_add_wagon(train)
    when 3 then train.remove_wagon
    when 4 then train.forward
    when 5 then train.backward
    end
  end
#метод добавления вагонов
def train_add_wagon(train)
    wagon = case train.type
            when 'passenger' then PassengerCarriage
            when 'cargo' then CargoCarriage
            end
    train.add_wagon(wagon.new)
  end
end
#просмотр станции.
  def show_stations
    print_title('show stations')
    @stations.each do |station|
      print station.name + '. '
      station.show_trains
    end
  end


=begin


#создаем метод выбора  
  def select_station(title = 'station')
    select_entity("choice #{title}", @stations, :name)
  end
#создание маршрута.  
rescue Exception => e
  

  def create_route
    puts 'To crate route enter two station of this list:'
    @stations.each.with_index { |station, index| puts "#{index} - #{station.name}" }
    puts 'Enter number of the first station.'
    number_first = gets.chomp.to_i
    first = @stations[number_first]
    puts 'Enter number of the last station.'
    number_last = gets.chomp.to_i
    last = @stations[number_last]
    @routes << Route.new(first, last)
  end

   #добавление станций в маршрут

  def add_station_in_route
    @routes.each.with_index { |route, index| puts "#{index} - #{route.stations.map { |station| station.name} }"  }
    puts 'Choose the route on that you need to add station.'
    number_route = gets.chomp.to_i
    current_route = @routes[number_route]
    puts 'Enter number of the station.'
    @stations.each.with_index { |station, index| puts "#{index} - #{station.name}" }
    number_station = gets.chomp.to_i
    current_route.add_station(@stations[number_station])
  end
    #удаление станций в маршрут.
  def remove_station_in_route
    @routes.each.with_index { |route, index| puts "#{index} - #{route.stations.map { |station| station.name} }"  }
    puts 'Choose the route on that you need to remove station.'
    number_route = gets.chomp.to_i
    current_route = @routes[number_route]
    puts 'Enter number of the station.'
    @stations.each.with_index { |station, index| puts "#{index} - #{station.name}" }
    number_station = gets.chomp.to_i
    current_route.delete_station(@stations[number_station])
  end
 #назначить маршрут поезду. 
  def get_route_to_train
    puts 'Choose route for train.'
    @routes.each.with_index { |route, index| puts "#{index} - #{route.stations.map { |station| station.name} }"  }
    number_route = gets.chomp.to_i
    current_route = @routes[number_route]
    puts 'Choose train.'
    @trains.each.with_index { |train, index| puts "#{index} - #{train.number}(#{train.type})" }
    number_train = gets.chomp.to_i
    current_train = @trains[number_train]
    current_train.take_route(current_route)
  end
    #Добавлять вагоны к поезду
  def add_carriage
    @trains.each.with_index { |train, index| puts "#{index} - #{train.number}(#{train.type})" }
    puts 'Choose train that need to add corriage.'
    number_train = gets.chomp.to_i
    if @trains[number_train].type == :cargo
      puts 'Enter number corriage.'
      number_carriage = gets.chomp.to_i
      @trains[number_train].add_carriage(CargoCarriage.new(number_carriage))
    elsif @trains[number_train].type == :passenger
      puts 'Enter number corriage.'
      number_carriage = gets.chomp.to_i
      @trains[number_train].add_carriage(PassengerCarriage.new(number_carriage))
    end
    puts "Number of carriage = #{@trains[number_train].count_carriages}"
  end
    # Отцеплять вагоны от поезда
  def delete_carriage
    @trains.each.with_index { |train, index| puts "#{index} - #{train.number}(#{train.type})" }
    puts 'Choose train that need to remove corriage.'
    number_train = gets.chomp.to_i
    @trains[number_train].remove_carriage if @trains[number_train].carriages.length != 0
    puts "Number of carriage = #{@trains[number_train].count_carriages}"
  end
    #Перемещать поезд по маршруту вперед и назад
  def move_train
    @trains.each.with_index { |train, index| puts "#{index} - #{train.number}(#{train.type})" }
    puts 'Choose train that you need to move.'
    number_train = gets.chomp.to_i
    puts 'Enter \'1\' to move forward or \'2\' to move backword.'
    input = gets.chomp.to_i
    case input
    when 1 then @trains[number_train].forward
    when 2 then @trains[number_train].backward
    end
  end
    #Просматривать список станций и список поездов на станции
  def list_stations_and_trains_on_it
    @stations.each.with_index { |station, index| puts "#{index} - #{station.name}" }
    puts "Enter number of station to view which trains on it."
    number_station = gets.chomp.to_i
    number_train = @stations[number_station].trains.map { |train| train.number}
    type_train = @stations[number_station].trains.map { |train| train.type}
    puts "Number of train:#{number_train} type:#{type_train}"
  end
end

main = Main.new
main.main_menu
=end