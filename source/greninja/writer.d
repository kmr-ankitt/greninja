module greninja.writer;

import std.stdio;

class Writer
{
  File output;
  uint width;

  /**
   @params:
   1. name of the file
   2. width of the output, default is 78 
  **/
  this(string filename, uint width = 78)
  {
    this.output = File(filename, "w");
    this.width = width;
  }

  /** 
    * @params:
    * 1. text to write
    * 2. (optional) indent level default is 0
  **/
  void line(string text, int indent = 0)
  {
    string leading_space = "";
    foreach (_; 0 .. indent)
    {
      leading_space ~= "  ";
    }

    this.output.writef("%s%s\n", leading_space, text);
  }

  /** 
   * @params:
   * 1. name of the variable
   * 2. value of variable
   * 3. (optional) indent level default is 0
   **/
  void variable(string key, string value, int indent = 0)
  {
    import std.format : format;

    if (value.length == 0)
      return;
    this.line(format("%s = %s", key, value), indent);
  }

  /** 
    @params:
    1. name of the rule
    2. command to execute
  **/
  void rule(string name, string command)
  {
    this.line("rule " ~ name);
    this.line("command = " ~ command, 1);
  }
}
