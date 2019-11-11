{ runCommand
, pandoc
, theme ? "black"
}:
let
  src = ./slides.md;
in runCommand "slides.html" { nativeBuildInputs = [ pandoc ]; } ''
  pandoc -t revealjs -s -o $out ${src} -V revealjs-url=https://revealjs.com
''
