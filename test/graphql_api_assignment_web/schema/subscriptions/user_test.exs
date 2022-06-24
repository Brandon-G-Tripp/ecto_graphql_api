defmodule GraphqlApiAssignmentWeb.Schema.Subscriptions.UserTest do 
  use GraphqlApiAssignmentWeb.SubscriptionCase, async: true

  alias GraphqlApiAssignment.Accounts

  @update_user_pref_doc """
  mutation UpdateUserPreference($userId: ID!, $likesEmails: Boolean, $likesPhoneCalls: Boolean) {
    updateUserPreference(userId: $userId, likesEmails: $likesEmails, likesPhoneCalls: $likesPhoneCalls) {
      likesEmails
      likesPhoneCalls
      userId
    }
  }
  """

  @updated_user_pref_sub_doc """
  subscription UpdatedUserPreference($userId: ID!) {
    updatedUserPreference(userId: $userId) {
      likesPhoneCalls
      likesEmails
      userId
    }
  }
  """

  describe "@updatedUserPreference" do 
    test "sends a preference when @updateUserPreference mutation is triggered", %{socket: socket} do 
      assert {:ok, user} = Accounts.create_user(%{
        name: "test",
        email: "test@test.com",
        preference: %{
          likes_emails: true,
          likes_phone_calls: false
        }
      })

      updated_pref_emails = false
      updated_pref_phone_calls = true
      user_id = user.id

      ref = push_doc socket, @updated_user_pref_sub_doc,
        variables: %{userId: user_id}

      assert_reply ref, :ok, %{subscriptionId: subscription_id}

      ref = push_doc socket, @update_user_pref_doc, variables: %{
        "userId" => user_id,
        "likesEmails" => updated_pref_emails,
        "likesPhoneCalls" => updated_pref_phone_calls
      }

      assert_reply ref, :ok, reply

      user_id_string = to_string(user_id)
      
      assert %{
        data: %{"updateUserPreference" => %{
          "userId" => ^user_id_string,
          "likesEmails" => ^updated_pref_emails,
          "likesPhoneCalls" => ^updated_pref_phone_calls
        }}
      } = reply

      assert_push "subscription:data", data

      assert %{
        subscriptionId: ^subscription_id,
        result: %{
          data: %{
            "updatedUserPreference" => %{
              "userId" => ^user_id_string,
              "likesEmails" => ^updated_pref_emails,
              "likesPhoneCalls" => ^updated_pref_phone_calls
            }
          }
        }
      } = data
    end
  end

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

  @created_user_sub_doc """
  subscription CreatedUser {
    createdUser {
      email
      id
      name
      preference {
        likesPhoneCalls
        likesEmails
      }
    }
  }
  """
  describe "@createdUser" do 
    test "sends a user when @createUser mutation is triggered", %{
      socket: socket
    } do 

      ref = push_doc socket, @created_user_sub_doc

      assert_reply ref, :ok, %{subscriptionId: subscription_id}
      
      ref = push_doc socket, @create_user_doc, variables: %{
        "name" => "test",
        "email" => "test@test.com",
        "preference" => %{
          "likesPhoneCalls" => true,
          "likesEmails" => false
        }
      }

      assert_reply ref, :ok, reply
      %{data: %{"createUser" => %{"id" => user_id}}} = reply

      assert %{
        data: %{"createUser" => %{
          "name" => "test",
          "email" => "test@test.com",
          "preference" => %{
            "likesPhoneCalls" => true,
            "likesEmails" => false
          }
        }}
      } = reply

      assert_push "subscription:data", data

      assert %{
        subscriptionId: ^subscription_id,
        result: %{
          data: %{"createdUser" => %{
            "id" => ^user_id,
            "name" => "test",
            "email" => "test@test.com",
            "preference" => %{
              "likesPhoneCalls" => true,
              "likesEmails" => false
            }
          }}
        }
      } = data
    end
  end
end
