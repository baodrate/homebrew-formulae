class Darker < Formula
  include Language::Python::Virtualenv

  desc "Python code formatter"
  homepage "https://github.com/akaihola/darker"
  url "https://github.com/akaihola/darker/releases/download/1.7.2/darker-1.7.2.tar.gz"
  sha256 "ec9d130ab2a0f7fa49ab68a08fd231a5bec66147ecbbf94c92a1f33d97b5ef6f"
  license "BSD"
  head "https://github.com/akaihola/darker.git", branch: "master"

  livecheck do
    url :stable
    regex(%r{href=.*?/releases/download/(\d+(?:\.\d+)+)/darker-[0-9.]+\.t}i)
  end

  depends_on "python-packaging"
  depends_on "python"
  depends_on "black"
  depends_on "isort" => :recommended

  def install
    virtualenv_install_with_resources

    generate_completions_from_executable(bin/"darker", shells: [:fish, :zsh], shell_parameter_format: :click)
  end

  test do
    ENV["LC_ALL"] = "en_US.UTF-8"
    (testpath/"black_test.py").write <<~EOS
      print(
      'It works!')
    EOS
    system bin/"darker", "black_test.py"
    assert_equal "print(\"It works!\")\n", (testpath/"black_test.py").read
  end
end
