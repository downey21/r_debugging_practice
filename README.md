# R Debugging Practice

This repository contains example codes and explanations for practicing debugging in R.  
It is designed to help you understand how R sessions work, how to use `debug()`, `browser()`, and how to explore error-prone code interactively.

## What is an R Session?

An **R session** is an instance of the R environment where objects are created, stored, and manipulated.  
All variables, loaded packages, and execution states live inside the session.

You can view all objects in the current session using:

```r
ls()
```

## `source()` vs `Rscript`

| Feature              | `source("file.R")`                  | `Rscript file.R`                  |
|----------------------|-------------------------------------|-----------------------------------|
| Session              | Runs in **current session**         | Starts a **new R session**        |
| Variable visibility  | Objects are added to current env    | Objects exist only during run     |
| Interactive debugging| Supported                           | Not supported                     |
| Usage                | From R console or RStudio           | From terminal or shell scripts    |

`source()` allows debugging with `debug()` or `browser()`, while `Rscript` does **not** support interactive debugging and should be used for batch execution.

## Debug Mode in R

When you enter **debug mode**, R allows step-by-step execution and introspection of variables and function calls.

### Main Debug Commands

| Command    | Description                              |
|------------|------------------------------------------|
| `n`        | Run the **next** line of code            |
| `s`        | **Step into** a called function          |
| `f`        | Run until the current function **finishes** |
| `c`        | **Continue** execution normally        |
| `Q`        | **Quit** debugging mode                  |
| `where`    | Show current call **stack**              |
| `help`     | Show help for debug mode                 |
| `<expr>`   | Evaluate an R expression (e.g. `x + 1`)  |

> **Note:** Debug mode works only in **interactive sessions** like R console or RStudio. It does **not** work when using `Rscript`.

## Example Code Overview

### `find_index_close_to_mean()`

This function finds the index (or indices) of values in a numeric vector that are closest to the mean.

## Debugging Approaches

### Case 1: Manual Interactive Inspection

You can manually step through your function outside of debug mode:

```r
vec <- c(1, 2, 3, 4, 5, NA)
mean_value <- mean(vec)  # What's the result?
```

This method works but can be tedious for long functions or many edge cases.

### Case 2: `debug()` and `undebug()`

Attach debug mode to a function:

```r
debug(find_index_close_to_mean)
find_index_close_to_mean(vec)
undebug(find_index_close_to_mean)
```

You can step through the function interactively with full access to the environment.

### Case 3: Use `browser()` at Suspicious Lines

If you suspect a specific part of a function, use `browser()` directly inside the function:

```r
find_index_close_to_mean_debugging <- function(vec) {
  ...
  browser()  # Pause here and inspect variables
  ...
}
```

This approach is powerful when debugging **large functions**, as it lets you jump straight to the problem area without stepping through every line.

## Recommendation

- Use `debug()`/`undebug()` when you're unsure **where** the problem is.
- Use `browser()` when you **know where** the issue might be.
- Avoid using `Rscript` when you need interactive debugging — use `source()` instead.

## Advanced Debugging

When debugging more complex functions—especially those from installed packages—you might want to inspect or modify the function behavior at a specific location.
Here are some powerful techniques:

### `as.list(body(...))`: Inspect Function Expressions

In R, the body of a function is a sequence of expressions, not just plain lines of code.
You can inspect each expression using:

```r
as.list(body(<function_name>))
```

This returns a list of expressions, allowing you to identify the exact position (e.g., 1st, 2nd, 12th…) for inserting debug logic.

### `trace()`: Insert Debug Code at Specific Locations

You can insert debugging expressions such as browser() (or even print(), etc...) at any expression index using trace().

```r
trace("<function_name>", tracer = quote(browser()), at = <expression_number>, where = asNamespace("<package_name>"))
```

- `tracer = quote(browser())`: inserts a pause for interactive inspection
- `at = <expression_number>`: expression index inside the function body (as identified from `as.list(body(...))`)
- `where = asNamespace(...)`: ensures access to non-exported functions in a package

### `untrace()`: Remove Trace Insertion

After you’re done debugging, remove the trace:

```r
untrace("<function_name>", where = asNamespace("<package_name>"))
```

### Examples

```r
as.list(body(MultiwayRegression:::rrr))

trace("rrr", tracer = quote(browser()), at = 12, where = asNamespace("MultiwayRegression"))

untrace("rrr", where = asNamespace("MultiwayRegression"))
```
