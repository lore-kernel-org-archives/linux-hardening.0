Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B268E5FB8B
	for <linux-hardening@vger.kernel.org>; Tue, 23 Apr 2024 09:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713864161; cv=none; b=nP/kbbdmzl0iVrOBfAts/RRxVie68p0llaIT6ESu0dKXTJs2/twDAZDcJVVaduUC2eEVkQdX0rDFFBY/UliVrFQh7YGo93F5PeyNluK7WIqGDZOBjZj4NKMN3nOIUuP70IYC5p2c1IdOZ7+kI5Q+yRFROO75bJk4q1X5IJuP/2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713864161; c=relaxed/simple;
	bh=pmiIhZqNkAU9D5wJUXj7KZx9frfV/C1gj9SoZyaZz+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nDx2psAcLVo5oT+LGgT4VuNVDTFmNGHUPQsFW1z5kl1xzFEDVD/AomvSmIHy5IvyDRnq4idI9X0LVMsuf/z05ZHiuk30bqrj/W4+SiLdI8rd0EYcc82dGWaOQcviNx5YWm16ciXAa6RzpV3dVReTu+JJJHghM5QMqBbE1jEM2Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WE3rYAon; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WE3rYAon"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-439b1c72676so301061cf.1
        for <linux-hardening@vger.kernel.org>; Tue, 23 Apr 2024 02:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713864158; x=1714468958; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=j7KMJtBamaRM8OXwIXGEBpgjYZFZmfOcv6cuOVqS8y0=;
        b=WE3rYAonm2D+7JIeSooUKlKAJcltX9Vzvxfap9oJulAFSSR3o+fyCnA5J4Mp76uxZg
         DkEU0so+t/GSEddn2tHxfNlas3RXynV5Q+UlzDTQFMtT6+CWikB7qJNjvLqQgHi+2pcV
         WZPIq0Mn8LxM8wRPXuAfydlk25+c440qTEILKq7oHVA+gcU9lCX2Ocu+ZZxjlkLh2I+n
         q3ks9Wd/F3ttYVV2WEAS50WyOGGOBY9xs7aK4+fH/GTsDbHYq40Ue9ZBuuUlJPLjV7Wn
         zvMOUZxyMDo65pwnxLbvGyTlQL29sLqssIl2/fk2Ivrsx3lRagl7diQic9DnnfcvIE1T
         8AAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713864158; x=1714468958;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j7KMJtBamaRM8OXwIXGEBpgjYZFZmfOcv6cuOVqS8y0=;
        b=uYckD+VVt97dqYJWNkMA8KtEnyCl21+Hus+PcJvng4G8TAhsjkGWOfIr8NwiTEFdRN
         hamPBCgIaSHPG0Gjxvh5DIDQDOI3iQq7z/DV3CvPHEXkR+8vpRaMLfLgq8jv4/8n/rWI
         9nUP2NOJJkA4MKn29Mdtu+KGqezpbGRsbnC8lVQVIe5+g7eYVbuj6QpwHSQ0RxQikpSe
         ePrP+WSmxljtUr1DeFDfiLpkSw6xoeosfTfOKDbDc+txgXpn4RdCtvQ+UdpUujaFldfq
         d7U/tUx3PeTnJj33t9Ndfw+23qAS77yDkOfHjV8y0NwAoFxDs055PoubB7/Mpl5FpjRy
         aXFw==
X-Forwarded-Encrypted: i=1; AJvYcCWAAdASEw+4JmODLd+xLX25aYrxcq4DuQWRch5On0nuZGPXkOJMCexwXLDiWvc8fLTTZ0//M3xQZY/Pw/DW23KxTi4KWyVilH3qgvVqadM4
X-Gm-Message-State: AOJu0YxJdLKIR53669L02Fjpy1/uzKYzsCyD4YaBYPE2a6ziqrPy1Kxx
	OqN9q835kwoa3qllvm/Ml7beCiS8f1z8JraKjUXi6vthLcoCfDITYRHhD5ak3Jwg2Rfpw5wqh+V
	YGkfRmtfdc5/nb9t1uec2EbcbA1eo0zmM9xzA
X-Google-Smtp-Source: AGHT+IHUVImZr46KE7NjLsb4voeWSuhmpLmq8uDA7LeYXKhI00U6dSCZBVehDUFO7fu/ApIxReC1GPQBk/y0xeNhlH0=
X-Received: by 2002:ac8:6682:0:b0:439:891f:bbd2 with SMTP id
 d2-20020ac86682000000b00439891fbbd2mr232880qtp.28.1713864158511; Tue, 23 Apr
 2024 02:22:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319104857.70783-1-mic@digikod.net> <20240319104857.70783-8-mic@digikod.net>
 <928249cc-e027-4f7f-b43f-502f99a1ea63@roeck-us.net> <b70332b0-3e55-4375-935f-35ef3167a151@roeck-us.net>
 <20240422.thesh7quoo0U@digikod.net> <a0179848-99a2-4169-b7b2-1a8cddb27615@roeck-us.net>
