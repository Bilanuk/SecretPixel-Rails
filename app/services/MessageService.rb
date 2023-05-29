# app/services/message_service.rb
class MessageService
  def self.extract_message(image)
    pixels = image.file.download
    return nil unless pixels
  
    message = ''
    binary_message = ''
    binary_index = 0
  
    pixels.each_byte do |byte|
      # Extract the least significant bit from the byte
      bit = byte & 1
      binary_message += bit.to_s
  
      binary_index += 1
  
      # Check if we have enough bits to form a complete character
      if binary_index % 8 == 0
        # Convert the binary message to ASCII string
        extracted_char = binary_to_ascii(binary_message)
        break if extracted_char == "\0" # Stop if null character is encountered
        message += extracted_char
        binary_message = ''
      end
    end
  
    message
  end
  

  def self.embed_message(image, message)
    # Convert the message to binary string
    binary_message = ascii_to_binary(message)
  
    # Embed the binary message into the image pixels
    pixels = image.file.download
    return nil unless pixels
  
    binary_message_index = 0
  
    # Skip the first 54 bytes (header) of the image
    header_size = 54
  
    (header_size...pixels.length).each do |index|
      break if binary_message_index >= binary_message.length
  
      # Convert the byte to binary string
      byte = pixels[index].ord
      binary_byte = byte.to_s(2).rjust(8, '0')
  
      # Replace the least significant bit of each channel with the corresponding bit from the message
      modified_byte = binary_byte[0, 7] + binary_message[binary_message_index]
  
      # Convert the modified byte back to integer
      modified_byte_int = modified_byte.to_i(2)
  
      # Modify the pixel byte with the modified byte
      modified_pixel = (byte & 0xFE) | (modified_byte_int & 0x01)
      pixels[index] = modified_pixel.chr
  
      binary_message_index += 1
    end
  
    # Save the modified pixels back to the image
    image.file.attach(io: StringIO.new(pixels), filename: image.file.filename)
  
    image
  end
  

  private

  def self.ascii_to_binary(text)
    text.unpack('B*').first
  end

  def self.binary_to_ascii(binary)
    [binary].pack('B*')
  end
end
