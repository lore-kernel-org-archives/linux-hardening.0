Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAB9171092;
	Fri, 27 Jun 2025 16:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751042875; cv=none; b=I4vph1hSegYYzrrvJyX4CUIcXRG+4Z6dKSZgCQysOXHrulEHS+oxKzls17vXDBdbf7FW5wdiX+GBVZEBwNmtN7ZmwoiArFPF+DR6M3y1OLEu4zu2aieU+OaLbv/KRgxDMWyVknwmccjrayfll4oc3S61mvNdRQclwWB4UUatXfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751042875; c=relaxed/simple;
	bh=+d0Snwx5bxRyQXelofUzjbjtGgPuctg9nXy7bfF/PnI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EcxSM4tdopYbiF/jWyuEbgvzLdRwdAQu9B+P0ABY2ynLc5bMQ6d6R5nmU0aI4cgOCP3IuIejDKUqF468jrHZuZdff8yemSqRd+cSQPeWdsGltDFG3FvrsfNA7fJKrYX3z4YRStHrwrK9QM3wjxCT+HkPlx6vEPCNuaSgoQfpyCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NsFnbEue; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NsFnbEue"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a6cdc27438so20563f8f.2;
        Fri, 27 Jun 2025 09:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751042872; x=1751647672; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+d0Snwx5bxRyQXelofUzjbjtGgPuctg9nXy7bfF/PnI=;
        b=NsFnbEueGNlOsOACU62HGULSF1AILrEJ5t04CYR6NjggH0b67wl6J8Mg5f/jSFG96R
         jUj1TPuT2XyYIBOUkXcF+lj0PmQfoou2eG8DierOglNQ5pdKcSA+/V/YcZ62lv95zbX8
         wbDew4vEUjGaPQqqT5XkRs889UGQtV4lz7M75WdgPx3cXwgmfQc3giJrN7MvMB9r9D3D
         u644bauksDH5wTvAw91ifnSZzXc97TdVaq4rnq46j7+CUy9DNdCL3G+rmZWZ+09NUb7s
         my9D646AwlAN938kPJwmwxFCw2LGEFz5ERH6J95OW+vttJc1kiY1+cRjt86WkKFNzJ13
         8OKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751042872; x=1751647672;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+d0Snwx5bxRyQXelofUzjbjtGgPuctg9nXy7bfF/PnI=;
        b=lQN21aUnKchJJgl6TVkv5ygPgpBSH6fgEyQFXJzBh2+095nxqTtXrnIYfqAvGcsFtU
         ENY66jGpYISRVkT8gZUmdDz0I2rwgdPmI6dmvpGD8CNhUWyhzQw9HRDIRrNqNgCW1vs0
         Upho/+VDJw92rtrnf+DUYdkDFloYLGGBIuLh7hRYnnJIqn3ye806V9sflF7VJgDriLN/
         OY+SSihb1GPXurGWyZN2OiE2uVojKxZOt7z2OMGL1a8++YwxhoS0o2ikhS2MshAcl3vD
         q9TECJgrDOvsKqFYfHtqGgKYzNBRtnoOVG/zuGr36pDOfy/A5QXdgohySqYVB2kUEQ/j
         VbZw==
X-Forwarded-Encrypted: i=1; AJvYcCUEMTlLv49FFmC2D99c+SeG6CxLSP2Y821bmS73Raj7CX6rqtlXGaNeCxXBPOgLay9+FnipQ9Jl8h1l6wZH3xw=@vger.kernel.org, AJvYcCW/y+v/Bq6HmdXbMWxev4iYtKFc+0GeXT7iFhX8jvZwuqBwkgS6tAwY1aLAzMzN+2aw5khEab0cNh6vzDzD@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6ATmZ0gCBElJDxO06GKwbmFkVvyyo14MYBEGv820KoCoooXw4
	U6gfINTVFZ5ALeRD5uEpfMmksfimbZSbjO3ekkjEK6fMcT2qHeouGYXE
X-Gm-Gg: ASbGnctJdpyTCMr1oTju8eAs/i2UVFPwaCD3XR3mPDz7RpRHheXv6cKS6YORAPr9/Fw
	3Ns/olpiABE+yakboAuA6pXGwhBmki6l6kWhG4UbC0YRtAr0Gq2fFTP2FPkMQsvZmDEe2DWvF/4
	H/RdSywlUiJyl6pkkfd4FF5PgzXRMEMkbWwGmJHQd02TeaALkgBouMpTx1dZbo8Om+QB1fC5GWF
	H2I/SKnil7EBT9UmLAedycMjHrudxGgoaz2P3KXYF9kLhgw/VR6Qop9xilDD8D50DWBSugEU7wK
	IFqC2A+pV9iuFTVD9KZefdRtWElVps3tsrvNiZnwP/3nFOHz8D4HtTwHYJoD4BI/MMJpDluHILC
	lk48=
