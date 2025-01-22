# holos-run/holos flake wrapper


# Use as a flake
 
[![FlakeHub](https://img.shields.io/endpoint?url=https://flakehub.com/f/mcfearsome/holos/badge)](https://flakehub.com/flake/mcfearsome/holos)
 
Add `holos-nix` to your `flake.nix`:
 
```nix
{
  inputs.holos.url = "https://flakehub.com/f/mcfearsome/holos/*";
 
outputs = { self, your-flake-name }: {
    # Use in your outputs
  };
}
```
