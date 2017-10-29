# #8 creates a file path to entry class
require_relative 'entry.rb'
require "csv"

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

  def import_from_csv(file_name)
    # #7 reads file, csv class used to parse the file and produce object csv table
    csv_text = File.read(file_name)
    csv = CSV.parse(csv_text, headers: true, skip_blanks: true)
    # #8 loop over the csv table rows, create a hash for each row and convert into an entry thru add_entry which adds entry to book
    csv.each do |row|
      row_hash = row.to_hash
      add_entry(row_hash["name"], row_hash["phone_number"], row_hash["email"])
    end
  end

  # # ends entire class
end
