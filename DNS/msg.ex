defmodule Msg do
    def decode(<<id::16, flag::16, qc::16, an::16, aan::16, nsc::16, arc::16, body::binary >>) do
        {id, flag, qc, an, aan, nsc, arc, body}
    end

    def decode_name(label, raw) do
      decode_name(label, [], raw)
    end

    def decode_name(<<0::1, 0::1, 0::6, rest::binary>>, names, _raw) do
      {Enum.reverse(names), rest}
    end

    def decode_name(<<0::1, 0::1, n::6, _::binary>> = label, names, raw) do
      <<name::binary-size(n), rest::binary>> = label
      decode_name(rest, [name|names], raw)
    end

    def decode_names(<<1::1, 1::1, n::14, rest::binary>>, names, raw) do
      ## offset encoding
      <<_::binary-size(n), section::binary>> = raw
      {name, _} = decode_names(section, names, raw)
        {name, rest}
    end
end
