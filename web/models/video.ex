defmodule Rumbl.Video do
  use Rumbl.Web, :model

  schema "videos" do
    field :url, :string
    field :title, :string
    field :description, :string
    belongs_to :user, Rumbl.User
    belongs_to :category, Rumbl.Category

    timestamps()
  end

  @required_fields ~w(url title description)a
  @optional_fields ~w(category_id)a
  # @allowed_fields  ~w(url title description category_id)a , atoms

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(model, params \\ %{}) do
    allowed_fields = @required_fields ++ @optional_fields
    model
    |> cast(params, allowed_fields)
    |> validate_required(@required_fields)
    |> assoc_constraint(:category)
  end
end
