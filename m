Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8760F79C2
	for <linux-hardening@vger.kernel.org>; Tue, 11 Jun 2024 06:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718086465; cv=none; b=WKeW2sdI4IzPorfhZx11WAjnbPL3NMcAHwxJylnTLwf5fd2EkA3olyP8oLN9x3cEU0ptS0PXFNZq8bH7WeiH9VPr8VICk6IcMo3Hzjdm/HJEAB/+CpswDYhyp1ywVJjfZsvGU0h9Dl7AETdNe0HHF+Nly4846R+EkX/NrNbSOwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718086465; c=relaxed/simple;
	bh=ExZLyA7PvDEe5vCKp6KPcJsw89xes0CEaQY68Y2rSFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y73bUgkMji9HR624PF1erF6e8iNpn7fJYebCLRp6TQQ7EA3W4eA10PInuyXUW2m/5k2dKAOTLUhN6kBqR9Rs0D1nXc/dmXtN++dessHsTMonk5jN+TpUt8WCq4t0CcUb/qHE3B5VWHy/ZFlPLqVTFToggeGSswV2XAHpBrQNvTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pYh4qMeT; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pYh4qMeT"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4405cf01a7fso179221cf.1
        for <linux-hardening@vger.kernel.org>; Mon, 10 Jun 2024 23:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718086461; x=1718691261; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k3M/77mxx5Z9HGelKENp7gkMm/i5nW+SCLfdz0+i6bQ=;
        b=pYh4qMeTso1VN2sR3JcBUloqNQgg09OLKiFtYkJ9TQFmyGnwR2ZnSpGAPq2/MQDXU5
         Ie3MUFRlceJGuWT1garkAXyPpEhuFQv132jYjnBIYIMXFncgO11Tydt9hDJpAnJ4F0/e
         sRIrIQr/8KKtaE6IBfPOsS7oJq1CShc6RRZ6+e+vFuEC4KcHoVnnYNF00ZXfsOiJQzsm
         gaHOGVmTn0ck8mMJ6SXhojyrjtkmg+JFAlBDZ40RU62fEmqCUYZxh0arIOlrxTbO1IHw
         V+gPmlJbjJzxho1S056vXhb60wK83YxuqlAPWM37FEcjTx9KqLOidLgCurRTDihDOEE/
         qF7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718086461; x=1718691261;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k3M/77mxx5Z9HGelKENp7gkMm/i5nW+SCLfdz0+i6bQ=;
        b=Bvqnu4drAH0NA+K6DYBlJ7wymXtaOuHdiybE6F+MxxIrIdUJrmDz2XYwMDZHBY5fdV
         7IuwpASmMq1s9GndMxZmFJauK7neUY83sMZK5IrgWES7QxF3I6Ek3Al4Yhop3rtK73Tf
         bRS2tXzP9AcXjWKe8vwbFukvJpKqB1wOC1yYpIQk2JgiF8jpVJPVDMGXsG7fAkV+i/d1
         kQPaVs5exMJCS6faLiL1xMf4uOKKvnZ7msi5T9OhUIw65narscP0GsOafN0lNBj71paL
         XaxIXF8sp2Q6HlOvAMQTdDliJjm0gVkeRygJRzt7I5CvtLJ5dTtUWCTpW3h49YX2WMKx
         3rkw==
X-Forwarded-Encrypted: i=1; AJvYcCU93Dp1cB7nnN56Es1INRHiR3Ixkwk1194cYITTIj1PMRppWcYLdqEWumCjUn0NTiohug8OGkqzzQpu3HU0hBCmbw6hNeOHZmS7hle+HTy/
X-Gm-Message-State: AOJu0YzyOijNkj0bTU6wVgeRlrcKPzstTUrhd2oLrjVbQbpPVvmnkBzi
	h98+kLSSYo+cDRT/lF2S4bkw+n+26g45ZSdrWHd4r+agaOd0g3zM0EVLFFRzLPw4nbUL6fQIw7I
	pCS9Hi7KJxBPk+/L1NFAm6eaRqcOnLxdJG3S5
