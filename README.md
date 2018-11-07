# ImageHash

This is a very simple Ruby library for calculating a perceptual hash of any image using ImageMagick.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'image_hash'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install image_hash

## Usage

Create a new ImageHash instance, passing in the path to your image. Use the `#hash` method
to get a compact hexadecimal hash representing the image:

```ruby
ImageHash.new('image1.jpg').hash        # => fce000101834b692
ImageHash.new('image2.jpg').hash        # => fce000101834b693
```

If you would rather, you can get the binary hash with `#binary_hash`:

```ruby
ImageHash.new('image1.jpg').binary_hash # => 1111110011100000000000000001000000011000001101001011011010010010
ImageHash.new('image2.jpg').binary_hash # => 1111110011100000000000000001000000011000001101001011011010010011
```

Easily compare two hashes using the `.distance` method:

```ruby
ImageHash.distance(
  ImageHash.new('image1.jpg').hash,
  ImageHash.new('image2.jpg').hash
) # => 1
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
