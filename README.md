# Chrome new tab bug

- [Whats the issue?](#whats-the-issue)
- [How to reproduce the issue](#how-to-reproduce-the-issue)
  - [Requirements](#requirements)
  - [Expected result](#expected-result)
  - [Demo video](#demo-video)

## Whats the issue?

Looks like Chrome/Chromium have an issue with the `Page.setDownloadBehavior`
development protocol command in combination with the
`always_open_pdf_externally` preference on new windows/tabs. The Chrome/Chromium
process dies suddenly without any logging. Also, no segmentation fault is
logged.

## How to reproduce the issue

You need to set up the Chrome/Chromium session with the specific preferences and
the open a random website. When you click on a link (`target="_blank"` /
`window.open`) to a PDF file you will see the crash.

I also setup this repository to demonstrate the issue and anybody can try to
reproduce it. Just take care of the requirements and run the following commands
to start the example:

```bash
# Install the required gems
$ bundle install

# Start the example
$ bundle exec ruby test.rb
```

### Requirements

* Linux >= 4.15.0
* Google Chrome >=64.0.3282.186
* ChromeDriver >=2.33
* Ruby >=2.4.0
* Bundler >= 1.16.0

### Expected result

The example should keep the Chrome/Chromium process (and window) open for at
least 60 seconds. You should also see the PDF file downloaded to the
`Downloads` directory.

### Demo video

[See the demo video](./demo.webm).
