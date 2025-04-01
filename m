Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BAF1E5B6F;
	Tue,  1 Apr 2025 21:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743543250; cv=none; b=Jeo08NjI7iDu+oWM2EaQXalisk3ayYxIDn5937kb2nBxLhuAzIFV3mnGzEgDQwxhqHtQl2fAFW/Iktt7FjD3kJ6tmgkOZu4o/qV1SkKf2699AOgJZX67P5zONYYkgdUqYeccRsIJ9Xytwg6fp5up0LCxtNbLNyUwrVZsOq7qwV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743543250; c=relaxed/simple;
	bh=pJQFVxaGGpdujsKrRjjsVWBBjbvfFCiBxMCHUBxhUyE=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=ag7VpiRtLXopAvfaguQx7ECDeLECdoJwBgkWEm9jNrBgBgu8Hu9R9lV+HnaIJ2WA0vvkiUTRGzBZcqkEx5eO+tCvCK4D2ok+FSyOw/4VVp8c7Fm0cFjpTnnlarJKMiwOl5BzZCCG1FVDhfVcIM+6GCLNplTkOm9ZWvMz6HtWMho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nB5LHv61; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nB5LHv61"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-476a304a8edso55906761cf.3;
        Tue, 01 Apr 2025 14:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743543247; x=1744148047; darn=vger.kernel.org;
        h=autocrypt:subject:from:to:content-language:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pJQFVxaGGpdujsKrRjjsVWBBjbvfFCiBxMCHUBxhUyE=;
        b=nB5LHv61kQdslvpSqUP1MiucDBE7OltNt7ElWsjTZ65Tam4BUrAs4o1Nfc3CalyfG2
         N/swIdaD60CL+llmFzJKAO71biE8wYzv7+6M7Esf6kIyfynarCADfy3jD3+xQ68smHC9
         478qpGUnXw15m8m72/ejfMVoV4RqHi9KQnlSoEfs0aO4/8hr4VNdMKTLM3f8ZuEGbQTI
         PPbqLNdJnDMMZDTptleWqJ+3RwXqBhVV49WHGcwPZqkPsCyCWmN215xKARVfgpYHk9bE
         yYBldXyl32XxVsvf0fxkpMd5xqGNztmScWMCo7RW5QGQ6DS07T78YA169uYgfVSdaTqY
         tjmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743543247; x=1744148047;
        h=autocrypt:subject:from:to:content-language:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pJQFVxaGGpdujsKrRjjsVWBBjbvfFCiBxMCHUBxhUyE=;
        b=Gjflruk3edScd7tQUG1l6dGOXoDL1YR/fDbPNJGV5xr7Kxzfty0sWzIk7rABB2f+3d
         U0ZeJCti6B2U3s74tS7vjJ+FuauG5xdtQbkZpork2Oixj4jG6WzsCYaijRU9Ea429EZ1
         7dyV7ynmwawlGnNuN7IrVelq9B/MgzkcWVQYZveXarZxtgui72keNBoipAZGwZDZhU/+
         +XzcG1/f9hhszYh8U28Vj1fVaabngeeC5+M0fJJaFFmzSRiw4/Dgn37/AwoPprOvLncS
         WEWA7hvWfbaiFJqqWkJRikHfQjHmw9zgyQSO/aST2hqOfL+k4JOgGvNTgJNaQrTdh8vi
         zkMg==
X-Forwarded-Encrypted: i=1; AJvYcCUgH0zXNBwAQiCJAktXwkaFNQu2AnVeBnsnf9+voD1ZUsInrD6iTmcYZN+aLHiVNX2y7ivUJZx+InKgbDCy@vger.kernel.org, AJvYcCXW6AmvzFVU0w8MhQEYTU82t7Zb9m1M/yYZxVMWHeeGkRU8Y0Zer45mzZJ/dGK9cco84jcosWivx2hu47bScmY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQtQeMxm9jKGZyL1xIp4U5mGs5fvna3Js0LQW4xMrxSO5kVKZM
	XTh1IZ/MjDd0t+rVg+SBAKSuo6bfhOLXf2jz7yvJIks/C2e29IH3
