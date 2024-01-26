defmodule LogWeb.LogController do
  use LogWeb, :controller
  alias Log.Logs

  def index(conn, _params) do
    logs = Logs.count_per_day()
    render(conn, :weekly, date: "", logs: logs)
  end

  def create(conn, params \\ %{}) do
    {:ok, _log} =
      NaiveDateTime.local_now()
      |> to_string()
      |> Logs.create()

    id = if params["date"], do: params["date"], else: ""
    redirect(conn, to: ~p"/" <> id)
  end

  def show(conn, %{"date" => date}) do
    [month, day] =
      String.split_at(date, 2)
      |> Tuple.to_list()
      |> Enum.map(fn x -> String.to_integer(x) end)

    logs = Logs.count_per_hour(month, day)
    render(conn, :daily, date: date, logs: logs)
  end
end
