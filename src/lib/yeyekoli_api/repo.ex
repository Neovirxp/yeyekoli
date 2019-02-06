defmodule YeyekoliApi.Repo do
  use Ecto.Repo,
    otp_app: :yeyekoli_api,
    adapter: Ecto.Adapters.Postgres

  @doc"""
  Dynamically loads the repository url from the
  PG_URL environment variable.
  """
  def init(_, opts) do
    {:ok, Keyword.put(opts, :url, System.get_env("PG_URL"))}
  end

end
