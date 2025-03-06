Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1054B20896D
	for <linux-hardening@vger.kernel.org>; Thu,  6 Mar 2025 09:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741251610; cv=none; b=cKTAdf18uT+rxuDvuLjQ5lB7CNZMWKtA6CvLCfmjoFs52mCsvpui6A5hp83ZnJTfHDtkcSNETpvNrc2VCqsjwyfs2+crqp3R4/B4Ci5vRUue+wWhykA9Aoxxht4sWy8TC9sBqeR9tLTLwkFXZeXK/BR6VXD/ydGdv/8LaRFd5V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741251610; c=relaxed/simple;
	bh=jO4S7tfDSMWSWnaWKKxeEEfJD3b4DMVQbunGW43I1Iw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cHvq4ViY5StfVk768A0LYJXEiZkJ8eukpCdes6+S0ZcGmLSUhgWJR5k25Pw+vNOVnVxOVYmVeaSDniZxPkenAjf3WjHBLfuK/cNfUP8kZSfUwItcYCC+Rs3KEIG3r3zNX/fQEj2BaaW02Iya4pRWvH3uLqhfZC1u/tTJFAdx0pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ow+qY5Rk; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ow+qY5Rk"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c3d1b78b93so25863685a.0
        for <linux-hardening@vger.kernel.org>; Thu, 06 Mar 2025 01:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741251606; x=1741856406; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Se/VQkF64PHTLf1VaXKN3QA/AKHhKFbAav8V07/cZwk=;
        b=ow+qY5Rkzh9D1D1UEyLR5rFgpnGl21u8n4VK5yIYbIxIIdlNsYnPZPT3JJp0K0fes7
         2+PK2lv4xvu5/8n5sFUIx3k8L0blEc5ZT+iJb5Cc64/UYV+DVaDuqnx/0tT0mS+T1ZwR
         +FuwYzJa2yCO46WMQCGIuf9nPUo+AfRMBP12LO8UZ3kgiow3TGUiJisTTeDwMfBYu9tx
         B93daEqbIgYmyjhBSPhQbZF6Jfv49OUc887S2zgfR6uYf736VFuH00/GbJP4R5kqwWV3
         EBQixx/Uv4m8oMn+s6ue9QSrxat9CeNmMczi7PtH/pD/cJZ41CitJF+qYl9UY51UwJNj
         y8Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741251606; x=1741856406;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Se/VQkF64PHTLf1VaXKN3QA/AKHhKFbAav8V07/cZwk=;
        b=VV7BNg90FuOJlf2tEWBgdOYKS1wK6GJZF2f8J86rtR81nw0k8doFwHFKma7p5UZJ5G
         56QDb23XGUgxAnlkq+zjOrdVudo6HvijrrJgimMqK7n4UpBzW5OsPwPBP4v+FtKTwze9
         KvlnXWerwx5hk/QpNPvUJO+dcTgxhBsaER6fJcfG2IWDFjP94gMGlQZySsZJipMdF2a5
         N+yKJ4USzqUU6Goyc8MaR2mvTLhhXvKKCv2Fldag9Syii/0W2iOmhUA7GAq8QRaOpnhC
         U95pWf8WN3K2KwhpBNX3nlDeGWUiFc7XfB2+MXJjhHRBG80HXH0JyCInBGiWZw6e7aEi
         EODQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwSpjjbNc0yfj7xd2U8mQdDqzkzP4zfaX0XaaeDFzZ95AudEf46ncKSvfqcRxEdBmABCi7DEic7BWkML329EQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoLYBZytqq/lGaKK86eKFVRw2n+AGZhVQbSi79/0OcETKNz9zU
	XFfS7UGJm/aP5Ar1stz8caP32WbrwJ1tMUWpdK9dK9r77c0aGzLixbrRdzE6UOO+G8yN2mjvjKE
	tOQZ5bYozk0JhggowqtMxn3s1saC9oSDP1bS4
X-Gm-Gg: ASbGncsVZyb6xU5r8d0cKUU6sSuq5AiMbRfxmi9BzKvlpA0cIk/+VEc8hoffs5lERk+
	4G9WpJShKgSzVv0pbFmAVgyugcgKkVPAJ9UqkWZH+cyRXMPxteyHGuASOmUc1HP6ACey4UWhuPl
	qIAMjgrxCBG/lHiYXpTHugvcuZiCQ=
