defmodule GraphqlApiAssignmentWeb.Schema.Queries.ResolverHitsTest do 
  use GraphqlApiAssignment.DataCase

  alias GraphqlApiAssignmentWeb.Schema
  alias GraphqlApiAssignment.Accounts

  @user_query_doc """
  query UserQuery($id: ID!) {
    user(id: $id) {
      id
      name
      preference {
        likesEmails
        likesPhoneCalls
      }
    }
  }
  """

  @resolver_hits_doc """
  query ResolverHitsQuery($key: String!) {
    resolverHits(key: $key) {
      key
      queryHits
    }
  }
  """

  describe "@resolverHits" do
    test "records hits from user query" do 
      assert {:ok, user} = Accounts.create_user(%{
        email: "testing@testing.com",
        name: "tester1",
        preference: %{
          likes_phone_calls: true,
          likes_emails: true,
        }
      })

      assert {:ok, %{data: data}} = Absinthe.run(
        @resolver_hits_doc,
        Schema,
        variables: %{"key" => "user"}
      )

      %{"resolverHits" => %{
        "key" => key,
        "queryHits" => queryHits
        }
      } = data

      assert {:ok, _resp} = Absinthe.run(
        @user_query_doc,
        Schema,
        variables: %{"id" => user.id}
      )

      assert {:ok, %{data: data}} = Absinthe.run(
        @resolver_hits_doc,
        Schema,
        variables: %{"key" => "user"}
      )

      %{"resolverHits" => %{
        "key" => _key,
        "queryHits" => queryHits_after_query
        }
      } = data

      assert queryHits + 1 === queryHits_after_query


    end
  end
end
