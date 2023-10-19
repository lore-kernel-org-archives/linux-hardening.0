Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8374DF57
	for <linux-hardening@vger.kernel.org>; Thu, 19 Oct 2023 08:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rTeLy9Q6"
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292B3115
	for <linux-hardening@vger.kernel.org>; Thu, 19 Oct 2023 01:00:49 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-98377c5d53eso1182642566b.0
        for <linux-hardening@vger.kernel.org>; Thu, 19 Oct 2023 01:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697702447; x=1698307247; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ACymOhha49GHG8WcdW2zLNZCOQpvyxXia5tNQJpdAJQ=;
        b=rTeLy9Q6a3x9euSL6+b43mDQe48jmGqUookJGNUZefSK2poZGofhbXS+5nStGC39vx
         F3u7NZOg63NOnMLlDio/pWRnDyaqzhc96NPiqn6WXtYXIAkfRkNQ/EXvs61KL2uz2MeN
         6uFzMG4740DUX2wxKxQydnr1FfTXXEp8fGT1DqkjvYAs2FTgNXJLA3k+JmXyiVVPCsAy
         UIcwN/7Hd5LZzWDLBcQ7ZXd2lsy0WzAzLd1lwVovwROOSpaz+dhoz2DzVc+ocHwV4/uv
         HpsqgxGb/Wc6RG8ZbEYEcowHpFUiVei7XpWO4EqlO0OmjOUuZ2PB5UcQ5ctb9zaKiIB6
         kuNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697702447; x=1698307247;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ACymOhha49GHG8WcdW2zLNZCOQpvyxXia5tNQJpdAJQ=;
        b=Dyml8Z+Lkb2XRiTGJJ5IFJMeAW6oGijtEKqxavZV+2Jub/uttCJI3JzTx125WTmb5u
         UN2XmHeGUU74eErtSyCotgnzUrYHw+OFpR24q9/QlZsWXNd8tk56QmbcUJkiIGgOAxMb
         cw4HBIRtdtbqM+eThyhvbcFJWHNlHhLN4GCT9mu+I6Yosl/vJR82xNiaqm5XTIh2Sb+u
         hMld6dGTcSm8I8SkQqUGerAP2nrzEydkY2ewRgdUxFbVNo4pJBsdWv4EwocmvuHq0KvJ
         1lowjq8wctKr1fGKI+w62q7qr75xhidLIdOCo7EEstmmiHkvCEJTM/nxsIBCG7r5pDDA
         HtAA==
X-Gm-Message-State: AOJu0YwIvZXD1pAPaS2zl67Qlvue27jT/1SjAVsi+mzb5hkM68dZtgtr
	nHkS3oP8LvPw6Y9wP1y6wm6VOFrk73rAe5zTrpRQjg==
X-Google-Smtp-Source: AGHT+IGvvBAOXddF5owRwRHOfUfE25ctm4Piy/qlWCUDwS2bRynHrk5Ji3mZ1+oA2JFNfhdLg+9pNtGTmYzliW9xAww=
X-Received: by 2002:a17:907:786:b0:9be:834a:f80b with SMTP id
 xd6-20020a170907078600b009be834af80bmr1206934ejb.75.1697702447293; Thu, 19
 Oct 2023 01:00:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016143828.647848-1-jeffxu@chromium.org> <CAHk-=whFZoap+DBTYvJx6ohqPwn11Puzh7q4huFWDX9vBwXHgg@mail.gmail.com>
 <CALmYWFtTDAb_kpZdAe_xspqwNgK1NWJmjTxaTC=jDEMzfe297Q@mail.gmail.com>
 <CAHk-=wj87GMTH=5901ob=SjQqegAm2JYBE7E4J7skJzE64U-wQ@mail.gmail.com>
 <55960.1697566804@cvs.openbsd.org> <CAHk-=wjS=xg12RVQdTNxEurjo21eXQBQO0D5My6Aox4LCfsO1A@mail.gmail.com>
In-Reply-To: <CAHk-=wjS=xg12RVQdTNxEurjo21eXQBQO0D5My6Aox4LCfsO1A@mail.gmail.com>
From: =?UTF-8?Q?Stephen_R=C3=B6ttger?= <sroettger@google.com>
Date: Thu, 19 Oct 2023 10:00:33 +0200
Message-ID: <CAEAAPHYgg49WtpE7Jdq6HDecFp5RHPhdxtPTUaNF12RONu5aDA@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/8] Introduce mseal() syscall
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Theo de Raadt <deraadt@openbsd.org>, Jeff Xu <jeffxu@google.com>, jeffxu@chromium.org, 
	akpm@linux-foundation.org, keescook@chromium.org, jorgelo@chromium.org, 
	groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, jannh@google.com, 
	surenb@google.com, alex.sierra@amd.com, apopple@nvidia.com, 
	aneesh.kumar@linux.ibm.com, axelrasmussen@google.com, ben@decadent.org.uk, 
	catalin.marinas@arm.com, david@redhat.com, dwmw@amazon.co.uk, 
	ying.huang@intel.com, hughd@google.com, joey.gouly@arm.com, corbet@lwn.net, 
	wangkefeng.wang@huawei.com, Liam.Howlett@oracle.com, lstoakes@gmail.com, 
	willy@infradead.org, mawupeng1@huawei.com, linmiaohe@huawei.com, 
	namit@vmware.com, peterx@redhat.com, peterz@infradead.org, 
	ryan.roberts@arm.com, shr@devkernel.io, vbabka@suse.cz, 
	xiujianfeng@huawei.com, yu.ma@intel.com, zhangpeng362@huawei.com, 
	dave.hansen@intel.com, luto@kernel.org, linux-hardening@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000056b17b06080d27e6"

