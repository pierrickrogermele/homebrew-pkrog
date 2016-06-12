# Documentation: https://github.com/Homebrew/brew/blob/master/share/doc/homebrew/Formula-Cookbook.md
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Cfm < Formula
  desc "CFM-ID (Competitive Fragmentation Modeling for Metabolite Identification)."
  homepage "https://sourceforge.net/projects/cfm-id/"
  url "svn://svn.code.sf.net/p/cfm-id/code/cfm", :revision => "28"
  version "28"

  # Update references to RDKit.
  patch do
	  url "https://raw.githubusercontent.com/pierrickrogermele/formula-patches/master/cfm.patch"
	  sha256 "2b0a4c466a3bb057f955f701da3044e6c24517c91f82345b6e463808078745ed"
  end

  # Dependencies
  depends_on "rdkit/rdkit/rdkit" => "with-inchi"
  depends_on "homebrew/science/lp_solve"
  depends_on "cmake" => :build

  def install
	system "cmake ."
	system "make"

#    # Remove unrecognized options if warned by configure
#    system "./configure", "--disable-debug",
#                          "--disable-dependency-tracking",
#                          "--disable-silent-rules",
#                          "--prefix=#{prefix}"
#    # system "cmake", ".", *std_cmake_args
#    system "make", "install" # if this fails, try separate make/make install steps
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test cfm`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
