version = "0.1.0"
author = "Metacraft Labs"
description = "CodeTracer test framework — TestBinary interface + per-framework adapters"
license = "MIT"
srcDir = "src"

requires "nim >= 2.2.0"

task build, "Build any ct-test apps":
  exec "just build"

task test, "Run the ct-test repo test suite":
  exec "just test"
