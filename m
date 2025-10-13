Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCDC258EE8
	for <linux-hardening@vger.kernel.org>; Mon, 13 Oct 2025 12:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760356848; cv=none; b=Ps+e/77JX19LouLPQly/3YloXKn4ueW4+MzQCqPVpIGapDPqDigPYZGJZ8ZSh2sMLdTBvYqT/6M/f2rC4mB69pwIUuc0MOoKLNEunY8DOi0Dx+GdxoB9m4O6D+j3C66zkJhCRuHELvr36stB0N4RfbygDooGWi3DWVW+a5fTcYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760356848; c=relaxed/simple;
	bh=/dxqBAuMFz/4ObPFc+VeEyW8NSDE0MktALoHnbWSUek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cyHmMQ1/ogN2j7QR/cZBO+SxyYc7woeSTton+jiTKeanBvQW+WDE8IL826Sk51BPJ9Jm/ulmr3IRqmeqFnBURYhFATR7aCL4eAJSiEkUYTdBwEbefphNecwgC/hSObSjgx5Obh8sfuPz8g0wd/zZeCqvNTXvf13qlpZF/OoLRfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MzKlObX9; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MzKlObX9"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-46e34bd8eb2so41670895e9.3
        for <linux-hardening@vger.kernel.org>; Mon, 13 Oct 2025 05:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760356844; x=1760961644; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/dxqBAuMFz/4ObPFc+VeEyW8NSDE0MktALoHnbWSUek=;
        b=MzKlObX9sgMojL95RWX9Pf2wdeFjSar0xXLHZa7gWC/jsTcOBgS3VXFpIDgaphvh1y
         pqqD798JSxD/oX/UWSbl30tvAgLc8GOL82OHsvve6qappcWqgWSEeSQEKvJlxjRq+iTw
         PH33qMEYnmHXEWzKbKzXjAerXRrqRFN3piH8yyFhJnOOKpQXdAcbcyhqgONEonN9Gf4t
         FdSoH6Kga8fldbpAhdkpDsgZL/QBW0v7+QGQUX3PnsC5r/AUfr5sujVFV/8xG7CfqLsP
         yheQ9dtafhfzFxcz8tJBED67He/r161xD239o6Uzm8Az5GcmWjdk47Ctdls5+HZYQinV
         zZWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760356844; x=1760961644;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/dxqBAuMFz/4ObPFc+VeEyW8NSDE0MktALoHnbWSUek=;
        b=fLhHjGXKHKAhA5B395OoyDktPTs/tyJ2TotrPvb7fKddJ3Bg0eIr6YLSiggnDKObRt
         mkeO/gDqhK8Ka3881Y75e4n2Um/5OLMZk0waFVkN6Gsz/43z3mJPT0LrhmHbN34bFt2k
         Wz3FhMp0QsNvUyn85X1PU95dVMtiqTq2ZfkTC+TKXDpdgfrxj6PT006zOrH4ij2MPOX4
         daMB9ldibDXMXget23xVvg2R462l9lyxHhXem3r/wWv69Ddro2ZiHc8up4yxt4cSahpg
         H3VHZqmhRErsTWO0y02ymSvkR1E1k/ENmaTxS5sX2VioNPTgzR7a7iZX7TQLPmKtBXTQ
         vE2Q==
X-Gm-Message-State: AOJu0YwngKVpeBeSb3gN1LS1xuAXinROZl0Dbgl8iJf/94Oejs8YJlnu
	eGHGWF5eIXRdfdfJ9IziACndShUzxlmthGEN48Xmmi+58PoU/qW7Agg30EpFZzqybj2oQWvPOXB
	SaGRk5eE=
X-Gm-Gg: ASbGncsV2inOJPeq7/HtBvRRG63LF8HEA+3G4mMw2f91XBIpWIsA1LHI41fVFOFE1Sz
	fVv+6esy2FZmy99gEzuktNUBy5heMHlIXeDPwPGF4CI0JYkfzS8gSGSwm3uwur1SRUx01mv3sX6
	qZk3wU64/IPKWluMCIRzB4TLp6Ud5wqihPBogCMFipmFi/t1YbpJ9BGGsRlcMnSjgjLcCQAxrh6
	xIJP1ueOZOTP/bjOoLn4u5wF0mzwBEJ9JsgCFP6JYwbNBMq0cszMA/l67RpT0KdGWVx/I6oSCAZ
	xRM6WoflGK4jgBhj+lRz57tw8DnO97Tiq2Mykos48/zD6D9SYbreQ45VAxcZyQxezSxndDDpSnN
	PLdsx4rRMjMbXlCUMBKWVswK3+OzOXKXW8+aQzFg7tUN3N130aLoWj7mF9Z6IznGf47pHQ0wz3s
	V+WQPDUdE68QuMvP/14wSAuJloNhb4zvFIbHMoqZsaMcypk4QIuhctzFKcQNknNeg=
