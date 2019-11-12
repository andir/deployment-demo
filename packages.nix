self: super: {
  my_service = self.callPackage ./my_service {};
  slides = self.callPackage ./slides {};
}
