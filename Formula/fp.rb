class Fp < Formula
  desc "Find free ports via kernel socket binding"
  homepage "https://github.com/luccabb/fp"
  url "https://github.com/luccabb/fp/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "60c0500ffd2284446917ce1cb204164709950216761ff619652e282d490529ae"
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