X-Google-Smtp-Source: AGHT+IEfF1ceGCvUIqpRgpGywpoFdhCEjJQ5SBrVnyTH7zFD7fIjC3mxz+EhRnvKT70AxygSJIfPcxTkh+gSBAi2+hs=
X-Received: by 2002:ac8:6f10:0:b0:43e:cb4:1d10 with SMTP id
 d75a77b69052e-44140140f5bmr2611541cf.14.1718086461364; Mon, 10 Jun 2024
 23:14:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240610210213.work.143-kees@kernel.org>
In-Reply-To: <20240610210213.work.143-kees@kernel.org>
From: David Gow <davidgow@google.com>
Date: Tue, 11 Jun 2024 14:14:07 +0800
Message-ID: <CABVgOSnk3Uq1HjNgV=ATjO455PDv-W6-hDjqGyscp=ybc7U3Qg@mail.gmail.com>
Subject: Re: [PATCH] x86/uaccess: Fix missed zeroing of ia32 u64 get_user()
 range checking
To: Kees Cook <kees@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Sean Christopherson <seanjc@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Arnd Bergmann <arnd@arndb.de>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>, Nadav Amit <nadav.amit@gmail.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	David Howells <dhowells@redhat.com>, Uros Bizjak <ubizjak@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000405fa5061a972d05"

--000000000000405fa5061a972d05
Content-Type: text/plain; charset="UTF-8"

On Tue, 11 Jun 2024 at 05:02, Kees Cook <kees@kernel.org> wrote:
>
> When reworking the range checking for get_user(), the get_user_8() case
> on 32-bit wasn't zeroing the high register. (The jump to bad_get_user_8
> was accidentally dropped.) Restore the correct error handling
> destination (and rename the jump to using the expected ".L" prefix).
>
> While here, switch to using a named argument ("size") for the call
> template ("%c4" to "%c[size]") as already used in the other call
> templates in this file.
>
> Found after moving the usercopy selftests to KUnit:
>
>       # usercopy_test_invalid: EXPECTATION FAILED at
>       lib/usercopy_kunit.c:278
>       Expected val_u64 == 0, but
>           val_u64 == -60129542144 (0xfffffff200000000)
>
> Reported-by: David Gow <davidgow@google.com>
> Closes: https://lore.kernel.org/all/CABVgOSn=tb=Lj9SxHuT4_9MTjjKVxsq-ikdXC4kGHO4CfKVmGQ@mail.gmail.com
> Fixes: b19b74bc99b1 ("x86/mm: Rework address range check in get_user() and put_user()")
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: x86@kernel.org
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Sean Christopherson <seanjc@google.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> Cc: Nadav Amit <nadav.amit@gmail.com>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> ---

Thanks: this fixes it here, both under qemu and on real hardware.

Tested-by: David Gow <davidgow@google.com>

-- David

