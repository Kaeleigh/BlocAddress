# # connects the controller to address book
require_relative '../model/address_book.rb'

class MenuController
  attr_reader :address_book

  def initialize
    @address_book = AddressBook.new
  end

  def main_menu
    # # display menu options
    puts "Main Menu - #{address_book.entries.count} entries"
    puts "1 - View all entries"
    puts "2 - Create an entry"
    puts "3 - Search for an entry"
    puts "4 - Import entries from a CSV"
    puts "5 - View Entry Number"
    puts "6 - Exit"
    print "Enter your selection: "

    # # retrieves user input
    selection = gets.to_i

    # # determines proper response to user's input
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
        system "clear"
        view_entry_number
        main_menu
      when 6
        puts "Good-bye"
        # # terminates program, 0 shows program is exiting without an error
        exit(0)
      # # else used to catch invalid inputs, calls main_menu to ask for another input
      else
        system "clear"
        puts "Sorry, that is not a valid input"
        main_menu
    end
  end

  # # view specific entry method
  def view_entry_number
    print "Enter entry number: "
    selection = gets.chomp.to_i

    if selection < @address_book.entries.count
      puts @address_book.entries[selection]
      puts "Hit enter to return to main menu"
      gets.chomp
      system "clear"
    else
      puts "#{selection} is not a valid entry number"
      view_entry_number
    end
  end

  # # menu options defined
  def view_all_entries
    # # loops through all entries in Address Book
    address_book.entries.each do |entry|
      system "clear"
      puts entry.to_s
    # # calls the method to display a submenu of each entry
      entry_submenu(entry)
    end

    system "clear"
    puts "End of entries"
  end

  def create_entry
    # # clears the terminal before displaying create entry prompts
    system "clear"
    puts "New AddressBloc Entry"
    # # print prompts the user for each Entry attribute
    print "Name: "
    name = gets.chomp
    print "Phone number: "
    phone = gets.chomp
    print "Email: "
    email = gets.chomp

    # # adds new entry to address_book and ensure it is added in proper order
    address_book.add_entry(name, phone, email)

    system "clear"
    puts "New entry created"
  end

  def search_entries
    # # prompts user to input a name, stores input into  name
    print "Search by name: "
    name = gets.chomp
    # # retrieves name thru binary_search and returns value in match
    match = address_book.binary_search(name)
    system "clear"
    # # check if search returned a match, if so call search submenu
    if match
      puts match.to_s
      search_submenu(match)
    else
      puts "No match found for #{name}"
    end
  end

  def read_csv
    # # prompt user to enter name of csv file to import, retrive file and place in file_name
    print "Enter CSV file to import: "
    file_name = gets.chomp

    # # checks if file is empty if so return to main menu
    if file_name.empty?
      system "clear"
      puts "No CSV file read"
      main_menu
    end

    # # inside begin & end blocks import specific file, clear screen and print entries from file
    begin
      entry_count = address_book.import_from_csv(file_name).count
      system "clear"
      puts "#{entry_count} new entries added from #{file_name}"
    # # rescue method alloes exception to continue executing
    rescue
      puts "#{file_name} is not a valid CSV file, please enter the name of a valid CSV file"
      read_csv
    end
  end

  def delete_entry(entry)
    # # entry is removed from address_book and print out message that confirms entry removal
    address_book.entries.delete(entry)
    puts "#{entry.name} has been deleted"
  end

  def edit_entry(entry)
    # # prompts user for updated info then updates the information
    print "Updated name: "
    name = gets.chomp
    print "Updated phone number: "
    phone_number = gets.chomp
    print "Updated email: "
    email = gets.chomp

    # # entry attribute set on entry only if valid attribute was read from user
    entry.name = name if !name.empty?
    entry.phone_number = phone_number if !phone_number.empty?
    entry.email = email if !email.empty?
    system "clear"

    # # prints updated entry that user inputed
    puts "Updated entry: "
    puts entry
  end

  def entry_submenu(entry)
    # # display the submenu options
    puts "n - next entry"
    puts "d - delete entry"
    puts "e - edit this entry"
    puts "m - return to main menu"

    # #chomp removes any trailing whitespace from string that get returns
    selection = gets.chomp
    case selection
      # # control returns to view_all_entries when user asks to see next entry
    when "n"
      # # deletes and edits entries
    when "d"
      # # calls the delete_entry method
      delete_entry(entry)
    when "e"
      # # returns to main menu
      # # calls edit_entry method, then shows submenu
      edit_entry(entry)
      entry_submenu(entry)
    when "m"
      system "clear"
      main_menu
    else
      system "clear"
      puts "#{selection} is not a valid input"
      entry_submenu(entry)
    end
  end

  def search_submenu(entry)
     # # print out submenu for entry
     puts "\nd - delete entry"
     puts "e - edit this entry"
     puts "m - return to main menu"
     # # save user input to selection
     selection = gets.chomp

     # # takes specific action based on input 
     case selection
       when "d"
         system "clear"
         delete_entry(entry)
         main_menu
       when "e"
         edit_entry(entry)
         system "clear"
         main_menu
       when "m"
         system "clear"
         main_menu
       else
         system "clear"
         puts "#{selection} is not a valid input"
         puts entry.to_s
         search_submenu(entry)
     end
   end
  # # closes entire controller
end
