module test.writer_test;

import greninja.writer;
import std.file;

unittest{
    auto w = new Writer("writer_build.ninja");
    assert(w.output.name.length > 0);
}

unittest{
  auto w = new Writer("line_build.ninja");
  w.line("rule cc");
  w.line("command = gcc -c $in -o $out", 1);
}

unittest{
  auto w = new Writer("variable_build.ninja");
  w.variable("cflags", "-Wall -O2");
}

unittest{
  auto w = new Writer("rule_build.ninja");
  w.rule("cc", "gcc -c $in -o $out");
}

unittest{
  auto w = new Writer("build_build.ninja");
  w.build(
      ["a.o"],
      "cc",
      ["a.cpp"],
      ["header.h","header.h","header.h","header.h","header.h",],
      ["config.txt","header.h","header.h","header.h","header.h","header.h",]
  );

  w.comment("compile");

  w.rule("cc", "g++ -c $in -o $out");

  w.build("main.o", "cc", "main.cpp");

  w.build(
      ["app"],
      "link",
      ["main.o", "util.o"],
      null,
      "config.txt"
  );

  w._default(["app"]);
}

unittest{
  auto w = new Writer("default_build.ninja");
  w._default(["main.o", "util.o"]);
}

unittest{
  auto w = new Writer("testing_build.ninja");
  w.build(
      ["a.o"],
      "cc",
      ["a.cpp"],
      ["header.h","header.h","header.h","header.h","header.h",],
      ["config.txt","header.h","header.h","header.h","header.h","header.h",]
  );

  w.comment("compile");

  w.rule("cc", "g++ -c $in -o $out");

  w.build("main.o", "cc", "main.cpp");

  w.build(
      ["app"],
      "link",
      ["main.o", "util.o"],
      null,
      "config.txt"
  );

  w._default(["app"]);
}
