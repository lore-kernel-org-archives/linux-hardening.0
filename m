Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF290155C97;
	Wed,  9 Apr 2025 21:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744233660; cv=none; b=qztsdxydtB0sz86Ld5sv3nwMlCO432QsDJeECnGnCXLGZ5agvKbjktfNk5G/c5alE/qHLrnztgngtF37Gnhb4mo/GiJSVBh8BTA68Ij9rkFfh6FFAye5TO/wE3ZnKU9vkUtXzqzrg4//kzTSfZKPsIvIemHDUdantF7emFJKOc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744233660; c=relaxed/simple;
	bh=Jp51whNFbljVvi7E/vANqPQEnhEvLvVfhaaM4dQ9oYg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=j134OQ302YEf+051zqPsph7A/Il3PhCdDZXD5rf2yiu44XzixkyI37OfI+QgPhy08vV3CI1w23coPe5vuWV2OBOWzwWkiM7bMB6qc59y9ayjSFa0nKnyS9W92EY6mknQmOPUMt981EsxOdavR7C+81peMTjQDC60WnDszs/B4l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UZOyvt6n; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZOyvt6n"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c5ba363f1aso20684085a.0;
        Wed, 09 Apr 2025 14:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744233657; x=1744838457; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:content-language:references:cc:to:subject
         :from:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1qqC44u6zJ/dYw8F5+CSfEmn4SaoTHgLswF3GpMzOqw=;
        b=UZOyvt6nduMEgLjyIRzkCaxhMerp/m5X2WvwQOnDp4P6LMCCs+PgAM4f8K9mAYEr29
         q8AcRhmyAnajQ/ZOk/qcUdlRdSEcecZAHGi4m9xjbeHHNoCAu/DXsxYvhUMRo99H7Jb5
         jxHmrbE3fnZhh7UUMylJmTgkbC5otZjj7LkZJWCqg7EdsPs2mZDMl3oxEbUseNdHlcOm
         2PaO7F1Z+5sQG3pB/A+6G0BHdQsJMKNVgSsu4pkU7OND9kzEruzcaY6dl3gSoWGsCvhU
         nLD7QDnRg1fnPBRLbrpBlK6q+9bOULWbEi3Uyhwqajitovy1uiQAyjqX5fFGqDjB66bR
         PtzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744233657; x=1744838457;
        h=in-reply-to:autocrypt:content-language:references:cc:to:subject
         :from:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1qqC44u6zJ/dYw8F5+CSfEmn4SaoTHgLswF3GpMzOqw=;
        b=R7ihVhG9eb0OCmRdk2Mzgx/IvBm5BcPhmbp8asxdQQreVI3fpinq+zo/jyq6w0hv3b
         jshYJN4up/wFgMI8plyubb5FTvYLXDqf4yHZdw4I9givxPiBLtOVzerMTeku91Vg9zq1
         HMiu41crNiRsgpg6QeQasE9P319Z1XuhTOYhYkDD7Vb9rnkp14C7+P0R2fEdwwH/ebQQ
         PtHGxqDFycWUiQrxRuf8IPI2GARfGy5IrldqB2o+ttWgDy0Z+kfMp8HeoVinjL3wDLRY
         siY6Q/gjn2FH7WeE0llwiM/sOclCXAwoEsLN21HNQf7Ptcc692Y5DCHUpVEPncDOpTHv
         9bJQ==
X-Forwarded-Encrypted: i=1; AJvYcCURkvCtmkbbzJRMgmuj/+5t1CgevB6Kz24jlLXtFCTU6AmJmKilo3nQUW8aAFTML6taM0Lftuy2A8V3vyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvACEwB3nN5xbGpirJ9+F0oXmkXqdFlmi7e3biRpkc2AZpPwWf
	cegl46w6qs0p838lOBR1FCTVQj08QqbMuecEjX8xBMSDepcoj+bFP2yAhNU/Kcw=
