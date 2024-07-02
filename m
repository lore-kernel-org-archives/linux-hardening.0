Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF462179AF
	for <linux-hardening@vger.kernel.org>; Tue,  2 Jul 2024 04:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719893356; cv=none; b=WMoAD5zPvDcbmTLZkMJgmHNLQrxD6R5UrsoqsqogGUNay8EjE/4wd4JpaRvX1Uxho7FUpvvKx4HpFle0SVn5J+g7RwO8pzl/8FScsaj9zR0C2hHK81jHoDpgAnn8+N4GWWC169WClkcAy2EdtRwpfwJDanhZOPJt7Yrt3gnxZlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719893356; c=relaxed/simple;
	bh=dNLPV3Nups4qlblh1WX8VXk2AKj4V9dAl2PwDt94pzA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TIDroxl/EvaJpS2tq1GeQiqUhMxGSHPthiYBrFB/v6qPmJddtwWl7yNX4h6R2+lakrlrD7p/E2oLJugLeGxl3jJAlcPPgbmN2DL34O/aDLZhp4O6S1IFZ8IQhUO3Nv0i7hfOJ7SYL5gHlGPjB4yS2cNfmRIxmQnRYFYy2lkg7fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xgJF8Rn1; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xgJF8Rn1"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-444fe7e9f11so765791cf.0
        for <linux-hardening@vger.kernel.org>; Mon, 01 Jul 2024 21:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719893353; x=1720498153; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dNLPV3Nups4qlblh1WX8VXk2AKj4V9dAl2PwDt94pzA=;
        b=xgJF8Rn1YfROAO/WoectYKTVOe+S6JYTlW17zFczvGJd5Iyl6h8Gqk+8ICr2iB5DSK
         XmbvpyszJOu+onDBC47vArposG53b/U9kV0ISbERt3Gx6J0SWxsuJ8tEJBQXVSbCoj3s
         AmcGPKwwpi6Ij0kSAwD3dU4zXvYj4uRVJoypulDC1JKUGlcIrZgxrIVi46Qk5Cnhn3TR
         pssBxsWIfwLFE9IrCa1dD/qSbpsCaKa77a0UXM6j28d1Bi8YL+gYeEVvsN2RbXIhVa4P
         0QaJsQdlLyx2R5zVUf27oU4VSsX/wwUyhu4sHpaU0Kd8H1aFZ+46VQOgQHR9vVHvUT5T
         uRvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719893353; x=1720498153;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dNLPV3Nups4qlblh1WX8VXk2AKj4V9dAl2PwDt94pzA=;
        b=jr28WcZjQrPn8g95uGmncBCQfpadMIBAepjjCJI6DBRA/vDMIDpv1JdjkfCkVdinlN
         edR+QuaCFsnto6MkpOHoopbn0GVC8+SYoZ3RReQLQg7BTXgysoNoDVM4idvSdu/E1MKd
         l1lLBqi/BSxtKv8yldiAJEFbiZJ1NImZSi/g5CgL4ZUx1Qu95jPcqqST6zj2nSL9yiji
         7McdgjCr7CdVzW8l23WIBnbMvoWZDzUBU1F3z1yhmo8NeZZlDwI2afSS3ayow/bznQ0u
         S2jMK310eBdrD9LmnrNttVomypsAemgXd0U6IiYbWpnM2eYMEgsHIN9TsyGdvJj8Ga1p
         T1lw==
X-Forwarded-Encrypted: i=1; AJvYcCVoAKHJNaYo1eMOiGnpAOwaRgjSop2BqaLKyiHRfAJ7bPEN0iJ4jtwrM9iM2jWWNvX5cMLGLkNt2T+/PD3K1MUPD7H7dquBwaU3T+Qy6Ikg
X-Gm-Message-State: AOJu0YzfOkXi7oTGd0s/pl3jqA1NhDG5WWaWqqb48eV1ED1aUIGO+Nq2
	MUMM/hApqYxAYxRFqAa6N9XaMSmIPr2FO77IFSWTiwsmtOhB6mfkox+FRTs8goP7cu/dvcc7loF
	PqN7nQXYLKdEaoNLqACIB19odTBp0/JvrXY1I
X-Google-Smtp-Source: AGHT+IHTq2vFWnuyFleYxcX5szuebmkHdxhFqmK8wuyk709Ytw8htr39s3gY8nGlhUuM4CRQtEyhWRNhMKc2HBnhxDE=
X-Received: by 2002:a05:622a:4709:b0:444:e9b9:708f with SMTP id
 d75a77b69052e-4465df8c326mr6039071cf.21.1719893353560; Mon, 01 Jul 2024
 21:09:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619202659.work.532-kees@kernel.org>
In-Reply-To: <20240619202659.work.532-kees@kernel.org>
From: David Gow <davidgow@google.com>
Date: Tue, 2 Jul 2024 12:09:02 +0800
Message-ID: <CABVgOS=Sqt7dbMkece_dokZm60PeyOtO1t1hPor+vYJqjN+ApA@mail.gmail.com>
Subject: Re: [PATCH] kunit/usercopy: Add missing MODULE_DESCRIPTION()
To: Kees Cook <kees@kernel.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>, Jeff Johnson <quic_jjohnson@quicinc.com>, 
	Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000006a2148061c3be07a"

--0000000000006a2148061c3be07a
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Jun 2024 at 04:27, Kees Cook <kees@kernel.org> wrote:
>
> From: Jeff Johnson <quic_jjohnson@quicinc.com>
>
> Fix warning seen with:
>
> $ make allmodconfig && make W=1 C=1 lib/usercopy_kunit.ko
> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/usercopy_kunit.o
>
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> At Jeff's reminder, I've split this out of:
> https://lore.kernel.org/all/20240601-md-lib-test-v1-1-a728620e37d8@quicinc.com/
> since the file got renamed.
> ---
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: Jeff Johnson <quic_jjohnson@quicinc.com>
> Cc: Brendan Higgins <brendan.higgins@linux.dev>
> Cc: David Gow <davidgow@google.com>
> Cc: Rae Moar <rmoar@google.com>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-kselftest@vger.kernel.org
> Cc: kunit-dev@googlegroups.com
> Cc: linux-hardening@vger.kernel.org
> Cc: linux-mm@kvack.org
> ---

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

--0000000000006a2148061c3be07a
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
hvcNAQkEMSIEIIghmbmhS3G8lIcy8JlVXs9mFoz9qVPdKiQPo/8w//l2MBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDcwMjA0MDkxM1owaQYJKoZIhvcNAQkPMVww
WjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkq
hkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBpcU9W
t8fkP77r0aUywd4EpBwPBYopY7onJVlcUdGcXy1zQqR0ucOaLmYUwMKsD2AtNBF38XfrE22sJD/w
Q6YYbWDF8x/M2rC1Zyqr00dz3v1QarqEGmcchKGtXwKF6nCwuoKynAXroF5o6J4bEy3vSOHnubx7
NErL5HbmT4AIUnQ7YOy1SJ6rzU06SueaAKYJCT5Ks7DxuJW/IfCkz5l61ybBZwnQ9QaExwG2RvO7
c/DSdMBj+9WCkWb+P9g/5ZWymhZ3B3lefHkN7wqOd9oOHittL4zrCdcwj/hmsISlULSjFfzdkdwh
81OqarBpq5TLi1p92Dme5YGgQVOSuU1s
--0000000000006a2148061c3be07a--
