// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// AUTOUPDATE
// TIP: To test this file alone, run:
// TIP:   bazel test //toolchain/testing:file_test --test_arg=--file_tests=toolchain/lower/testdata/tuple/one_entry.carbon
// TIP: To dump output, run:
// TIP:   bazel run //toolchain/testing:file_test -- --dump_output --file_tests=toolchain/lower/testdata/tuple/one_entry.carbon

fn Run() -> i32 {
  var x: (i32, ) = (1, );
  var y: (i32, ) = x;
  return 0;
}

// CHECK:STDOUT: ; ModuleID = 'one_entry.carbon'
// CHECK:STDOUT: source_filename = "one_entry.carbon"
// CHECK:STDOUT:
// CHECK:STDOUT: define i32 @main() {
// CHECK:STDOUT: entry:
// CHECK:STDOUT:   %x.var = alloca { i32 }, align 8
// CHECK:STDOUT:   store { i32 } { i32 1 }, ptr %x.var, align 4
// CHECK:STDOUT:   %y.var = alloca { i32 }, align 8
// CHECK:STDOUT:   %.loc13_20.1.tuple.elem = getelementptr inbounds { i32 }, ptr %x.var, i32 0, i32 0
// CHECK:STDOUT:   %.loc13_20.2 = load i32, ptr %.loc13_20.1.tuple.elem, align 4
// CHECK:STDOUT:   %.loc13_20.3.tuple.init = insertvalue { i32 } poison, i32 %.loc13_20.2, 0
// CHECK:STDOUT:   store { i32 } %.loc13_20.3.tuple.init, ptr %y.var, align 4
// CHECK:STDOUT:   ret i32 0
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: ; uselistorder directives
// CHECK:STDOUT: uselistorder i32 1, { 0, 2, 1 }
