# This project is a mini API containing a service that provides shipping quotes on FedEx. It is a challenge for some job. Also, this is a personal demonstration of the correct use of the JSON:API module, which is a standard in a professional API and almost nobody uses it.

### Recruiter has required:
"Hello Fernando, Good afternoon.

In the attached mail a collection of postman where is the information that you will need to carry out the challenge.

The challenge consists of the following:
* Make a gem in ruby which allows you to connect to the Fedex webservice and obtain the shipping rates.
* Consume that gem from a small api to which I send the parameters that are necessary to obtain the rates and that api uses the library to obtain the shipping rates.

You send me the repository of the api and the library to review the code and its correct operation, after this we continue in the process.

You can send me the challenge on Friday or Saturday.

Any questions you have, please let me know.

Greetings."

### And he gave me two files (and no more explanations):
* [Fedex_SDK_Ruby.pdf](https://github.com/ferpadron/reto/blob/main/docs/Fedex_SDK_Ruby.pdf)
* [Fedex.postman_collection.json](https://github.com/ferpadron/reto/blob/main/docs/Fedex.postman_collection.json)

### Comment:
* I didn't ask any questions!

## In the end, it is a good opportunity to make my portfolio. Please continue in this project:

* **Uses a brand new private gem created by me called "fedex"**. Together API & GEM get shipping quotes. My gem is at [https://github.com/ferpadron/fedex](https://github.com/ferpadron/fedex)
* Recruiter didn't require it, but, all APIs should use **JSON:API module** => "By following shared conventions, you can increase productivity and take advantage of widespread tools and best practices."
  * I did some demonstrations in controllers clients. You can try:
    * [http://localhost:3000/api/v1/clients](http://localhost:3000/api/v1/clients) get clients and their items in the database
* Uses **ExceptionHandler gem** to catch errors 4XX and 5XX. It normally uses views, but an Rails API does not have views, so I did the correct adaptation to send only mails to developer's team.
  * Internally through the code, I catch all possible errors to improve the UX. This handling is only to enforce new implementations or new functionalities and detect external problems.
  * In addition to avoiding views, **I did several improvements to this gem overriding** their normal work on its controller, model and email template.
* Uses **Minitest gem** as unit testing framework. It provides a rich set of assertions to make the tests clean and readable.
  * I don't use fixtures, but use the same **db/seeds.rb file** as in development mode to keep initialization simpler, speaking of associations.
* Uses **SimpleCov gem** to do a efficient test coverage analysis.
* Uses **RuboCop gem** to get the best quality in code creation. I love and try to do poems with my code.
* The database engine is **Sqlite3**.
* Uses **credentials** per each environment to hide sensitive data such as passwords, keys, and secrets.
* Uses AWS SES for email sending. Email sending is used by ExceptionHandler gem only.


* In summary, **this project is a compendium of best practices in creating APIs**.

## Ruby and rails versions:
```
ruby 3.1.2p20
rails 7.0.3
```

## First step, clone the repository
```git clone https://github.com/ferpadron/reto.git```

## Configuration
Passwords and other sensitive data are encrypted, to setup your local environments follow steps below:
### Rails Environments

### Improving your 'development' rails environment
* First, generate a 'secret key base' string:

```
bundle exec rake secret
```
- Copy the secret_key
* Run:
```
  EDITOR=nano rails credentials:edit --environment development
```
* This task will create ```config/credentials/development.yml.enc``` with the new encryption key in ```config/credentials/development.key```
* Hints
  * [**Open a FedEx account**](https://weblets.dmz.apac.fedex.com/BaC/jp/en/account) at [https://weblets.dmz.apac.fedex.com/BaC/jp/en/account](https://weblets.dmz.apac.fedex.com/BaC/jp/en/account)
* Now, SET/search your own passwords, keys and secrets and fill the file with this info:
```
fedex:
  key: <your own data, from fedex account>
  password: <your own data, from fedex account>
  account_number: <your own data, from fedex account>
  meter_number: <your own data, from fedex account>

cors:
  origins: <your own data, or simply asterisk with single quotes to allow all: '*'>

smtp:
  address: <your own data, can be gmail smtp.gmail.com, I use AWS SES>
  domain: <any value as example.com>
  user_name: <your own data, can be gmail user name account>
  password: <your own data, can be gmail password account>

# Used as the base secret for all MessageVerifiers in Rails, including the one protecting cookies.
secret_key_base: REPLACE_THIS_STRING_with_your_secret_key_base__f9b9b8e4ae3ba771aad9791c0b7d092961f2f419b0f3d348dcb6fee8
```

### Test environment
Almost same procedure, come on!
* First and again, generate a 'secret key base' string:

```
bundle exec rake secret
```
- Copy the secret_key

* Run:
```
  EDITOR=nano rails credentials:edit --environment test
```
* This task will create ```config/credentials/test.yml.enc``` with the new encryption key in ```config/credentials/test.key```
* Then, fill the file with same above info ('smtp' is skipped since the **test environment** doesn't send emails):
```
fedex:
  key: <same as above>
  password: <same as above>
  account_number: <same as above>
  meter_number: <same as above>

cors:
  origins: <same as above, or simply '*'>

# Used as the base secret for all MessageVerifiers in Rails, including the one protecting cookies.
secret_key_base: REPLACE_THIS_STRING_with_your_secret_key_base__f9b9b8e4ae3ba771aad9791c0b7d092961f2f419b0f3d348dcb6fee8
```

## Next step, run:
```bundle install```

## Next, Database creation:
```rails db:drop db:create```

## Next, Database initialization:
```rails db:migrate db:seed```

## How to run the test suite (optional):
```rails test```

## Next, How to run the application:
```rails s```

### TO GET FEDEX QUOTES using this API (original challenge), in a browser type [http://localhost:3000](http://localhost:3000)
* This project is prepared to work without parameters. It takes some default values, or 'in a real-life', you can try:
* [http://localhost:3000/api/v1/fedex_quotes?client_id=1&item_no=2&zip=06500&country=MX](http://localhost:3000/api/v1/fedex_quotes?client_id=1&item_no=2&zip=06500&country=MX)
  * Where **client_id** can be 1 to 4 according db/seeds.file (other value gives error, try it).
  * **item_no** can be 1 or 2 (every client has two items). This number is a fake product in database. (other value gives error, try it).
  * **zip** is the zip of the buyer or recipient of the package.
  * **country** is the country in two letters of the buyer or recipient of the package.
  * Finally, you can skip any parameter and the application will replace it with a default value.
### My personal demonstrations about JSON:API MODULE:
  * [http://localhost:3000/api/v1/clients?page=1&per_page=2&f=name&q=KARLA&order=name](http://localhost:3000/api/v1/clients?page=1&per_page=2&f=name&q=KARLA&order=name)
    * Get clients and their items in the database.
    * Set page, per_page. Response includes links of pagination useful to Frontend side.
    * To filter/search provide parameters 'f' and 'q', where:
      * 'f' parameter can be one of: ["id", "name", "kind", "zip", "country", "created_at", "updated_at"]
      * 'q' parameter should be a valid value
      * The response for this sample: ```f=zip&q=97000``` will be **Client: "Sophie Kenneth"**
    * And set an order (name, zip, country). If you not set an order ID order is provided.
### TEST COVERAGE (Code coverage analysis) through SimpleCov gem
* Run ```rails test``` from root directory
* In your Internet browser, type ```file:///<ROOT_DIRECTORY>/coverage/index.html#_AllFiles``` to open the report.
  * In my case: ```file:///Users/fer/projects/ruby3/reto/coverage/index.html#_AllFiles```
* **OR**
  * After running your tests:
    * **In a Mac Terminal**, run the following command from your application's root directory:
      * ```open coverage/index.html```
    * **In a debian/ubuntu Terminal**:
      * ```xdg-open coverage/index.html```
* Browse by clicking on the file names!

## I'm Fer and I say THANK YOU!
