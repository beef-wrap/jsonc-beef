using System;
using System.Collections;
using System.Diagnostics;
using System.IO;
using static jsonc_Beef.jsonc;

namespace example;

static class Program
{
	static void single_basic_parse(char8* test_string)
	{
		json_object* new_obj;

		new_obj = json_tokener_parse(test_string);

		let str = StringView(test_string);

		let json = StringView(json_object_to_json_string(new_obj));

		Debug.WriteLine($"new_obj.to_string({str}) = {json}\n");

		json_object_put(new_obj);
	}

	static int Main(params String[] args)
	{
		single_basic_parse("{ \"foo\": \"bar\" }");

		return 0;
	}
}