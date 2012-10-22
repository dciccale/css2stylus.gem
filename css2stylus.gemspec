Gem::Specification.new do |gem|
  gem.name        = 'css2stylus'
  gem.version     = '0.0.3'
  gem.date        = Date.today.to_s
  gem.summary     = "CSS to Stylus converter"
  gem.description = "A ruby library to convert CSS into Stylus."
  gem.authors     = ['Denis Ciccale']
  gem.email       = ['dciccale@gmail.com']
  gem.homepage    = 'https://github.com/dciccale/css2stylus'
  gem.license     = 'MIT'
  gem.files       = ["lib/css2stylus.rb"]
  gem.executables << 'css2stylus'
end