require_relative 'controllers/menu_controller.rb'

# #4 creates new menu controller when AddressBloc starts
menu = MenuController.new
# #5 this clears the command line
system "clear"
puts "Welcome to AddressBloc!"
# #6 call the main_menu function to display the menu
menu.main_menu