X-Google-Smtp-Source: AGHT+IHWjz7Ej3wEAPJIpFJFOdmPWjsE48+WWC4CRp2XJR1uDTR0yvYuXeK6Qw+cEsB+rWEhog+aQg==
X-Received: by 2002:adf:9c89:0:b0:3a5:300d:ead0 with SMTP id ffacd0b85a97d-3a8fe5b1b0cmr3447794f8f.43.1751042871609;
        Fri, 27 Jun 2025 09:47:51 -0700 (PDT)
Received: from [192.168.1.201] ([87.254.0.133])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a88c7e71dfsm3097831f8f.7.2025.06.27.09.47.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jun 2025 09:47:50 -0700 (PDT)
Message-ID: <7d618e76-5eab-4e4f-90af-18501c0f9035@gmail.com>
Date: Fri, 27 Jun 2025 17:47:27 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] fortify: add branch hints on unlikely fortify_panic
 paths
To: Kees Cook <kees@kernel.org>
Cc: linux-hardening@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250625161221.295575-1-colin.i.king@gmail.com>
 <202506270935.283087E22D@keescook>
Content-Language: en-US
From: "Colin King (gmail)" <colin.i.king@gmail.com>
Autocrypt: addr=colin.i.king@gmail.com; keydata=
 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
 FVPMkxl2UyaayDvhrO9kNXvl1SKCpdzCMQ==
In-Reply-To: <202506270935.283087E22D@keescook>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------sb31CwcuUKCH5b7jgC6oA1vD"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------sb31CwcuUKCH5b7jgC6oA1vD
Content-Type: multipart/mixed; boundary="------------pZR4LXDAW1UzawmNusDTLIBi";
 protected-headers="v1"
From: "Colin King (gmail)" <colin.i.king@gmail.com>
To: Kees Cook <kees@kernel.org>
Cc: linux-hardening@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <7d618e76-5eab-4e4f-90af-18501c0f9035@gmail.com>
Subject: Re: [PATCH][next] fortify: add branch hints on unlikely fortify_panic
 paths
References: <20250625161221.295575-1-colin.i.king@gmail.com>
 <202506270935.283087E22D@keescook>
In-Reply-To: <202506270935.283087E22D@keescook>

--------------pZR4LXDAW1UzawmNusDTLIBi
Content-Type: multipart/mixed; boundary="------------fjHF8UKmjaMHR25Ihe28wV3k"

