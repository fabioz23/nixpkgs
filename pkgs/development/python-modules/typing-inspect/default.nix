{ lib
, buildPythonPackage
, fetchPypi
, typing-extensions
, mypy-extensions
, pytestCheckHook
}:

buildPythonPackage rec {
  pname = "typing-inspect";
  version = "0.7.1";

  src = fetchPypi {
    inherit version;
    pname = "typing_inspect";
    sha256 = "sha256-BH1Al9mxf0ZTG/bwFDVhEaG2+4IaJP56yQmFPKKngqo=";
  };

  propagatedBuildInputs = [
    typing-extensions
    mypy-extensions
  ];

  checkInputs = [
    pytestCheckHook
  ];

  pythonImportsCheck = [ "typing_inspect" ];

  meta = with lib; {
    description = "Runtime inspection utilities for Python typing module";
    homepage = "https://github.com/ilevkivskyi/typing_inspect";
    license = licenses.mit;
    maintainers = with maintainers; [ albakham ];
  };
}
