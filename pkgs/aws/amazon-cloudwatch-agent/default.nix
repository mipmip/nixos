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

    #cat Makefile

    make amazon-cloudwatch-agent-nixos-linux
  '';

  preInstall = ''
    '';

  installPhase = ''

    runHook preInstall

    #mkdir -p $out/bin
    #cp -av build/* $out/
    mkdir -p $out/etc

    ###FAKE
    #mkdir -p build/bin/linux_amd64
    #touch build/bin/linux_amd64/fakebin

    cp -av build/bin/linux_amd64 $out/bin
    #cp build/linux_amd64/amazon-cloudwatch-agent $out/bin/
    #cp build/linux_amd64/amazon-cloudwatch-agent-config-wizard $out/bin/
    #cp build/linux_amd64/config-downloader $out/bin/
    #cp build/linux_amd64/config-translator $out/bin/
    #cp build/linux_amd64/start-amazon-cloudwatch-agent $out/bin/

    cp LICENSE $out/
    cp NOTICE $out/
    cp licensing/THIRD-PARTY-LICENSES $out/
    cp RELEASE_NOTES $out/
    cp packaging/dependencies/amazon-cloudwatch-agent-ctl $out/bin/
    cp cfg/commonconfig/common-config.toml $out/etc/
    substituteInPlace $out/bin/amazon-cloudwatch-agent-ctl --replace /opt/aws/amazon-cloudwatch-agent "$out"

    mkdir -p /tmp/amazon-cloudwatch-agent
    touch /tmp/amazon-cloudwatch-agent/amazon-cloudwatch-agent.log
    ln -s /tmp/amazon-cloudwatch-agent/log $out/log

    runHook postInstall
    '';

  postInstall = ''
    echo Here are the commands executed after installPhase
  '';
}
