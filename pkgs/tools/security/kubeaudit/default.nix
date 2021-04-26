{ lib
, buildGoModule
, fetchFromGitHub
}:

buildGoModule rec {
  pname = "kubeaudit";
  version = "0.14.0";

  src = fetchFromGitHub {
    owner = "Shopify";
    repo = pname;
    rev = "v${version}";
    sha256 = "1n6vzv1bpvyvk9slw835m54dpbfvxs945fsra7lqacs9ckcr1an0";
  };

  vendorSha256 = "0av42svb30wxqq6r3rv19859rbkf7npa9dvfiq6h7bdp0g12y0c5";

  # Tests requires a Kubernetes instance
  doCheck = false;

  meta = with lib; {
    description = "Audit tool for Kubernetes clusters";
    homepage = "https://github.com/Shopify/kubeaudit";
    license = with licenses; [ mit ];
    maintainers = with maintainers; [ fab ];
  };
}
