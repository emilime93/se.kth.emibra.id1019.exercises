defmodule DNS do

    @server {8,8,8,8}
    @port 53
    @local 5300

    def start() do
        start(@local, @server, @port)
    end

    def start(local, server, port) do
        spawn(fn() -> init(local, server, port) end)
    end

    def init(local, server, port) do
        case :gen_udp.open(local, [{:active, true}, :binary]) do
            {:ok, local } ->
                case :gen_udp.open(0, [{:active, true}, :binary]) do
                    {:ok, remote} ->
                        dns(local, remote, server, port, Map.new())
                    error ->
                        :io.format("DNS error opening remote socket ~w~n", [error])
                end
            error ->
                :io.format("DNS error opening local socket: ~w~n", [error])
        end
    end

    # def dns(local, remote, server, server_port) do
    #     dns(local, remote, server, server_port, Map.new())
    # end

    def dns(local, remote, server, server_port, queries) do
        receive do
            {:udp, ^local, client, client_port, query, queries} ->
                :io.format("request from ~w ~w ~n", [client, client_port])
                {id, _flag, _qc, _an, _aan, _nsc, _arc, _body} = Msg.decode(query)
                :io.format("id: ~w ~n", [id])
                :gen_udp.send(remote, server, server_port, query)
                dns(local, remote, server, server_port, MAP.put(queries, id, {client, client_port}))
            {:udp, ^remote, server, server_port, reply, queries} ->
                :io.format("request from ~w ~w ~n", [server, server_port])
                {id, _flag, _qc, _an, _aan, _nsc, _arc, _body} = Msg.decode(reply)
                # decoded = Msg.decode(reply)
                :io.format("id: ~w ~n", [id])
                {{client, client_port}, rest} = Map.pop(queries, id)
                :gen_udp.send(local, client, client_port, reply)
                dns(local, remote, server, server_port, rest)
            :update ->
                DNS.dns(local, remote, server, server_port, queries)
            :quit ->
                :ok
            strange ->
                :io.format("strange message ~p ~n", [strange])
                dns(local, remote, server, server_port, queries)
        end

    end

end