--------------fjHF8UKmjaMHR25Ihe28wV3k
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjcvMDYvMjAyNSAxNzozNiwgS2VlcyBDb29rIHdyb3RlOg0KPiBPbiBXZWQsIEp1biAy
NSwgMjAyNSBhdCAwNToxMjoyMFBNICswMTAwLCBDb2xpbiBJYW4gS2luZyB3cm90ZToNCj4+
IEFuYWx5c2lzIHdpdGggZ2NvdiB3aGlsZSBydW5uaW5nIHRoZSBzdHJlc3MtbmcgdXJhbmRv
bSBzdHJlc3Nvcg0KPj4gc2hvd3MgdGhhdCB0aGVyZSBhcmUgYSBjb3VwbGUgb2YgZm9ydGlm
eSBwYW5pYyBwYXRocyB0aGF0IGFyZSBoaWdobHkNCj4+IHVubGlrZWx5IHRvIGJlIGV4ZWN1
dGVkIGZvciB3ZWxsLWJlaGF2aW5nIGNvZGUuIEFkZGluZyBhcHByb3ByaWF0ZQ0KPj4gYnJh
bmNoIGhpbnRzIGltcHJvdmVzIHRoZSBzdHJlc3MtbmcgdXJhbmRvbSBzdHJlc3NvciBteSBh
IHNtYWxsDQo+PiBidXQgc3RhdGlzdGljYWxseSBtZWFzdXJlYWJsZSBhbW91bnQuIFJhbiAx
MDAgeCAxIG1pbnV0ZSB0ZXN0cyBhbmQNCj4+IG1lYXN1cmVkIHRoZSBzdHJlc3NvciBib2dv
LW9wIHJhdGVzIG9uIGEgRGViaWFuIGJhc2VkIEludGVsKFIpDQo+PiBDb3JlKFRNKSBVbHRy
YSA5IDI4NUsgd2l0aCBhIDYuMTUga2VybmVsIHdpdGggdHVyYm8gZGlzYWJsZWQgdG8NCj4+
IHJlZHVjZSBqaXR0ZXIuDQo+Pg0KPj4gUmVzdWx0cyBiYXNlZCBvbiBhIEdlb21ldGljIE1l
YW4gb2YgMTAwIHRlc3RzOg0KPj4NCj4+IFdpdGhvdXQgcGF0Y2g6IDUwNTEyLjk1IGJvZ28t
b3BzL3NlYw0KPj4gV2l0aCBwYXRjaDogICAgNTA4MTkuNTggYm9nby1vcHMvc2VjDQo+Pg0K
Pj4gJVN0ZC5EZXZpYXRpb24gb2YgfjAuMTglLCBzbyBsb3cgaml0dGVyIGluIHJlc3VsdHMs
IGltcHJvdmVtZW50IG9mIH4wLjYlDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogQ29saW4gSWFu
IEtpbmcgPGNvbGluLmkua2luZ0BnbWFpbC5jb20+DQo+IA0KPiBOaWNlIGZpbmQhIEl0IHNl
ZW1zIHNvbWUgZnRyYWNlIGNvbmZpZ3MgYXJlIHVuaGFwcHkgd2l0aCB0aGlzIGNoYW5nZSwN
Cj4gdGhvdWdoPw0KDQpJJ2xsIHJlc2VuZCBvbmNlIEkgZ2V0IHNvbWUgdGltZSB0byBmaWd1
cmUgb3V0IHRoZSBpc3N1ZXMgd2l0aCB0aGUgDQpmdHJhY2UgY29uZmlncw0KDQpDb2xpbg0K
PiANCj4gLUtlZXMNCj4gDQoNCg==
--------------fjHF8UKmjaMHR25Ihe28wV3k
Content-Type: application/pgp-keys; name="OpenPGP_0x68C287DFC6A80226.asc"
Content-Disposition: attachment; filename="OpenPGP_0x68C287DFC6A80226.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsFNBE6TJCgBEACo6nMNvy06zNKj5tiwDsXXS+LhT+LwtEsy9EnraKYXAf2xwazc
ICSjX06efanlyhB0figzQO0n/tP7BcfMVNG7n1+DC71mSyRK1ZERcG1523ajvdZO
xbBCTvTitYOy3bjs+LXKqeVMhK3mRvdTjjmVpWnWqJ1LL+Hn12ysDVVfkbtuIm2N
oaSEC8Ae8LSSyCMecd22d9PnLR4UeFgrWEkQsqROq6ZDJT9pBLGe1ZS0pVGhkRyB
P9GP65oPev39SmfAx9R92SYJygCy0pPvBMWKvEZS/7bpetPNx6l2xu9UvwoeEbpz
UvH26PHO3DDAv0ynJugPCoxlGPVf3zcfGQxy3otydNTWkP6Wh3Q85m+AlifgKZud
jZLrO6c+fAw/jFu1UMjNuyhgShtFU7NvEzL3RqzFf9O1qM2muj83IeFQ1FZ65QAi
CdTa3npz1vHc7N4uEQBUxyXgXfCI+A5yDnjHwzU0Y3RYS52TA3nfa08yLGPLTf5w
yAREkFYou20vh5vRvPASoXx6auVf1MuxokDShVhxLpryBnlKCobs4voxN54BUO7m
zuERXN8kadsxGFzItAyfKYzEiJrpUB1yhm78AecDyiPlMjl99xXk0zs9lcKriaBy
VUv/NsyJFQj/kmdxox3XHi9K29kopFszm1tFiDwCFr/xumbZcMY17Yi2bQARAQAB
zSdDb2xpbiBJYW4gS2luZyA8Y29saW4uaS5raW5nQGdtYWlsLmNvbT7CwZEEEwEI
ADsCGwMFCwkIBwMFFQoJCAsFFgIDAQACHgECF4AWIQRwYtqk8AG5xmFnAM9owoff
xqgCJgUCY8GcawIZAQAKCRBowoffxqgCJtd/EACIWcaxfVt/MH4qqo5ELsjCFPVp
+RhVpQDWy8v9Np2YbTcZ4AY2Zj4Pq/HrZ3F/Bh02v85C6mNv8BDTKev6Qcq3BYw0
iqw6/xLNvRcSFHM81mQI9xtnAWIWfI9k5hpX19QooPIIP3GOMdMc1uRUGTxTgTFA
AsAswRY3kMzo6k7arQnUs9zbiZ9SmS43qWOIxzGnvneekHHDAcomc/oho7kgj6rK
p/f9qRrhForkgVQwdj6iBlW934yRXzeFVF3wr7Lk5GQNIEkJiNQPZs54ojBS/Kx6
3UTLT1HgOp6UY9RPEi9wubmUR+J6YjLRZMr5PCcA86EYmRoysnnJ8Q/SlBVD8npp
GVEcuvrbH3MBfhmwOPDc3RyLkEtKfSTB92k1hsmRkx9zkyuUzhcSnqQnpWGJD+xt
KHvcHRT7Uxaa+SDwUDM36BjkyVcZQy8c+Is2jA55uwNgPpiA7n82pTeT+FRGd+7i
CLQHaryu6FO6DNDv09RbPBjIiC/q814aeKJaSILP1ld9/PEBrLPdm+6lG6OKOt9D
DV6jPmfR96FydjxcmI1cgZVgPomSxv2JB1erOggB8rmX4hhWYsVQl1AXZs3LdEpJ
6clmCPspn/ufZxHslgR9/WR1EvPMQc8XtssF55p8ehRIcVSXDRcMFr3ZuqMTXcL6
8YbDmv5OGS95O1Gs4c0iQ29saW4gS2luZyA8Y29saW4ua2luZ0B1YnVudHUuY29t
PsLBdwQTAQgAIQUCTwq47wIbAwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgAAKCRBo
woffxqgCJo1bD/4gPIQ0Muy5TGHqTQ/bSiQ9oWjS5rAQvsrsVwcm2Ka7Uo8LzG8e
grZrYieJxn3Qc22b98TiT6/5+sMa3XxhxBZ9FvALve175NPOz+2pQsAV88tR5NWk
5YSzhrpzi7+klkWEVAB71hKFZcT0qNlDSeg9NXfbXOyCVNPDJQJfrtOPEuutuRuU
hrXziaRchqmlhmszKZGHWybmPWnDQEAJdRs2Twwsi68WgScqapqd1vq2+5vWqzUT
JcoHrxVOnlBq0e0IlbrpkxnmxhfQ+tx/Sw9BP9RITgOEFh6tf7uwly6/aqNWMgFL
WACArNMMkWyOsFj8ouSMjk4lglT96ksVeCUfKqvCYRhMMUuXxAe+q/lxsXC+6qok
Jlcd25I5U+hZ52pz3A+0bDDgIDXKXn7VbKooJxTwN1x2g3nsOLffXn/sCsIoslO4
6nbr0rfGpi1YqeXcTdU2Cqlj2riBy9xNgCiCrqrGfX7VCdzVwpQHyNxBzzGG6JOm
9OJ2UlpgbbSh6/GJFReW+I62mzC5VaAoPgxmH38g0mA8MvRT7yVpLep331F3Inmq
4nkpRxLd39dgj6ejjkfMhWVpSEmCnQ/Tw81z/ZCWExFp6+3Q933hGSvifTecKQlO
x736wORwjjCYH/A3H7HK4/R9kKfL2xKzD+42ejmGqQjleTGUulue8JRtpM1AQ29s
aW4gSWFuIEtpbmcgKEludGVsIENvbGluIElhbiBLaW5nIGtleSkgPGNvbGluLmtp
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
=3DQKm6
-----END PGP PUBLIC KEY BLOCK-----

