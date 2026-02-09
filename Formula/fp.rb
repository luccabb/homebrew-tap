class Fp < Formula
  desc "Find free ports via kernel socket binding"
  homepage "https://github.com/luccabb/fp"
  url "https://github.com/luccabb/fp/archive/refs/heads/main.tar.gz"
  version "1.0.0"
  sha256 "74cb7a575791ef99bca51a5c4b185cd2390abdbb646dd3df08d9d77a9e29e15a"
  license "MIT"

  def install
    system "make"
    bin.install "fp"
  end

  test do
    port = shell_output("#{bin}/fp").strip
    assert_match(/^\d+$/, port)
    assert (1..65535).cover?(port.to_i)
  end
end
