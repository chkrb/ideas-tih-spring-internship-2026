with import <nixpkgs> { };

mkShell {
  packages = [
    git
    typst

    (python3.withPackages (
      py: with py; [
        ipython
        jupyter
        pandas
      ]
    ))
  ];
}
