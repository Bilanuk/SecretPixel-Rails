class BmpCreationService
  def self.generate_dependent_bmp(image, method, color)
    # Load the pixels of the original image
    pixels = image.file.download
    return nil unless pixels

    # Skip the first 54 bytes (header) of the image
    header_size = 54

    # Get the dimensions of the image
    width_bytes = pixels[18..21].unpack("C*") # Retrieve the bytes as an array
    width = width_bytes.reverse.inject { |a, b| (a << 8) + b } # Convert the byte array to an integer
    height_bytes = pixels[22..25].unpack("C*") # Retrieve the bytes as an array
    height = height_bytes.reverse.inject { |a, b| (a << 8) + b } # Convert the byte array to an integer

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
  
    # Define the number of points in the snowflake (e.g., 6 for a Star of David)
    num_points = 6
  
    # Calculate the angle between each point in radians
    angle = (2 * Math::PI) / num_points
  
    # Define the size of the outer radius of the snowflake shape
    outer_radius = width / 4
  
    # Define the size of the inner radius of the snowflake shape
    inner_radius = outer_radius / 2
  
    # Iterate through each point of the snowflake
    num_points.times do |i|
      # Calculate the current angle for the point
      current_angle = i * angle
  
      # Calculate the x and y coordinates of the point based on the angle and radii
      point_x = center_x + outer_radius * Math.cos(current_angle)
      point_y = center_y + outer_radius * Math.sin(current_angle)
  
      # Calculate the distance from the current pixel to the current point
      distance = Math.sqrt((x - point_x)**2 + (y - point_y)**2)
  
      # Check if the pixel is within the outer radius of the current point
      if distance < outer_radius
        # Calculate the inner point for the current angle and radius
        inner_point_x = center_x + inner_radius * Math.cos(current_angle)
        inner_point_y = center_y + inner_radius * Math.sin(current_angle)
  
        # Calculate the distance from the current pixel to the inner point
        inner_distance = Math.sqrt((x - inner_point_x)**2 + (y - inner_point_y)**2)
  
        # Check if the pixel is outside the inner radius of the current point
        if inner_distance > inner_radius
          # Pixel is within the snowflake shape
          # Return a specific color value (e.g., white)
          return 255
        end
      end
    end
  
    # Pixel is outside the snowflake shape
    # Return a different color value (e.g., black)
    return 0
  end
  
  
  def self.within_snowflake?(x, y, width, height)
    # Calculate the center coordinates of the snowflake shape
    center_x = width / 2
    center_y = height / 2
  
    # Calculate the size of the center segment
    segment_width = width / 3
    segment_height = height / 3
  
    # Check if the pixel is within the center segment
    if x >= center_x - segment_width && x < center_x + segment_width &&
       y >= center_y - segment_height && y < center_y + segment_height
      return true
    else
      return false
    end
  end  
  
  
  def self.within_central_triangle?(x, y, width, height)
    # Check if the current pixel is within the central triangle of the snowflake
  
    # Calculate the size and coordinates of the central triangle
    triangle_size = [width, height].min / 3
    triangle_x = (width - triangle_size) / 2
    triangle_y = (height - triangle_size) / 2
  
    # Check if the pixel is within the central triangle
    return (x >= triangle_x && x < triangle_x + triangle_size &&
            y >= triangle_y && y < triangle_y + triangle_size)
  end
  

  def self.determine_carpet_color(x, y, width, height)
    # Check if the current pixel is within the carpet shape
    if sierpinski_carpet?(x, y, width, height)
      # Pixel is within the carpet shape
      # Return a specific color value (e.g., red)
      return 255
    else
      # Pixel is outside the carpet shape
      # Return a different color value (e.g., green)
      return 0
    end
  end
  
  def self.sierpinski_carpet?(x, y, width, height)
    # Base case: check if the current square is the smallest carpet tile
    return true if width <= 3 && height <= 3
  
    # Calculate the size of each carpet tile based on the dimensions
    tile_width = width / 3
    tile_height = height / 3
  
    # Check if the current pixel is within the center square of the current carpet tile
    if x % tile_width >= tile_width / 3 && x % tile_width < 2 * tile_width / 3 &&
       y % tile_height >= tile_height / 3 && y % tile_height < 2 * tile_height / 3
      return false # Pixel is in the center square, not part of the carpet
    else
      # Recursively check the smaller carpet tiles within the current square
      return sierpinski_carpet?(x % tile_width, y % tile_height, tile_width, tile_height)
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
    
    p = [x, y]
    v0 = [vertex2[0] - vertex1[0], vertex2[1] - vertex1[1]]
    v1 = [vertex3[0] - vertex1[0], vertex3[1] - vertex1[1]]
    v2 = [p[0] - vertex1[0], p[1] - vertex1[1]]
    
    dot00 = dot_product(v0, v0)
    dot01 = dot_product(v0, v1)
    dot02 = dot_product(v0, v2)
    dot11 = dot_product(v1, v1)
    dot12 = dot_product(v1, v2)
    
    inv_denominator = 1 / (dot00 * dot11 - dot01 * dot01)
    u = (dot11 * dot02 - dot01 * dot12) * inv_denominator
    v = (dot00 * dot12 - dot01 * dot02) * inv_denominator
    
    return (u >= 0) && (v >= 0) && (u + v < 1)
  end
  
  def self.dot_product(vector1, vector2)
    # Calculate the dot product of two vectors
    # Return the dot product value
    
    dot_product = vector1[0] * vector2[0] + vector1[1] * vector2[1]
    return dot_product
  end  
end
