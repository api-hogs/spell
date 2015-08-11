defmodule Spell.Message do
  use Spell.Web, :model

  schema "messages" do
    field :body, :string
    field :read, :boolean, default: false
    field :recipient_id, :integer
    field :sender_id, :integer

    timestamps
  end

  @required_fields ~w(body read sender_id recipient_id)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

  def between(user_1_id, user_2_id) do
    Spell.Repo.all(
    from m in __MODULE__,
    where: (m.sender_id == ^user_1_id and m.recipient_id == ^user_2_id) or
    (m.sender_id == ^user_2_id and m.recipient_id == ^user_1_id),
    order_by: [asc: :id]
    )
  end
end
