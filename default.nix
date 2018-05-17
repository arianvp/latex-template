let pkgs = import <nixpkgs> {};
in
with pkgs;
let
my-texlive = texlive.combine {
  inherit (texlive)
    scheme-small
    ;
};

latexrun = stdenv.mkDerivation {
  name = "latexrun";
  src = fetchFromGitHub {
    owner = "aclements";
    repo = "latexrun";
    rev = "38ff6ec2815654513c91f64bdf2a5760c85da26e";
    sha256 = "0xdl94kn0dbp6r7jk82cwxybglm9wp5qwrjqjxmvadrqix11a48w";
  };
  buildInputs = [ python36 ];
  installPhase = ''
  mkdir -p $out/bin
  cp latexrun $out/bin/latexrun
  '';
};
in
stdenv.mkDerivation {
  name = "tex";
  src = lib.cleanSource ./.;
  buildInputs = [ latexrun my-texlive ];  
  # Fonts for xetex
  FONTCONFIG_FILE = makeFontsConf { fontDirectories = [ source-code-pro lmodern xits-math ]; };
}