--00000000000056b17b06080d27e6
Content-Type: text/plain; charset="UTF-8"

> I do like us starting with just "mimmutable()", since it already
> exists. Particularly if chrome already knows how to use it.
>
> Maybe add a flag field (require it to be zero initially) just to allow
> any future expansion. Maybe the chrome team has *wanted* to have some
> finer granularity thing and currently doesn't use mimmutable() in some
> case?

Yes, we do have a use case in Chrome to split the sealing into unmap and
mprotect which will allow us to seal additional pages that we can't seal with
pure mimmutable().
For example, we have pkey-tagged RWX memory that we want to seal. Since
the memory is already RWX and the pkey controls write access, we don't care
about permission changes but sometimes we do need to mprotect data only
pages.
But the munmap sealing will provide protection against implicit changes of the
pkey in this case which would happen if a page gets unmapped and another
mapped in its place.

--00000000000056b17b06080d27e6
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPoQYJKoZIhvcNAQcCoIIPkjCCD44CAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggz7MIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
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
miiwZhqbFo3H+sN+36dVsCIwTAYDVR0gBEUwQzBBBgkrBgEEAaAyASgwNDAyBggrBgEFBQcCARYm
aHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wDAYDVR0TAQH/BAIwADCBmgYI
KwYBBQUHAQEEgY0wgYowPgYIKwYBBQUHMAGGMmh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2Nh
L2dzYXRsYXNyM3NtaW1lY2EyMDIwMEgGCCsGAQUFBzAChjxodHRwOi8vc2VjdXJlLmdsb2JhbHNp
Z24uY29tL2NhY2VydC9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcnQwHwYDVR0jBBgwFoAUfMwKaNei
6x4schvRzV2Vb4378mMwRgYDVR0fBD8wPTA7oDmgN4Y1aHR0cDovL2NybC5nbG9iYWxzaWduLmNv
bS9jYS9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcmwwDQYJKoZIhvcNAQELBQADggEBABDOrwE7xhhZ
KPffKFRtuggfC0sfh0EHmrCzCXlyiQFmTpjm73me7rw+ibiPUnohQxkeqC9KvwDd/gF7OAY3un01
f8y5iEmwoymOLIzkTKIMHDp6qOul60jFrAWe8EQMuBMEc9TQbOiXB4jFgLuDZX7AspyVvnmLA5sw
msq0yrGgxTsEeZniQpdOP/qZNS2TJmvNH8a8HuQfHH/pd20lRWfTEuhSRN8cTkKihK7iO8wjCmrp
EXefUessFdMqMUSfGI6rUaZTfU0SRfdrVHW4IE8onI30/UVurbGlFiugNF3LbDMXdqzs2/eTsLiD
8Dv1+pt7SJqI4zNhzZFOpvBPVIkxggJqMIICZgIBATBoMFQxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFzIFIzIFNNSU1FIENB
IDIwMjACEAFp/vXw/R/y8Lw9a5440YEwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIE
IPi898HIh9BIwdhETZ7/O7Dh3D+SsJLi3hgcuaXknxYwMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0B
BwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTAxOTA4MDA0N1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgB
ZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQow
CwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAZGA2Cd/UjtzNhs4zX
p3eag/xW+BTUBF/ITizZRukko4vAy6z8c/uelsd47857pBOkhqW2SCgQ6A7YJOdqXi/IxYv1y+MH
74cRBtTnZ3i2Qj/2oL0gXtuwLGWP2b8PwKnSigUOj6c06i8viH2pYF5QQkt9kJCYg7/BADl0VrCO
KA0sChavPZ7DT2V7JwCH/i0okvfPuL3rGakweTdvuKK6VYUZJu+8MGoOp+Ybhtw574270ii8oC2a
Dm/k/wQ+F0d38Tpfb9yxZoxzfOINM7H3ctc3gIXfjlSD90uAwcoriw5717lbvmHHQmfFH6Ny6kES
y1ckI+KJBbzuPvnS6r8K
--00000000000056b17b06080d27e6--