X-Google-Smtp-Source: AGHT+IHNmfIQro8bZ9rUp87wYfOLAinwzxeTujO3aZ6r35YV6zlRbtPOgdgDVVdRdtd9uOyFqAv8LvauzpzlR35Gz9E=
X-Received: by 2002:ad4:5f87:0:b0:6e6:682b:804d with SMTP id
 6a1803df08f44-6e8e6cffda0mr82434036d6.25.1741251605533; Thu, 06 Mar 2025
 01:00:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304162124.it.785-kees@kernel.org>
In-Reply-To: <20250304162124.it.785-kees@kernel.org>
From: David Gow <davidgow@google.com>
Date: Thu, 6 Mar 2025 16:59:53 +0800
X-Gm-Features: AQ5f1JpXdhcvQ-vxmG77qF-HLwsAihgcrX98W9RgxOkXaeqIx0QIaSB8R88urJY
Message-ID: <CABVgOSnEaTVUfZB6KACFJE4mM=oSWnUtcrf7ETHFq8h_k=mFTw@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: clang: Support building UM with SUBARCH=i386
To: Kees Cook <kees@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, llvm@lists.linux.dev, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000721c7c062fa8bb57"

--000000000000721c7c062fa8bb57
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 5 Mar 2025 at 00:21, Kees Cook <kees@kernel.org> wrote:
>
> The UM builds distinguish i386 from x86_64 via SUBARCH, but we don't
> support building i386 directly with Clang. To make SUBARCH work for
> i386 UM, we need to explicitly test for it.
>
> This lets me run i386 KUnit tests with Clang:
>
> $ ./tools/testing/kunit/kunit.py run \
>         --make_options LLVM=3D1 \
>         --make_options SUBARCH=3Di386
> ...
>
> Fixes: c7500c1b53bf ("um: Allow builds with Clang")
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---

Thanks for this -- I'd been using `--kconfig_add CONFIG_64BIT=3Dn` as a
way to build i386 UML kernels, which seems to work even without this
patch -- but this is definitely an improvement.

It may be worth noting that CONFIG_FORTIFY_SOURCE is incompatible with
clang + i386, which seems to affect UML as well. (That might actually
not be required, as I think UML doesn't use any of the strange
-mregparm calling convention stuff which appears to be what breaks
FORTIFY_SOURCE here.)

Regardless,

Tested-by: David Gow <davidgow@google.com>

Cheers,
-- David


> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> Cc: Bill Wendling <morbo@google.com>
> Cc: Justin Stitt <justinstitt@google.com>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Nicolas Schier <nicolas@fjasle.eu>
> Cc: llvm@lists.linux.dev
> Cc: linux-kbuild@vger.kernel.org
> ---
>  scripts/Makefile.clang | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/scripts/Makefile.clang b/scripts/Makefile.clang
> index 2435efae67f5..b67636b28c35 100644
> --- a/scripts/Makefile.clang
> +++ b/scripts/Makefile.clang
> @@ -12,6 +12,8 @@ CLANG_TARGET_FLAGS_riscv      :=3D riscv64-linux-gnu
>  CLANG_TARGET_FLAGS_s390                :=3D s390x-linux-gnu
>  CLANG_TARGET_FLAGS_sparc       :=3D sparc64-linux-gnu
>  CLANG_TARGET_FLAGS_x86         :=3D x86_64-linux-gnu
> +# This is only for i386 UM builds, which need the 32-bit target not -m32
> +CLANG_TARGET_FLAGS_i386                :=3D i386-linux-gnu
>  CLANG_TARGET_FLAGS_um          :=3D $(CLANG_TARGET_FLAGS_$(SUBARCH))
>  CLANG_TARGET_FLAGS             :=3D $(CLANG_TARGET_FLAGS_$(SRCARCH))
>
> --
> 2.34.1
>

