module test.writer_test;

import ninjad.writer;

unittest{
    auto w = new Writer("build.ninja");
    assert(w.output.name.length > 0);
    assert(w.output.name == "build.ninja");
}
