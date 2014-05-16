#!/bin/bash


need_pass=149
failures=0
PIGLIT_PATH=/usr/local/autotest/deps/piglit/piglit/
export PIGLIT_SOURCE_DIR=/usr/local/autotest/deps/piglit/piglit/
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$PIGLIT_PATH/lib
export DISPLAY=:0
export XAUTHORITY=/home/chronos/.Xauthority


function run_test()
{
  local name="$1"
  local time="$2"
  local command="$3"
  echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
  echo "+ Running test "$name" of expected runtime $time sec: $command"
  sync
  $command
  if [ $? == 0 ] ; then
    let "need_pass--"
    echo "+ Return code 0 -> Test passed. ($name)"
  else
    let "failures++"
    echo "+ Return code not 0 -> Test failed. ($name)"
  fi
}


pushd $PIGLIT_PATH
run_test "glean/glsl1-mat4x2 construct" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-mat4x3 construct" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-matrix column check (1)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-matrix column check (2)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-matrix, vector multiply (1)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-matrix, vector multiply (3)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-max() function" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-min() function" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-mix(float) function" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-mix(vec4) function" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-mod() function" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-nested function calls (1)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-nested function calls (2)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-nested function calls (3)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-normalize(vec3) function" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-post decrement (x--)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-post increment (x++)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-pow(vec4) function" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-pre decrement (--x)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-pre increment (++x)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-precision exp2" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-sequence (comma) operator" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-shadow2D(): 2" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-shadow2D(): 4" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-sign() function" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-simple function call" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-simple if statement (scalar test)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-simple if statement, fragment shader" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-simple if statement, vertex shader" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-simple if-else statement, fragment shader" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-simple if-else statement, vertex shader" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-smoothstep() function" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-sqrt(vec2) function" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-sqrt(vec4) function" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-step() function" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-struct (1)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-struct (2)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-struct (3)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-struct (4)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-syntax error check (1)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-syntax error check (2)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-syntax error check (3)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-temp array with constant indexing, fragment shader" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-temp array with constant indexing, vertex shader" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-temp array with variable indexing, fragment shader" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-temp array with variable indexing, vertex shader" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-texcoord varying" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-texture1D()" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-texture2D()" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-texture2D(), computed coordinate" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-texture2D(), with bias" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-texture2DProj()" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-texture3D()" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-texture3D(), computed coord" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-unary negation" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-undefined variable" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-uniform matrix" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-uniform matrix 2x4" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-uniform matrix 2x4, transposed" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-uniform matrix 4x3" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-uniform matrix 4x3, transposed" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-uniform matrix, transposed" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-uniform variable (fragment shader)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-uniform variable (vertex shader)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-varying read but not written" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-varying var mismatch" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-varying variable" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-varying variable read-write" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-vec2 * mat4x2 multiply" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-vec3 * mat4x3 multiply" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-vec4 * mat3x4 multiply" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-vec4, scalar arithmetic" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-vector relational (bvec2 <,<=)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-vector relational (bvec2 ==,!=)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-vector relational (bvec2 >,>=)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-vector relational (vec4 !=)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-vector relational (vec4 <)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-vector relational (vec4 <=)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-vector relational (vec4 ==)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-vector relational (vec4 >)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-vector relational (vec4 >=)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-vector subscript *=" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-while-loop" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-|| operator (1)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-|| operator (2)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-|| operator, short-circuit" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/makeCurrent" 0.0 "bin/glean -o -v -v -v -t +makeCurrent --quick"
run_test "glean/maskedClear" 0.0 "bin/glean -o -v -v -v -t +maskedClear --quick"
run_test "glean/orthoPosHLines" 0.0 "bin/glean -o -v -v -v -t +orthoPosHLines --quick"
run_test "glean/orthoPosPoints" 0.0 "bin/glean -o -v -v -v -t +orthoPosPoints --quick"
run_test "glean/orthoPosRandRects" 0.0 "bin/glean -o -v -v -v -t +orthoPosRandRects --quick"
run_test "glean/orthoPosRandTris" 0.0 "bin/glean -o -v -v -v -t +orthoPosRandTris --quick"
run_test "glean/orthoPosVLines" 0.0 "bin/glean -o -v -v -v -t +orthoPosVLines --quick"
run_test "glean/pixelFormats" 0.0 "bin/glean -o -v -v -v -t +pixelFormats --quick"
run_test "glean/pointSprite" 0.0 "bin/glean -o -v -v -v -t +pointSprite --quick"
run_test "glean/readPixSanity" 0.0 "bin/glean -o -v -v -v -t +readPixSanity --quick"
run_test "glean/scissor" 0.0 "bin/glean -o -v -v -v -t +scissor --quick"
run_test "glean/shaderAPI" 0.0 "bin/glean -o -v -v -v -t +shaderAPI --quick"
run_test "glean/texCombine" 0.0 "bin/glean -o -v -v -v -t +texCombine --quick"
run_test "glean/texCombine4" 0.0 "bin/glean -o -v -v -v -t +texCombine4 --quick"
run_test "glean/texEnv" 0.0 "bin/glean -o -v -v -v -t +texEnv --quick"
run_test "glean/texRect" 0.0 "bin/glean -o -v -v -v -t +texRect --quick"
run_test "glean/texSwizzle" 0.0 "bin/glean -o -v -v -v -t +texSwizzle --quick"
run_test "glean/texUnits" 0.0 "bin/glean -o -v -v -v -t +texUnits --quick"
run_test "glean/texgen" 0.0 "bin/glean -o -v -v -v -t +texgen --quick"
run_test "glean/texture_srgb" 0.0 "bin/glean -o -v -v -v -t +texture_srgb --quick"
run_test "glean/vertattrib" 0.0 "bin/glean -o -v -v -v -t +vertattrib --quick"
run_test "glean/vp1-ABS test" 0.0 "bin/glean -o -v -v -v -t +vertProg1 --quick"
run_test "glean/vp1-ADD test" 0.0 "bin/glean -o -v -v -v -t +vertProg1 --quick"
run_test "glean/vp1-ARL test" 0.0 "bin/glean -o -v -v -v -t +vertProg1 --quick"
run_test "glean/vp1-DP3 test" 0.0 "bin/glean -o -v -v -v -t +vertProg1 --quick"
run_test "glean/vp1-DP4 test" 0.0 "bin/glean -o -v -v -v -t +vertProg1 --quick"
run_test "glean/vp1-DPH test" 0.0 "bin/glean -o -v -v -v -t +vertProg1 --quick"
run_test "glean/vp1-DST test" 0.0 "bin/glean -o -v -v -v -t +vertProg1 --quick"
run_test "glean/vp1-Divide by zero test" 0.0 "bin/glean -o -v -v -v -t +vertProg1 --quick"
run_test "glean/vp1-EX2 test" 0.0 "bin/glean -o -v -v -v -t +vertProg1 --quick"
run_test "glean/vp1-EXP test" 0.0 "bin/glean -o -v -v -v -t +vertProg1 --quick"
run_test "glean/vp1-FLR test" 0.0 "bin/glean -o -v -v -v -t +vertProg1 --quick"
run_test "glean/vp1-FRC test" 0.0 "bin/glean -o -v -v -v -t +vertProg1 --quick"
run_test "glean/vp1-Infinity and nan test" 0.0 "bin/glean -o -v -v -v -t +vertProg1 --quick"
run_test "glean/vp1-LG2 test" 0.0 "bin/glean -o -v -v -v -t +vertProg1 --quick"
run_test "glean/vp1-LIT test 1" 0.0 "bin/glean -o -v -v -v -t +vertProg1 --quick"
run_test "glean/vp1-LIT test 2 (degenerate case: 0 ^ 0 -> 1)" 0.0 "bin/glean -o -v -v -v -t +vertProg1 --quick"
run_test "glean/vp1-LIT test 3 (case x < 0)" 0.0 "bin/glean -o -v -v -v -t +vertProg1 --quick"
run_test "glean/vp1-LOG test" 0.0 "bin/glean -o -v -v -v -t +vertProg1 --quick"
run_test "glean/vp1-MAD test" 0.0 "bin/glean -o -v -v -v -t +vertProg1 --quick"
run_test "glean/vp1-MAX test" 0.0 "bin/glean -o -v -v -v -t +vertProg1 --quick"
run_test "glean/vp1-MIN test" 0.0 "bin/glean -o -v -v -v -t +vertProg1 --quick"
run_test "glean/vp1-MOV test (with swizzle)" 0.0 "bin/glean -o -v -v -v -t +vertProg1 --quick"
run_test "glean/vp1-MUL test (with swizzle and masking)" 0.0 "bin/glean -o -v -v -v -t +vertProg1 --quick"
run_test "glean/vp1-POW test (exponentiation)" 0.0 "bin/glean -o -v -v -v -t +vertProg1 --quick"
run_test "glean/vp1-Position write test (compute position from texcoord)" 0.0 "bin/glean -o -v -v -v -t +vertProg1 --quick"
run_test "glean/vp1-RCP test (reciprocal)" 0.0 "bin/glean -o -v -v -v -t +vertProg1 --quick"
run_test "glean/vp1-RSQ test 1 (reciprocal square root)" 0.0 "bin/glean -o -v -v -v -t +vertProg1 --quick"
run_test "glean/vp1-RSQ test 2 (reciprocal square root of negative value)" 0.0 "bin/glean -o -v -v -v -t +vertProg1 --quick"
run_test "glean/vp1-SGE test" 0.0 "bin/glean -o -v -v -v -t +vertProg1 --quick"
run_test "glean/vp1-SLT test" 0.0 "bin/glean -o -v -v -v -t +vertProg1 --quick"
run_test "glean/vp1-SUB test (with swizzle)" 0.0 "bin/glean -o -v -v -v -t +vertProg1 --quick"
run_test "glean/vp1-SWZ test 1" 0.0 "bin/glean -o -v -v -v -t +vertProg1 --quick"
run_test "glean/vp1-SWZ test 2" 0.0 "bin/glean -o -v -v -v -t +vertProg1 --quick"
run_test "glean/vp1-SWZ test 3" 0.0 "bin/glean -o -v -v -v -t +vertProg1 --quick"
run_test "glean/vp1-SWZ test 4" 0.0 "bin/glean -o -v -v -v -t +vertProg1 --quick"
run_test "glean/vp1-SWZ test 5" 0.0 "bin/glean -o -v -v -v -t +vertProg1 --quick"
run_test "glean/vp1-State reference test 1 (material ambient)" 0.0 "bin/glean -o -v -v -v -t +vertProg1 --quick"
run_test "glean/vp1-State reference test 2 (light products)" 0.0 "bin/glean -o -v -v -v -t +vertProg1 --quick"
run_test "glean/vp1-State reference test 3 (fog params)" 0.0 "bin/glean -o -v -v -v -t +vertProg1 --quick"
run_test "glean/vp1-XPD test 1" 0.0 "bin/glean -o -v -v -v -t +vertProg1 --quick"
run_test "glean/vp1-XPD test 2 (same src and dst arg)" 0.0 "bin/glean -o -v -v -v -t +vertProg1 --quick"
run_test "glean/vp1-Z-write test" 0.0 "bin/glean -o -v -v -v -t +vertProg1 --quick"
popd

if [ $need_pass == 0 ] ; then
  echo "+---------------------------------------------+"
  echo "| Overall pass, as all 149 tests have passed. |"
  echo "+---------------------------------------------+"
else
  echo "+-----------------------------------------------------------+"
  echo "| Overall failure, as $need_pass tests did not pass and $failures failed. |"
  echo "+-----------------------------------------------------------+"
fi
exit $need_pass

