Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDCD42AAF
	for <linux-hardening@vger.kernel.org>; Thu, 11 Jul 2024 05:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720676370; cv=none; b=cInqWMVtILec2HAzZqHZoQCrv61EAsUv545HlB3oSPiTKFpmXkGuUCRV2YhsWFp5uc0Aem8HJ9DfF0GwCSLMcd53C7kLBMEgcVW7PKMtHUw+RPdnOgoRuV6EnMJ44a8bnCBn2ywOWu2brA1goscJIeaC/2O7EvIosCpIbS7ddvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720676370; c=relaxed/simple;
	bh=2DoFrnddTUjDDB/DPnC/7GBoQxGdaO2abxWq8/4KF1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HT8lZIwVWtcZCKnmXDLWJcwREfn2gDCdbnAcZjXfNlA68QLnbwe1rIbRxD55CkbjXrMBMlzpQjdW6CrlNyi+gDww3HhBqON/oBBxmwQcd1UFfLGIeLzrLNUyv/pxfN1gg3YFCEZTyjjiRdh2bygJOiA4LBxnpq/AzzJm8x1BLqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SrKJL2Gu; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SrKJL2Gu"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-44664ad946eso110571cf.1
        for <linux-hardening@vger.kernel.org>; Wed, 10 Jul 2024 22:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720676368; x=1721281168; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xB/W0xy4e0QOO3rWW5KI86ud7IEKRbeJVN6DhcJdxXQ=;
        b=SrKJL2Gu93aY5PZJ732qkut+HlmyiZuj43cxxJ/LQ/zc6moKiGM/TPiAiJADc227SD
         EzipLMlost1f7MVm56kr9WetFizydhpVAnPGoazkPPIvdoyc4r8WSmtm+P/FU1JRL6Iu
         /YzHUWsRrYG7tzYKB3J9ZDhx7Mgm0aQmYxFMQ5TsBS6T8Ec+7C4vgW8LsxLQ/vgPRl1X
         Qh3MleomU1NbSUBFM09Pu2QvcEnVH/hEvLNEBZfoYKZuhmIEVSZ4KkDw2uxeuWyzAB/h
         gKqQOLhLRm67KDq95dnlltYw2w529/7hXsKVAV0A3Gi0KMYlsFEuwVah6ediiDZQJmdT
         n+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720676368; x=1721281168;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xB/W0xy4e0QOO3rWW5KI86ud7IEKRbeJVN6DhcJdxXQ=;
        b=ZCSmpWDxEaPu528cWZqGBgvaCxmryK9+x35D8W5BFxq8LUbcIBFQ3DBgnCNq3g0WKf
         9F4Z4YT4r3Xhn3t8pJyNmSHNhaAxzrFeQJDV+zhBOs1DpW1hhaaN/lzYGmuTPq2/G7s3
         3oRwrubLAW5MMEGA//p20AaerfJQ3KellYzOs/ntOwGZSTMWhCLNM0ZMpiWC7HQ8HXwe
         jqWDfsB7TmsoVSY5MjFosTWsXC5fvi/KCyl/f96GZ21tkE3fbPtONTNHqMVaXGsGwwUQ
         pS296qauggm9AaKggiZNaHdijI7nUndrJqdqbOCONd+rIGoPyOOd5PVp2k0lt9eBm5cy
         Rr9g==
X-Forwarded-Encrypted: i=1; AJvYcCXPayNzSDKbmQ8JefZlv3cJqwc2DP+Z4zIA0c+duaS8Dp1vfEk/ssYUoGI7ylA57UAbIu+vwIII/LR5ha7YeUIHkkQeuHMEQCZGP7MJpg7j
X-Gm-Message-State: AOJu0YxHeWIsEa0VXziBG8hUAxcihctP/u80yWdfz83mbQm38WVYmU+6
	PzLU5TQo7wLXT3QBQae62sSHI6/ZrlH9BYuFqqg1gOtOeJ5qKz79qATPROld+1N3t8l+eP+GGRz
	W2uedG0PU0pxMYUgt3Yt4SGAbRxCd4XOjcJ5q