X-Gm-Gg: ASbGncuhOwQvuOJaBR0MUiT+otwxQKhLw8rjflOGplVe5G5R7N9uLZN7letFU0xfL/j
	fz64JBHihekOJqy+O1W19t0yk0+6Pk0j0hYxVqacd9ndcJI1Q4J5EMg17c2nPw4jn5vWGiBdcEk
	IR5DKFo8HFfyXErHpAIjcvCaa53vm+zQ796me9N5wBqw7PX2OFuZdHR+tvE+3g4AOpFg5G0XSKg
	4IsfJV31bvH4RcdoYDbsE06L31ihW+V4Cgyt1LbIhI7tXozGptM8rpRfs4I3ZTfTqKEwhAn4XNx
	SFmQM+UPt8FU9s52VOw9H6wr1zmE9ZKWVc3/yrazdpGm
X-Google-Smtp-Source: AGHT+IGhQm1RrqAVwjKt/f6zVcNz5NVth2ngWDdzmpn4R6UIeSbWM02LqLPJtM5jJbYrKurtS+81kw==
X-Received: by 2002:a05:620a:f0b:b0:7c5:61b2:b84 with SMTP id af79cd13be357-7c7a766e493mr45342785a.19.1744233657585;
        Wed, 09 Apr 2025 14:20:57 -0700 (PDT)
Received: from [192.168.2.11] ([174.89.30.36])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f0de982641sm11727356d6.68.2025.04.09.14.20.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 14:20:56 -0700 (PDT)
Message-ID: <7f679eb9-9641-4d79-aaa0-1f11d3754f9b@gmail.com>
Date: Wed, 9 Apr 2025 17:20:45 -0400
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Icedove Daily
From: Tadhg McDonald-Jensen <tadhgmister@gmail.com>
Subject: Re: cross compile fails with GCC_PLUGIN_LATENT_ENTROPY
To: Kees Cook <kees@kernel.org>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
References: <d8375c5b-03d6-4c24-83c1-483f0093c48d@gmail.com>
 <202504041030.FDB5E355F@keescook>
Content-Language: en-US
Autocrypt: addr=tadhgmister@gmail.com; keydata=
 xjMEZ3rpXBYJKwYBBAHaRw8BAQdAYDEhZ488BxMM8Md8rbPVN9LQYm5t0mEbfYA4muH4+TfN
 LVRhZGhnIE1jRG9uYWxkLUplbnNlbiA8dGFkaGdtaXN0ZXJAZ21haWwuY29tPsKPBBMWCAA3
 FiEE9UIQxuXDjUBQBc31hcDI3Lv0TucFAmd66VwFCQWjmoACGwMECwkIBwUVCAkKCwUWAgMB
 AAAKCRCFwMjcu/RO5yvRAPwIopAhcFwcgpAeh34s1MgV17YZOqpyNfkoj3RP2sW4GwEAk43y
 9ATcrGsZg3rrnpo6bmedY8ssPsOPvalB2W8Gyg/OOARneuldEgorBgEEAZdVAQUBAQdAFPa4
 7FHJdQf1AlwPz0ewUAPhB4c1pmGJntgFQgTvqGUDAQgHwn4EGBYIACYWIQT1QhDG5cONQFAF
 zfWFwMjcu/RO5wUCZ3rpXQUJBaOagAIbDAAKCRCFwMjcu/RO58X0AQD3umRLqs0tnYZ1HjK1
 FZM7HKaLgW8UBMgk+s+b3bAHHAEA3wlt2RuX9me3oGTi+gSCIsX856/Wx5b7db5SWmG5Ugw=
In-Reply-To: <202504041030.FDB5E355F@keescook>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Ue3JSkNF6SG3VhGa9mcNM8c4"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------Ue3JSkNF6SG3VhGa9mcNM8c4
Content-Type: multipart/mixed; boundary="------------taivhiqttIdkGcm1fNUrICeP";
 protected-headers="v1"
From: Tadhg McDonald-Jensen <tadhgmister@gmail.com>
To: Kees Cook <kees@kernel.org>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <7f679eb9-9641-4d79-aaa0-1f11d3754f9b@gmail.com>
Subject: Re: cross compile fails with GCC_PLUGIN_LATENT_ENTROPY
References: <d8375c5b-03d6-4c24-83c1-483f0093c48d@gmail.com>
 <202504041030.FDB5E355F@keescook>
In-Reply-To: <202504041030.FDB5E355F@keescook>

--------------taivhiqttIdkGcm1fNUrICeP
Content-Type: multipart/mixed; boundary="------------Y3bGARI9l8O9dwDXVpbbBGDD"

