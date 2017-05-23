module BinariesHelper
  def render_preview(binary)
    return image_preview(binary) if image_extensions.include? binary.extension
    return text_preview(binary) if binary.extension == 'txt'
    return no_preview
  end

private

  def image_extensions
    [
      'jpg',
      'jpeg',
      'png',
      'bmp'
    ]
  end

  def image_preview(binary)
    image_tag binary.data_url
  end

  def text_preview(binary)
    response = Faraday.get(binary.data_url)
    text = response.body

    simple_format text
  end

  def no_preview
    "I can't display a preview of that data type."
  end
end