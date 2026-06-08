Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4879E27E05E
	for <linux-hardening@vger.kernel.org>; Mon,  8 Jun 2026 13:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780925652; cv=none; b=hX6zwmf5FHqUE8Kp30ZLJT+qdx5i56/5eKlExjkcY4u29CciGIhENm49aeA5aDuWx/YPWHufTBt1jIQfUsaEvMfJeCqfoVR4KIqaXn0LxMSZGmxmx8rVjTc4y27GQFZo/eqOATchWVu6QrnQG7qtRU90D2k2M6CQ31c1yi9nUAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780925652; c=relaxed/simple;
	bh=2/2kL569aPkF2+65Au1wGQnqSm0E68Pji8SDsK2Iujg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IzpFcRYlUWIJgtn/i7tD973LeyOVi7wAq7cgqnCKzVmvHy9hzi9crnP2Q0UVBO+Fs3cQX+66mnbvqNn/dIigU2tu9x8FW+RcDPBZRmhRHCUE/XspO2qNICa1rZxrrLTV4P8rog0P0UJvBFviwMy8A/iGiz7gBG+n1qfS7CLBHzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FcK6Bmqa; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FcK6Bmqa"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-69155ca09d8so2443540a12.3
        for <linux-hardening@vger.kernel.org>; Mon, 08 Jun 2026 06:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1780925649; x=1781530449; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2/2kL569aPkF2+65Au1wGQnqSm0E68Pji8SDsK2Iujg=;
        b=FcK6Bmqak7YDrCC6yGb1SRAe07Iz8MyFB/te00oUjj7pT2/AG0PxaOhWXpxKx+3Dls
         lYr24TYuMFArMxqoaN/bRUBoF2hk77jIq0GXt8MqDIyt7X8xvLi/JRI2KXhcfvO6xRHX
         6C1r93rf1qvVlHvpjYvBsBOtsAL5bNb1COHnuqH/lC7eM756YAHWb+JBcS1wcIYjy2HE
         V+TRMzjL2xsdIBRrqrWqGUNqK/eiHu7sUK+3BuaRKzWGWmZHYYLqiov51tCXuSXmgxLn
         Tzaz1KAjZf8AqlQ+m4Hs+H6tZliVKskZHmU8+6acjqiWftDDE/afVWxEo5W1ArvZEP2w
         inRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780925649; x=1781530449;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2/2kL569aPkF2+65Au1wGQnqSm0E68Pji8SDsK2Iujg=;
        b=V8yzeQVn6KT9JfijXeb2O+pn/Y3eCfNdeE8gBXcTdbFaV60Hv8Ep42CDWsT4zJrzwb
         JlCBct724Oa5hQZN4FgWFpnHSSX+M8/QD+CzujYx4kimrMy5REku7LaFu4YMD/z7elGb
         jStOxyB9VhrPNIRLSkquDto/Renas22IhQPBLsrGeyVHzKM2ms6fJ6ZgrIft8nteznh3
         EQ0ulCIZoR86JMzRqGW8NjS/id9Kict9PzyZ+kx6Rf7LRgppgAtg/UJ3JLwvEvyVxHPS
         O607k3DaxKU3OepxdUREzFiDdy176BPwIl6dXziWJ848yUWvc7qYDtnVv7uD9pNA0IRX
         daiQ==
X-Forwarded-Encrypted: i=1; AFNElJ+RhEIx8n36rimSrpFRFmkNu7sVfL3CGUl2rZOh+EKtCHwy/EI2uQeyhlWGwaVi5KttFWc4pq9SuIN3idE38mA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFneiJYLbNSf7MlmXXieC4uY6VwePhg5K2wfL1C3oRTRX12KvE
	+EcVDOBnrZxhsocZlV8sVFRBurMGcUhKUKiMSeDw1j5x3DEDx1PpkUNMnrb5msTg0cwOzk++Z3o
	Vmaymt4E=
