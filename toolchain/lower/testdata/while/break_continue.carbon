// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// AUTOUPDATE
// TIP: To test this file alone, run:
// TIP:   bazel test //toolchain/testing:file_test --test_arg=--file_tests=toolchain/lower/testdata/while/break_continue.carbon
// TIP: To dump output, run:
// TIP:   bazel run //toolchain/testing:file_test -- --dump_output --file_tests=toolchain/lower/testdata/while/break_continue.carbon

fn A() -> bool;
fn B() -> bool;
fn C() -> bool;

fn While() {
  while (A()) {
    if (B()) { continue; }
    if (C()) { break; }
  }
}

// CHECK:STDOUT: ; ModuleID = 'break_continue.carbon'
// CHECK:STDOUT: source_filename = "break_continue.carbon"
// CHECK:STDOUT:
// CHECK:STDOUT: declare i1 @A()
// CHECK:STDOUT:
// CHECK:STDOUT: declare i1 @B()
// CHECK:STDOUT:
// CHECK:STDOUT: declare i1 @C()
// CHECK:STDOUT:
// CHECK:STDOUT: define void @While() {
// CHECK:STDOUT: entry:
// CHECK:STDOUT:   br label %while.cond
// CHECK:STDOUT:
// CHECK:STDOUT: while.cond:                                       ; preds = %entry, %if.else.loc18, %if.then.loc17
// CHECK:STDOUT:   %A.call = call i1 @A()
// CHECK:STDOUT:   br i1 %A.call, label %while.body, label %while.done
// CHECK:STDOUT:
// CHECK:STDOUT: while.body:                                       ; preds = %while.cond
// CHECK:STDOUT:   %B.call = call i1 @B()
// CHECK:STDOUT:   br i1 %B.call, label %if.then.loc17, label %if.else.loc17
// CHECK:STDOUT:
// CHECK:STDOUT: if.then.loc17:                                    ; preds = %while.body
// CHECK:STDOUT:   br label %while.cond
// CHECK:STDOUT:
// CHECK:STDOUT: if.else.loc17:                                    ; preds = %while.body
// CHECK:STDOUT:   %C.call = call i1 @C()
// CHECK:STDOUT:   br i1 %C.call, label %if.then.loc18, label %if.else.loc18
// CHECK:STDOUT:
// CHECK:STDOUT: if.then.loc18:                                    ; preds = %if.else.loc17
// CHECK:STDOUT:   br label %while.done
// CHECK:STDOUT:
// CHECK:STDOUT: if.else.loc18:                                    ; preds = %if.else.loc17
// CHECK:STDOUT:   br label %while.cond
// CHECK:STDOUT:
// CHECK:STDOUT: while.done:                                       ; preds = %if.then.loc18, %while.cond
// CHECK:STDOUT:   ret void
// CHECK:STDOUT:
// CHECK:STDOUT: ; uselistorder directives
// CHECK:STDOUT:   uselistorder label %while.cond, { 1, 2, 0 }
// CHECK:STDOUT: }