X-Google-Smtp-Source: AGHT+IG7XvmJKaX301oK5fK/lXy0XU1Sj/+mXbchvIMmc7V7LKM0rkFeVvHuFFfVAFLVkchOyB/nXFmkwAvNyV7Kv/U=
X-Received: by 2002:ac8:4cc4:0:b0:446:405f:81f5 with SMTP id
 d75a77b69052e-44d341f1e21mr1359101cf.5.1720676368059; Wed, 10 Jul 2024
 22:39:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710000220.work.852-kees@kernel.org>
In-Reply-To: <20240710000220.work.852-kees@kernel.org>
From: David Gow <davidgow@google.com>
Date: Thu, 11 Jul 2024 13:39:15 +0800
Message-ID: <CABVgOSnXgA20O9bHTUP8uwcMH3Wggb2Agjpc3MK9qQa0+oH_Bg@mail.gmail.com>
Subject: Re: [PATCH] kunit: executor: Simplify string allocation handling
To: Kees Cook <kees@kernel.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000b7e53d061cf22f5d"

--000000000000b7e53d061cf22f5d
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Jul 2024 at 08:02, Kees Cook <kees@kernel.org> wrote:
>
> The alloc/copy code pattern is better consolidated to single kstrdup (and
> kstrndup) calls instead. This gets rid of deprecated[1] strncpy() uses as
> well. Replace one other strncpy() use with the more idiomatic strscpy().
>
> Link: https://github.com/KSPP/linux/issues/90 [1]
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Brendan Higgins <brendan.higgins@linux.dev>
> Cc: David Gow <davidgow@google.com>
> Cc: Rae Moar <rmoar@google.com>
> Cc: linux-kselftest@vger.kernel.org
> Cc: kunit-dev@googlegroups.com
> ---

Looks good apart from the strscpy() change, which is broken by the
(char *) cast. Using the 3-argument version worked here.

