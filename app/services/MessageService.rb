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

    pixels.each_byte.with_index do |byte, index|
      bit = binary_message[index] || '0'
      bit = bit.to_i

      # Modify the least significant bit of the byte
      modified_byte = (byte & 0xFE) | bit
      pixels[index] = modified_byte.chr
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
