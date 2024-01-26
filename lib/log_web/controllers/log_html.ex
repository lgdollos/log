defmodule LogWeb.LogHTML do
  use LogWeb, :html

  embed_templates "/*"

  def logo(assigns) do
    ~H"""
    <div class="self-center text-light text-gray-400 tracking-tighter font-mono border-2 border-gray-400 px-[0.3rem] rounded">
      <a href="/">LOG</a>
    </div>

    <%!-- see app.js for js keydown fn --%>
    <.simple_form for={%{}} action={~p"/" <> @date}>
      <.button id={@lol} type="submit" class="hidden"></.button>
    </.simple_form>
    """
  end

  @doc """
  Route: '/'
  Input: %{month, day, count}
  """
  def weekly(assigns) do
    ~H"""
    <div class="flex flex-col justify-center mt-16">
      <.logo lol="logo" date={@date} />
      <div
        :for={log <- @logs}
        class="flex flex-row self-center content-start m-4 justify-items-start w-48"
      >
        <div class={first_item?(@logs, log) <> " mr-4 text-m text-right font-mono pt-3 tracking-tighter"}>
          <%= convert_month(log.month) %> <%= left_pad(log.day) %>
        </div>

        <div class={first_item?(@logs, log) <> " text-7xl text-left font-sans tracking-tighter"}>
          <a href={"/" <> left_pad(log.month) <> left_pad(log.day)}>
            <%= left_pad(log.count) %>
          </a>
        </div>
      </div>
    </div>
    """
  end

  @doc """
  Route: '/<MMDD>'
  Input: %{month, day, hour, count}
  """
  def daily(assigns) do
    ~H"""
    <div class="flex flex-col justify-center mt-16">
      <.logo lol="logo" date={@date} />
      <div
        :for={log <- @logs}
        class="flex flex-row self-center content-start m-4 justify-items-start w-44"
      >
        <div class={ first_item?(@logs, log) <> " mr-4 text-m text-right font-mono pt-3 tracking-tighter"}>
          <%= convert_hour(log.hour) %>
        </div>
        <div class={ first_item?(@logs, log) <> " text-7xl text-left font-sans tracking-tighter"}>
          <%= left_pad(log.count) %>
        </div>
      </div>
    </div>
    """
  end

  defp convert_month(month) when is_integer(month) do
    case month do
      1 -> "JAN"
      2 -> "FEB"
      3 -> "MAR"
      4 -> "APR"
      5 -> "MAY"
      6 -> "JUN"
      7 -> "JUL"
      8 -> "AUG"
      9 -> "SEP"
      10 -> "OCT"
      11 -> "NOV"
      12 -> "DEV"
      _ -> ""
    end
  end

  defp convert_hour(hr) do
    cond do
      hr > 12 -> left_pad(hr - 12) <> " PM"
      hr == 12 -> "12 NN"
      hr == 0 -> "12 AM"
      hr < 12 -> left_pad(hr) <> " AM"
    end
  end

  defp left_pad(day) do
    day
    |> to_string()
    |> String.pad_leading(2, "0")
  end

  defp first_item?(logs, log) do
    if hd(logs) == log, do: "text-gray-800 mb-12", else: "text-gray-300"
  end
end