--000000000000405fa5061a972d05
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
LmNybDBMBgNVHSAERTBDMEEGCSsGAQQBoDIBKDA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5n
bG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzANBgkqhkiG9w0BAQsFAAOCAQEANyYcO+9JZYyqQt41
TMwvFWAw3vLoLOQIfIn48/yea/ekOcParTb0mbhsvVSZ6sGn+txYAZb33wIb1f4wK4xQ7+RUYBfI
TuTPL7olF9hDpojC2F6Eu8nuEf1XD9qNI8zFd4kfjg4rb+AME0L81WaCL/WhP2kDCnRU4jm6TryB
CHhZqtxkIvXGPGHjwJJazJBnX5NayIce4fGuUEJ7HkuCthVZ3Rws0UyHSAXesT/0tXATND4mNr1X
El6adiSQy619ybVERnRi5aDe1PTwE+qNiotEEaeujz1a/+yYaaTY+k+qJcVxi7tbyQ0hi0UB3myM
A/z2HmGEwO8hx7hDjKmKbDCCA18wggJHoAMCAQICCwQAAAAAASFYUwiiMA0GCSqGSIb3DQEBCwUA
MEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9vdCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWdu
MRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTA5MDMxODEwMDAwMFoXDTI5MDMxODEwMDAwMFowTDEg
MB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENBIC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzAR
BgNVBAMTCkdsb2JhbFNpZ24wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMJXaQeQZ4
Ihb1wIO2hMoonv0FdhHFrYhy/EYCQ8eyip0EXyTLLkvhYIJG4VKrDIFHcGzdZNHr9SyjD4I9DCuu
l9e2FIYQebs7E4B3jAjhSdJqYi8fXvqWaN+JJ5U4nwbXPsnLJlkNc96wyOkmDoMVxu9bi9IEYMpJ
pij2aTv2y8gokeWdimFXN6x0FNx04Druci8unPvQu7/1PQDhBjPogiuuU6Y6FnOM3UEOIDrAtKeh
6bJPkC4yYOlXy7kEkmho5TgmYHWyn3f/kRTvriBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti
+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGjQjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8E
BTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5NUPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEA
S0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigHM8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9u
bG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmUY/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaM
ld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88
q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcya5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/f
hO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/XzCCBOMwggPLoAMCAQICEAFsPHWl8lqMEwx3lAnp
ufYwDQYJKoZIhvcNAQELBQAwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYt
c2ExKjAoBgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjMgU01JTUUgQ0EgMjAyMDAeFw0yNDA1MDIx
NjM4MDFaFw0yNDEwMjkxNjM4MDFaMCQxIjAgBgkqhkiG9w0BCQEWE2RhdmlkZ293QGdvb2dsZS5j
b20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCTXdIWMQF7nbbIaTKZYFFHPZMXJQ+E
UPQgWZ3nEBBk6iSB8aSPiMSq7EAFTQAaoNLZJ8JaIwthCo8I9CKIlhJBTkOZP5uZHraqCDWArgBu
hkcnmzIClwKn7WKRE93IX7Y2S2L8/zs7VKX4KiiFMj24sZ+8PkN81zaSPcxzjWm9VavFSeMzZ8oA
BCXfAl7p6TBuxYDS1gTpiU/0WFmWWAyhEIF3xXcjLSbem0317PyiGmHck1IVTz+lQNTO/fdM5IHR
zrtRFI2hj4BxDQtViyXYHGTn3VsLP3mVeYwqn5IuIXRSLUBL5lm2+6h5/S/Wt99gwQOw+mk0d9bC
weJCltovAgMBAAGjggHfMIIB2zAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29nbGUuY29tMA4GA1Ud
DwEB/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFDNpU2Nt
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
hvcNAQkEMSIEIGGf0FbWQBXElxXhKcACOdaBZboCNMX8T93QLr1mK4jiMBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDYxMTA2MTQyMVowaQYJKoZIhvcNAQkPMVww
WjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkq
hkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAq9IW1
PsS5RyRm+2iPrCTuWhSycsSm08uCE+WwPo47gYpNjU01ypNIjFGlm/VNmP6qGRAQmM+sUcQ4SoFm
/3elrTkmEbGd5NuUgqKSxt1Ohl9sMMjnK/ENFHY45ucSjeUdRT6ZqvMXdxMyZx41xjggXW+FS95k
u/F9B9KBhZe9ZOmVkn97jXJoxqdmqScXNUD02xBE0WxbEwxMLfO7RbEXSPWxUCb1oUDj6yhRkYWx
4+1SY2sHyF/4LA9lyx0B31Dl9nZw2uvQ47LPoUYdbFGdmp5rzsFbcWSofvCcjcbNOJ+QtxRqyicy
Axhwp8FbT34Snz4/XeHUv15qaA71XviC
--000000000000405fa5061a972d05--
