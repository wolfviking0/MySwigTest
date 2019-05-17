// REQUIRE
var MySwig = require("./MySwig").MySwig

console.log(MySwig.version())

var swig = new MySwig()
var memory = new Uint8Array(20);
for (var i = 0; i < 20; i++)
{
	memory[i] = 1
}
console.log(memory)
swig.setMem(memory)
console.log(memory)