--000000000000721c7c062fa8bb57
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIUnQYJKoZIhvcNAQcCoIIUjjCCFIoCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghIEMIIGkTCCBHmgAwIBAgIQfofDAVIq0iZG5Ok+mZCT2TANBgkqhkiG9w0BAQwFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSNjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMzA0MTkwMzUzNDdaFw0zMjA0MTkwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFI2IFNNSU1FIENBIDIwMjMwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQDYydcdmKyg
4IBqVjT4XMf6SR2Ix+1ChW2efX6LpapgGIl63csmTdJQw8EcbwU9C691spkltzTASK2Ayi4aeosB
mk63SPrdVjJNNTkSbTowej3xVVGnYwAjZ6/qcrIgRUNtd/mbtG7j9W80JoP6o2Szu6/mdjb/yxRM
KaCDlloE9vID2jSNB5qOGkKKvN0x6I5e/B1Y6tidYDHemkW4Qv9mfE3xtDAoe5ygUvKA4KHQTOIy
VQEFpd/ZAu1yvrEeA/egkcmdJs6o47sxfo9p/fGNsLm/TOOZg5aj5RHJbZlc0zQ3yZt1wh+NEe3x
ewU5ZoFnETCjjTKz16eJ5RE21EmnCtLb3kU1s+t/L0RUU3XUAzMeBVYBEsEmNnbo1UiiuwUZBWiJ
vMBxd9LeIodDzz3ULIN5Q84oYBOeWGI2ILvplRe9Fx/WBjHhl9rJgAXs2h9dAMVeEYIYkvW+9mpt
BIU9cXUiO0bky1lumSRRg11fOgRzIJQsphStaOq5OPTb3pBiNpwWvYpvv5kCG2X58GfdR8SWA+fm
OLXHcb5lRljrS4rT9MROG/QkZgNtoFLBo/r7qANrtlyAwPx5zPsQSwG9r8SFdgMTHnA2eWCZPOmN
1Tt4xU4v9mQIHNqQBuNJLjlxvalUOdTRgw21OJAFt6Ncx5j/20Qw9FECnP+B3EPVmQIDAQABo4IB
ZTCCAWEwDgYDVR0PAQH/BAQDAgGGMDMGA1UdJQQsMCoGCCsGAQUFBwMCBggrBgEFBQcDBAYJKwYB
BAGCNxUGBgkrBgEEAYI3FQUwEgYDVR0TAQH/BAgwBgEB/wIBADAdBgNVHQ4EFgQUM7q+o9Q5TSoZ
18hmkmiB/cHGycYwHwYDVR0jBBgwFoAUrmwFo5MT4qLn4tcc1sfwf8hnU6AwewYIKwYBBQUHAQEE
bzBtMC4GCCsGAQUFBzABhiJodHRwOi8vb2NzcDIuZ2xvYmFsc2lnbi5jb20vcm9vdHI2MDsGCCsG
AQUFBzAChi9odHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9yb290LXI2LmNydDA2
BgNVHR8ELzAtMCugKaAnhiVodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL3Jvb3QtcjYuY3JsMBEG
A1UdIAQKMAgwBgYEVR0gADANBgkqhkiG9w0BAQwFAAOCAgEAVc4mpSLg9A6QpSq1JNO6tURZ4rBI
MkwhqdLrEsKs8z40RyxMURo+B2ZljZmFLcEVxyNt7zwpZ2IDfk4URESmfDTiy95jf856Hcwzdxfy
jdwx0k7n4/0WK9ElybN4J95sgeGRcqd4pji6171bREVt0UlHrIRkftIMFK1bzU0dgpgLMu+ykJSE
0Bog41D9T6Swl2RTuKYYO4UAl9nSjWN6CVP8rZQotJv8Kl2llpe83n6ULzNfe2QT67IB5sJdsrNk
jIxSwaWjOUNddWvCk/b5qsVUROOuctPyYnAFTU5KY5qhyuiFTvvVlOMArFkStNlVKIufop5EQh6p
jqDGT6rp4ANDoEWbHKd4mwrMtvrh51/8UzaJrLzj3GjdkJ/sPWkDbn+AIt6lrO8hbYSD8L7RQDqK
C28FheVr4ynpkrWkT7Rl6npWhyumaCbjR+8bo9gs7rto9SPDhWhgPSR9R1//WF3mdHt8SKERhvtd
NFkE3zf36V9Vnu0EO1ay2n5imrOfLkOVF3vtAjleJnesM/R7v5tMS0tWoIr39KaQNURwI//WVuR+
zjqIQVx5s7Ta1GgEL56z0C5GJoNE1LvGXnQDyvDO6QeJVThFNgwkossyvmMAaPOJYnYCrYXiXXle
A6TpL63Gu8foNftUO0T83JbV/e6J8iCOnGZwZDrubOtYn1QwggWDMIIDa6ADAgECAg5F5rsDgzPD
hWVI5v9FUTANBgkqhkiG9w0BAQwFADBMMSAwHgYDVQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBS
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
YE9NAgMBAAGjggHgMIIB3DAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29nbGUuY29tMA4GA1UdDwEB
/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFHgsCGkO2Hex
N6ybc+GeQEb6790qMFgGA1UdIARRME8wCQYHZ4EMAQUBAjBCBgorBgEEAaAyCgMDMDQwMgYIKwYB
BQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQC
MAAwgZoGCCsGAQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWdu
LmNvbS9jYS9nc2F0bGFzcjZzbWltZWNhMjAyMzBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5n
bG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3J0MB8GA1UdIwQYMBaA
FDO6vqPUOU0qGdfIZpJogf3BxsnGMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vY2EvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3JsMA0GCSqGSIb3DQEBCwUAA4ICAQAs
exV05yVDmPhHRqOq9lAbfWOUvEf8zydxabZUHna6bayb83jD2eb9nMGGEprfuNBRmFg35sgF1TyN
+ieuQakvQYmY8tzK49hhHa2Y3qhGCTqYTHO3ypHvhHsZiGbL0gmdgB9P8ssVIws//34ae99GUOxo
XKTxPwwsQ5Arq42besv3/HXAW+4nRAT8d3ht5ZWCHc5rjL/vdGzu7PaYo3u0da69AZ8Sh4Gf5yoc
QANr2ZkMrxXbLmSmnRvbkQrzlZp2YbTFnczx46429D6q75/FNFOL1vAjxtRAPzkyACvW0eKvchza
TMvvD3IWERLlcBL5yXpENc3rI8/wVjqgAWYxlFg1b/4b/TCgYe2MZC0rx4Uh3zTIbmPNiHdN6QZ9
oDiYzWUcqWZ5jCO4bMKNlVJXeCvdANLHuhcC8FONj5VzNgYXs6gWkp9/Wt6XnQPX4dF4JBa8JdL/
cT46RJIzoiJHEx/8syO5FparZHIKbkunoq6niPsRaQUGeqWc56H4Z1sQXuBJN9fhqkIkG0Ywfrwt
uFrCoYIRlx4rSVHpBIKgnsgdm0SFQK72MPmIkfhfq9Fh0h8AjhF73sLO7K5BfwWkx1gwMySyNY0e
PCRYr6WEVOkUJS0a0fui693ymMPFLQAimmz8EpyFok4Ju066StkYO1dIgUIla4x61auxkWHwnzGC
Al0wggJZAgEBMGgwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKjAo
BgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjYgU01JTUUgQ0EgMjAyMwIQAcDMKctW1GQKDKqEUSh4
pjANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQgowr1Rt1dJMtYGOA1ffssayY4JrFB
siFUgiP7D2SxHsUwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUw
MzA2MDkwMDA2WjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcN
AQEBBQAEggEAo20B8a3jETsGmAp7DRXv/2Tq/ePr30Istaa3aPQmA0j5WfsVITm1F2ycJfJu2BrK
1Nxe+3y+qcj0YDHA8eb5nJJyi53x5n4yUoUU7ujz5BkORtK7wAllUCveAf5c2GCO2AC6PgNopFam
phE1G4sKRf0DYeqQoqWqPHG7WDcxkI3ymXJwiF9nMHTSquRT0araioCKpyyz9bqbCKyO+gKVlO5t
J1tYPL/kZRA1eKJInJuJMYyPAqV03tFGXbsMoVI75WL6S5wlmANru3qQK0lu/Vvw7Q5ivmOEjaD3
WbdFXODAYKPPO/OsNB4xV3sj1OMqyc6FSXPJ5ASINN7Y2VBVyQ==
--000000000000721c7c062fa8bb57--