--------------Y3bGARI9l8O9dwDXVpbbBGDD
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Ok when I tried to get a minimal reproducible case I set it up
incorrectly, when the flag is enabled and you run `make scripts` it
prints `HOSTCXX scripts/gcc-plugins/latent_entropy_plugin.so` and gives
this error:

$ make scripts
  HOSTCXX scripts/gcc-plugins/latent_entropy_plugin.so
In file included from
/.../gcc-cross-arm-linux-gnueabihf-14.2.0/include/c++/bits/stl_pair.h:60,=

                 from
/.../gcc-cross-arm-linux-gnueabihf-14.2.0/include/c++/utility:69,
                 from
/.../gcc-cross-arm-linux-gnueabihf-14.2.0-lib/lib/gcc/arm-linux-gnueabihf=
/14.2.0/plugin/include/system.h:228,
                 from
/.../gcc-cross-arm-linux-gnueabihf-14.2.0-lib/lib/gcc/arm-linux-gnueabihf=
/14.2.0/plugin/include/gcc-plugin.h:28,
                 from scripts/gcc-plugins/gcc-common.h:7,
                 from scripts/gcc-plugins/latent_entropy_plugin.c:78:
/.../gcc-cross-arm-linux-gnueabihf-14.2.0/include/c++/type_traits:526:31:=

error: missing binary operator before token "("
  526 | #if _GLIBCXX_USE_BUILTIN_TRAIT(__is_array)
      |                            ^

It is honestly giving me a massive wall of errors from that file and
then some other errors from other c++ include files, should the plugin
even be using `HOSTCXX` or should it just be using `HOSTCC`?

Tadhg

On 2025-04-04 1:32 p.m., Kees Cook wrote:
> On Tue, Apr 01, 2025 at 05:34:05PM -0400, Tadhg McDonald-Jensen wrote:
>> Hello,
>>
>> When cross compiling the linux kernel with
>> `CONFIG_GCC_PLUGIN_LATENT_ENTROPY=3Dy` it tries to compile the plugin =
for
>> the target platform instead of for the host machine causing the
>> compilation to fail.
>>
>> I've opened a bug on bugzilla:
>> https://bugzilla.kernel.org/show_bug.cgi?id=3D219973
>>
>> Specifically I am using GNU guix and trying to compile with `ARCH=3Dar=
m`
>> and `CROSS_COMPILE=3Darm-linux-gnueabihf`, in guix the include paths a=
re
>> setup in a non typical way so if that is relevant to this error I am
>> happy to provide more detail, but hopefully just the output of make
>> showing `CC scripts/gcc-plugins/latent_entropy_plugin.o` instead of
>> `HOSTCC` like many other files in the scripts folder is sufficient to
>> reproduce and solve this issue.
>=20
> If the kernel's build system can't find the right includes, that would
> explain it. I'd check final depends line from scripts/gcc-plugins/Kconf=
ig:
>=20
> bool "GCC plugins"
>         depends on HAVE_GCC_PLUGINS
>         depends on CC_IS_GCC
>         depends on $(success,test -e $(shell,$(CC) -print-file-name=3Dp=
lugin)/include/plugin-version.h)
>=20
> Which validates the Makefile's use of that:
>=20
> GCC_PLUGINS_DIR =3D $(shell $(CC) -print-file-name=3Dplugin)
>=20
>=20
--------------Y3bGARI9l8O9dwDXVpbbBGDD
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

--------------Y3bGARI9l8O9dwDXVpbbBGDD--

--------------taivhiqttIdkGcm1fNUrICeP--

--------------Ue3JSkNF6SG3VhGa9mcNM8c4
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQT1QhDG5cONQFAFzfWFwMjcu/RO5wUCZ/bkrQUDAAAAAAAKCRCFwMjcu/RO50NY
AP9hJvK1AcfoJ63QzHRj+olHzpFy4FDjpSALIrxBgEd87AD+OWRpD7ChIQg0qB9HsdRLp35XaeTo
xMoCbdAocT9r0gY=
=TD9g
-----END PGP SIGNATURE-----

--------------Ue3JSkNF6SG3VhGa9mcNM8c4--
