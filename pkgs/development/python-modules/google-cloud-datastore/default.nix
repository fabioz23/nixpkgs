{ lib
, buildPythonPackage
, fetchPypi
, google-api-core
, google-cloud-core
, libcst
, proto-plus
, mock
, pytest
, pytest-asyncio
, google-cloud-testutils
}:

buildPythonPackage rec {
  pname = "google-cloud-datastore";
  version = "2.1.3";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-56UQdZudVf9jyYPjxCy/XDX5tzEPTWEevjaX2mV2vLQ=";
  };

  propagatedBuildInputs = [
    google-api-core
    google-cloud-core
    libcst
    proto-plus
  ];

  checkInputs = [
    google-cloud-testutils
    mock
    # We can't use pytestCheckHook here as tests are designed to run with nox
    # pytestCheckPhase is executed twice otherwise
    pytest
    pytest-asyncio
  ];

  preCheck = ''
    # Prevent google directory from shadowing google imports
    rm -r google
    # Requires credentials
    rm tests/system/test_system.py
  '';

  pythonImportsCheck = [
    "google.cloud.datastore"
    "google.cloud.datastore_admin_v1"
    "google.cloud.datastore_v1"
  ];

  meta = with lib; {
    description = "Google Cloud Datastore API client library";
    homepage = "https://github.com/googleapis/python-datastore";
    license = licenses.asl20;
    maintainers = with maintainers; [ SuperSandro2000 ];
  };
}
