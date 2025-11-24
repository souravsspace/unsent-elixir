# Unsent Elixir SDK

Official Elixir SDK for the [Unsent API](https://unsent.dev) - Send transactional emails with ease.

## Prerequisites

- [Unsent API key](https://app.unsent.dev/dev-settings/api-keys)
- [Verified domain](https://app.unsent.dev/domains)
- Elixir 1.14 or higher

## Installation

Add `unsent` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:unsent, "~> 1.0.1"}
  ]
end
```

## Usage

### Basic Setup

```elixir
client = Unsent.new("us_12345")
```

### Environment Variables

You can also set your API key using environment variables:

```elixir
# Set UNSENT_API_KEY in your environment
# Then initialize without passing the key
client = Unsent.new()
```

### Sending Emails

#### Simple Email

```elixir
{:ok, data} = Unsent.Emails.send(client, %{
  to: "hello@acme.com",
  from: "hello@company.com",
  subject: "Unsent email",
  html: "<p>Unsent is the best email service provider to send emails</p>",
  text: "Unsent is the best email service provider to send emails"
})

IO.inspect(data, label: "Email sent")
```

#### Email with Attachments

```elixir
{:ok, data} = Unsent.Emails.send(client, %{
  to: "hello@acme.com",
  from: "hello@company.com",
  subject: "Email with attachment",
  html: "<p>Please find the attachment below</p>",
  attachments: [
    %{
      filename: "document.pdf",
      content: "base64-encoded-content-here"
    }
  ]
})
```

#### Scheduled Email

```elixir
scheduled_time = DateTime.utc_now() |> DateTime.add(1, :hour)

{:ok, data} = Unsent.Emails.send(client, %{
  to: "hello@acme.com",
  from: "hello@company.com",
  subject: "Scheduled email",
  html: "<p>This email was scheduled</p>",
  scheduledAt: scheduled_time
})
```

#### Batch Emails

```elixir
emails = [
  %{
    to: "user1@example.com",
    from: "hello@company.com",
    subject: "Hello User 1",
    html: "<p>Welcome User 1</p>"
  },
  %{
    to: "user2@example.com",
    from: "hello@company.com",
    subject: "Hello User 2",
    html: "<p>Welcome User 2</p>"
  }
]

{:ok, data} = Unsent.Emails.batch(client, emails)
IO.puts("Sent #{length(data["data"])} emails")
```

#### Idempotent Retries

```elixir
# Idempotent retries: same payload + same key returns the original response
payload = %{
  to: "hello@acme.com",
  from: "hello@company.com",
  subject: "Welcome!",
  html: "<p>Welcome to our service</p>"
}

{:ok, data} = Unsent.Emails.send(
  client,
  payload,
  headers: [{"Idempotency-Key", "signup-123"}]
)

# Works for batch requests as well
batch_payload = [
  # ... items
]

{:ok, data} = Unsent.Emails.batch(
  client,
  batch_payload,
  headers: [{"Idempotency-Key", "bulk-welcome-1"}]
)

# If the same key is reused with a different payload, the API responds with HTTP 409.
```

### Managing Emails

#### Get Email Details

```elixir
{:ok, email} = Unsent.Emails.get(client, "email_id")
IO.puts("Email status: #{email["status"]}")
```

#### Update Email

```elixir
{:ok, data} = Unsent.Emails.update(client, "email_id", %{
  subject: "Updated subject",
  html: "<p>Updated content</p>"
})
```

#### Cancel Scheduled Email

```elixir
{:ok, _} = Unsent.Emails.cancel(client, "email_id")
IO.puts("Email cancelled successfully")
```

### Managing Contacts

#### Create Contact

```elixir
{:ok, contact} = Unsent.Contacts.create(client, "contact_book_id", %{
  email: "user@example.com",
  firstName: "John",
  lastName: "Doe",
  metadata: %{
    company: "Acme Inc",
    role: "Developer"
  }
})
```

#### Get Contact

```elixir
{:ok, contact} = Unsent.Contacts.get(client, "contact_book_id", "contact_id")
```

#### Update Contact

```elixir
{:ok, contact} = Unsent.Contacts.update(client, "contact_book_id", "contact_id", %{
  firstName: "Jane",
  metadata: %{
    role: "Senior Developer"
  }
})
```

#### Upsert Contact

```elixir
# Creates if doesn't exist, updates if exists
{:ok, contact} = Unsent.Contacts.upsert(client, "contact_book_id", "contact_id", %{
  email: "user@example.com",
  firstName: "John",
  lastName: "Doe"
})
```

#### Delete Contact

```elixir
{:ok, _} = Unsent.Contacts.delete(client, "contact_book_id", "contact_id")
```

### Managing Campaigns

#### Create Campaign

```elixir
{:ok, campaign} = Unsent.Campaigns.create(client, %{
  name: "Welcome Series",
  subject: "Welcome to our service!",
  html: "<p>Thanks for joining us!</p>",
  from: "welcome@example.com",
  contactBookId: "cb_1234567890"
})

IO.puts("Campaign created! ID: #{campaign["id"]}")
```

#### Schedule Campaign

```elixir
{:ok, _} = Unsent.Campaigns.schedule(client, campaign["id"], %{
  scheduledAt: "2024-12-01T10:00:00Z"
})
```

#### Pause/Resume Campaigns

```elixir
# Pause a campaign
{:ok, _} = Unsent.Campaigns.pause(client, "campaign_123")

# Resume a campaign
{:ok, _} = Unsent.Campaigns.resume(client, "campaign_123")
```

#### Get Campaign Details

```elixir
{:ok, campaign} = Unsent.Campaigns.get(client, "campaign_id")
IO.puts("Campaign status: #{campaign["status"]}")
```

### Managing Domains

#### List Domains

```elixir
{:ok, domains} = Unsent.Domains.list(client)
Enum.each(domains, fn domain ->
  IO.puts("Domain: #{domain["domain"]}, Status: #{domain["status"]}")
end)
```

#### Create Domain

```elixir
{:ok, domain} = Unsent.Domains.create(client, %{
  domain: "example.com"
})
```

#### Verify Domain

```elixir
{:ok, result} = Unsent.Domains.verify(client, 123)
IO.puts("Verification status: #{result["status"]}")
```

#### Get Domain

```elixir
{:ok, domain} = Unsent.Domains.get(client, 123)
```

## Error Handling

The SDK returns `{:ok, data}` on success and `{:error, error}` on failure.

```elixir
case Unsent.Emails.send(client, payload) do
  {:ok, data} ->
    IO.puts("Success: #{data["id"]}")
  {:error, error} ->
    IO.puts("Error: #{error.message}")
end
```

## License

MIT

## Support

- [Documentation](https://docs.unsent.dev)
- [GitHub Issues](https://github.com/souravsspace/unsent-elixir/issues)
- [Discord Community](https://discord.gg/unsent)

