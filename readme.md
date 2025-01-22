# holos-run/holos flake wrapper


# Use as a flake
 
[![FlakeHub](https://img.shields.io/endpoint?url=https://flakehub.com/f/mcfearsome/holos-nix/badge)](https://flakehub.com/flake/mcfearsome/holos-nix)
 
Add `holos-nix` to your `flake.nix`:
 
```nix
{
  inputs.holos-nix.url = "https://flakehub.com/f/mcfearsome/holos-nix/*";
 
outputs = { self, your-flake-name }: {
    # Use in your outputs
  };
}
```