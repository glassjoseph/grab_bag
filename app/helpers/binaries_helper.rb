module BinariesHelper
  def render_preview(binary)
    return image_preview(binary) if binary.extension == 'jpg'
    return text_preview(binary) if binary.extension == 'txt'
    return no_preview
  end

private

  def image_preview(binary)
    image_tag binary.data_url
  end

  def text_preview(binary)
    content_tag :p, File.read(binary.data_url)
  end

  def no_preview
    "I can't display a preview of that data type."
  end
end