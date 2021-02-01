{ lib, buildPythonPackage, fetchPypi
, cryptography, ecdsa
, pytestrunner, pytestcov, pytest }:

buildPythonPackage rec {
  pname = "PyJWT";
  version = "2.0.1";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-pccKBuHzPYHvJe7NUNUL0w403hyosrn6P+Daqrz2m/c=";
  };

  propagatedBuildInputs = [ cryptography ecdsa ];

  checkInputs = [ pytestrunner pytestcov pytest ];

  postPatch = ''
    substituteInPlace setup.py --replace "pytest>=4.0.1,<5.0.0" "pytest"
  '';

  # ecdsa changed internal behavior
  checkPhase = ''
    pytest tests -k 'not ec_verify_should_return_false_if_signature_invalid'
  '';

  meta = with lib; {
    description = "JSON Web Token implementation in Python";
    homepage = "https://github.com/jpadilla/pyjwt";
    license = licenses.mit;
    maintainers = with maintainers; [ prikhi ];
  };
}
