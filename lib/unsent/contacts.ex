defmodule Unsent.Contacts do
  @moduledoc """
  Client for contact operations.
  """

  alias Unsent.Client

  @doc """
  List contacts in a contact book.

  ## Parameters

    * `contact_book_id` - The ID of the contact book
    * `query` - Optional query parameters:
      * `:emails` - Filter by email addresses (comma-separated)
      * `:page` - Page number for pagination
      * `:limit` - Number of items per page
      * `:ids` - Filter by contact IDs (comma-separated)

  ## Examples

      {:ok, contacts} = Unsent.Contacts.list(client, "book_123")
      {:ok, contacts} = Unsent.Contacts.list(client, "book_123", page: 2, limit: 50)
      {:ok, contacts} = Unsent.Contacts.list(client, "book_123", emails: "user1@example.com,user2@example.com")
  """
  def list(client, contact_book_id, query \\ []) do
    params = build_query_params(query, [:emails, :page, :limit, :ids])
    path = build_path("/contactBooks/#{contact_book_id}/contacts", params)
    Client.get(client, path)
  end

  def create(client, book_id, payload) do
    Client.post(client, "/contactBooks/#{book_id}/contacts", payload)
  end

  def get(client, book_id, contact_id) do
    Client.get(client, "/contactBooks/#{book_id}/contacts/#{contact_id}")
  end

  def update(client, book_id, contact_id, payload) do
    Client.patch(client, "/contactBooks/#{book_id}/contacts/#{contact_id}", payload)
  end

  def upsert(client, book_id, contact_id, payload) do
    Client.put(client, "/contactBooks/#{book_id}/contacts/#{contact_id}", payload)
  end

  def delete(client, book_id, contact_id) do
    Client.delete(client, "/contactBooks/#{book_id}/contacts/#{contact_id}")
  end

  # Private helper functions

  defp build_query_params(query, allowed_keys) do
    query
    |> Keyword.take(allowed_keys)
    |> Enum.filter(fn {_k, v} -> v != nil end)
  end

  defp build_path(base_path, []), do: base_path
  defp build_path(base_path, params) do
    query_string = URI.encode_query(params)
    "#{base_path}?#{query_string}"
  end
end
