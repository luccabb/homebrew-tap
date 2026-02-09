class Fp < Formula
  desc "Find free ports via kernel socket binding"
  homepage "https://github.com/luccabb/fp"
  url "https://github.com/luccabb/fp/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "a5396b2725965e0e8bd11893f53ef23c2e658575527a277eb699cae9bd4e7e89"
  license "MIT"

  head "https://github.com/luccabb/fp.git", branch: "main"

  def install
    system "make", "CC=#{ENV.cc}"
    bin.install "fp"
  end

  test do
    # Verify basic port finding returns a valid port number
    port = shell_output("#{bin}/fp").strip
    assert_match(/^\d+$/, port)
    port_num = port.to_i
    assert_operator port_num, :>=, 1
    assert_operator port_num, :<=, 65535

    # Verify multiple unique ports
    ports = shell_output("#{bin}/fp -n 5").strip.split("\n")
    assert_equal 5, ports.length
    assert_equal ports.length, ports.uniq.length

    # Verify range constraint
    range_port = shell_output("#{bin}/fp -r 9000:9100").strip.to_i
    assert_operator range_port, :>=, 9000
    assert_operator range_port, :<=, 9100

    # Verify version output
    assert_match(/^\d+\.\d+\.\d+$/, shell_output("#{bin}/fp -v").strip)
  end
end
