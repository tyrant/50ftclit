require 'sinatra'

# Routes is an array of arrays. Each subarray's first entry
# is the shortened URL we're checking for: something like 
# 50ftcl.it/:shortened; and the second entry is the complete
# URL we're redirecting to.
routes = [
  ['grond', 'https://www.youtube.com/watch?v=u9BinUHHPv0'],
]

get '/:shortened' do
  if route = routes.find {|r| r[0] === params['shortened'] }
    redirect route[1]
  end
end