defmodule SimpleChat.Chat.Message do
  use Ecto.Schema
  import Ecto.Changeset

  schema "messages" do
    field :content, :string
    belongs_to :user, SimpleChat.Accounts.User  # Adjust this line if your User schema is located elsewhere

    timestamps(type: :utc_datetime)
  end

  @spec changeset(
          {map(), map()}
          | %{
              :__struct__ => atom() | %{:__changeset__ => any(), optional(any()) => any()},
              optional(atom()) => any()
            },
          :invalid | %{optional(:__struct__) => none(), optional(atom() | binary()) => any()}
        ) :: Ecto.Changeset.t()
  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:content, :user_id])
    |> validate_required([:content, :user_id])
  end
end
