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
    url "https://raw.githubusercontent.com/pierrickrogermele/homebrew-prm/master/patches/cfm-homebrew.patch"
    sha256 "3c0a740437d96c7694ec769aa958110029754f6e161234c5a18b61fa0c83a1ff"
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
      
    # Write test input file
    spectra = \
"low\n"\
"63.02323 55903.75098\n"\
"68.99732 114646.68457\n"\
"89.03852 640570.51136\n"\
"94.06520 89431.66211\n"\
"116.04951 752045.78409\n"\
"120.04443 833294.09943\n"\
"144.04442 464478.70028\n"\
"155.19063 89958.19434\n"\
"155.28327 87278.06771\n"\
"161.99461 323295.35491\n"\
"162.00115 608134.52699\n"\
"162.03384 131602.27344\n"\
"162.04424 536103.85417\n"\
"162.05497 151131418.18182\n"\
"med\n"\
"63.02321 96938.63672\n"\
"65.03879 82036.42383\n"\
"68.99717 120371.93522\n"\
"89.03853 921107.98011\n"\
"92.04952 92164.01674\n"\
"94.06516 349290.34943\n"\
"116.04952 1239673.75000\n"\
"120.04441 2370596.75000\n"\
"144.04441 1310654.28409\n"\
"155.19124 62868.42285\n"\
"155.23265 193552.24609\n"\
"155.28181 96209.26250\n"\
"161.99428 314350.15625\n"\
"162.00099 617392.30312\n"\
"162.04424 621329.71875\n"\
"162.05498 148778234.18182\n"\
"high\n"\
"51.02344 109682.38281\n"\
"53.03899 236564.88594\n"\
"55.20296 81884.32292\n"\
"63.02321 544095.65000\n"\
"65.03877 1206241.43750\n"\
"68.99723 2257920.60000\n"\
"77.03857 495293.43750\n"\
"89.01523 126119.62305\n"\
"89.03858 24403855.20000\n"\
"90.03391 171432.24219\n"\
"91.05421 128129.66992\n"\
"92.04947 4412828.25000\n"\
"94.06517 4840471.75000\n"\
"95.04916 630667.15625\n"\
"105.04476 243480.18125\n"\
"116.01530 276214.05078\n"\
"116.04952 51486709.60000\n"\
"116.08230 196977.56719\n"\
"117.03349 737376.18750\n"\
"119.04924 153711.06406\n"\
"120.04441 8385928.00000\n"\
"120.04877 186166.11979\n"\
"129.04475 1000845.25000\n"\
"134.06009 1430215.65000\n"\
"144.04446 5492362.00000\n"\
"144.04913 102996.79948\n"\
"155.28256 106508.23594\n"\
"157.07619 238350.98125\n"\
"161.99771 474479.46875\n"\
"162.05497 88074873.60000\n"
    File.open('testst.txt', 'w') { |file| file.write(spectra) }
    
    # Get trained model file
    system "wget", "-O", "param_config.txt", "https://sourceforge.net/p/cfm-id/code/HEAD/tree/supplementary_material/trained_models/esi_msms_models/metab_se_cfm/param_config.txt?format=raw"
    
    # Test annotation
    system "#{bin}/cfm-annotate", "InChI=1S/C9H7NO2/c11-8-5-9(12)10-7-4-2-1-3-6(7)8/h1-5H,(H2,10,11,12)", "testst.txt", "id", "5", "0.005", "none", "param_config.txt"
  end
end
