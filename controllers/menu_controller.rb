# #1 connects the controller to address book
require_relative '../model/address_book.rb'

class MenuController
  attr_reader :address_book

  def initialize
    @address_book = AddressBook.new
  end

  def main_menu
    # #2 display menu options
    puts "Main Menu - #{address_book.entries.count} entries"
    puts "1 - View all entries"
    puts "2 - Create an entry"
    puts "3 - Search for an entry"
    puts "4 - Import entries from a CSV"
    puts "5 - Exit"
    print "Enter your selection: "

    # #3 retrieves user input
    selection = gets.to_i

    # #7 determines proper response to user's input
    case selection
      when 1
        system "clear"
        view_all_entries
        main_menu
      when 2
        system "clear"
        create_entry
        main_menu
      when 3
        system "clear"
        search_entries
        main_menu
      when 4
        system "clear"
        read_csv
        main_menu
      when 5
        puts "Good-bye"
        # #8 terminates program, 0 shows program is exiting without an error
        exit(0)
      # #9 else used to catch invalid inputs, calls main_menu to ask for another input
      else
        system "clear"
        puts "Sorry, that is not a valid input"
        main_menu
    end
  end

  # #10 menu options defined
  def view_all_entries
    # #14 loops through all entries in Address Book
    address_book.entries.each do |entry|
      system "clear"
      puts entry.to_s
    # #15 calls the method to display a submenu of each entry
      entry_submenu(entry)
    end

    system "clear"
    puts "End of entries"
  end

  def create_entry
    # #11 clears the terminal before displaying create entry prompts
    system "clear"
    puts "New AddressBloc Entry"
    # #12 print prompts the user for each Entry attribute
    print "Name: "
    name = gets.chomp
    print "Phone number: "
    phone = gets.chomp
    print "Email: "
    email = gets.chomp

    # #13 adds new entry to address_book and ensure it is added in proper order
    address_book.add_entry(name, phone, email)

    system "clear"
    puts "New entry created"
  end

  def search_entries
  end

  def read_csv
  end

  def entry_submenu(entry)
    # #16 display the submenu options
    puts "n - next entry"
    puts "d - delete entry"
    puts "e - edit this entry"
    puts "m - return to main menu"

    # #17 chomp removes any trailing whitespace from string that get returns
    selection = gets.chomp
    case selection
      # #18 control returns to view_all_entries when user asks to see next entry
    when "n"
      # #19 deletes and edits entries 
    when "d"
    when "e"
      # #20 returns to main menu
    when "m"
      system "clear"
      main_menu
    else
      system "clear"
      puts "#{selection} is not a valid input"
      entry_submenu(entry)
    end
  end
end
