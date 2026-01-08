defmodule Unsent.ContactBooks do
  @moduledoc """
  Client for contact book management operations.
  """

  alias Unsent.Client

  @doc """
  Retrieve all contact books.

  ## Examples

      {:ok, contact_books} = Unsent.ContactBooks.list(client)
  """
  def list(client) do
    Client.get(client, "/contactBooks")
  end

  @doc """
  Create a new contact book.

  ## Parameters

    * `payload` - Map containing contact book details

  ## Examples

      {:ok, book} = Unsent.ContactBooks.create(client, %{
        name: "Newsletter Subscribers"
      })
  """
  def create(client, payload) do
    Client.post(client, "/contactBooks", payload)
  end

  @doc """
  Get a specific contact book by ID.

  ## Examples

      {:ok, book} = Unsent.ContactBooks.get(client, "book_123")
  """
  def get(client, id) do
    Client.get(client, "/contactBooks/#{id}")
  end

  @doc """
  Update a contact book.

  ## Parameters

    * `id` - Contact book ID
    * `payload` - Map containing fields to update

  ## Examples

      {:ok, book} = Unsent.ContactBooks.update(client, "book_123", %{
        name: "Updated Newsletter Subscribers"
      })
  """
  def update(client, id, payload) do
    Client.patch(client, "/contactBooks/#{id}", payload)
  end

  @doc """
  Delete a contact book by ID.

  ## Examples

      {:ok, _} = Unsent.ContactBooks.delete(client, "book_123")
  """
  def delete(client, id) do
    Client.delete(client, "/contactBooks/#{id}")
  end
end