X-Gm-Gg: Acq92OGHVYdxXyQ9kUeXioqrMy/ZIbcnln0UjjkBppBfKI7FDclC+sTZIKfYEg0mdMA
	ZNMZZrqX7gwM+jtEwvL6z9HUeuj2eE54w0dwlfvtgb/fEAi+AsO4x9C4dBEigpaTnMeIDwQgfHn
	0osdVxgV+sGRZD/jSsFa9mcXTZ6z2j6zxVDc4BaQ7+zx/vzTU23avpwKQTmqvNXZMkH4g/AQ1Qt
	LObVxAWMWl3yRNqC7qxCadKmGuHVTzstF8NzWWwd3OdVxk5kWI6J6/bSPDOmSwdH9YOC4t9MoP1
	ki14hk4MG6VIevr5Esabak5kjAD9P5T4TDoFAiLLDE6LqiphAZvkRVH00NZm6fyIL0PrGEgsYUN
	lZvQNvNyZurBTGnVXWSdwyHj2eS/lMXHC57uueedGubUqKKZ5aGm6SVvnrFiUDeyvESeBedE14Y
	zKgrXSN4uGrrYd3aw3zLxpaZX8lpZopUqnpb6a/cmXeT2O28af1ffsGToGo86ZoV2emMTijjAOU
	bn9OhzUYmuiKAXNO7FD0YFAawwtuMvtcQzoIwx8krZraBzqHb+gGlsiE13PAEO+
X-Received: by 2002:a05:6402:4594:b0:689:b30c:4205 with SMTP id 4fb4d7f45d1cf-68fa47bc5c8mr7316048a12.0.1780925648540;
        Mon, 08 Jun 2026 06:34:08 -0700 (PDT)
