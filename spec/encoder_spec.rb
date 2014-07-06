require 'spec_helper'

describe 'Encoder' do
  before do
    allow(Time).to receive(:now).and_return(946681200)
    @payload = { hello: 'world' }
  end

  it 'encodes a JWT using HS' do
    secret       = 'mysecret'
    expected_jwt = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJoZWxsbyI6IndvcmxkIiwiaWF0Ijo5NDY2ODEyMDB9.XNHCL9anTmqt31OVA91Px-bQ6QJxTrRlkiysluDJeKo'
    jwt          = JWT.encode(@payload, secret)

    expect(jwt).to eq(expected_jwt)
  end

  it 'encodes a JWT using RS' do
    key = OpenSSL::PKey::RSA.new(<<-PIVKEY)
-----BEGIN RSA PRIVATE KEY-----
MIIBOgIBAAJAa3OaqnpApn6lqTVCefBLjcXxiN22Ks3HZcyy4xnxhlJK1MxqNMJs
FLCvIIwsMBFrHpWs+iZ8SCA2GzvoPn5wlwIDAQABAkBKAt20sPJY/AD1VNcOEKKp
637bzAMO5qCCkQVigdsnriCab5AL+2M4f4XD6jI5OJkG6KZzse96PjmaTyWwZcvB
AiEApycN0oyYeEISG14YUntH4zmiOSJb+rhZrRH+z45B+SECIQCkkNxM+IhTCp4W
hZLDTYum329QOfHPyEjEi7if8QgatwIgY8/AQz/NM9JQOaNgZrBS5u5dXjyULAy1
D9G1FH9gCcECIQCKaTBxKKP4PDjktmnPDBzGOKz17BZ+7XSOovmgxGhNlwIhAIaQ
/z9AMGKMCwy1/oGt6viqaY/Kdnh6CrkvEofRAdzB
-----END RSA PRIVATE KEY-----
PIVKEY
    expected_jwt = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJoZWxsbyI6IndvcmxkIiwiaWF0Ijo5NDY2ODEyMDB9.WKVdIXaohabURkq7Z6Gn5wLJNhjydYFvqflaxw27CLJG9CVlyJJJ4E47bUGHAbPoUTKq3gZp7ubAecRcOJNDng'
    jwt          = JWT.encode(@payload, key, algorithm: 'RS256')
    expect(jwt).to eq(expected_jwt)
  end

  it 'raises NotImplementedError using a fake signature' do
    secret = 'mysecret'
    expect { JWT.encode(@payload, secret, algorithm: 'HS9888889') }
      .to raise_error NotImplementedError
  end

  it 'raises an error if you dont use a private key on RS algorithms' do
    secret = 'mysecret'
    expect { JWT.encode(@payload, secret, algorithm: 'RS256') }
      .to raise_error StandardError
  end
end