In-Reply-To: <a0179848-99a2-4169-b7b2-1a8cddb27615@roeck-us.net>
From: David Gow <davidgow@google.com>
Date: Tue, 23 Apr 2024 17:22:24 +0800
Message-ID: <CABVgOS=MOaWhUwVb2Rp2JDTK9=qX_p2SDZp7ZAj+03isZps9iA@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] kunit: Add tests for fault
To: Guenter Roeck <linux@roeck-us.net>
Cc: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Brendan Higgins <brendanhiggins@google.com>, Rae Moar <rmoar@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Alan Maguire <alan.maguire@oracle.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, 
	James Morris <jamorris@linux.microsoft.com>, Kees Cook <keescook@chromium.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, 
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>, Marco Pagani <marpagan@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, Stephen Boyd <sboyd@kernel.org>, 
	Thara Gopinath <tgopinath@microsoft.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Wanpeng Li <wanpengli@tencent.com>, 
	Zahra Tarkhani <ztarkhani@microsoft.com>, kvm@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-um@lists.infradead.org, x86@kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000062f73a0616c0183a"

--00000000000062f73a0616c0183a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 22 Apr 2024 at 21:36, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 4/22/24 06:08, Micka=C3=ABl Sala=C3=BCn wrote:
> > On Fri, Apr 19, 2024 at 04:38:01PM -0700, Guenter Roeck wrote:
> >> On Fri, Apr 19, 2024 at 03:33:49PM -0700, Guenter Roeck wrote:
> >>> Hi,
> >>>
> >>> On Tue, Mar 19, 2024 at 11:48:57AM +0100, Micka=C3=ABl Sala=C3=BCn wr=
ote:
> >>>> Add a test case to check NULL pointer dereference and make sure it w=
ould
> >>>> result as a failed test.
> >>>>
> >>>> The full kunit_fault test suite is marked as skipped when run on UML
> >>>> because it would result to a kernel panic.
> >>>>
> >>>> Tested with:
> >>>> ./tools/testing/kunit/kunit.py run --arch x86_64 kunit_fault
> >>>> ./tools/testing/kunit/kunit.py run --arch arm64 \
> >>>>    --cross_compile=3Daarch64-linux-gnu- kunit_fault
> >>>>
> >>>
> >>> What is the rationale for adding those tests unconditionally whenever
> >>> CONFIG_KUNIT_TEST is enabled ? This completely messes up my test syst=
em
> >>> because it concludes that it is pointless to continue testing
> >>> after the "Unable to handle kernel NULL pointer dereference" backtrac=
e.
> >>> At the same time, it is all or nothing, meaning I can not disable
> >>> it but still run other kunit tests.
> >>>
> >
> > CONFIG_KUNIT_TEST is to test KUnit itself.  Why does this messes up you=
r
> > test system, and what is your test system?  Is it related to the kernel
> > warning and then the message you previously sent?
>
> It is not a warning, it is a BUG which terminates the affected kernel thr=
ead.
> NULL pointer dereferences are normally fatal, which is why I abort tests
> if one is encountered. I am not going to start introducing code into my
> scripts to ignore such warnings (or BUG messages) on a case by case basis=
;
> this would be unmaintainable.
>
> > https://lore.kernel.org/r/fd604ae0-5630-4745-acf2-1e51c69cf0c0@roeck-us=
.net
> > It seems David has a solution to suppress such warning.
> >
>
> I don't think so. My series tried to suppress warning backtraces, not BUG
> messages. BUG messages can not easily be suppressed since the reaction is
> architecture specific and typically fatal.
>
> As I said below, never mind, I just disabled CONFIG_KUNIT_TEST in my test=
ing.
>
> Guenter
>

I think it probably makes sense to permit disabling the fault tests
independently, at least until we have a way of suppressing the
warnings.

I've sent out a patch to add a CONFIG_KUNIT_FAULT_TEST option to
disable these tests. Would that help?
https://lore.kernel.org/linux-kselftest/20240423090808.242389-1-davidgow@go=
ogle.com/

(The other option is to split the tests out into a totally separate
file / module. I think that's an option (and would make the config
option more consistent with other test options) but since they're
otherwise part of the KUnit tests, I think I prefer to keep them
together.)

Cheers,
-- David