X-Gm-Gg: ASbGnctfsGGSPzAILnJbDgqh7JyMJ1CVa6rVWeTUZAn4XXspf61q3xc22eFuwzHlBGb
	7PqGJDx14czRx0bE1gxD9kfAFxwYs3L0FJ/5RanmqMqvLc0KfiiyMGxc26B+oTDX1EfAXZoMhDZ
	rTmoXPUH5XaaKH8oOUhP5x83tssVEnZtqNZkeO5okMDgGwaISMmCjYb1jJxefU6j586RfgQQ0FF
	RCxFJ1/Y6ONynuOtPkZi8g5TWcwF6EouL1gvV4c4I3Epwpfj5Z4hzxAno90RKHDhNKb0xhJ0jC2
	tP9mrWfeJl3IxiaiknntcY8lBFWJ/foQesL6UBFfVMrIW9kV/E6SlVOG2YScR6Hx8RJqegiDflI
	LRCDmEaF+GsvjOfMqvke+t2u/O+0kgRxTbiU=
X-Google-Smtp-Source: AGHT+IEsbBOqInzibqwnq8k3tqars5ay5/0pUy+dP8dqjIwEuH2JFoKpgMYjD2nAO+TesZTI1GVTeQ==
X-Received: by 2002:a05:622a:296:b0:477:cb9:13b0 with SMTP id d75a77b69052e-47909f4f87amr954001cf.7.1743543247250;
        Tue, 01 Apr 2025 14:34:07 -0700 (PDT)
Received: from [192.168.2.11] (bras-base-otwaon1093w-grc-60-174-89-30-36.dsl.bell.ca. [174.89.30.36])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5f7682b88sm707270085a.32.2025.04.01.14.34.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Apr 2025 14:34:06 -0700 (PDT)
Message-ID: <d8375c5b-03d6-4c24-83c1-483f0093c48d@gmail.com>
Date: Tue, 1 Apr 2025 17:34:05 -0400
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Icedove Daily
Content-Language: en-US
To: kees@kernel.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: Tadhg McDonald-Jensen <tadhgmister@gmail.com>
Subject: cross compile fails with GCC_PLUGIN_LATENT_ENTROPY
Autocrypt: addr=tadhgmister@gmail.com; keydata=
 xjMEZ3rpXBYJKwYBBAHaRw8BAQdAYDEhZ488BxMM8Md8rbPVN9LQYm5t0mEbfYA4muH4+TfN
 LVRhZGhnIE1jRG9uYWxkLUplbnNlbiA8dGFkaGdtaXN0ZXJAZ21haWwuY29tPsKPBBMWCAA3
 FiEE9UIQxuXDjUBQBc31hcDI3Lv0TucFAmd66VwFCQWjmoACGwMECwkIBwUVCAkKCwUWAgMB
 AAAKCRCFwMjcu/RO5yvRAPwIopAhcFwcgpAeh34s1MgV17YZOqpyNfkoj3RP2sW4GwEAk43y
 9ATcrGsZg3rrnpo6bmedY8ssPsOPvalB2W8Gyg/OOARneuldEgorBgEEAZdVAQUBAQdAFPa4
 7FHJdQf1AlwPz0ewUAPhB4c1pmGJntgFQgTvqGUDAQgHwn4EGBYIACYWIQT1QhDG5cONQFAF
 zfWFwMjcu/RO5wUCZ3rpXQUJBaOagAIbDAAKCRCFwMjcu/RO58X0AQD3umRLqs0tnYZ1HjK1
 FZM7HKaLgW8UBMgk+s+b3bAHHAEA3wlt2RuX9me3oGTi+gSCIsX856/Wx5b7db5SWmG5Ugw=
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------V8H4fRzQZlNYoBZQPsk08ibT"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------V8H4fRzQZlNYoBZQPsk08ibT
Content-Type: multipart/mixed; boundary="------------HwasvmjwvDRxUWCEOncAeSs0";
 protected-headers="v1"
