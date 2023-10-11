class Huniq < Formula
  desc "An efficient way to filter duplicate lines from input, à la uniq"
  homepage "https://github.com/koraa/huniq"
  version "2.7.0"
  url "https://github.com/koraa/huniq.git",
    revision: "e34b11a9e72d45810ccac481aa380c1f754b40d5"
  license "0BSD"
  head "https://github.com/dbrgn/huniq.git", branch: "main"

  depends_on "rust" => :build

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "huniq", shell_output("#{bin}/huniq --help")
  end
end