X-Google-Smtp-Source: AGHT+IGocgXogRM7akcTSK1xrQE9tVgR+Nty1WOVCqdVeCe6O8qvzxmQNwZZ3oohkfEaftJ6wP49/A==
X-Received: by 2002:a05:600c:4510:b0:45d:f83b:96aa with SMTP id 5b1f17b1804b1-46fa9a8f2e1mr144516785e9.7.1760356844293;
        Mon, 13 Oct 2025 05:00:44 -0700 (PDT)
Received: from ?IPV6:2003:e5:873f:400:7b4f:e512:a417:5a86? (p200300e5873f04007b4fe512a4175a86.dip0.t-ipconnect.de. [2003:e5:873f:400:7b4f:e512:a417:5a86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb489accbsm207642235e9.14.2025.10.13.05.00.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 05:00:43 -0700 (PDT)
Message-ID: <cf834c9b-4c2b-4851-a2c0-5885b3cf1fda@suse.com>
Date: Mon, 13 Oct 2025 14:00:43 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drivers/xen/xenbus: Replace deprecated strcpy in
 xenbus_transaction_end
To: Thorsten Blum <thorsten.blum@linux.dev>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Jason Andryuk <jason.andryuk@amd.com>,
 "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: linux-hardening@vger.kernel.org, xen-devel@lists.xenproject.org,
 linux-kernel@vger.kernel.org
References: <20251013115129.30304-2-thorsten.blum@linux.dev>
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
In-Reply-To: <20251013115129.30304-2-thorsten.blum@linux.dev>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------vMnIqwKGSJE0PqZfv8VIdFz0"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------vMnIqwKGSJE0PqZfv8VIdFz0
Content-Type: multipart/mixed; boundary="------------1E9wWmb0SvyhzfRDWrCDwsNl";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Thorsten Blum <thorsten.blum@linux.dev>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Jason Andryuk <jason.andryuk@amd.com>,
 "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: linux-hardening@vger.kernel.org, xen-devel@lists.xenproject.org,
 linux-kernel@vger.kernel.org
Message-ID: <cf834c9b-4c2b-4851-a2c0-5885b3cf1fda@suse.com>
Subject: Re: [PATCH v2] drivers/xen/xenbus: Replace deprecated strcpy in
 xenbus_transaction_end
References: <20251013115129.30304-2-thorsten.blum@linux.dev>
In-Reply-To: <20251013115129.30304-2-thorsten.blum@linux.dev>

--------------1E9wWmb0SvyhzfRDWrCDwsNl
Content-Type: multipart/mixed; boundary="------------RRK0hufaSRgt4jr4TufFezF4"

--------------RRK0hufaSRgt4jr4TufFezF4
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTMuMTAuMjUgMTM6NTEsIFRob3JzdGVuIEJsdW0gd3JvdGU6DQo+IHN0cmNweSgpIGlz
IGRlcHJlY2F0ZWQ7IGlubGluZSB0aGUgcmVhZC1vbmx5IHN0cmluZyBpbnN0ZWFkLiBGaXgg
dGhlDQo+IGZ1bmN0aW9uIGNvbW1lbnQgYW5kIHVzZSBib29sIGluc3RlYWQgb2YgaW50IHdo
aWxlIHdlJ3JlIGF0IGl0Lg0KPiANCj4gTGluazogaHR0cHM6Ly9naXRodWIuY29tL0tTUFAv
bGludXgvaXNzdWVzLzg4DQo+IFNpZ25lZC1vZmYtYnk6IFRob3JzdGVuIEJsdW0gPHRob3Jz
dGVuLmJsdW1AbGludXguZGV2Pg0KDQpSZXZpZXdlZC1ieTogSnVlcmdlbiBHcm9zcyA8amdy
b3NzQHN1c2UuY29tPg0KDQoNCkp1ZXJnZW4NCg==
--------------RRK0hufaSRgt4jr4TufFezF4
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------RRK0hufaSRgt4jr4TufFezF4--

--------------1E9wWmb0SvyhzfRDWrCDwsNl--

--------------vMnIqwKGSJE0PqZfv8VIdFz0
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmjs6esFAwAAAAAACgkQsN6d1ii/Ey+O
9wf9GdcUf4z3v+VEm53GypvPg2UeLJ4HA5tDBSxJ4YwSi+yZksUoxZn3cvSygw9qwfajvNldPUmQ
rtlg0lLPlqorVV9ieTri3ERw7DGytVRjh6Us/KAbV28LK68ePMzRhl33yu0wkgBgY2k7n8l9yQaW
C+YJU/VQFsqqLHPvYKkaIngNtVENbVdp37eYBbqlejnoYWlHTPmzzBXavo5nVpLfQcjX9v9GMXKF
S+a3ClBkUFP6JYMcdnv3V9cXOVHX+aEO0PPv+73AkZNr4jLRhMwHBhG3lrs6EasYK1QILG3Oo3HS
XwHUOLJp+KwZprNsNcZQp3/Zzyk4KusunKrc7dOflQ==
=rMBF
-----END PGP SIGNATURE-----

--------------vMnIqwKGSJE0PqZfv8VIdFz0--
