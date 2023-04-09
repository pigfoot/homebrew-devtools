class Buildah < Formula
  desc "A tool that facilitates building OCI container images."
  homepage "https://buildah.io/"
  url "https://github.com/containers/buildah.git", :tag => "v1.30.0"
  revision 1
  license all_of: ["Apache-2.0"]
  head "https://github.com/containers/buildah.git", branch: "main"

  depends_on "go" => :build

  on_macos do
    depends_on "make" => :build
    depends_on "gpgme" => :build
    depends_on "pkg-config" => :build
    depends_on "libgpg-error" => :build
    depends_on "libassuan" => :build
  end

  def install
    if OS.mac?
      ENV["CGO_ENABLED"] = "1"
      ENV.prepend_path "PATH", Formula["make"].opt_libexec/"gnubin"

      system "make", "bin/buildah"
      bin.install "bin/buildah" => "buildah"
    end
  end
end
