module Quartz
  # Initialize Quartz module.
  #
  # Quartz is **AUTOMATICALLY** initialized when you include this module, so you don't need to call this.
  def init
    Suppressor.suppress Process::ORIGINAL_STDERR, LibPortAudio.init
    at_exit { LibPortAudio.terminate }
  end

  # Print out the version of internal PortAudio library.
  def pa_version(io = STDOUT)
    io.puts String.new(LibPortAudio.get_version_text)
  end

  # type to pa format
  #
  # ```
  # format(Int32) # => 2
  # ```
  def format(type : T.class) forall T
    case type
    when Float32.class
      LibPortAudio::PaFloat32
    when Int32.class
      LibPortAudio::PaInt32
    when Int16.class
      LibPortAudio::PaInt16
    when Int8.class
      LibPortAudio::PaInt8
    when UInt8.class
      LibPortAudio::PaUInt8
    else
      raise "Invalid Type for PaFormat"
    end
  end
end
