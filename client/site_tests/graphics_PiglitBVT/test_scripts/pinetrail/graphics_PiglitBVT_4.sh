#!/bin/bash


need_pass=223
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
run_test "shaders/glsl-const-builtin-normalize" 0.0 "bin/shader_runner tests/shaders/glsl-const-builtin-normalize.shader_test -auto"
run_test "shaders/glsl-const-builtin-not" 0.0 "bin/shader_runner tests/shaders/glsl-const-builtin-not.shader_test -auto"
run_test "shaders/glsl-const-builtin-notEqual" 0.0 "bin/shader_runner tests/shaders/glsl-const-builtin-notEqual.shader_test -auto"
run_test "shaders/glsl-const-builtin-notEqual-02" 0.0 "bin/shader_runner tests/shaders/glsl-const-builtin-notEqual-02.shader_test -auto"
run_test "shaders/glsl-const-builtin-notEqual-03" 0.0 "bin/shader_runner tests/shaders/glsl-const-builtin-notEqual-03.shader_test -auto"
run_test "shaders/glsl-const-builtin-notEqual-04" 0.0 "bin/shader_runner tests/shaders/glsl-const-builtin-notEqual-04.shader_test -auto"
run_test "shaders/glsl-const-builtin-notEqual-05" 0.0 "bin/shader_runner tests/shaders/glsl-const-builtin-notEqual-05.shader_test -auto"
run_test "shaders/glsl-const-builtin-notEqual-06" 0.0 "bin/shader_runner tests/shaders/glsl-const-builtin-notEqual-06.shader_test -auto"
run_test "shaders/glsl-const-builtin-notEqual-07" 0.0 "bin/shader_runner tests/shaders/glsl-const-builtin-notEqual-07.shader_test -auto"
run_test "shaders/glsl-const-builtin-notEqual-08" 0.0 "bin/shader_runner tests/shaders/glsl-const-builtin-notEqual-08.shader_test -auto"
run_test "shaders/glsl-const-builtin-notEqual-09" 0.0 "bin/shader_runner tests/shaders/glsl-const-builtin-notEqual-09.shader_test -auto"
run_test "shaders/glsl-const-builtin-notEqual-10" 0.0 "bin/shader_runner tests/shaders/glsl-const-builtin-notEqual-10.shader_test -auto"
run_test "shaders/glsl-const-builtin-notEqual-bool" 0.0 "bin/shader_runner tests/shaders/glsl-const-builtin-notEqual-bool.shader_test -auto"
run_test "shaders/glsl-const-builtin-outerProduct" 0.0 "bin/shader_runner tests/shaders/glsl-const-builtin-outerProduct.shader_test -auto"
run_test "shaders/glsl-const-builtin-pow" 0.0 "bin/shader_runner tests/shaders/glsl-const-builtin-pow.shader_test -auto"
run_test "shaders/glsl-const-builtin-radians" 0.0 "bin/shader_runner tests/shaders/glsl-const-builtin-radians.shader_test -auto"
run_test "shaders/glsl-const-builtin-reflect" 0.0 "bin/shader_runner tests/shaders/glsl-const-builtin-reflect.shader_test -auto"
run_test "shaders/glsl-const-builtin-refract" 0.0 "bin/shader_runner tests/shaders/glsl-const-builtin-refract.shader_test -auto"
run_test "shaders/glsl-const-builtin-sign" 0.0 "bin/shader_runner tests/shaders/glsl-const-builtin-sign.shader_test -auto"
run_test "shaders/glsl-const-builtin-sin" 0.0 "bin/shader_runner tests/shaders/glsl-const-builtin-sin.shader_test -auto"
run_test "shaders/glsl-const-builtin-smoothstep" 0.0 "bin/shader_runner tests/shaders/glsl-const-builtin-smoothstep.shader_test -auto"
run_test "shaders/glsl-const-builtin-sqrt" 0.0 "bin/shader_runner tests/shaders/glsl-const-builtin-sqrt.shader_test -auto"
run_test "shaders/glsl-const-builtin-step" 0.0 "bin/shader_runner tests/shaders/glsl-const-builtin-step.shader_test -auto"
run_test "shaders/glsl-const-builtin-tan" 0.0 "bin/shader_runner tests/shaders/glsl-const-builtin-tan.shader_test -auto"
run_test "shaders/glsl-const-builtin-transpose" 0.0 "bin/shader_runner tests/shaders/glsl-const-builtin-transpose.shader_test -auto"
run_test "shaders/glsl-const-initializer-01" 0.0 "bin/shader_runner tests/shaders/glsl-const-initializer-01.shader_test -auto"
run_test "shaders/glsl-const-initializer-02" 0.0 "bin/shader_runner tests/shaders/glsl-const-initializer-02.shader_test -auto"
run_test "shaders/glsl-const-initializer-03" 0.0 "bin/shader_runner tests/shaders/glsl-const-initializer-03.shader_test -auto"
run_test "shaders/glsl-constant-folding-call-1" 0.0 "bin/shader_runner tests/shaders/glsl-constant-folding-call-1.shader_test -auto"
run_test "shaders/glsl-copy-propagation-if-1" 0.0 "bin/shader_runner tests/shaders/glsl-copy-propagation-if-1.shader_test -auto"
run_test "shaders/glsl-copy-propagation-if-2" 0.0 "bin/shader_runner tests/shaders/glsl-copy-propagation-if-2.shader_test -auto"
run_test "shaders/glsl-copy-propagation-if-3" 0.0 "bin/shader_runner tests/shaders/glsl-copy-propagation-if-3.shader_test -auto"
run_test "shaders/glsl-copy-propagation-loop-2" 0.0 "bin/shader_runner tests/shaders/glsl-copy-propagation-loop-2.shader_test -auto"
run_test "shaders/glsl-copy-propagation-self-1" 0.0 "bin/shader_runner tests/shaders/glsl-copy-propagation-self-1.shader_test -auto"
run_test "shaders/glsl-copy-propagation-self-2" 0.0 "bin/shader_runner tests/shaders/glsl-copy-propagation-self-2.shader_test -auto"
run_test "shaders/glsl-copy-propagation-vector-indexing" 0.0 "bin/shader_runner tests/shaders/glsl-copy-propagation-vector-indexing.shader_test -auto"
run_test "shaders/glsl-deadcode-call" 0.0 "bin/shader_runner tests/shaders/glsl-deadcode-call.shader_test -auto"
run_test "shaders/glsl-deadcode-self-assign" 0.0 "bin/shader_runner tests/shaders/glsl-deadcode-self-assign.shader_test -auto"
run_test "shaders/glsl-deadcode-varying" 0.0 "bin/shader_runner tests/shaders/glsl-deadcode-varying.shader_test -auto"
run_test "shaders/glsl-dlist-getattriblocation" 0.0 "bin/glsl-dlist-getattriblocation -auto"
run_test "shaders/glsl-empty-vs-no-fs" 0.0 "bin/glsl-empty-vs-no-fs -auto"
run_test "shaders/glsl-floating-constant-120" 0.0 "bin/shader_runner tests/shaders/glsl-floating-constant-120.shader_test -auto"
run_test "shaders/glsl-fs-abs-01" 0.0 "bin/shader_runner tests/shaders/glsl-fs-abs-01.shader_test -auto"
run_test "shaders/glsl-fs-abs-02" 0.0 "bin/shader_runner tests/shaders/glsl-fs-abs-02.shader_test -auto"
run_test "shaders/glsl-fs-abs-03" 0.0 "bin/shader_runner tests/shaders/glsl-fs-abs-03.shader_test -auto"
run_test "shaders/glsl-fs-abs-04" 0.0 "bin/shader_runner tests/shaders/glsl-fs-abs-04.shader_test -auto"
run_test "shaders/glsl-fs-abs-neg" 0.0 "bin/shader_runner tests/shaders/glsl-fs-abs-neg.shader_test -auto"
run_test "shaders/glsl-fs-abs-neg-with-intermediate" 0.0 "bin/shader_runner tests/shaders/glsl-fs-abs-neg-with-intermediate.shader_test -auto"
run_test "shaders/glsl-fs-add-masked" 0.0 "bin/shader_runner tests/shaders/glsl-fs-add-masked.shader_test -auto"
run_test "shaders/glsl-fs-all-01" 0.0 "bin/shader_runner tests/shaders/glsl-fs-all-01.shader_test -auto"
run_test "shaders/glsl-fs-all-02" 0.0 "bin/shader_runner tests/shaders/glsl-fs-all-02.shader_test -auto"
run_test "shaders/glsl-fs-any" 0.0 "bin/shader_runner tests/shaders/glsl-fs-any.shader_test -auto"
run_test "shaders/glsl-fs-array-redeclaration" 0.0 "bin/shader_runner tests/shaders/glsl-fs-array-redeclaration.shader_test -auto"
run_test "shaders/glsl-fs-asin" 0.0 "bin/shader_runner tests/shaders/glsl-fs-asin.shader_test -auto"
run_test "shaders/glsl-fs-atan-1" 0.0 "bin/shader_runner tests/shaders/glsl-fs-atan-1.shader_test -auto"
run_test "shaders/glsl-fs-bug25902" 0.0 "bin/glsl-fs-bug25902 -auto"
run_test "shaders/glsl-fs-ceil" 0.0 "bin/shader_runner tests/shaders/glsl-fs-ceil.shader_test -auto"
run_test "shaders/glsl-fs-clamp-1" 0.0 "bin/shader_runner tests/shaders/glsl-fs-clamp-1.shader_test -auto"
run_test "shaders/glsl-fs-clamp-2" 0.0 "bin/shader_runner tests/shaders/glsl-fs-clamp-2.shader_test -auto"
run_test "shaders/glsl-fs-clamp-3" 0.0 "bin/shader_runner tests/shaders/glsl-fs-clamp-3.shader_test -auto"
run_test "shaders/glsl-fs-clamp-4" 0.0 "bin/shader_runner tests/shaders/glsl-fs-clamp-4.shader_test -auto"
run_test "shaders/glsl-fs-clamp-5" 0.0 "bin/shader_runner tests/shaders/glsl-fs-clamp-5.shader_test -auto"
run_test "shaders/glsl-fs-color-matrix" 0.0 "bin/glsl-fs-color-matrix -auto"
run_test "shaders/glsl-fs-conditional-output-write" 0.0 "bin/shader_runner tests/shaders/glsl-fs-conditional-output-write.shader_test -auto"
run_test "shaders/glsl-fs-copy-propagation-texcoords-1" 0.0 "bin/shader_runner tests/shaders/glsl-fs-copy-propagation-texcoords-1.shader_test -auto"
run_test "shaders/glsl-fs-copy-propagation-texcoords-2" 0.0 "bin/shader_runner tests/shaders/glsl-fs-copy-propagation-texcoords-2.shader_test -auto"
run_test "shaders/glsl-fs-cross" 0.0 "bin/shader_runner tests/shaders/glsl-fs-cross.shader_test -auto"
run_test "shaders/glsl-fs-cross-2" 0.0 "bin/shader_runner tests/shaders/glsl-fs-cross-2.shader_test -auto"
run_test "shaders/glsl-fs-cross-3" 0.0 "bin/shader_runner tests/shaders/glsl-fs-cross-3.shader_test -auto"
run_test "shaders/glsl-fs-discard-01" 0.0 "bin/shader_runner tests/shaders/glsl-fs-discard-01.shader_test -auto"
run_test "shaders/glsl-fs-discard-02" 0.0 "bin/glsl-fs-discard-02 -auto"
run_test "shaders/glsl-fs-dot-vec2" 0.0 "bin/shader_runner tests/shaders/glsl-fs-dot-vec2.shader_test -auto"
run_test "shaders/glsl-fs-dot-vec2-2" 0.0 "bin/shader_runner tests/shaders/glsl-fs-dot-vec2-2.shader_test -auto"
run_test "shaders/glsl-fs-double-negative-copy-propagation" 0.0 "bin/shader_runner tests/shaders/glsl-fs-double-negative-copy-propagation.shader_test -auto"
run_test "shaders/glsl-fs-exp" 0.0 "bin/shader_runner tests/shaders/glsl-fs-exp.shader_test -auto"
run_test "shaders/glsl-fs-exp2" 0.0 "bin/glsl-fs-exp2 -auto"
run_test "shaders/glsl-fs-f2b" 0.0 "bin/shader_runner tests/shaders/glsl-fs-f2b.shader_test -auto"
run_test "shaders/glsl-fs-flat-color" 0.0 "bin/glsl-fs-flat-color -auto"
run_test "shaders/glsl-fs-floor" 0.0 "bin/shader_runner tests/shaders/glsl-fs-floor.shader_test -auto"
run_test "shaders/glsl-fs-fogcolor-statechange" 0.0 "bin/glsl-fs-fogcolor-statechange -auto"
run_test "shaders/glsl-fs-fragcoord" 0.0 "bin/glsl-fs-fragcoord -auto"
run_test "shaders/glsl-fs-fragcoord-zw-ortho" 0.0 "bin/glsl-fs-fragcoord-zw-ortho -auto"
run_test "shaders/glsl-fs-fragcoord-zw-perspective" 0.0 "bin/glsl-fs-fragcoord-zw-perspective -auto"
run_test "shaders/glsl-fs-fragdata-1" 0.0 "bin/shader_runner tests/shaders/glsl-fs-fragdata-1.shader_test -auto"
run_test "shaders/glsl-fs-functions-2" 0.0 "bin/shader_runner tests/shaders/glsl-fs-functions-2.shader_test -auto"
run_test "shaders/glsl-fs-functions-3" 0.0 "bin/shader_runner tests/shaders/glsl-fs-functions-3.shader_test -auto"
run_test "shaders/glsl-fs-functions-4" 0.0 "bin/shader_runner tests/shaders/glsl-fs-functions-4.shader_test -auto"
run_test "shaders/glsl-fs-functions-5" 0.0 "bin/shader_runner tests/shaders/glsl-fs-functions-5.shader_test -auto"
run_test "shaders/glsl-fs-functions-6" 0.0 "bin/shader_runner tests/shaders/glsl-fs-functions-6.shader_test -auto"
run_test "shaders/glsl-fs-functions-samplers" 0.0 "bin/shader_runner tests/shaders/glsl-fs-functions-samplers.shader_test -auto"
run_test "shaders/glsl-fs-i2b" 0.0 "bin/shader_runner tests/shaders/glsl-fs-i2b.shader_test -auto"
run_test "shaders/glsl-fs-if-greater" 0.0 "bin/shader_runner tests/shaders/glsl-fs-if-greater.shader_test -auto"
run_test "shaders/glsl-fs-if-greater-equal" 0.0 "bin/shader_runner tests/shaders/glsl-fs-if-greater-equal.shader_test -auto"
run_test "shaders/glsl-fs-if-less" 0.0 "bin/shader_runner tests/shaders/glsl-fs-if-less.shader_test -auto"
run_test "shaders/glsl-fs-if-less-equal" 0.0 "bin/shader_runner tests/shaders/glsl-fs-if-less-equal.shader_test -auto"
run_test "shaders/glsl-fs-if-texture2d-discard" 0.0 "bin/shader_runner tests/shaders/glsl-fs-if-texture2d-discard.shader_test -auto"
run_test "shaders/glsl-fs-implicit-array-size-01" 0.0 "bin/shader_runner tests/shaders/glsl-fs-implicit-array-size-01.shader_test -auto"
run_test "shaders/glsl-fs-implicit-array-size-02" 0.0 "bin/shader_runner tests/shaders/glsl-fs-implicit-array-size-02.shader_test -auto"
run_test "shaders/glsl-fs-implicit-array-size-03" 0.0 "bin/shader_runner tests/shaders/glsl-fs-implicit-array-size-03.shader_test -auto"
run_test "shaders/glsl-fs-log" 0.0 "bin/shader_runner tests/shaders/glsl-fs-log.shader_test -auto"
run_test "shaders/glsl-fs-log2" 0.0 "bin/shader_runner tests/shaders/glsl-fs-log2.shader_test -auto"
run_test "shaders/glsl-fs-loop-break" 0.0 "bin/shader_runner tests/shaders/glsl-fs-loop-break.shader_test -auto"
run_test "shaders/glsl-fs-loop-const-decr" 0.0 "bin/shader_runner tests/shaders/glsl-fs-loop-const-decr.shader_test -auto"
run_test "shaders/glsl-fs-loop-const-incr" 0.0 "bin/shader_runner tests/shaders/glsl-fs-loop-const-incr.shader_test -auto"
run_test "shaders/glsl-fs-loop-diagonal-break" 0.0 "bin/shader_runner tests/shaders/glsl-fs-loop-diagonal-break.shader_test -auto"
run_test "shaders/glsl-fs-loop-ge" 0.0 "bin/shader_runner tests/shaders/glsl-fs-loop-ge.shader_test -auto"
run_test "shaders/glsl-fs-loop-gt" 0.0 "bin/shader_runner tests/shaders/glsl-fs-loop-gt.shader_test -auto"
run_test "shaders/glsl-fs-loop-le" 0.0 "bin/shader_runner tests/shaders/glsl-fs-loop-le.shader_test -auto"
run_test "shaders/glsl-fs-loop-lt" 0.0 "bin/shader_runner tests/shaders/glsl-fs-loop-lt.shader_test -auto"
run_test "shaders/glsl-fs-loop-nested-if" 0.0 "bin/shader_runner tests/shaders/glsl-fs-loop-nested-if.shader_test -auto"
run_test "shaders/glsl-fs-loop-two-counter-01" 0.0 "bin/shader_runner tests/shaders/glsl-fs-loop-two-counter-01.shader_test -auto"
run_test "shaders/glsl-fs-loop-two-counter-02" 0.0 "bin/shader_runner tests/shaders/glsl-fs-loop-two-counter-02.shader_test -auto"
run_test "shaders/glsl-fs-loop-two-counter-03" 0.0 "bin/shader_runner tests/shaders/glsl-fs-loop-two-counter-03.shader_test -auto"
run_test "shaders/glsl-fs-loop-two-counter-04" 0.0 "bin/shader_runner tests/shaders/glsl-fs-loop-two-counter-04.shader_test -auto"
run_test "shaders/glsl-fs-loop-zero-iter" 0.0 "bin/shader_runner tests/shaders/glsl-fs-loop-zero-iter.shader_test -auto"
run_test "shaders/glsl-fs-main-return" 0.0 "bin/shader_runner tests/shaders/glsl-fs-main-return.shader_test -auto"
run_test "shaders/glsl-fs-max" 0.0 "bin/shader_runner tests/shaders/glsl-fs-max.shader_test -auto"
run_test "shaders/glsl-fs-max-2" 0.0 "bin/shader_runner tests/shaders/glsl-fs-max-2.shader_test -auto"
run_test "shaders/glsl-fs-max-3" 0.0 "bin/shader_runner tests/shaders/glsl-fs-max-3.shader_test -auto"
run_test "shaders/glsl-fs-min" 0.0 "bin/shader_runner tests/shaders/glsl-fs-min.shader_test -auto"
run_test "shaders/glsl-fs-min-2" 0.0 "bin/shader_runner tests/shaders/glsl-fs-min-2.shader_test -auto"
run_test "shaders/glsl-fs-min-3" 0.0 "bin/shader_runner tests/shaders/glsl-fs-min-3.shader_test -auto"
run_test "shaders/glsl-fs-mix" 0.0 "bin/shader_runner tests/shaders/glsl-fs-mix.shader_test -auto"
run_test "shaders/glsl-fs-mix-constant" 0.0 "bin/shader_runner tests/shaders/glsl-fs-mix-constant.shader_test -auto"
run_test "shaders/glsl-fs-mod" 0.0 "bin/shader_runner tests/shaders/glsl-fs-mod.shader_test -auto"
run_test "shaders/glsl-fs-mov-masked" 0.0 "bin/shader_runner tests/shaders/glsl-fs-mov-masked.shader_test -auto"
run_test "shaders/glsl-fs-neg" 0.0 "bin/shader_runner tests/shaders/glsl-fs-neg.shader_test -auto"
run_test "shaders/glsl-fs-neg-abs" 0.0 "bin/shader_runner tests/shaders/glsl-fs-neg-abs.shader_test -auto"
run_test "shaders/glsl-fs-neg-dot" 0.0 "bin/shader_runner tests/shaders/glsl-fs-neg-dot.shader_test -auto"
run_test "shaders/glsl-fs-pointcoord" 0.0 "bin/glsl-fs-pointcoord -auto"
run_test "shaders/glsl-fs-post-increment-01" 0.0 "bin/shader_runner tests/shaders/glsl-fs-post-increment-01.shader_test -auto"
run_test "shaders/glsl-fs-reflect" 0.0 "bin/shader_runner tests/shaders/glsl-fs-reflect.shader_test -auto"
run_test "shaders/glsl-fs-sampler-numbering" 0.0 "bin/glsl-fs-sampler-numbering -auto"
run_test "shaders/glsl-fs-sampler-numbering-2" 0.0 "bin/shader_runner tests/shaders/glsl-fs-sampler-numbering-2.shader_test -auto"
run_test "shaders/glsl-fs-sampler-numbering-3" 0.0 "bin/shader_runner tests/shaders/glsl-fs-sampler-numbering-3.shader_test -auto"
run_test "shaders/glsl-fs-sign" 0.0 "bin/shader_runner tests/shaders/glsl-fs-sign.shader_test -auto"
run_test "shaders/glsl-fs-sqrt-branch" 0.0 "bin/glsl-fs-sqrt-branch -auto"
run_test "shaders/glsl-fs-statevar-call" 0.0 "bin/shader_runner tests/shaders/glsl-fs-statevar-call.shader_test -auto"
run_test "shaders/glsl-fs-step" 0.0 "bin/shader_runner tests/shaders/glsl-fs-step.shader_test -auto"
run_test "shaders/glsl-fs-struct-equal" 0.0 "bin/shader_runner tests/shaders/glsl-fs-struct-equal.shader_test -auto"
run_test "shaders/glsl-fs-struct-notequal" 0.0 "bin/shader_runner tests/shaders/glsl-fs-struct-notequal.shader_test -auto"
run_test "shaders/glsl-fs-swizzle-1" 0.0 "bin/shader_runner tests/shaders/glsl-fs-swizzle-1.shader_test -auto"
run_test "shaders/glsl-fs-tan-2" 0.0 "bin/shader_runner tests/shaders/glsl-fs-tan-2.shader_test -auto"
run_test "shaders/glsl-fs-texture2d" 0.0 "bin/shader_runner tests/shaders/glsl-fs-texture2d.shader_test -auto"
run_test "shaders/glsl-fs-texture2d-bias" 0.0 "bin/shader_runner tests/shaders/glsl-fs-texture2d-bias.shader_test -auto"
run_test "shaders/glsl-fs-texture2d-branching" 0.0 "bin/shader_runner tests/shaders/glsl-fs-texture2d-branching.shader_test -auto"
run_test "shaders/glsl-fs-texture2d-dependent-1" 0.0 "bin/shader_runner tests/shaders/glsl-fs-texture2d-dependent-1.shader_test -auto"
run_test "shaders/glsl-fs-texture2d-dependent-2" 0.0 "bin/shader_runner tests/shaders/glsl-fs-texture2d-dependent-2.shader_test -auto"
run_test "shaders/glsl-fs-texture2d-dependent-3" 0.0 "bin/shader_runner tests/shaders/glsl-fs-texture2d-dependent-3.shader_test -auto"
run_test "shaders/glsl-fs-texture2d-dependent-4" 0.0 "bin/shader_runner tests/shaders/glsl-fs-texture2d-dependent-4.shader_test -auto"
run_test "shaders/glsl-fs-texture2d-dependent-5" 0.0 "bin/shader_runner tests/shaders/glsl-fs-texture2d-dependent-5.shader_test -auto"
run_test "shaders/glsl-fs-texture2d-masked" 0.0 "bin/shader_runner tests/shaders/glsl-fs-texture2d-masked.shader_test -auto"
run_test "shaders/glsl-fs-texture2d-masked-2" 0.0 "bin/shader_runner tests/shaders/glsl-fs-texture2d-masked-2.shader_test -auto"
run_test "shaders/glsl-fs-texture2d-masked-3" 0.0 "bin/shader_runner tests/shaders/glsl-fs-texture2d-masked-3.shader_test -auto"
run_test "shaders/glsl-fs-texture2d-masked-4" 0.0 "bin/shader_runner tests/shaders/glsl-fs-texture2d-masked-4.shader_test -auto"
run_test "shaders/glsl-fs-texture2dproj" 0.0 "bin/shader_runner tests/shaders/glsl-fs-texture2dproj.shader_test -auto"
run_test "shaders/glsl-fs-texture2dproj-2" 0.0 "bin/shader_runner tests/shaders/glsl-fs-texture2dproj-2.shader_test -auto"
run_test "shaders/glsl-fs-texture2dproj-bias" 0.0 "bin/shader_runner tests/shaders/glsl-fs-texture2dproj-bias.shader_test -auto"
run_test "shaders/glsl-fs-texture2dproj-bias-2" 0.0 "bin/shader_runner tests/shaders/glsl-fs-texture2dproj-bias-2.shader_test -auto"
run_test "shaders/glsl-fs-texture2drect" 0.0 "bin/glsl-fs-texture2drect -auto"
run_test "shaders/glsl-fs-texture2drect-proj3" 0.0 "bin/glsl-fs-texture2drect -auto -proj3"
run_test "shaders/glsl-fs-texture2drect-proj4" 0.0 "bin/glsl-fs-texture2drect -auto -proj4"
run_test "shaders/glsl-fs-texturecube" 0.0 "bin/glsl-fs-texturecube -auto"
run_test "shaders/glsl-fs-texturecube-2" 0.0 "bin/glsl-fs-texturecube-2 -auto"
run_test "shaders/glsl-fs-texturecube-2-bias" 0.0 "bin/glsl-fs-texturecube-2 -auto -bias"
run_test "shaders/glsl-fs-texturecube-bias" 0.0 "bin/glsl-fs-texturecube -auto -bias"
run_test "shaders/glsl-fs-textureenvcolor-statechange" 0.0 "bin/glsl-fs-textureenvcolor-statechange -auto"
run_test "shaders/glsl-fs-uniform-array-1" 0.0 "bin/shader_runner tests/shaders/glsl-fs-uniform-array-1.shader_test -auto"
run_test "shaders/glsl-fs-uniform-array-3" 0.0 "bin/shader_runner tests/shaders/glsl-fs-uniform-array-3.shader_test -auto"
run_test "shaders/glsl-fs-uniform-array-4" 0.0 "bin/shader_runner tests/shaders/glsl-fs-uniform-array-4.shader_test -auto"
run_test "shaders/glsl-fs-uniform-bool-1" 0.0 "bin/shader_runner tests/shaders/glsl-fs-uniform-bool-1.shader_test -auto"
run_test "shaders/glsl-fs-uniform-bool-2" 0.0 "bin/shader_runner tests/shaders/glsl-fs-uniform-bool-2.shader_test -auto"
run_test "shaders/glsl-fs-uniform-sampler-array" 0.0 "bin/shader_runner tests/shaders/glsl-fs-uniform-sampler-array.shader_test -auto"
run_test "shaders/glsl-fs-user-varying-ff" 0.0 "bin/glsl-fs-user-varying-ff -auto"
run_test "shaders/glsl-fs-vec4-indexing-1" 0.0 "bin/shader_runner tests/shaders/glsl-fs-vec4-indexing-1.shader_test -auto"
run_test "shaders/glsl-fs-vec4-indexing-2" 0.0 "bin/shader_runner tests/shaders/glsl-fs-vec4-indexing-2.shader_test -auto"
run_test "shaders/glsl-fs-vec4-indexing-3" 0.0 "bin/shader_runner tests/shaders/glsl-fs-vec4-indexing-3.shader_test -auto"
run_test "shaders/glsl-fs-vec4-indexing-4" 0.0 "bin/shader_runner tests/shaders/glsl-fs-vec4-indexing-4.shader_test -auto"
run_test "shaders/glsl-fs-vec4-indexing-5" 0.0 "bin/shader_runner tests/shaders/glsl-fs-vec4-indexing-5.shader_test -auto"
run_test "shaders/glsl-fs-vec4-indexing-6" 0.0 "bin/shader_runner tests/shaders/glsl-fs-vec4-indexing-6.shader_test -auto"
run_test "shaders/glsl-fs-vec4-indexing-7" 0.0 "bin/shader_runner tests/shaders/glsl-fs-vec4-indexing-7.shader_test -auto"
run_test "shaders/glsl-fs-vec4-operator-equal" 0.0 "bin/shader_runner tests/shaders/glsl-fs-vec4-operator-equal.shader_test -auto"
run_test "shaders/glsl-fs-vec4-operator-notequal" 0.0 "bin/shader_runner tests/shaders/glsl-fs-vec4-operator-notequal.shader_test -auto"
run_test "shaders/glsl-function-chain16" 0.0 "bin/shader_runner tests/shaders/glsl-function-chain16.shader_test -auto"
run_test "shaders/glsl-function-prototype" 0.0 "bin/shader_runner tests/shaders/glsl-function-prototype.shader_test -auto"
run_test "shaders/glsl-getactiveuniform-array-size" 0.0 "bin/glsl-getactiveuniform-array-size -auto"
run_test "shaders/glsl-getactiveuniform-count: glsl-getactiveuniform-length" 0.0 "bin/glsl-getactiveuniform-count -auto shaders/glsl-getactiveuniform-length.vert 1"
run_test "shaders/glsl-getactiveuniform-length" 0.0 "bin/glsl-getactiveuniform-length -auto"
run_test "shaders/glsl-getattriblocation" 0.0 "bin/glsl-getattriblocation -auto"
run_test "shaders/glsl-gnome-shell-dim-window" 0.0 "bin/shader_runner tests/shaders/glsl-gnome-shell-dim-window.shader_test -auto"
run_test "shaders/glsl-if-assign-call" 0.0 "bin/shader_runner tests/shaders/glsl-if-assign-call.shader_test -auto"
run_test "shaders/glsl-implicit-conversion-01" 0.0 "bin/shader_runner tests/shaders/glsl-implicit-conversion-01.shader_test -auto"
run_test "shaders/glsl-implicit-conversion-02" 0.0 "bin/shader_runner tests/shaders/glsl-implicit-conversion-02.shader_test -auto"
run_test "shaders/glsl-inexact-overloads" 0.0 "bin/shader_runner tests/shaders/glsl-inexact-overloads.shader_test -auto"
run_test "shaders/glsl-inout-struct-01" 0.0 "bin/shader_runner tests/shaders/glsl-inout-struct-01.shader_test -auto"
run_test "shaders/glsl-inout-struct-02" 0.0 "bin/shader_runner tests/shaders/glsl-inout-struct-02.shader_test -auto"
run_test "shaders/glsl-invalid-asm-01" 0.0 "bin/glsl-invalid-asm-01 -auto"
run_test "shaders/glsl-invalid-asm-02" 0.0 "bin/glsl-invalid-asm-02 -auto"
run_test "shaders/glsl-invariant-pragma" 0.0 "bin/shader_runner tests/shaders/glsl-invariant-pragma.shader_test -auto"
run_test "shaders/glsl-kwin-blur-1" 0.0 "bin/glsl-kwin-blur-1 -auto"
run_test "shaders/glsl-light-model" 0.0 "bin/glsl-light-model -auto"
run_test "shaders/glsl-link-array-01" 0.0 "bin/shader_runner tests/shaders/glsl-link-array-01.shader_test -auto"
run_test "shaders/glsl-link-bug30552" 0.0 "bin/glsl-link-bug30552 -auto"
run_test "shaders/glsl-link-bug38015" 0.0 "bin/glsl-link-bug38015 -auto"
run_test "shaders/glsl-link-empty-prog-01" 0.0 "bin/glsl-link-empty-prog-01 -auto"
run_test "shaders/glsl-link-empty-prog-02" 0.0 "bin/glsl-link-empty-prog-02 -auto"
run_test "shaders/glsl-link-varying-TexCoord" 0.0 "bin/shader_runner tests/shaders/glsl-link-varying-TexCoord.shader_test -auto"
run_test "shaders/glsl-link-varyings-1" 0.0 "bin/shader_runner tests/shaders/glsl-link-varyings-1.shader_test -auto"
run_test "shaders/glsl-link-varyings-2" 0.0 "bin/shader_runner tests/shaders/glsl-link-varyings-2.shader_test -auto"
run_test "shaders/glsl-link-varyings-3" 0.0 "bin/shader_runner tests/shaders/glsl-link-varyings-3.shader_test -auto"
run_test "shaders/glsl-lod-bias" 0.0 "bin/glsl-lod-bias -auto"
run_test "shaders/glsl-mat-110" 0.0 "bin/shader_runner tests/shaders/glsl-mat-110.shader_test -auto"
run_test "shaders/glsl-mat-attribute" 0.0 "bin/glsl-mat-attribute -auto"
run_test "shaders/glsl-mat-from-int-ctor-01" 0.0 "bin/shader_runner tests/shaders/glsl-mat-from-int-ctor-01.shader_test -auto"
run_test "shaders/glsl-mat-from-int-ctor-02" 0.0 "bin/shader_runner tests/shaders/glsl-mat-from-int-ctor-02.shader_test -auto"
run_test "shaders/glsl-mat-from-int-ctor-03" 0.0 "bin/shader_runner tests/shaders/glsl-mat-from-int-ctor-03.shader_test -auto"
run_test "shaders/glsl-mat-from-vec-ctor-01" 0.0 "bin/shader_runner tests/shaders/glsl-mat-from-vec-ctor-01.shader_test -auto"
run_test "shaders/glsl-mat-mul-1" 0.0 "bin/shader_runner tests/shaders/glsl-mat-mul-1.shader_test -auto"
run_test "shaders/glsl-max-vertex-attrib" 0.0 "bin/glsl-max-vertex-attrib -auto"
run_test "shaders/glsl-novertexdata" 0.0 "bin/glsl-novertexdata -auto"
run_test "shaders/glsl-octal" 0.0 "bin/shader_runner tests/shaders/glsl-octal.shader_test -auto"
run_test "shaders/glsl-orangebook-ch06-bump" 0.0 "bin/glsl-orangebook-ch06-bump -auto"
run_test "shaders/glsl-override-builtin" 0.0 "bin/shader_runner tests/shaders/glsl-override-builtin.shader_test -auto"
popd

if [ $need_pass == 0 ] ; then
  echo "+---------------------------------------------+"
  echo "| Overall pass, as all 223 tests have passed. |"
  echo "+---------------------------------------------+"
else
  echo "+-----------------------------------------------------------+"
  echo "| Overall failure, as $need_pass tests did not pass and $failures failed. |"
  echo "+-----------------------------------------------------------+"
fi
exit $need_pass

