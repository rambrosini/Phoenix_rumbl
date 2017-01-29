defmodule Rumbl.Repo do
  use Ecto.Repo, otp_app: :rumbl

  @moduledoc """
  In memory repository.
  
  def all(Rumbl.User) do
  	[%Rumbl.User{id: "1", name: "José", username: "josevalim", password: "elixir"},
     %Rumbl.User{id: "2", name: "Bruce", username: "redrapids", password: "7langs"},
     %Rumbl.User{id: "3", name: "Chris", username: "chrismccord", password: "phx"}]
  end
  def all(_module), do: []

  def get(module, id) do
  	Enum.find all(module), fn x -> x.id == id end
  end

  def get_by(module, params) do
  	Enum.find all(module), fn record -> 
  		Enum.all?(params, fn {k,v} -> Map.get(record,k) == v  end)
  		end 
  end
  """
  
end
