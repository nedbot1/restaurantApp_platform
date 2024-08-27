defmodule RestaurantAppPlatform.SessionsTest do
  use RestaurantAppPlatform.DataCase

  alias RestaurantAppPlatform.Sessions

  describe "sessions" do
    alias RestaurantAppPlatform.Sessions.Session

    import RestaurantAppPlatform.SessionsFixtures

    @invalid_attrs %{session_token: nil}

    test "list_sessions/0 returns all sessions" do
      session = session_fixture()
      assert Sessions.list_sessions() == [session]
    end

    test "get_session!/1 returns the session with given id" do
      session = session_fixture()
      assert Sessions.get_session!(session.id) == session
    end

    test "create_session/1 with valid data creates a session" do
      valid_attrs = %{session_token: "some session_token"}

      assert {:ok, %Session{} = session} = Sessions.create_session(valid_attrs)
      assert session.session_token == "some session_token"
    end

    test "create_session/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Sessions.create_session(@invalid_attrs)
    end

    test "update_session/2 with valid data updates the session" do
      session = session_fixture()
      update_attrs = %{session_token: "some updated session_token"}

      assert {:ok, %Session{} = session} = Sessions.update_session(session, update_attrs)
      assert session.session_token == "some updated session_token"
    end

    test "update_session/2 with invalid data returns error changeset" do
      session = session_fixture()
      assert {:error, %Ecto.Changeset{}} = Sessions.update_session(session, @invalid_attrs)
      assert session == Sessions.get_session!(session.id)
    end

    test "delete_session/1 deletes the session" do
      session = session_fixture()
      assert {:ok, %Session{}} = Sessions.delete_session(session)
      assert_raise Ecto.NoResultsError, fn -> Sessions.get_session!(session.id) end
    end

    test "change_session/1 returns a session changeset" do
      session = session_fixture()
      assert %Ecto.Changeset{} = Sessions.change_session(session)
    end
  end

  describe "sessions" do
    alias RestaurantAppPlatform.Sessions.Session

    import RestaurantAppPlatform.SessionsFixtures

    @invalid_attrs %{session_token: nil, start_time: nil, end_time: nil}

    test "list_sessions/0 returns all sessions" do
      session = session_fixture()
      assert Sessions.list_sessions() == [session]
    end

    test "get_session!/1 returns the session with given id" do
      session = session_fixture()
      assert Sessions.get_session!(session.id) == session
    end

    test "create_session/1 with valid data creates a session" do
      valid_attrs = %{session_token: "some session_token", start_time: ~U[2024-08-26 05:31:00Z], end_time: ~U[2024-08-26 05:31:00Z]}

      assert {:ok, %Session{} = session} = Sessions.create_session(valid_attrs)
      assert session.session_token == "some session_token"
      assert session.start_time == ~U[2024-08-26 05:31:00Z]
      assert session.end_time == ~U[2024-08-26 05:31:00Z]
    end

    test "create_session/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Sessions.create_session(@invalid_attrs)
    end

    test "update_session/2 with valid data updates the session" do
      session = session_fixture()
      update_attrs = %{session_token: "some updated session_token", start_time: ~U[2024-08-27 05:31:00Z], end_time: ~U[2024-08-27 05:31:00Z]}

      assert {:ok, %Session{} = session} = Sessions.update_session(session, update_attrs)
      assert session.session_token == "some updated session_token"
      assert session.start_time == ~U[2024-08-27 05:31:00Z]
      assert session.end_time == ~U[2024-08-27 05:31:00Z]
    end

    test "update_session/2 with invalid data returns error changeset" do
      session = session_fixture()
      assert {:error, %Ecto.Changeset{}} = Sessions.update_session(session, @invalid_attrs)
      assert session == Sessions.get_session!(session.id)
    end

    test "delete_session/1 deletes the session" do
      session = session_fixture()
      assert {:ok, %Session{}} = Sessions.delete_session(session)
      assert_raise Ecto.NoResultsError, fn -> Sessions.get_session!(session.id) end
    end

    test "change_session/1 returns a session changeset" do
      session = session_fixture()
      assert %Ecto.Changeset{} = Sessions.change_session(session)
    end
  end
end