--------------fjHF8UKmjaMHR25Ihe28wV3k--

--------------pZR4LXDAW1UzawmNusDTLIBi--

--------------sb31CwcuUKCH5b7jgC6oA1vD
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEcGLapPABucZhZwDPaMKH38aoAiYFAmheyyAFAwAAAAAACgkQaMKH38aoAiZo
hhAAiN3X4IGv0p6og/JfXYgB2E2Hcrasjvs/Y1ebzogD/v+ocY8DHNkT45KsbBL8iTExq6aKzGad
n1yJXPI0nzHNrNNna3iIeS6KbkldbVmlc2nsIKTAXv77S/6g5qmjcAdYg0liR2pzbj6AXbrBQusF
QMVzn3SEO/UOI1oAx2hCGgpE248Sf05VbONeZFtgqVtiV9Ya2O3TOF0ktXfvSLehx9HPU3NZs/gI
BbgEOrAd3a0NqBVpt3xxWveqs7tUCPPXns2Pt7mSBrH/rWeGNbHK5+FN93xTIGUqSf4Nq3sUllQ6
5IEwT4Nu4+EO29OGucn6QXuBNa6TZW/accPplRbhWSngUE0uYJYw08Rcs63eCmzksfbwLvUOe9R+
mKwsxOhMADkJt0ZTwiKn7jkFCN/U7z4ajgVAv55MbzMvwO1DpOdV9EyaXxefKygb39kKJQSXCmbN
mK2h9rCfwn0NNsziG/6x64NOjAJ2kPwGKUhKCYvt7IkfyWCfdNpw1JphnamEwbgsqHcwTcPztn0k
sC8oLVxvbni4KmW102wgYJ3q3UBqs2NydnJWGq41mScz+XzSa891Pv8Gx4ztqR/KuiKnUxSKOMZ1
rH8IIAHCIgD4TS37j9cPwxAxevBEd7R+W41kmO9HCJw+bFqhYPm4GmmNYdoQk83zybTCOxjUPKSm
OCg=
=EhPn
-----END PGP SIGNATURE-----

--------------sb31CwcuUKCH5b7jgC6oA1vD--
