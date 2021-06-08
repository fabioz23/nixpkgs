{ lib
, buildPythonPackage
, fetchPypi
, pytestCheckHook
, google-auth
, google-cloud-iam
, google-cloud-core
, google-cloud-kms
, google-cloud-testutils
, google-resumable-media
, mock
}:

buildPythonPackage rec {
  pname = "google-cloud-storage";
  version = "1.38.0";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-FiAR1m9kuNxdeTZgml2vAGbMUhIxVGrqAsEmpVWURsQ=";
  };

  propagatedBuildInputs = [
    google-auth
    google-cloud-core
    google-resumable-media
  ];

  checkInputs = [
    google-cloud-iam
    google-cloud-kms
    google-cloud-testutils
    mock
    pytestCheckHook
  ];

  disabledTests = [
    # disable tests which require credentials and network access
    "create"
    "download"
    "get"
    "post"
    "test_build_api_url"
    "test_ctor_mtls"
    "test_open"
  ];

  disabledTestPaths = [
    "tests/unit/test_bucket.py"
    "tests/system/test_system.py"
  ];

  preCheck = ''
    # prevent google directory from shadowing google imports
    rm -r google
  '';

  pythonImportsCheck = [ "google.cloud.storage" ];

  meta = with lib; {
    description = "Google Cloud Storage API client library";
    homepage = "https://github.com/googleapis/python-storage";
    license = licenses.asl20;
    maintainers = with maintainers; [ SuperSandro2000 ];
  };
}
