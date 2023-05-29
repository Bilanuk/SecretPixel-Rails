class BmpCreationService
  def self.generate_dependent_bmp(image, method, color)
    # Load the pixels of the original image
    pixels = image.file.download
    return nil unless pixels

    # Skip the first 54 bytes (header) of the image
    header_size = 54

    # Get the dimensions of the image
    width = pixels[18..21].unpack("L>").first
    height = pixels[22..25].unpack("L>").first

    (header_size...pixels.length).each do |index|
      # Calculate the x and y coordinates of the pixel
      x = (index - header_size) % width
      y = (index - header_size) / width

      # Determine the color value based on the specified method
      color = determine_color(x, y, width, height, method)

      # Modify the pixel color
      pixels[index] = color.chr
    end

    # Save the modified pixels back to the image
    image.file.attach(io: StringIO.new(pixels), filename: image.file.filename)

    image
  end

  private

  def self.determine_color(x, y, width, height, method)
    case method
    when "snowflake"
      determine_snowflake_color(x, y, width, height)
    when "carpet"
      determine_carpet_color(x, y, width, height)
    when "triangle"
      determine_triangle_color(x, y, width, height)
    else
      # Default color (black) if the method is not recognized
      0
    end
  end

  def self.determine_snowflake_color(x, y, width, height)
    # Calculate the center coordinates of the snowflake shape
    center_x = width / 2
    center_y = height / 2
  
    # Calculate the distance from the current pixel to the center of the snowflake
    distance = Math.sqrt((x - center_x)**2 + (y - center_y)**2)
  
    # Define the radius of the snowflake shape
    radius = width / 4
  
    if distance < radius
      # Pixel is within the snowflake shape
      # Return a specific color value (e.g., white)
      return 255
    else
      # Pixel is outside the snowflake shape
      # Return a different color value (e.g., black)
      return 0
    end
  end
  
  def self.determine_carpet_color(x, y, width, height)
    # Calculate the size of each carpet tile based on the dimensions
    tile_size = width / 3
  
    # Check if the current pixel is within the carpet shape
    if (x / tile_size) % 3 == 1 && (y / tile_size) % 3 == 1
      # Pixel is within the carpet shape
      # Return a specific color value (e.g., red)
      return 255
    else
      # Pixel is outside the carpet shape
      # Return a different color value (e.g., green)
      return 0
    end
  end
  
  def self.determine_triangle_color(x, y, width, height)
    # Calculate the center coordinates of the triangle shape
    center_x = width / 2
    center_y = height / 2
  
    # Define the size of the triangle shape
    triangle_size = width / 3
  
    # Calculate the coordinates of the three vertices of the triangle
    vertex1 = [center_x, center_y - triangle_size]
    vertex2 = [center_x - (Math.sqrt(3) * triangle_size) / 2, center_y + triangle_size / 2]
    vertex3 = [center_x + (Math.sqrt(3) * triangle_size) / 2, center_y + triangle_size / 2]
  
    # Check if the current pixel is within the triangle shape
    if point_in_triangle(x, y, vertex1, vertex2, vertex3)
      # Pixel is within the triangle shape
      # Return a specific color value (e.g., blue)
      return 255
    else
      # Pixel is outside the triangle shape
      # Return a different color value (e.g., yellow)
      return 0
    end
  end
  
  def self.point_in_triangle(x, y, vertex1, vertex2, vertex3)
    # Implement the point-in-triangle algorithm to check if the given coordinates are within the triangle
    # Return true if the point is inside the triangle, false otherwise
    # Example implementation:
    # Use barycentric coordinates to determine if the point is inside the triangle
    # You can find examples and explanations of the algorithm online
    # Here's a simple implementation assuming counter-clockwise vertex order:
    # p = [x, y]
    # v0 = vertex2 - vertex1
    # v1 = vertex3 - vertex1
    # v2 = p - vertex1
    # dot00 = dot_product(v0, v0)
    # dot01 = dot_product(v0, v1)
    # dot02 = dot_product(v0, v2)
    # dot11 = dot_product(v1, v1)
    # dot12 = dot_product(v1, v2)
    # inv_denominator = 1 / (dot00 * dot11 - dot01 * dot01)
    # u = (dot11 * dot02 - dot01 * dot12) * inv_denominator
    # v = (dot00 * dot12 - dot01 * dot02) * inv_denominator
    # return (u >= 0) && (v >= 0) && (u + v < 1)
    # You'll need to implement the dot_product function as well
  
    # Replace the implementation above with your own code
  end
  
  def self.dot_product(vector1, vector2)
    # Calculate the dot product of two vectors
    # Return the dot product value
    # Example implementation:
    # dot_product = vector1[0] * vector2[0] + vector1[1] * vector2[1]
    # return dot_product
  
    # Replace the implementation above with your own code
  end  
end
