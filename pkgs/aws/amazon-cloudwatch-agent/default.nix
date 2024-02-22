{ lib, buildGoModule, fetchgit }:
buildGoModule rec {
  pname = "amazon-cloudwatch-agent";
  version = "1.300032.3";

  src = fetchgit {
    url = "https://github.com/aws/amazon-cloudwatch-agent.git";
    rev = "v${version}";
    sha256 = "sha256-M/SGxMkALTCSRjrMdCCEr4iHR+CzDwIlD9DC3KAVITk=";
    #sha256 = "sha256:0000000000000000000000000000000000000000000000000000";
  };

  vendorHash = "sha256-bXyFrdWsMlfapoDQdkDk6nbTvn1uEKEh68QWRWACO4g=";

  meta = with lib; {
    description = ''
      Amazon CloudWatch Agent
      '';
    homepage = "https://github.com/aws/amazon-cloudwatch-agent";
    license = licenses.mit;
  };

  #nativeBuildInputs = [ git ];
  doCheck = false;

  buildPhase = ''

    # TODO MOVE TO PATCH PHASE
    echo "" >> Makefile
    echo "amazon-cloudwatch-agent-nixos-linux: copy-version-file" >> Makefile
    echo -e "\t@echo Building CloudWatchAgent for Linux,Debian with ARM64 and AMD64" >> Makefile
    echo -e "\t\$(LINUX_AMD64_BUILD)/config-downloader github.com/aws/amazon-cloudwatch-agent/cmd/config-downloader" >> Makefile
    echo -e "\t\$(LINUX_AMD64_BUILD)/config-translator github.com/aws/amazon-cloudwatch-agent/cmd/config-translator" >> Makefile
    echo -e "\t\$(LINUX_AMD64_BUILD)/amazon-cloudwatch-agent github.com/aws/amazon-cloudwatch-agent/cmd/amazon-cloudwatch-agent" >> Makefile
    echo -e "\t\$(LINUX_AMD64_BUILD)/start-amazon-cloudwatch-agent github.com/aws/amazon-cloudwatch-agent/cmd/start-amazon-cloudwatch-agent" >> Makefile
    echo -e "\t\$(LINUX_AMD64_BUILD)/amazon-cloudwatch-agent-config-wizard github.com/aws/amazon-cloudwatch-agent/cmd/amazon-cloudwatch-agent-config-wizard" >> Makefile

    cat Makefile

    make amazon-cloudwatch-agent-nixos-linux
  '';

  preInstall = ''
    echo Here are the commands executed before installPhase
    '';

  installPhase = ''
  # Run preInstall commands. Included in the default installPhase, but not in your specified one. You need to add this yourself, or preInstall won't run
    runHook preInstall

    echo Here are the commands for installPhase

    cp -av build/* $out/

  # Run postInstall commands, same as above
    runHook postInstall
    '';

  postInstall = ''
    echo Here are the commands executed after installPhase
  '';
}
