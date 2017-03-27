defmodule Rumbl.UserController do
	use Rumbl.Web , :controller
	alias Rumbl.User
	require Logger

	plug :authenticate when action in [:index, :show]

	def index(conn, _params) do
		#IO.puts  inspect conn
		#uid = get_session(conn, :user_id)
		users = Repo.all(Rumbl.User)
		render conn, "index.html", [users: users, uid: get_session(conn, :user_id)]
	end

	def show(conn, %{"id" => id}) do
		user = Repo.get(Rumbl.User, id)
		render conn, "show.html", user: user
	end

	def new(conn, _params) do
		changeset = User.changeset(%User{})
		render conn, "new.html", changeset: changeset
	end

	def create(conn, %{"user" => user_params}) do
		%{:creador => creador} = conn.assigns
		Logger.debug "Creado Por:  #{creador}"
		#text conn, inspect conn
		changeset = User.registration_changeset(%User{},user_params)
		case Repo.insert(changeset) do
			{:ok, user} ->
				conn
				|> Rumbl.Auth.login(user)
		    |> put_flash(:info, "#{user.name} created!")
		    |> redirect(to: user_path(conn, :index))
			{:error, changeset} ->
				render(conn, 	"new.html", changeset: changeset)
		end
	end

	defp authenticate(conn, _opts) do
		if conn.assigns.current_user do
			conn
		else
			conn
			|> put_flash(:error, "Necesita logearse para accesar a esta página")
			|> redirect(to: page_path(conn, :index))
			|> halt()
		end
	end

end
