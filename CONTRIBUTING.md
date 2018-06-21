# Contributing
- Fork it.
- Create a branch (`git checkout -b my_feature_branch`)
- Make some changes (with tests!)
- Run `rubocop`
- Commit your changes (`git commit -am "Added a sweet feature"`)
- Push to the branch (`git push origin my_feature_branch`)
- If you have a Travis-CI account, make sure the build passes
- Create a pull request from your branch into master (Please be sure to provide enough detail for us to understand what this change is doing)

## Supported Versions
This repo supports [Ruby](https://www.ruby-lang.org/en/downloads/branches/) and [Rails](https://rubyonrails.org/maintenance/) versions that are still in their support period. Please do not submit changes to support older versions.

## Testing
This repo uses the stock Rails testing setup. That means you should be able to run the tests locally without any special setup or configuration. **If you can't run the tests locally, please create an issue.**

All changes should have tests. Those tests should fail without your new code, but pass with your new code.

## Rubocop
Rubocop is used to give the code in this repo a consistent style. The rules are negotiable. If a rule is getting in the way of your contribution, submit it anyway and we'll figure it out.

## Travis CI
If you have a travis-ci.com account, the test suite will automatically run for all supported Ruby versions when you push changes to your branch. If you haven't used Travis CI, consider this an invitation to make an account and try it out. It is recommended that you do this before submitting a pull request, but it is not required.
