# app/services/message_service.rb
class MessageService
  def self.extract_message(image)
    # Get the pixel data from the image
    pixels = image.file.download
    return nil unless pixels

    # Extract the message from the pixel data
    message = ''
    pixels.each_byte do |byte|
      message += (byte & 1).to_s
    end

    # Convert the binary message to ASCII string
    extracted_message = binary_to_ascii(message)

    extracted_message
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
