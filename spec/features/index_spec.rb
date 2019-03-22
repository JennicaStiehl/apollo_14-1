require 'rails_helper'
RSpec.describe 'as a visitor' do
  before :each do
    @neil = Astronaut.create(name:"Neil", age:35, job:"commander")
    @sam = Astronaut.create(name:"sam", age:50, job:"astronaut")
    @sally = Astronaut.create(name:"sally", age:25, job:"astronaut")
    @m1 = @neil.missions.create(title:"Apollo 13", time_in_space: 10)
    @m2 = @neil.missions.create!(title:"Gemini 7", time_in_space: 5)
    @m3 = @neil.missions.create(title:"Capricorn 4", time_in_space: 5)
  end
  describe 'when i visit astronaut index' do
    it 'i see names, ages, jobs' do
      visit astronauts_path
      expect(page).to have_content(@neil.name)
      expect(page).to have_content(@sam.name)
      expect(page).to have_content(@sally.name)
      expect(page).to have_content(@neil.age)
      expect(page).to have_content(@sam.age)
      expect(page).to have_content(@sally.age)
      expect(page).to have_content(@neil.job)
      expect(page).to have_content(@sam.job)
      expect(page).to have_content(@sally.job)
    end
    it 'can calc avg age of astronauts' do
      visit astronauts_path
      expect(page).to have_content("Avg age: 36.7")
    end
    it 'can sort alphabetically' do
      visit astronauts_path

      expect(page).to have_content("Apollo 13 Capricorn 4 Gemini 7")
    end
    it 'can calc total time in space' do
      visit astronauts_path
      expect(page).to have_content("Total Time in Space: 20 days")
      # I see the total time in space for each astronaut.
      # (e.g. "Name: Neil Armstrong, Age: 37, Job: Commander, Total Time in Space: 760 days")

    end
  end
end
