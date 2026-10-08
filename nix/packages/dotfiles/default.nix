/**
The `dotfiles` command, which opens this repository from anywhere: in a coding
agent, the shell, the file manager or an editor.
*/
{pkgs, ...}:
pkgs.buildGoModule (finalAttrs: {
  pname = "dotfiles";
  version = "0.1.0";

  src = pkgs.lib.fileset.toSource {
    root = ./.;
    fileset = pkgs.lib.fileset.fileFilter (file: file.hasExt "go" || file.name == "go.mod" || file.name == "go.sum") ./.;
  };

  vendorHash = "sha256-2t6h0pXo5i6f/DcGawkKQr4dyoRMHtgx0sK/6f1sjo4=";

  ldflags = [
    "-s"
    "-w"
    "-X main.version=${finalAttrs.version}"
  ];

  nativeBuildInputs = [pkgs.installShellFiles];

  postInstall = ''
    installShellCompletion --cmd dotfiles \
      --bash <($out/bin/dotfiles completion bash) \
      --fish <($out/bin/dotfiles completion fish) \
      --zsh <($out/bin/dotfiles completion zsh)
  '';

  meta.mainProgram = "dotfiles";
})
