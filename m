Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE87D8F64
	for <linux-hardening@vger.kernel.org>; Thu, 19 Oct 2023 07:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GAoOf/cw"
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADAB9123
	for <linux-hardening@vger.kernel.org>; Thu, 19 Oct 2023 00:27:17 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99c1c66876aso1239960266b.2
        for <linux-hardening@vger.kernel.org>; Thu, 19 Oct 2023 00:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697700436; x=1698305236; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O/ZKxMKf/USNm5bZ6xhM+rXMP6XySK64MyJeVcyVRQo=;
        b=GAoOf/cwUX8NSRUIZNfD611OUNq95HSD2qyBBSMD+9I9H816iyTNFrIUndp6Jsl7xW
         x03P7rTZhMB+yLfqT2vsWDKFfbTFMwnOFwUw5vE8XbJuh51zSd305L4i7QA6WMlRZ6un
         D0RmyQvVMBQFuKPJryifqkToXnje2T0nT1y5HtlFu4gNDh48ydwE0tzPDC6r8hccq+mF
         QPUyc1ROBZCF8Bn8DKUrn1uVZhAqczHsA5Qh/G/UXb2745Bb9hiAxaLnqjLrSVju940O
         LmacuZgB95jBXP0aG+aPU9D6cBX2ZbYhG1NAJyuO7Yl8V6/AiNUQ5H4S3z4YyL0th6vN
         xrxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697700436; x=1698305236;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O/ZKxMKf/USNm5bZ6xhM+rXMP6XySK64MyJeVcyVRQo=;
        b=VkmjUTFvkRDY3t8TZ9wGPHK3ZAWClOEeonIMd/9ZG/MMPYwQjBvwt04M8yDfEgFuHg
         CVmYm8EgwHUbKZ3Rc069crXW11faBHvxfPhk1ADrVVraCSTnPpZjauUm4uQHQTkLW6jE
         AgOrXyX+EeG3+c9r8xghbx3ZNwatIM6zuegD/kh9o2ggP2ORPdGnd+SqYuF2ynFPhQNN
         N2viCHL2b1wjwhWw/9Uxvk52yJw+ehuXXNjmCpHAoCR5cEYMux49+2nA242bCPxKXu/2
         omLjOla0cBrhZzOKwwkajqjLgJ9xt4DSyEJzquln7By2xrgWnkF6A7LNbZ/WhnGhnsVc
         OA/A==
X-Gm-Message-State: AOJu0Yxq3LsXlTZp6p3HOWUdKu3bEpz/wteDtuNgjOvklgyjQqInyaC9
	tekguUUir3JVuI/PcQ9tNIlIG+fdOYZ6BfyIWXhH2g==
X-Google-Smtp-Source: AGHT+IGDuSrjm/LSP0ZdVnB/CsSuk8tRwiJx8nY9IgGE+UbaAmYZ6S004s+qoUGv4L+jbyufwK1NmNeJnxPu2l58U3I=
X-Received: by 2002:a17:907:2d9e:b0:9bf:b8f7:1fca with SMTP id
 gt30-20020a1709072d9e00b009bfb8f71fcamr971488ejc.55.1697700435854; Thu, 19
 Oct 2023 00:27:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231017090815.1067790-1-jeffxu@chromium.org> <20231017090815.1067790-8-jeffxu@chromium.org>
 <CAHk-=wh+6n6f0zuezKem+W=aytHMv2bib6Fbrg-xnWOoujFb6g@mail.gmail.com> <CAHk-=whchB_=Qx_oNAg3KBe-erNg9R2p_91ikaRZhsNY_2-G7g@mail.gmail.com>
In-Reply-To: <CAHk-=whchB_=Qx_oNAg3KBe-erNg9R2p_91ikaRZhsNY_2-G7g@mail.gmail.com>
From: =?UTF-8?Q?Stephen_R=C3=B6ttger?= <sroettger@google.com>
Date: Thu, 19 Oct 2023 09:27:03 +0200
Message-ID: <CAEAAPHYakbZxf7CYbhGVJ-sGM3KFP3vCMJ9kErbMpi75Ekg20A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 7/8] mseal:Check seal flag for mmap(2)
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: jeffxu@chromium.org, akpm@linux-foundation.org, keescook@chromium.org, 
	jannh@google.com, willy@infradead.org, gregkh@linuxfoundation.org, 
	jeffxu@google.com, jorgelo@chromium.org, groeck@chromium.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, surenb@google.com, alex.sierra@amd.com, 
	apopple@nvidia.com, aneesh.kumar@linux.ibm.com, axelrasmussen@google.com, 
	ben@decadent.org.uk, catalin.marinas@arm.com, david@redhat.com, 
	dwmw@amazon.co.uk, ying.huang@intel.com, hughd@google.com, joey.gouly@arm.com, 
	corbet@lwn.net, wangkefeng.wang@huawei.com, Liam.Howlett@oracle.com, 
	lstoakes@gmail.com, mawupeng1@huawei.com, linmiaohe@huawei.com, 
	namit@vmware.com, peterx@redhat.com, peterz@infradead.org, 
	ryan.roberts@arm.com, shr@devkernel.io, vbabka@suse.cz, 
	xiujianfeng@huawei.com, yu.ma@intel.com, zhangpeng362@huawei.com, 
	dave.hansen@intel.com, luto@kernel.org, linux-hardening@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000734f9906080caf88"

--000000000000734f9906080caf88
Content-Type: text/plain; charset="UTF-8"

> Without that practical reason, I think the only two sane sealing operations are:
>
>  - SEAL_MUNMAP: "don't allow this mapping address to go away"
>
>    IOW no unmap, no shrinking, no moving mremap
>
>  - SEAL_MPROTECT: "don't allow any mapping permission changes"
>
> Again, that permission case might end up being "don't allow
> _additional_ permissions" and "don't allow taking permissions away".
> Or it could be split by operation (ie "don't allow permission changes
> to writability / readability / executability respectively").
>
> I suspect there isn't a real-life example of splitting the
> SEAL_MPROTECT (the same way I doubt there's a real-life example for
> splitting the UNMAP into "unmap vs move"), so unless there is some
> real reason, I'd keep the sealing minimal and to just those two flags.

These two flags are exactly what we would use in Chrome. I can't think of a
use case for a more fine grained split either.

--000000000000734f9906080caf88
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
IN2IFPpOnvXSpoGzgEz3z1Q7ztGrZLNWxOihLSSxsUInMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0B
BwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTAxOTA3MjcxNlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgB
ZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQow
CwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAQZi8Cbujk7196wVll
Ohg031+F1CO0igozIyB4gXg6lJ/SWn7dHjH/fbtuqmRgIMAK0JJkv3/lxutEF7Rnw9CUgSSw7c8l
eq2/8nqhOC6E6GgJ63tyfJ0q3EiwXZTfzqBNh5TnoFUFGjzgYr+eSKbP6DFGCYqLk/y3749s3yo2
S9opv3yJY/2deCWfCSX7JM4UPM53PGyXZjtH/TW/ocuocdldouKXrnxbCr4+/MVHXHYale0oqmJV
ahL7qn3Gpb6x7PBUGZ7XoZghcy4AKiPKaJXmyWEahnhhC+FPCfHRyuewSrWUbV3TyOdrbp7Tg/zt
5gcgWkqKezX7GR/5d6KT
--000000000000734f9906080caf88--
