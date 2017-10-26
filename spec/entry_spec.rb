require_relative '../model/entry.rb'
# #1 line below is standard first line of RSpec test
RSpec.describe Entry do
  # #2 describe makes our test structure, used to communicate that specs test Entry attributes
  describe "attributes" do
    let(:entry) { Entry.new('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com') }
    # #3 it separates individual tests
    it "responds to name" do
      # #4 expect declares the expectations for the test, if met test passes ; if not met test fails
      expect(entry).to respond_to(:name)
    end

    it "reports its name" do
      expect(entry.name).to eq('Ada Lovelace')
    end

    it "responds to phone number" do
      expect(entry).to respond_to(:phone_number)
    end

    it "reports its phone number" do
      expect(entry.phone_number).to eq('010.012.1815')
    end

    it "responds to email" do
      expect(entry).to respond_to(:email)
    end

    it "reports its email" do
      expect(entry.email).to eq('augusta.king@lovelace.com')
    end
  end

  # #5 describe used to separate string test from other test; # indicates to_s is an instance method
  describe "#to_s" do
    it "prints an entry as a string" do
      entry = Entry.new('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')
      expected_string = "Name: Ada Lovelace\nPhone Number: 010.012.1815\nEmail: augusta.king@lovelace.com"
  # #6 eq checks that to_s returns a string equal to content in variable expected_string
    expect(entry.to_s).to eq(expected_string)
    end
  end
end