With the strscpy() fixed, this is:

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  lib/kunit/executor.c      | 12 +++---------
>  lib/kunit/executor_test.c |  2 +-
>  2 files changed, 4 insertions(+), 10 deletions(-)
>
> diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
> index 70b9a43cd257..34b7b6833df3 100644
> --- a/lib/kunit/executor.c
> +++ b/lib/kunit/executor.c
> @@ -70,32 +70,26 @@ struct kunit_glob_filter {
>  static int kunit_parse_glob_filter(struct kunit_glob_filter *parsed,
>                                     const char *filter_glob)
>  {
> -       const int len = strlen(filter_glob);
>         const char *period = strchr(filter_glob, '.');
>
>         if (!period) {
> -               parsed->suite_glob = kzalloc(len + 1, GFP_KERNEL);
> +               parsed->suite_glob = kstrdup(filter_glob, GFP_KERNEL);
>                 if (!parsed->suite_glob)
>                         return -ENOMEM;
> -
>                 parsed->test_glob = NULL;
> -               strcpy(parsed->suite_glob, filter_glob);
>                 return 0;
>         }
>
> -       parsed->suite_glob = kzalloc(period - filter_glob + 1, GFP_KERNEL);
> +       parsed->suite_glob = kstrndup(filter_glob, period - filter_glob, GFP_KERNEL);
>         if (!parsed->suite_glob)
>                 return -ENOMEM;
>
> -       parsed->test_glob = kzalloc(len - (period - filter_glob) + 1, GFP_KERNEL);
> +       parsed->test_glob = kstrdup(period + 1, GFP_KERNEL);
>         if (!parsed->test_glob) {
>                 kfree(parsed->suite_glob);
>                 return -ENOMEM;
>         }
>
> -       strncpy(parsed->suite_glob, filter_glob, period - filter_glob);
> -       strncpy(parsed->test_glob, period + 1, len - (period - filter_glob));
> -
>         return 0;
>  }
>
> diff --git a/lib/kunit/executor_test.c b/lib/kunit/executor_test.c
> index 3f7f967e3688..7191be9c4f9b 100644
> --- a/lib/kunit/executor_test.c
> +++ b/lib/kunit/executor_test.c
> @@ -286,7 +286,7 @@ static struct kunit_suite *alloc_fake_suite(struct kunit *test,
>
>         /* We normally never expect to allocate suites, hence the non-const cast. */
>         suite = kunit_kzalloc(test, sizeof(*suite), GFP_KERNEL);
> -       strncpy((char *)suite->name, suite_name, sizeof(suite->name) - 1);
> +       strscpy((char *)suite->name, suite_name);

This is broken: we still need to pass the length of suite->name. The
(char *) cast, which is necessary to remove the 'cosnt' qualifier,
stops the strscpy() macro from treating suite->name as an array.

>         suite->test_cases = test_cases;
>
>         return suite;
> --
> 2.34.1
>
>

--000000000000b7e53d061cf22f5d
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPqgYJKoZIhvcNAQcCoIIPmzCCD5cCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg0EMIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
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
JEfDtvHU6wy3MSBE3/TrMFcGA1UdIARQME4wCQYHZ4EMAQUBATBBBgkrBgEEAaAyASgwNDAyBggr
BgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wDAYDVR0TAQH/
BAIwADCBmgYIKwYBBQUHAQEEgY0wgYowPgYIKwYBBQUHMAGGMmh0dHA6Ly9vY3NwLmdsb2JhbHNp
Z24uY29tL2NhL2dzYXRsYXNyM3NtaW1lY2EyMDIwMEgGCCsGAQUFBzAChjxodHRwOi8vc2VjdXJl
Lmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcnQwHwYDVR0jBBgw
FoAUfMwKaNei6x4schvRzV2Vb4378mMwRgYDVR0fBD8wPTA7oDmgN4Y1aHR0cDovL2NybC5nbG9i
YWxzaWduLmNvbS9jYS9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcmwwDQYJKoZIhvcNAQELBQADggEB
AGwXYwvLVjByVooZ+uKzQVW2nnClCIizd0jfARuMRTPNAWI2uOBSKoR0T6XWsGsVvX1vBF0FA+a9
DQOd8GYqzEaKOiHDIjq/o455YXkiKhPpxDSIM+7st/OZnlkRbgAyq4rAhAjbZlceKp+1vj0wIvCa
4evQZvJNnJvTb4Vcnqf4Xg2Pl57hSUAgejWvIGAxfiAKG8Zk09I9DNd84hucIS2UIgoRGGWw3eIg
GQs0EfiilyTgsH8iMOPqUJ1h4oX9z1FpaiJzfxcvcGG46SCieSFP0USs9aMl7GeERue37kBf14Pd
kOYIfx09Pcv/N6lHV6kXlzG0xeUuV3RxtLtszQgxggJqMIICZgIBATBoMFQxCzAJBgNVBAYTAkJF
MRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFzIFIz
IFNNSU1FIENBIDIwMjACEAFsPHWl8lqMEwx3lAnpufYwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZI
hvcNAQkEMSIEIJakMhyahna+BOAKQ3F6UlCll3x860YjryN4eeZa68IMMBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDcxMTA1MzkyOFowaQYJKoZIhvcNAQkPMVww
WjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkq
hkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQABJnIp
pWhV4aNSyvaRayHpZmHIB0rbVG1qYW6YNyad5eaodjWDK99qaqIDxVdZXujFlYfMncHqknVxgZ3D
wXOCBxoRiVV6gq5BnqNDB4Y4ePaxZL1d8x8R2OxmyvxtRKt/9J4XO7ugEBisbuHXNt4SyZgQYT1d
GRhd8KdUXmVN68t/soUrfEmS3Wopg8X9ws/LyZDasTfXluwnRYpGZn3zeeOUiSmOs1We6568Bh5r
CKZQdIc2D/GbSy8wZwpzM5nCpENoQsJOZq7YrAdy88NkLGUFtVHCOFmi5j/K56aRCI7aYLginnkv
r1M8hLjungm8d7kJCSm0pE87shsVUa01
--000000000000b7e53d061cf22f5d--