--00000000000062f73a0616c0183a
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
hO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/XzCCBOMwggPLoAMCAQICEAHS+TgZvH/tCq5FcDC0
n9IwDQYJKoZIhvcNAQELBQAwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYt
c2ExKjAoBgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjMgU01JTUUgQ0EgMjAyMDAeFw0yNDAxMDcx
MDQ5MDJaFw0yNDA3MDUxMDQ5MDJaMCQxIjAgBgkqhkiG9w0BCQEWE2RhdmlkZ293QGdvb2dsZS5j
b20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDY2jJMFqnyVx9tBZhkuJguTnM4nHJI
ZGdQAt5hic4KMUR2KbYKHuTQpTNJz6gZ54lsH26D/RS1fawr64fewddmUIPOuRxaecSFexpzGf3J
Igkjzu54wULNQzFLp1SdF+mPjBSrcULSHBgrsFJqilQcudqXr6wMQsdRHyaEr3orDL9QFYBegYec
fn7dqwoXKByjhyvs/juYwxoeAiLNR2hGWt4+URursrD4DJXaf13j/c4N+dTMLO3eCwykTBDufzyC
t6G+O3dSXDzZ2OarW/miZvN/y+QD2ZRe+wl39x2HMo3Fc6Dhz2IWawh7E8p2FvbFSosBxRZyJH38
84Qr8NSHAgMBAAGjggHfMIIB2zAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29nbGUuY29tMA4GA1Ud
DwEB/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFC+LS03D
7xDrOPfX3COqq162RFg/MFcGA1UdIARQME4wCQYHZ4EMAQUBATBBBgkrBgEEAaAyASgwNDAyBggr
BgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wDAYDVR0TAQH/
BAIwADCBmgYIKwYBBQUHAQEEgY0wgYowPgYIKwYBBQUHMAGGMmh0dHA6Ly9vY3NwLmdsb2JhbHNp
Z24uY29tL2NhL2dzYXRsYXNyM3NtaW1lY2EyMDIwMEgGCCsGAQUFBzAChjxodHRwOi8vc2VjdXJl
Lmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcnQwHwYDVR0jBBgw
FoAUfMwKaNei6x4schvRzV2Vb4378mMwRgYDVR0fBD8wPTA7oDmgN4Y1aHR0cDovL2NybC5nbG9i
YWxzaWduLmNvbS9jYS9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcmwwDQYJKoZIhvcNAQELBQADggEB
AK0lDd6/eSh3qHmXaw1YUfIFy07B25BEcTvWgOdla99gF1O7sOsdYaTz/DFkZI5ghjgaPJCovgla
mRMfNcxZCfoBtsB7mAS6iOYjuwFOZxi9cv6jhfiON6b89QWdMaPeDddg/F2Q0bxZ9Z2ZEBxyT34G
wlDp+1p6RAqlDpHifQJW16h5jWIIwYisvm5QyfxQEVc+XH1lt+taSzCfiBT0ZLgjB9Sg+zAo8ys6
5PHxFaT2a5Td/fj5yJ5hRSrqy/nj/hjT14w3/ZdX5uWg+cus6VjiiR/5qGSZRjHt8JoApD6t6/tg
ITv8ZEy6ByumbU23nkHTMOzzQSxczHkT+0q10/MxggJqMIICZgIBATBoMFQxCzAJBgNVBAYTAkJF
MRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFzIFIz
IFNNSU1FIENBIDIwMjACEAHS+TgZvH/tCq5FcDC0n9IwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZI
hvcNAQkEMSIEICOgtZbnjNPnp0XK9jkyAuFSQkAiQFiPF/waq0dMweU1MBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDQyMzA5MjIzOFowaQYJKoZIhvcNAQkPMVww
WjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkq
hkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCLzff9
FDeDetOWvy6uoOdJnlb25fbO6q5RHkefp+asUsi42FPODqn3EfHQdwwl4+C+keK704m9Y6zGgg4T
0vxixRA/BtSXwbM8Fl6Df200ElutWw3ljz5zva1NfMfAx2CNpDgHNtbAmEOhYUYd+VGOxVVlCOOk
0gsqxi6xHO2Yxbyf0Wkz6fPhz3TyElZQUrHt/Jim/6rNIaDHAlKzp34cdFdWdsIu9R+eJSazQHy0
ruGHCF3+zW0TxdeWINQJE/W2WKrLUAUhBQgatT1cAY5aMozV35d8JLYMiZ1m/Ft57btFmiR78bxn
aX+P2Imbjr5ryox6Ves599tT+j+e7/kq
--00000000000062f73a0616c0183a--
