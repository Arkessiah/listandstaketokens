Part 1
Challenge: Company’s stakeholders want to get a list of all BAR token (ERC20) transfers where the from OR
the to is part of a given list and have happened over the last X years.
Write a code snippet in your preferred language without using a 3rd party provider (like Alchemy, Moralis, …).
Then describe how you could improve your code by using a modern approach and keeping in mind security,
scalability, maintainability, speed, use of 3rd party tools, etc..

Things that could be taken into account with the code in part 1:
At the Security level: 
- Input parameters could be validated to prevent possible invalid input attacks.
- Access and authorization controls should be implemented to restrict access to this information.
At scalability level:
- We could use paging or batch processing techniques to handle large volumes of events from these transfers.
- It would be advisable to use third party tools such as indexers, for example The Graph, to index and query the events in a more efficient way.
At Maintenance level:
- The code could be organized into reusable functions.
- The code will have to be documented.

---------------------------------------------------------------------------------------------------------------------------------------------------

Part 2
Challenge: The company wants to create a platform where users could stake their tokens. This will allow users
to participate in (vote) different Surveys. When a user stakes some amount of a particular token (ex: BAR) it
gives them the possibility to vote on any survey linked to that token (ie: BAR).
Design an upgradeable smart contracts architecture to tackle this challenge. Consider security risks and
maintainability.
Describe possible improvements. Eventually provide a diagram.


I have coded 4 contracts:

StorageContract: Contains all the addresses of the contracts we will deploy to facilitate the work of the proxy.

ProxyContract: Interacts as an intermediary between the users and the logical contracts whose addresses are stored in the storage contract.

Logical Contracts: StakingContract and SurveyContract contain the logic of the problem and can be updated thanks to the transparent proxy contract and the storage.