Received: from ?IPV6:2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112? (2a00-12d0-af5d-ad01-5d3f-14e6-9bcb-5112.ip.tng.de. [2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6912365bd3fsm3724373a12.5.2026.06.08.06.34.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 06:34:08 -0700 (PDT)
Message-ID: <a0aaac58-5ffe-4b50-adb1-65ec3a9c00fa@suse.com>
Date: Mon, 8 Jun 2026 15:34:07 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next] nxen/xenbus: Replace strcpy() with memcpy()
To: david.laight.linux@gmail.com, Kees Cook <kees@kernel.org>,
 linux-hardening@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
 linux-kernel@vger.kernel.org
Cc: Stefano Stabellini <sstabellini@kernel.org>
References: <20260606202633.5018-4-david.laight.linux@gmail.com>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Autocrypt: addr=jgross@suse.com; keydata=
 xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjrioyspZKOB
 ycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2kaV2KL9650I1SJve
 dYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i1TXkH09XSSI8mEQ/ouNcMvIJ
 NwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/BBLUVbDa4+gmzDC9ezlZkTZG2t14zWPvx
 XP3FAp2pkW0xqG7/377qptDmrk42GlSKN4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEB
 AAHNH0p1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT7CwHkEEwECACMFAlOMcK8CGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRCw3p3WKL8TL8eZB/9G0juS/kDY9LhEXseh
 mE9U+iA1VsLhgDqVbsOtZ/S14LRFHczNd/Lqkn7souCSoyWsBs3/wO+OjPvxf7m+Ef+sMtr0
 G5lCWEWa9wa0IXx5HRPW/ScL+e4AVUbL7rurYMfwCzco+7TfjhMEOkC+va5gzi1KrErgNRHH
 kg3PhlnRY0Udyqx++UYkAsN4TQuEhNN32MvN0Np3WlBJOgKcuXpIElmMM5f1BBzJSKBkW0Jc
 Wy3h2Wy912vHKpPV/Xv7ZwVJ27v7KcuZcErtptDevAljxJtE7aJG6WiBzm+v9EswyWxwMCIO
 RoVBYuiocc51872tRGywc03xaQydB+9R7BHPzsBNBFOMcBYBCADLMfoA44MwGOB9YT1V4KCy
 vAfd7E0BTfaAurbG+Olacciz3yd09QOmejFZC6AnoykydyvTFLAWYcSCdISMr88COmmCbJzn
 sHAogjexXiif6ANUUlHpjxlHCCcELmZUzomNDnEOTxZFeWMTFF9Rf2k2F0Tl4E5kmsNGgtSa
 aMO0rNZoOEiD/7UfPP3dfh8JCQ1VtUUsQtT1sxos8Eb/HmriJhnaTZ7Hp3jtgTVkV0ybpgFg
 w6WMaRkrBh17mV0z2ajjmabB7SJxcouSkR0hcpNl4oM74d2/VqoW4BxxxOD1FcNCObCELfIS
 auZx+XT6s+CE7Qi/c44ibBMR7hyjdzWbABEBAAHCwF8EGAECAAkFAlOMcBYCGwwACgkQsN6d
 1ii/Ey9D+Af/WFr3q+bg/8v5tCknCtn92d5lyYTBNt7xgWzDZX8G6/pngzKyWfedArllp0Pn
 fgIXtMNV+3t8Li1Tg843EXkP7+2+CQ98MB8XvvPLYAfW8nNDV85TyVgWlldNcgdv7nn1Sq8g
 HwB2BHdIAkYce3hEoDQXt/mKlgEGsLpzJcnLKimtPXQQy9TxUaLBe9PInPd+Ohix0XOlY+Uk
 QFEx50Ki3rSDl2Zt2tnkNYKUCvTJq7jvOlaPd6d/W0tZqpyy7KVay+K4aMobDsodB3dvEAs6
 ScCnh03dDAFgIq5nsB11j3KPKdVoPlfucX2c7kGNH+LUMbzqV6beIENfNexkOfxHfw==
In-Reply-To: <20260606202633.5018-4-david.laight.linux@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------3jijwgSjk5aLJ7iS8lKnSaj4"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------3jijwgSjk5aLJ7iS8lKnSaj4
Content-Type: multipart/mixed; boundary="------------YBSTqtcmM0DjukCudPTQsJit";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: david.laight.linux@gmail.com, Kees Cook <kees@kernel.org>,
 linux-hardening@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
 linux-kernel@vger.kernel.org
Cc: Stefano Stabellini <sstabellini@kernel.org>
Message-ID: <a0aaac58-5ffe-4b50-adb1-65ec3a9c00fa@suse.com>
Subject: Re: [PATCH next] nxen/xenbus: Replace strcpy() with memcpy()
References: <20260606202633.5018-4-david.laight.linux@gmail.com>
In-Reply-To: <20260606202633.5018-4-david.laight.linux@gmail.com>

--------------YBSTqtcmM0DjukCudPTQsJit
Content-Type: multipart/mixed; boundary="------------3EMfhRG8rDnr2FiQzJTRy60Q"

--------------3EMfhRG8rDnr2FiQzJTRy60Q
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDYuMDYuMjYgMjI6MjUsIGRhdmlkLmxhaWdodC5saW51eEBnbWFpbC5jb20gd3JvdGU6
DQo+IEZyb206IERhdmlkIExhaWdodCA8ZGF2aWQubGFpZ2h0LmxpbnV4QGdtYWlsLmNvbT4N
Cj4gDQo+IFRoZSBsZW5ndGggb2YgdGhlIHN0cmluZyBpcyBjYWxjdWxhdGVkIGluIG9yZGVy
IHRvIGFsbG9jYXRlIHRoZSBjb3JyZWN0DQo+IHNpemVkIG1lbW9yeSBibG9jaywgdXNlIHRo
ZSBzYW1lIGxlbmd0aCB0byBjb3B5IHRoZSBzdHJpbmcuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBEYXZpZCBMYWlnaHQgPGRhdmlkLmxhaWdodC5saW51eEBnbWFpbC5jb20+DQoNClJldmll
d2VkLWJ5OiBKdWVyZ2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+DQoNCg0KSnVlcmdlbg0K

--------------3EMfhRG8rDnr2FiQzJTRy60Q
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------3EMfhRG8rDnr2FiQzJTRy60Q--

--------------YBSTqtcmM0DjukCudPTQsJit--

--------------3jijwgSjk5aLJ7iS8lKnSaj4
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmomxM8FAwAAAAAACgkQsN6d1ii/Ey9N
qAf/U6hjMucnSmIIg1TYdVN9citZO/LBG0mRT+jcFxgx+3Ir7oLe/vwFGTsUsTt7QJyF4fJVceOP
WeBuNpei1dXOxzNZxgkSifYgqMmgUK8eADvLS/xgBLR6aRzvVAk9g90DBMiOn5dUNguIt3Z8quhi
4QXSXeXqu0Pkl/k8HMW7y9Eg5kWodJFJDSw4cZoSY4dTBL/wW1uh4xMy1fVugp37SGm2URYizQAU
lZ9J4yGsrgogcYmy21UJJBG9nsww0an08H4jSkSvHIK7NBDiGLDgM8vVy7yHpfrQeWhxvLvDrscN
Gnz+6l8BhfGkGqs5LFvFsp3ORjEaYWpftKy8MDFF9A==
=TazD
-----END PGP SIGNATURE-----

--------------3jijwgSjk5aLJ7iS8lKnSaj4--
