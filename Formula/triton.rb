require "language/node"

class Triton < Formula
  desc "Joyent Triton CLI"
  homepage "https://www.npmjs.com/package/triton"
  url "https://registry.npmjs.org/triton/-/triton-7.4.0.tgz"
  sha256 "ef9a3669a5787a1a975a39fd6fc684f8c7b7d768821bc8bc5f02fd0621da975d"

  bottle do
    cellar :any_skip_relocation
    sha256 "658ed62a7f9bbe5ab80c452dd05e351758f3b3400c311161a999d14881e1f1b4" => :mojave
    sha256 "e2b50996b096bc1fba5fc8f69d2df77a15091d5f3a30c99974e79688bbeb8e8a" => :high_sierra
    sha256 "5a8b6f24246025699cf3ab0f96467bf3b0a85c0b635264e03970b2c5474d0edb" => :sierra
  end

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
    (bash_completion/"triton").write `#{bin}/triton completion`
  end

  test do
    output = shell_output("#{bin}/triton profile ls")
    assert_match /\ANAME  CURR  ACCOUNT  USER  URL$/, output
  end
end
