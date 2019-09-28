lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'image_hash/version'

Gem::Specification.new do |spec|
  spec.name          = 'image_hash'
  spec.version       = ImageHash::VERSION
  spec.authors       = ['Tim Morgan']
  spec.email         = ['tim@timmorgan.org']

  spec.summary       = 'a simple perceptual hash library for images'
  spec.description   = 'generate a perceptual hash of any image using ImageMagick and a very simple algorithm'
  spec.homepage      = 'https://github.com/seven1m/image_hash_ruby'
  spec.license       = 'MIT'

  spec.files         = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files`.split("\n").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.require_paths = ['lib']

  spec.add_dependency 'mini_magick'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
end
