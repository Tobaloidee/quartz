# require "quartz"
require "../../../src/quartz.cr"

include Quartz

puts Quartz.devices()

phase = 0.0_f32

stream = AudioStream.new(2, 2, 44100.0, 256_u64)
stream.start(phase) do |input, output, frame_count, time_info, status_flags, user_data|
  # reinterpret casting
  p = Pointer(Float32).new(user_data.address)
  out_buf = Pointer(Float32).new(output.address)
  delta_p = 2 * Math::PI * 440 / 44100
  (0..frame_count - 1).each do |i|
    out_buf[2*i] = out_buf[2*i + 1] = Math.sin(p.value)
    p.value += delta_p.to_f32
  end
  0
end

(0..5).each do |_|
  puts stream
  sleep(1)
end