From: Tadhg McDonald-Jensen <tadhgmister@gmail.com>
To: kees@kernel.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <d8375c5b-03d6-4c24-83c1-483f0093c48d@gmail.com>
Subject: cross compile fails with GCC_PLUGIN_LATENT_ENTROPY

--------------HwasvmjwvDRxUWCEOncAeSs0
Content-Type: multipart/mixed; boundary="------------D9Y9xazbVSMI51lVRdkGTwtG"

--------------D9Y9xazbVSMI51lVRdkGTwtG
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello,

When cross compiling the linux kernel with
`CONFIG_GCC_PLUGIN_LATENT_ENTROPY=3Dy` it tries to compile the plugin for=

the target platform instead of for the host machine causing the
compilation to fail.

I've opened a bug on bugzilla:
https://bugzilla.kernel.org/show_bug.cgi?id=3D219973

Specifically I am using GNU guix and trying to compile with `ARCH=3Darm`
and `CROSS_COMPILE=3Darm-linux-gnueabihf`, in guix the include paths are
setup in a non typical way so if that is relevant to this error I am
happy to provide more detail, but hopefully just the output of make
showing `CC scripts/gcc-plugins/latent_entropy_plugin.o` instead of
`HOSTCC` like many other files in the scripts folder is sufficient to
reproduce and solve this issue.

Kind Regards,
Tadhg McDonald-Jensen
--------------D9Y9xazbVSMI51lVRdkGTwtG
Content-Type: application/pgp-keys; name="OpenPGP_0x85C0C8DCBBF44EE7.asc"
Content-Disposition: attachment; filename="OpenPGP_0x85C0C8DCBBF44EE7.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xjMEZ3rpXBYJKwYBBAHaRw8BAQdAYDEhZ488BxMM8Md8rbPVN9LQYm5t0mEbfYA4
muH4+TfNLVRhZGhnIE1jRG9uYWxkLUplbnNlbiA8dGFkaGdtaXN0ZXJAZ21haWwu
Y29tPsKPBBMWCAA3FiEE9UIQxuXDjUBQBc31hcDI3Lv0TucFAmd66VwFCQWjmoAC
GwMECwkIBwUVCAkKCwUWAgMBAAAKCRCFwMjcu/RO5yvRAPwIopAhcFwcgpAeh34s
1MgV17YZOqpyNfkoj3RP2sW4GwEAk43y9ATcrGsZg3rrnpo6bmedY8ssPsOPvalB
2W8Gyg/OOARneuldEgorBgEEAZdVAQUBAQdAFPa47FHJdQf1AlwPz0ewUAPhB4c1
pmGJntgFQgTvqGUDAQgHwn4EGBYIACYWIQT1QhDG5cONQFAFzfWFwMjcu/RO5wUC
Z3rpXQUJBaOagAIbDAAKCRCFwMjcu/RO58X0AQD3umRLqs0tnYZ1HjK1FZM7HKaL
gW8UBMgk+s+b3bAHHAEA3wlt2RuX9me3oGTi+gSCIsX856/Wx5b7db5SWmG5Ugw=3D
=3DmvH2
-----END PGP PUBLIC KEY BLOCK-----

--------------D9Y9xazbVSMI51lVRdkGTwtG--

--------------HwasvmjwvDRxUWCEOncAeSs0--

--------------V8H4fRzQZlNYoBZQPsk08ibT
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQT1QhDG5cONQFAFzfWFwMjcu/RO5wUCZ+xbzQUDAAAAAAAKCRCFwMjcu/RO51IM
AQCuWN9bZcJ8mObj2mq5wGi1K2k6iC5h7JK6zWwZTXY5pwEAsMLIyjr1Mdd1QW6HOschXSSrTODN
cCkT6RpxPKieLQk=
=Unqj
-----END PGP SIGNATURE-----

--------------V8H4fRzQZlNYoBZQPsk08ibT--
