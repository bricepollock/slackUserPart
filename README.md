# Slack User Party
A sample iOS application that displays a list of users and displays their profile. The app will additionally work offline through some basic caching functionality.

Notable features include:
* Modular UI design with focus on keeping only layout code in UI objects like table view cells or view controllers
* A generic data layer created using composition and Single Responsibility principles that seperates responsibilities for caching logic, network or persistence into their own objects. This also allows swaping out their implementations or frameworks much easier in the future
* A decoupled architecture that puts business logic into highly testable classes or extensions
* A suite of tests targeted at things that are easy to test and fast to complete

== Note ==
This app will not work out of the box. Please add a file called Secrets.swift defining "slackSecretToken" whose value will correspond to your Slack API Token.



