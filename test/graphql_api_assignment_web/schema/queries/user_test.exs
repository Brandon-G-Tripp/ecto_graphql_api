defmodule GraphqlApiAssignmentWeb.Schema.Queries.UserTest do 
  use GraphqlApiAssignment.DataCase, async: true

  alias GraphqlApiAssignmentWeb.Schema
  alias GraphqlApiAssignment.Accounts


  @all_user_doc """
  query AllUsers($likesEmails: Boolean, $likesPhoneCalls: Boolean, $first: Int) {
    users(likesEmails: $likesEmails, likesPhoneCalls: $likesPhoneCalls, first: $first) {
      email
      id
      name
      preference {
        likesEmails
        likesPhoneCalls
      }
    }
  }
  """

  describe "@users" do 
    test "fetches users by preferences" do 
      assert {:ok, user} = Accounts.create_user(%{
        email: "testing@testing.com",
        name: "tester1",
        preference: %{
          likes_phone_calls: true,
          likes_emails: true,
        }
      })

      assert {:ok, %{data: data}} = Absinthe.run(@all_user_doc, Schema, variables: %{
          "likes_emails" => "true",
          "likes_phone_calls" => "true"
        }
      )

      assert List.first(data["users"])["id"] === to_string(user.id)
    end

    test "fetches first x users" do 
      assert {:ok, user} = Accounts.create_user(%{
        email: "testing1@gmail.com",
        name: "tester1",
        preference: %{
          likes_phone_calls: false,
          likes_emails: true,
        }
      })

      assert {:ok, user1} = Accounts.create_user(%{
        email: "testing2@gmail.com",
        name: "tester2",
        preference: %{
          likes_phone_calls: true,
          likes_emails: true,
        }
      })

      assert {:ok, _user2} = Accounts.create_user(%{
        email: "testing3@gmail.com",
        name: "tester3",
        preference: %{
          likes_phone_calls: false,
          likes_emails: false,
        }
      })

      assert {:ok, %{data: data}} = Absinthe.run(@all_user_doc, Schema, 
        variables: %{
          "first" => 2
        }
      )

      assert [user_from_query_1, user_from_query_2] = data["users"]

      assert user_from_query_1["id"] === to_string(user.id)
      assert user_from_query_2["id"] === to_string(user1.id)
    end
  end

  @user_by_id_doc """
  query UserById($id: ID!) {
    user(id: $id) {
      id
      name
      email
      preference {
        likesEmails
        likesPhoneCalls
      }
    }
  }
  """

  describe "@user" do 
    test "fetch a single user by id" do 
      assert {:ok, user} = Accounts.create_user(%{
        email: "tester@testing.com",
        name: "tester",
        preference: %{
          likes_emails: true,
          likes_phone_calls: false
        }
      })

      assert {:ok, %{data: data}} = Absinthe.run(@user_by_id_doc,Schema, 
        variables: %{
          "id" => to_string(user.id)
        }
      )

      assert data["user"]["id"] === to_string(user.id)
    end
  end
end
