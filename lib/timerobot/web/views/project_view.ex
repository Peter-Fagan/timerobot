defmodule Timerobot.Web.ProjectView do
  use Timerobot.Web, :view

  def person_dailies(beginning_of_week, person_times) do
    0..6
    |> Enum.map(fn(day_offset) ->
      day = Timex.shift(beginning_of_week, days: day_offset)
      hours =
        person_times
        |> Enum.filter(&(elem(&1, 0) == day))
        |> Enum.reduce(0, &(elem(&1, 2) + &2))
      {day, hours}
    end)
  end

  def calculate_totals(times) do
    times
    |> Enum.reduce(0, fn({_date, _entry, hours}, sum) -> sum + hours end)
  end

  def daily_hours(beginning_of_week, times) do
    0..6
    |> Enum.map(fn(day_offset) ->
      day = Timex.shift(beginning_of_week, days: day_offset)
      hours =
        times
        |> Enum.filter(fn({date, _entry, _hours}) -> date == day end)
        |> Enum.reduce(0, fn({_date, _entry, hours}, sum) -> sum + hours end)
      {day, hours}
    end)
  end
end
