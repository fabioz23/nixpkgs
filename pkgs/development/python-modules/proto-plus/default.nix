{ stdenv
, buildPythonPackage
, fetchPypi
, isPy3k
, protobuf
, google_api_core
, pytestCheckHook
}:

buildPythonPackage rec {
  pname = "proto-plus";
  version = "1.13.0";
  disabled = !isPy3k;

  src = fetchPypi {
    inherit pname version;
    sha256 = "1i5jjnwpd288378h37zads08h695iwmhxm0sxbr3ln6aax97rdb1";
  };

  propagatedBuildInputs = [ protobuf ];

  checkInputs = [ pytestCheckHook google_api_core ];

  meta = with stdenv.lib; {
    description = "Beautiful, idiomatic protocol buffers in Python";
    homepage = "https://github.com/googleapis/proto-plus-python";
    license = licenses.asl20;
    maintainers = [ maintainers.ruuda ];
  };
}
