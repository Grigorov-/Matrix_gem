Gem::Specification.new do |s|
  s.name        = 'matrix_gem'
  s.version     = '0.2.3'
  s.date        = '2015-02-14'
  s.summary     = "Matrix gem"
  s.description = "Gem with easy interface for work with matrices"
  s.authors     = ["Bozhidar Grigorov"]
  s.email       = 'bojko002@gmail.com'
  s.files       = ["lib/matrix_gem.rb","lib/matrix_gem/matrix.rb","lib/matrix_gem/matrix_err.rb",
    "lib/matrix_gem/properties_module.rb","lib/matrix_gem/diagonal_matrix.rb",
    "lib/matrix_gem/orthogonal_matrix.rb","Rakefile"]
  s.homepage    =
    'http://rubygems.org/gems/matrix_gem'

  s.add_development_dependency "bundler" , '~> 1.7'
  s.add_development_dependency "rake",  '~> 10.4'
  s.add_development_dependency 'minitest', '~> 5.4'

  s.license       = 'MIT'
end