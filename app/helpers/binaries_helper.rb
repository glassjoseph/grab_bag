module BinariesHelper
  def render_preview(binary)
    return image_preview(binary) if binary.extension
  end
end