#CreditList

To use this app:

1. clone credit-list from Github
2. change directory (cd) into the directory credit-list,
3. run bundle install
4. run shotgun.
5. If you choose to delete the database and start fresh: (a) delete development.sqlite file, (b) run rake db:migrate

Overview:

This app allows a User to maintain a list of credits in their portfolio with their associated transactions(s).
A credit is unique to a User.  A User will be able to view all Credits in the domain, but will have access to only create, update or view
the credits they own (or created).
The first time a credit is created a transaction must be created at that time.
A credit can not be deleted if there are any associated transactions, you must delete any credit related transactions first.
To edit or delete a credit, select User Credits Only and select a transaction link.
All information related to a Credit and/or Transaction must be entered otherwise creating a Credit and/or Transaction is prohibited.
