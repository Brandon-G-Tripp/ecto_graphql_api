defmodule GraphqlApiAssignmentWeb.Schema.Mutations.UserTest do 
  use GraphqlApiAssignment.DataCase, async: true

  alias GraphqlApiAssignmentWeb.Schema
  alias GraphqlApiAssignment.Accounts
  alias EctoShorts.Actions
  alias GraphqlApiAssignment.Accounts.Preference
  alias GraphqlApiAssignment.Accounts.User

  @create_user_doc """
  mutation CreateUser (
    $email: String!, 
    $name: String!, 
    $preference: UserPreferenceInput!
  ){
    createUser (
      email: $email, 
      name: $name, 
      preference: $preference
    ) {
      email 
      name
      id
      preference {
        likesPhoneCalls
        likesEmails
      }
    }
  }
  """

  describe "createUser" do 
    test "creates a user" do 
      users = Accounts.all
      assert length(users) === 0

      assert {:ok, %{data: data}} = Absinthe.run(@create_user_doc,
        Schema, 
        variables: %{
          "email" => "test@test.com",
          "name" => "test",
          "preference" => %{
            "likesEmails" => true,
            "likesPhoneCalls" => false
          }
        }
      )

      result = data["createUser"]
      name = result["name"]
      email = result["email"]
      id = result["id"]

      users = Accounts.all
      assert length(users) === 1

      {:ok, user}= Actions.find(User, %{id: id})

      assert name === user.name
      assert email === user.email
    end
  end

  @update_user_doc """
  mutation UpdateUser($id: ID!, $name: String, $email: String) {
    updateUser(id: $id, name: $name, email: $email) {
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

  describe "@updateUser" do 
    test "updates a user by id" do 
      assert {:ok, user} = Accounts.create_user(%{
        email: "testing@testing.com", 
        name: "tester1",
        preference: %{
          likes_emails: true,
          likes_phone_calls: false
        }
      })

      updated_name = "tester1_updated"
      updated_email = "testing_updated@testing.com"

      assert {:ok, %{data: data}} = Absinthe.run(@update_user_doc, Schema,
        variables: %{
          "id" => user.id,
          "name" => updated_name,
          "email" => updated_email
        }
      )

      update_user_res = data["updateUser"]

      assert update_user_res["name"] === updated_name
      assert update_user_res["email"] === updated_email

      assert {:ok, %{
        name: ^updated_name,
        email: ^updated_email
      }} = Accounts.find(%{id: user.id})

    end
  end

  @update_user_preference_doc """
  mutation  UpdateUserPreferenceMutation($userId: ID!, $likesEmails: Boolean, $likesPhoneCalls: Boolean) {
    updateUserPreference(userId: $userId, likesPhoneCalls: $likesPhoneCalls, likesEmails: $likesEmails) {
      likesEmails
      likesPhoneCalls
    }
  }
  """

  describe "@updateUserPreference" do 
    test "update preferences of a user" do 
      assert {:ok, user2} = Accounts.create_user(%{
        email: "testing2@testing.com", 
        name: "tester2",
        preference: %{
          likes_emails: false,
          likes_phone_calls: false
        }
      })

      user_id = to_string(user2.id)

      {:ok, pref} = Actions.find(Preference, %{"user_id" => user_id})

      assert pref.likes_emails === false
      assert pref.likes_phone_calls === false

      updated_likes_emails = true
      updated_likes_phone_calls = true

      assert {:ok,%{data: data}} = Absinthe.run(@update_user_preference_doc, Schema,
        variables: %{
          "userId" => user2.id,
          "likesEmails" => updated_likes_emails,
          "likesPhoneCalls" => updated_likes_phone_calls
        }
      )

      assert %{
        "updateUserPreference" => %{
          "likesEmails" => ^updated_likes_emails,
          "likesPhoneCalls" => ^updated_likes_phone_calls,
        }
      } = data


      {:ok, updated_pref} = Actions.find(Preference, %{"user_id" => user_id})

      assert updated_pref.likes_emails === updated_likes_emails
      assert updated_pref.likes_phone_calls === updated_likes_phone_calls
    end
  end
end
