require 'sinatra'

# Disclaimer: Eine sehr simple Anwendung, man kann zu einem Key ein Value mappen, zB post -d "Name Vorname" und diese dann mit
# get URI/Name abfragen, es wird dann das Value ausgegeben, get URI/all gibt alle Einträge aus

# Das Programm ist wirklich sehr simpel gehalten, es finden keine tests statt und es muss aus dem . directory mit ruby src/test.rb ausgeführt werden
# (das sind aber alles Sachen die man leicht fixen kann), die db Datei muss zB vorher existieren

# API calls

# get all saved data
get '/all' do
  string = ''
  get_data.each do |element|
    string += element
    string += "\n"
  end
  string
end

# get a value to a key from the db file
get '/:key' do
  get_value params['key'].to_s
end

# post a new entry for the db file
post '/' do
  post_data request.body.read
end

# functions

# get the whole data
def get_data
  file = File.open 'data/db'
  data = file.readlines.map(&:chomp)
  file.close
  data
end

# get a fitting value to a key
def get_value(key)
  data = get_data
  data.each do |element|
    return element.gsub key + ' ', '' if element.include? key
  end
  'key not present'
end

# put data into the db file
def post_data(data)
  file = File.open 'data/db', 'a'
  file.puts data
  file.close
end
