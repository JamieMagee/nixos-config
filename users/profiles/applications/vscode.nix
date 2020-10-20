{ pkgs, ... }: {
  programs.vscode = {
    enable = true;
    extensions = pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "Nix";
        publisher = "bbenoist";
        version = "1.0.1";
        sha256 = "0zd0n9f5z1f0ckzfjr38xw2zzmcxg1gjrava7yahg5cvdcw6l35b";
      }
      {
        name = "vscode-markdownlint";
        publisher = "DavidAnson";
        version = "0.37.1";
        sha256 = "1dmffnig75hiyxl0psn2wh36q4g0a4bpl7zp3bh0gl8f04gcavas";
      }
      {
        name = "vscode-eslint";
        publisher = "dbaeumer";
        version = "2.1.13";
        sha256 = "1adzgisljlq6xmmwrziawkgy941bf8i8nq4c9w3gnsbr20gd9pyi";
      }
      {
        name = "xml";
        publisher = "DotJoshJohnson";
        version = "2.5.1";
        sha256 = "1v4x6yhzny1f8f4jzm4g7vqmqg5bqchyx4n25mkgvw2xp6yls037";
      }
      {
        name = "gitlens";
        publisher = "eamodio";
        version = "10.2.2";
        sha256 = "00fp6pz9jqcr6j6zwr2wpvqazh1ssa48jnk1282gnj5k560vh8mb";
      }
      {
        name = "vsc-material-theme";
        publisher = "Equinusocio";
        version = "33.0.0";
        sha256 = "1r8g9jm34xp7lld9mwv3sja1913aan0khxqrp7az89szwpnv73vg";
      }
      {
        name = "prettier-vscode";
        publisher = "esbenp";
        version = "5.7.1";
        sha256 = "0f2q17d028j2c816rns9hi2w38ln3mssdcgzm6kc948ih252jflr";
      }
      {
        name = "shell-format";
        publisher = "foxundermoon";
        version = "7.0.1";
        sha256 = "0lxwcm7b553d6ix9d6jjprizbxc5gpf3n180csn6dvkiz4fx1c84";
      }
      {
        name = "terraform";
        publisher = "hashicorp";
        version = "2.2.3";
        sha256 = "0ypc6difv808d6k1ndjrxdxd75p71w9xwvcfj2ygpdxdlqshkhdk";
      }
      {
        name = "vscode-drawio";
        publisher = "hediet";
        version = "1.0.2";
        sha256 = "1aa1hj81dpi9aapwhwzbypjf2badn3irgd3b8s7g2ywm3381fg38";
      }
      {
        name = "rest-client";
        publisher = "humao";
        version = "0.24.3";
        sha256 = "1pb30rxg5f0s20x1s8h51kblgyv6idnm50qm21sfv9n0vw00wipk";
      }
      {
        name = "latex-workshop";
        publisher = "James-Yu";
        version = "8.13.2";
        sha256 = "1hpsb4f9b8b04j8hfqbr5fsxj2rrbk7x51nl16j1f8vkdcpkd5zx";
      }
      {
        name = "azure-pipelines";
        publisher = "ms-azure-devops";
        version = "1.177.0";
        sha256 = "0y0m4ibyzpfwg8pw9rc00y6099s134872g2bd46x340lzl0bw93j";
      }
      {
        name = "vscode-azurefunctions";
        publisher = "ms-azuretools";
        version = "0.24.1";
        sha256 = "0agw2rw7apfk0qb4dg2f41lm50pg9c0prqrmkj8s5vxsa2jhr87w";
      }
      {
        name = "vscode-azureterraform";
        publisher = "ms-azuretools";
        version = "0.3.1";
        sha256 = "0y49rylc296r2fxmqjaaf9w1fi1s2yxsx84jaxc06fyf20g6rjqp";
      }
      {
        name = "vscode-docker";
        publisher = "ms-azuretools";
        version = "1.7.0";
        sha256 = "0xl5y36kwh59mnb9j1pnsl5bn62z4n4lvsp31r1xscxrs9vh1ngb";
      }
      {
        name = "csharp";
        publisher = "ms-dotnettools";
        version = "1.23.4";
        sha256 = "1x90r4c90ylvwx4bmr6pmlzmx55vbkc91a4sqhi129rdvq2miv4w";
      }
      {
        name = "vscode-kubernetes-tools";
        publisher = "ms-kubernetes-tools";
        version = "1.2.1";
        sha256 = "071p27xcq77vbpnmb83pjsnng7h97q4gai0k6qgwg3ygv086hpf4";
      }
      {
        name = "python";
        publisher = "ms-python";
        version = "2020.9.114305";
        sha256 = "1vh0wvfvzszc58lw7dbl60knpm5l6rrsghfchhn5dvwyadx4a33h";
      }
      {
        name = "remote-containers";
        publisher = "ms-vscode-remote";
        version = "0.145.1";
        sha256 = "0qjixy9p8kh8kjiqv77x2dc6p8jbjvdl54lkc8k7jjdq70rr07xm";
      }
      {
        name = "remote-ssh";
        publisher = "ms-vscode-remote";
        version = "0.55.0";
        sha256 = "1rzdz6539zbqsh3ikwmysz0587s1p5w72bqry17147s7hk513gn0";
      }
      {
        name = "remote-ssh-edit";
        publisher = "ms-vscode-remote";
        version = "0.55.0";
        sha256 = "0bqjp0xzliyzp8kq3ss4b4by402p2l4fbdms8955yk1vp88d0lfa";
      }
      {
        name = "azure-account";
        publisher = "ms-vscode";
        version = "0.9.3";
        sha256 = "1c77xhsll4w3m3sh63hhmwnmnmalvg0axqifzdl3h2lv0fm75cx6";
      }
      # {
      #   name = "powershell";
      #   publisher = "ms-vscode";
      #   version = "2020.6.0";
      #   sha256 = "0inp5yln510772x0byy1baj71himk559nr3xh6rmyi4h6yvhhr54";
      # }
      {
        name = "vscode-jest";
        publisher = "Orta";
        version = "3.2.0";
        sha256 = "1qhhy3q5lmdmgw25vmyx69h37i2vbpjxca46jra86vm6kdwglc36";
      }
      {
        name = "material-icon-theme";
        publisher = "PKief";
        version = "4.3.0";
        sha256 = "1a69kdmhgd4cplwl5x17kv6l5hnpyms7qjqrgj7m4wpmwqnj081h";
      }
      {
        name = "vscode-yaml";
        publisher = "redhat";
        version = "0.11.1";
        sha256 = "0pxmw150k1n9mnfxf6v2bqqdwpkaglg2zx6r928cyjzzplpyd53x";
      }
      {
        name = "code-spell-checker";
        publisher = "streetsidesoftware";
        version = "1.9.2";
        sha256 = "17wkhwlnicy9inkv69mlkfz6ws7n6j7wfsnwczkc7dbyfqcz0mdb";
      }
      {
        name = "sass-indented";
        publisher = "syler";
        version = "1.8.12";
        sha256 = "0jv6nnz8mx3jq2qxfrqic64q64ppn1mhaz0xb9wghfqn5bh09cd3";
      }
      # {
      #   name = "vscode-ansible";
      #   publisher = "vscoss";
      #   version = "0.5.2";
      #   sha256 = "0r1aqfc969354j8b1k9xsg682fynbk4xjp196f3yknlwj66jnpwx";
      # }
    ];
  };
}
