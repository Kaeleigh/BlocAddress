# #8 creates a file path to entry class
require_relative 'entry.rb'

class AddressBook
  attr_reader :entries

  def initialize
    @entries = []
  end

  def add_entry(name, phone_number, email)
    # #9 create variable index to store insertion
    index = 0
    entries.each do |entry|
      # #10 compare name with current name; insert index if name proceeds entry.new; otherwise increase index and continue comparing entries
      if name < entry.name
        break
      end
      index+= 1
    end
    # #11 insert new entry into entries array using calculated index
    entries.insert(index, Entry.new(name, phone_number, email))
  end

  def remove_entry(name, phone_number, email)
    entries.each_with_index do |index, entry|
      entries.delete_at(index) and break if name == entry.name
    end
  end
end
