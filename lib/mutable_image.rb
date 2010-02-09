require 'rubygems'
require 'open-uri'
require 'RMagick'

class MutableImage

  def initialize(url)
    @image = Magick::Image.from_blob(open(url).read).first
    @image.format = 'png'
  end

  def valid?
    !@image.nil?
  end

  def none
  end

  def save_to(file)
    return nil unless valid?
    begin
      File.open(file,'w') do |f|
        f.write(@image.to_blob)
      end
    rescue
      return nil
    end
  end

  def spread
    @image = @image.spread(3.0)
  end

  def flip_vertical
    @image = @image.flip
  end

  def flip_horizontal
    @image = @image.flop
  end

  def frame
    @image = @image.frame
  end

  def blur
    @image = @image.gaussian_blur
  end

  def wet_floor
    images = Magick::ImageList.new
    images << @image
    images << @image.wet_floor(0.5,2.0)
    @image = images.append(true)
  end

  def polaroid
    @image[:caption] = "Great Times at RubyCamp 2010"
    @image = @image.polaroid
  end

end
