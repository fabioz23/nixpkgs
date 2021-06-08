{ lib
, buildPythonPackage
, fetchPypi
, google-api-core
, google-cloud-core
, google-cloud-testutils
, grpc_google_iam_v1
, libcst
, mock
, proto-plus
, pytest-asyncio
, pytest
}:

buildPythonPackage rec {
  pname = "google-cloud-bigtable";
  version = "2.2.0";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-89fXmr3jHTtp8QOMFeueJwslHJ7Q6srQ/Kxsp0mLlKU=";
  };

  propagatedBuildInputs = [
    google-api-core
    google-cloud-core
    grpc_google_iam_v1
    libcst
    proto-plus
  ];

  checkInputs = [
    google-cloud-testutils
    mock
    pytest-asyncio
    pytest
  ];

  prePhase = ''
    # Prevent google directory from shadowing google imports
    rm -r google
  '';

  disabledTestPaths = [
    # Tests seems outdated
    "tests/unit/test_app_profile.py"
    "tests/unit/test_backup.py"
    "tests/unit/test_batcher.py"
    "tests/unit/test_client.py"
    "tests/unit/test_cluster.py"
    "tests/unit/test_column_family.py"
    "tests/unit/test_instance.py"
    "tests/unit/test_row_data.py"
    "tests/unit/test_row_filters.py"
    "tests/unit/test_row_set.py"
    "tests/unit/test_row.py"
    "tests/unit/test_table.py"
  ];

  disabledTests = [
    "policy"
  ];

  pythonImportsCheck = [
    "google.cloud.bigtable_admin_v2"
    "google.cloud.bigtable_v2"
    "google.cloud.bigtable"
  ];

  meta = with lib; {
    description = "Google Cloud Bigtable API client library";
    homepage = "https://github.com/googleapis/python-bigtable";
    license = licenses.asl20;
    maintainers = [ maintainers.costrouc ];
  };
}
