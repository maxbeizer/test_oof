# TestOof

[![CircleCI](https://circleci.com/gh/maxbeizer/test_oof.svg?style=svg)](https://circleci.com/gh/maxbeizer/test_oof)

A tiny test helper tool to make sure all your test files run.

## Why
I'm an idiot. As an idiot, I often will write tests that I think are great
and the whole suite passes and I feel great about myself. Only
later—sometimes much later— do I notice the compiler warning that one of my
beautiful tests has the `.ex` extension and not the `.exs` extenion that
ExUnit requires to run the test.

This package is an attempt to remove that rake I tend to step on.

## How it works
TestOof assumes that all files in your test directory (the location of
which you can override) that end in `_test` are indeed ExUnit test files.
TestOof gathers files matching that criteria and filters that list down to
files whose extension is anything other than `.exs`. If there are any files
left after filter, TestOof raises and lists all offenders.

* Could it be more efficient? Certainly.
* Will it stop me from making the mistake of assuming test are running when the actually aren't? Possibly

## Installation

When [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `test_oof` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:test_oof, "~> 0.2.0", only: :test}
  ]
end
```

Then add the following to your `test_helper.exs`

```elixir
TestOof.ensure_test_files_are_exs!()
```

## Configuration
`test_oof` supports the following options as configuration:
* `test_dir` (string): Path to where the tests live, e.g. `File.cwd!() <> "/test"`
* `ignore` (list): Paths to ignore when checking extensions—false positives., e.g. `["some_cool_test"]`

Documentation can be found at
[https://hexdocs.pm/test_oof](https://hexdocs.pm/test_oof).

## Development
### Run the tests
```
$ mix test
```

Or run the linter and tests combined:
```
$ make test
```

### Run the linter
```
$ make lint
```

## Roadmap
* [ ] Handle umbrella projects
* [x] Make it more configurable
* [ ] Add an option to auto-correct
* [x] Add an option to ignore a list of false positives

## License
MIT. See LICENSE.
