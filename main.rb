# frozen_string_literal: true

system 'clear' || 'cls'
@profit = 0
@valid_money = [5_000, 2_000, 1_000, 500, 200, 100]
@init_drinks = [
  {
    name: 'Coke',
    cost: 2_500,
    qty: 5
  },
  {
    name: 'Water',
    cost: 2_000,
    qty: 4
  },
  {
    name: 'Oatmeal',
    cost: 1_500,
    qty: 3
  },
  {
    name: 'Tea',
    cost: 100,
    qty: 2
  }
]

def main
  loop do
    show_drinks
    puts "Enter the letter of the option:\na. Pick a drink\nb. Exit\n"
    option = gets.chomp
    case option
    when 'a' then purchase_process
    when 'b' then break
    else invalid_input
    end
  end
end

def show_drinks
  system 'clear' || 'cls'
  puts "No.\tName\t\tPrice\t\tQuantity"
  @init_drinks.each_with_index do |drink, index|
    puts "#{index}\t#{drink[:name]}\t\t#{drink[:cost]}\t\t#{drink[:qty]}"
  end
  puts '-' * 100
end

def purchase_process
  puts 'Enter the number of the drink you want'
  drink_option = gets.chomp
  begin
    drink_option = Integer(drink_option)
  rescue ArgumentError
    invalid_input
  else
    drink_selected drink_option
  end
end

def drink_selected(drink_option)
  drink = @init_drinks[drink_option]
  if validate_selected_drink drink
    puts "You choosed: #{drink[:name]}\nCost: #{drink[:cost]}"
    get_money drink
    update_drink drink_option
    @profit += drink[:cost]
  end
  gets.chomp
end

def validate_selected_drink(drink)
  if drink.nil?
    puts 'Drink does not exists'
    false
  elsif drink[:qty].zero?
    puts 'Drink sold out, please select another'
    false
  else
    true
  end
end

def get_money(drink)
  drink_cost = drink[:cost]
  total_receive = 0
  while drink_cost > total_receive
    puts "\nEnter the money"
    current_amount = gets.to_i
    @valid_money.include?(current_amount) ? total_receive += current_amount : puts("Enter valid money:#{@valid_money}")
    puts "#{drink_cost - total_receive} left" if total_receive < drink_cost
  end
  give_change total_receive - drink_cost if drink_cost < total_receive
  puts "Thanks for buy: #{drink[:name]}"
end

def give_change(amount)
  puts 'Your change is:'
  while amount.positive?
    @valid_money.each do |money|
      next unless money <= amount

      puts money
      amount -= money
      break
    end
  end
end

def update_drink(index)
  drink = @init_drinks[index]
  drink_qty = drink[:qty]
  @init_drinks[index][:qty] = drink_qty - 1
end

def invalid_input
  puts "#{'-' * 100}\nEnter a valid option\nPress enter to continue\n"
  gets.chomp
end

def close_program
  show_drinks
  puts "Total profit: #{@profit}"
  puts 'bye..'
  gets
end

main
close_program
