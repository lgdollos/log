defmodule Log.Logs do
  use Ecto.Schema
  import Ecto.Query
  alias Log.Repo
  alias Log.Logs

  schema "logs" do
    field :log, :string
    field :year, :integer
    field :month, :integer
    field :day, :integer
    field :hour, :integer
    timestamps()
  end

  ##### CONTEXT #####

  def create(log \\ []) do
    ndt = NaiveDateTime.local_now()

    new = %Logs{
      log: log,
      year: ndt.year,
      month: ndt.month,
      day: ndt.day,
      hour: ndt.hour
    }

    Repo.insert(new)
  end

  def read do
    Repo.all(Logs)
  end

  def count_per_day() do
    Logs
    |> where([l], not is_nil(l.month))
    |> group_by([l], [l.year, l.month, l.day])
    |> select([l], %{month: l.month, day: l.day, count: count(l.log)})
    |> order_by([l], desc: l.year, desc: l.month, desc: l.day)
    |> limit(7)
    |> Repo.all()
  end

  def count_per_hour(m, d) do
    query =
      from l in Logs,
        where: not is_nil(l.month),
        where: l.month == ^m and l.day == ^d,
        group_by: [l.month, l.day, l.hour],
        select: %{month: l.month, day: l.day, hour: l.hour, count: count(l.log)},
        order_by: [desc: l.hour]

    Repo.all(query)
  end
end
