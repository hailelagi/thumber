defmodule ThumberWeb.ErrorJSONTest do
  use ThumberWeb.ConnCase, async: true

  test "renders 404" do
    assert ThumberWeb.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert ThumberWeb.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
