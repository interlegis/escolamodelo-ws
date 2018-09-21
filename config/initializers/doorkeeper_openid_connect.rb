Doorkeeper::OpenidConnect.configure do
  issuer 'https://escolamodelows.interlegis.leg.br'

  signing_key <<-EOL
-----BEGIN RSA PRIVATE KEY-----
MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDWcVO8fnEmIulC
fhJFx2PsdvooPKcSuLdLjbqZRQKMDP02sh40lsxt7gsN2en3PlnnTIaKGhE7CnoP
t6sawYsUsA/+pE3UJ1bgnML9nOsIOA23pBVNa7JTH5FSv1yHR3Gqpf0Y0RtvGtol
HWfw/qYUsXb75nDtVvaZNe7XfGot9lgyjZvBToBrnPSepsjtrIAzEn6MGQh9DKJ+
zXcaPLwMtFx5hNfHqflqb6PPH7kRSix3EM5v8xTLIr/SUQ3eSlsjKT4sZCmu3++8
Ii0LTMQlZDMM+94MClMKWmfW2P5T+jDkh7e/Ou3wXXLq+I/ybkS01HKJeXHoitJl
C9uCAc/NAgMBAAECggEAcPFNLgjWZUSb4EZwL0o96awcQxb209hvyZ5C+jirh8HL
l4QmfoIx93AZaFkubebsCPN4JMJn8tWoxiBxQO1Q6Dt2oSI+T4/MpQ5LcLG15CVJ
rEACbD1dtYP50UAyZpmNV1iHPgvcTB8zZ7reJMKqDFoPlcqgDZDw3m7Wda30anHO
4TEkYj5mEDvyt8Qgx+b7S5Y7NzrK7wBN7IEbb9hVQCOhZF6bOiJEzMJLQn7I2/Uj
yTDu45jQrf/24uO+Nk8PErxn46E2NJ85isdiD8APsO6PW8qWhJuybkOrbaux1VNR
0H68DMFEAleCXMrTIBNYpNyc0qaqXeOc4J7lBzWajQKBgQDqqGU5zi2jH/Igzbse
yl0IPv7F1FZ0WPXjQPSJb2B5n1pkgFySG1/5PYCpvQm5b/puScTC/zJIr2QrUpwH
M2HYdh0V3LG1s20pnC1zbbm565UQJ6uIcDq++22JMVUA5uFIvxD/f5O8FTqj+DRL
EdgcvEaSAORQ9NTANJH2TxXJowKBgQDp8kHp8DNOrSisWM1IMZEkM1gttjmKUMHq
hshHSleNi/fbghsBvRG5R5pgCT62l8+QJZffLI1LTDFLRKED5LYkKO5xGRC98TAc
q2WMUFB600HoFi6ymrgRPI8gL1DVa7HFIj+O482bdPuZTTJCJCu8ppGeDmeZDYk9
Pb8HQ0N3zwKBgBwr81spQZlf8HW3vUtJCDpBNd0STP7S31JVLgaB9JclZnjCYFq6
Jp+JnrTCGTTGGM681H6EnMjVJbV9yXWj2Y9fPsatJDioPebM9TfyaGXFvrOdz54l
uyfKj6/02DuvfER7i9Lgwh/GfK/K0JxinAt3HxHQQZjmi9Q3e36SqA75AoGAFJcF
xhkl6t7CnaiTKK90HsOGFz/agJnq90E1j1Czs/mFrwQcbGK/lJcAt0MZCekCk6U7
YKEDLoVeMUmxAi62+SfBFKMoHg+ENIHBRkArVSQSwOJy6bVETgAOeL6xVpdL5hXF
kkXqaqw5GJz6t2eHker3FfoelBHk6kbs8S6yWXECgYEAmhBf8ZBBKxtuq7+U3wuQ
z/P1Lx6uYHHUALi73eRL3+HgAzYJCuP5PJ/9L37ShSd5rEC12xIh4xivc1zcZy3p
KbRf5izoSStze/FkQTp7fWybkE3LZvEb6L4gVk4BaqATPNjU4QF4A4BvDg2rtErp
+Llri+JTVuOhNRpJEEa1jYU=
-----END RSA PRIVATE KEY-----
EOL

  subject_types_supported [:public]

  resource_owner_from_access_token do |access_token|
    User.find(access_token.resource_owner_id)
  end

  auth_time_from_resource_owner do |resource_owner|
    resource_owner.last_activity_at
  end

  reauthenticate_resource_owner do |resource_owner, return_to|
    # Example implementation:
    # store_location_for resource_owner, return_to
    # sign_out resource_owner
    # redirect_to new_user_session_url
  end

  subject do |resource_owner, application|
    resource_owner.id

    # or if you need pairwise subject identifier, implement like below:
    # Digest::SHA256.hexdigest("#{resource_owner.id}#{URI.parse(application.redirect_uri).host}#{'your_secret_salt'}")
  end

  # Protocol to use when generating URIs for the discovery endpoint,
  # for example if you also use HTTPS in development
  # protocol do
  #   :https
  # end

  # Expiration time on or after which the ID Token MUST NOT be accepted for processing. (default 120 seconds).
  # expiration 600

  # Example claims:
  claims do
    claim :given_name, scope: :openid do |user, scopes|
      if scopes.exists?(:profile)
        user.first_name
      end
    end
    claim :family_name, scope: :openid do |user, scopes|
      if scopes.exists?(:profile)
        user.last_name
      end
    end
    claim :nickname, scope: :openid do |user, scopes|
      if scopes.exists?(:profile)
        user.username
      end
    end
    claim :phone, scope: :openid do |user, scopes|
      if scopes.exists?(:profile)
        user.phone
      end
    end
    claim :email, scope: :openid do |user, scopes|
      if scopes.exists?(:email)
        user.email
      end
    end
    claim :locale, scope: :openid do |user, scopes|
      if scopes.exists?(:profile)
        'pt_br'
      end
    end
    claim :cpf, scope: :openid do |user, scopes|
      if scopes.exists?(:profile)
        user.cpf
      end
    end
    claim :token_id, scope: :openid do |user, scopes, token|
      token.id
    end
  end
end
