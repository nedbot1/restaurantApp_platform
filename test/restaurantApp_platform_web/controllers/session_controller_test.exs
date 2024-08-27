defmodule RestaurantAppPlatformWeb.SessionControllerTest do
  use RestaurantAppPlatformWeb.ConnCase

  import RestaurantAppPlatform.SessionsFixtures

  alias RestaurantAppPlatform.Sessions.Session

  @create_attrs %{
    session_token: "some session_token",
    start_time: ~U[2024-08-26 05:31:00Z],
    end_time: ~U[2024-08-26 05:31:00Z]
  }
  @update_attrs %{
    session_token: "some updated session_token",
    start_time: ~U[2024-08-27 05:31:00Z],
    end_time: ~U[2024-08-27 05:31:00Z]
  }
  @invalid_attrs %{session_token: nil, start_time: nil, end_time: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all sessions", %{conn: conn} do
      conn = get(conn, ~p"/api/sessions")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create session" do
    test "renders session when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/sessions", session: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/sessions/#{id}")

      assert %{
               "id" => ^id,
               "end_time" => "2024-08-26T05:31:00Z",
               "session_token" => "some session_token",
               "start_time" => "2024-08-26T05:31:00Z"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/sessions", session: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update session" do
    setup [:create_session]

    test "renders session when data is valid", %{conn: conn, session: %Session{id: id} = session} do
      conn = put(conn, ~p"/api/sessions/#{session}", session: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/sessions/#{id}")

      assert %{
               "id" => ^id,
               "end_time" => "2024-08-27T05:31:00Z",
               "session_token" => "some updated session_token",
               "start_time" => "2024-08-27T05:31:00Z"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, session: session} do
      conn = put(conn, ~p"/api/sessions/#{session}", session: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete session" do
    setup [:create_session]

    test "deletes chosen session", %{conn: conn, session: session} do
      conn = delete(conn, ~p"/api/sessions/#{session}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/sessions/#{session}")
      end
    end
  end

  defp create_session(_) do
    session = session_fixture()
    %{session: session}
  end
end
