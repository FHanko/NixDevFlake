{
  description = "A collection of flake templates";

  outputs =
    { self }:
    {

      templates = {

        ktx = {
          path = ./ktx;
          description = "Kotlin dev flake";
        };

        rust = {
          path = ./rust;
          description = "Rust dev flake";
        };
      };

      defaultTemplate = self.templates.ktx;
    };
}
