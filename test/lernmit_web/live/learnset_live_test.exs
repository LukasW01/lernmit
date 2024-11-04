defmodule LernmitWeb.LearnsetLiveTest do
  use LernmitWeb.ConnCase

  import Phoenix.LiveViewTest
  import Lernmit.LearnsetsFixtures

  @create_attrs %{title: "some title", desc: "some desc"}
  @update_attrs %{title: "some updated title", desc: "some updated desc"}
  @invalid_attrs %{title: nil, desc: nil}

  defp create_learnset(_) do
    learnset = learnset_fixture()
    %{learnset: learnset}
  end

  describe "Index" do
    setup [:create_learnset]

    test "lists all learnset", %{conn: conn, learnset: learnset} do
      {:ok, _index_live, html} = live(conn, ~p"/learnset")

      assert html =~ "Listing Learnset"
      assert html =~ learnset.title
    end

    test "saves new learnset", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/learnset")

      assert index_live |> element("a", "New Learnset") |> render_click() =~
               "New Learnset"

      assert_patch(index_live, ~p"/learnset/new")

      assert index_live
             |> form("#learnset-form", learnset: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#learnset-form", learnset: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/learnset")

      html = render(index_live)
      assert html =~ "Learnset created successfully"
      assert html =~ "some title"
    end

    test "updates learnset in listing", %{conn: conn, learnset: learnset} do
      {:ok, index_live, _html} = live(conn, ~p"/learnset")

      assert index_live |> element("#learnset-#{learnset.id} a", "Edit") |> render_click() =~
               "Edit Learnset"

      assert_patch(index_live, ~p"/learnset/#{learnset}/edit")

      assert index_live
             |> form("#learnset-form", learnset: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#learnset-form", learnset: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/learnset")

      html = render(index_live)
      assert html =~ "Learnset updated successfully"
      assert html =~ "some updated title"
    end

    test "deletes learnset in listing", %{conn: conn, learnset: learnset} do
      {:ok, index_live, _html} = live(conn, ~p"/learnset")

      assert index_live |> element("#learnset-#{learnset.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#learnset-#{learnset.id}")
    end
  end

  describe "Show" do
    setup [:create_learnset]

    test "displays learnset", %{conn: conn, learnset: learnset} do
      {:ok, _show_live, html} = live(conn, ~p"/learnset/#{learnset}")

      assert html =~ "Show Learnset"
      assert html =~ learnset.title
    end

    test "updates learnset within modal", %{conn: conn, learnset: learnset} do
      {:ok, show_live, _html} = live(conn, ~p"/learnset/#{learnset}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Learnset"

      assert_patch(show_live, ~p"/learnset/#{learnset}/show/edit")

      assert show_live
             |> form("#learnset-form", learnset: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#learnset-form", learnset: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/learnset/#{learnset}")

      html = render(show_live)
      assert html =~ "Learnset updated successfully"
      assert html =~ "some updated title"
    end
  end
end
