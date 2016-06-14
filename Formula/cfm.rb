# vi: ts=2 et

class Cfm < Formula
  desc "CFM-ID (Competitive Fragmentation Modeling for Metabolite Identification)."
  homepage "https://sourceforge.net/projects/cfm-id/"
  url "svn://svn.code.sf.net/p/cfm-id/code/cfm", :revision => "28"
  version "28"

  # Update references to RDKit in order to use the one installed using Homebrew.
  # Allow to install files normally through cmake.
  # Embed isotope information (instead of trying to load ISOTOPE.DAT file).
  patch do
    url "https://raw.githubusercontent.com/pierrickrogermele/formula-patches/master/cfm.patch"
  end
  
  # Dependencies
  depends_on "rdkit/rdkit/rdkit" => "with-inchi"
  depends_on "homebrew/science/lp_solve"
  depends_on "cmake" => :build

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
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
