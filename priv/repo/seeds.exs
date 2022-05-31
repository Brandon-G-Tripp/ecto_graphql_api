# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     GraphqlApiAssignment.Repo.insert!(%GraphqlApiAssignment.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
#
import Ecto.Query

alias GraphqlApiAssignment.Accounts.User
alias GraphqlApiAssignment.Accounts.Preference
alias GraphqlApiAssignment.Repo

GraphqlApiAssignment.Repo.delete_all(GraphqlApiAssignment.Accounts.Preference)
GraphqlApiAssignment.Repo.delete_all(GraphqlApiAssignment.Accounts.User)
now = NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)

Repo.insert! %User{
  name: "Bill",
  email: "bill@gmail.com",
  preference: 
    %Preference{
      likes_emails: false,
      likes_phone_calls: false,
    },
}

Repo.insert! %User{
    name: "Alice",
    email: "alice@gmail.com",
    preference: 
      %Preference{
        likes_emails: true,
        likes_phone_calls: true,
      },
}

Repo.insert! %User{
    name: "Jill",
    email: "jill@hotmail.com",
    preference: 
      %Preference{
        likes_emails: true,
        likes_phone_calls: false,
      },
}

Repo.insert! %User{
    name: "Tim",
    email: "tim@gmail.com",
    preference: 
      %Preference{
        likes_emails: false,
        likes_phone_calls: true,
      }
  }


