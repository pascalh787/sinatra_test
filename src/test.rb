require 'sinatra'

# API calls

# get all saved data
get '/all' do
  string = ''
  data.each do |element|
    string += element
    string += "\n"
  end
  string
end

# get a value to a key from the db file
get '/:key' do
  value(params['key'].to_s)
end

# post a new entry for the db file
post '/' do
  post_data(request.body.read)
end

# functions

# get the whole data
def data
  file = File.open('data/db')
  data = file.readlines.map(&:chomp)
  file.close
  data
end

# get a fitting value to a key
def value(key)
  temp = data
  temp.each do |element|
    return element.gsub("#{key} ", '') if element.include?(key)
  end
  'key not present'
end

# put data into the db file
def post_data(data)
  file = File.open('data/db', 'a')
  file.puts(data)
  file.close
end
