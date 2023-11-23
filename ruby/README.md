# Gilded Rose starting position in Ruby

## О реализации задачи

* Подключил bundler, остальные пункты оставил как есть.
* Историю в git не чистил, чтобы было видно как происходил рефакторинг
* Файловую структуру менять не стал, т.к. не было в ТЗ
* В ТЗ есть неоднозначности
  ```markdown
    - Качество «Backstage passes» также, как и «Aged Brie», увеличивается по мере приближения к сроку хранения.
      Качество увеличивается на 2, когда до истечения срока хранения 10 или менее дней и на 3,
      если до истечения 5 или менее дней. При этом качество падает до 0 после даты проведения концерта.
  ```
* К сожалению, последние два месяца я тратил больше времени на отклики, а не самообучение и кодинг
* Тесты по expired делать не стал, но нужно добавить

## Installation

## Run the unit tests from the Command-Line

Ensure you have RSpec installed

    gem install rspec

```
ruby gilded_rose_spec.rb
```

## Run the TextTest fixture from the Command-Line

For e.g. 10 days:

```
ruby texttest_fixture.rb 10
```

You should make sure the command shown above works when you execute it in a terminal before trying to use TextTest (see below).

## Run the TextTest approval test that comes with this project

There are instructions in the [TextTest Readme](../texttests/README.md) for setting up TextTest. You will need to specify the Ruby executable and interpreter in [config.gr](../texttests/config.gr). Uncomment these lines:

    executable:${TEXTTEST_HOME}/ruby/texttest_fixture.rb
    interpreter:ruby
