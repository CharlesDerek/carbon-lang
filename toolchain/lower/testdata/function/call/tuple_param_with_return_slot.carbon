// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// AUTOUPDATE
// TIP: To test this file alone, run:
// TIP:   bazel test //toolchain/testing:file_test --test_arg=--file_tests=toolchain/lower/testdata/function/call/tuple_param_with_return_slot.carbon
// TIP: To dump output, run:
// TIP:   bazel run //toolchain/testing:file_test -- --dump_output --file_tests=toolchain/lower/testdata/function/call/tuple_param_with_return_slot.carbon

fn F(a: (), b: (i32,), c: (i32, i32)) -> (i32, i32, i32) {
  return (b[0], c[0], c[1]);
}

fn Main() {
  F((), (1,), (2, 3));
}

// CHECK:STDOUT: ; ModuleID = 'tuple_param_with_return_slot.carbon'
// CHECK:STDOUT: source_filename = "tuple_param_with_return_slot.carbon"
// CHECK:STDOUT:
// CHECK:STDOUT: @tuple.3.loc16_4.4 = internal constant { i32, i32 } { i32 2, i32 3 }
// CHECK:STDOUT:
// CHECK:STDOUT: define void @F(ptr sret({ i32, i32, i32 }) %return, { i32 } %b, ptr %c) {
// CHECK:STDOUT: entry:
// CHECK:STDOUT:   %.loc12_14.tuple.index = extractvalue { i32 } %b, 0
// CHECK:STDOUT:   %.loc12_20.tuple.index = getelementptr inbounds { i32, i32 }, ptr %c, i32 0, i32 0
// CHECK:STDOUT:   %.loc12_20.tuple.index.load = load i32, ptr %.loc12_20.tuple.index, align 4
// CHECK:STDOUT:   %.loc12_26.tuple.index = getelementptr inbounds { i32, i32 }, ptr %c, i32 0, i32 1
// CHECK:STDOUT:   %.loc12_26.tuple.index.load = load i32, ptr %.loc12_26.tuple.index, align 4
// CHECK:STDOUT:   %.loc12_27.2.tuple.elem = getelementptr inbounds { i32, i32, i32 }, ptr %return, i32 0, i32 0
// CHECK:STDOUT:   store i32 %.loc12_14.tuple.index, ptr %.loc12_27.2.tuple.elem, align 4
// CHECK:STDOUT:   %.loc12_27.4.tuple.elem = getelementptr inbounds { i32, i32, i32 }, ptr %return, i32 0, i32 1
// CHECK:STDOUT:   store i32 %.loc12_20.tuple.index.load, ptr %.loc12_27.4.tuple.elem, align 4
// CHECK:STDOUT:   %.loc12_27.6.tuple.elem = getelementptr inbounds { i32, i32, i32 }, ptr %return, i32 0, i32 2
// CHECK:STDOUT:   store i32 %.loc12_26.tuple.index.load, ptr %.loc12_27.6.tuple.elem, align 4
// CHECK:STDOUT:   ret void
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: define void @Main() {
// CHECK:STDOUT: entry:
// CHECK:STDOUT:   %.loc16_4.1.temp = alloca { i32, i32, i32 }, align 8
// CHECK:STDOUT:   call void @F(ptr %.loc16_4.1.temp, { i32 } { i32 1 }, ptr @tuple.3.loc16_4.4)
// CHECK:STDOUT:   ret void
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: ; uselistorder directives
// CHECK:STDOUT: uselistorder i32 1, { 3, 0, 1, 2 }
