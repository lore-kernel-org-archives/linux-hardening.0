Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEE92EAF7
	for <linux-hardening@vger.kernel.org>; Tue, 17 Oct 2023 21:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="O7nLD01Q"
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF424170A
	for <linux-hardening@vger.kernel.org>; Tue, 17 Oct 2023 14:27:50 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-53e3b8f906fso8432522a12.2
        for <linux-hardening@vger.kernel.org>; Tue, 17 Oct 2023 14:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1697578069; x=1698182869; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zv9dCxYWEpQHm9cXUl+0kUfVkSq2tjjytfz/JgW8glY=;
        b=O7nLD01QCaojySsCSzHe2xDpEnN8OiI8JzF6HTYpuasYVPxgcwdejOPn+vID+DUtwx
         H8mA0+bFKrESTcA2ngXLMgXM7ydbD+p+MlTI+IXPjaem1dm2iOPCluIO+liRcQbhH0GE
         8s1BrJJcz8s5dH13IFYoBTOHjXEF4Cwk1F2Vg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697578069; x=1698182869;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zv9dCxYWEpQHm9cXUl+0kUfVkSq2tjjytfz/JgW8glY=;
        b=NVrR4I4pvt6YyMeJPm/UP/wR7EoGUkxwT4p/50xFAugWZpcjwq2spGfKATduZ3wtnI
         DATXrsBwxmfGqWDMgxjN9v/inaDCS/e/uQfXCnoUJQPHgUwzCwifEFWO80b3gNrCq31F
         oj4iGg6Ov3LWvdRPsjnp4KV39lle59NZknDKGnuS+uK3h/FWkSGPNhLaOEG2hckIB4Vh
         aGlW3JvLwSWINzBXu8epvygR8YHY+mw9VNm85Byl7aNNm9G8DXIbcqzLeDnTC6OIKRvf
         dVIRS99yPP7UUwzHVpopu03Bi78H96lQ3WiCTehBPXkK+tRfot/qGwtoJZXJUYoo07+2
         gJxg==
X-Gm-Message-State: AOJu0YzwhK3Up6fni40MlvvINcVhPAhSSst8xjZM01ZeSrM0Tqxwm4Mb
	BA2l4RcBdJXpG0VC7gyby7Fy6N+SH1Fy0/tuof7LGw==
X-Google-Smtp-Source: AGHT+IHz//RTMV0xdLNsXC+boHDA3P92nGp7xaTVos4w8MggCT9M2rR3TSu1YqGCHC2/kEs7JuziGYkbZHEK19GvaZY=
X-Received: by 2002:a05:6402:2711:b0:53e:f321:e6fd with SMTP id
 y17-20020a056402271100b0053ef321e6fdmr2880225edd.9.1697578069408; Tue, 17 Oct
 2023 14:27:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231017-strncpy-drivers-net-wireless-broadcom-brcm80211-brcmfmac-cfg80211-c-v3-0-af780d74ae38@google.com>
In-Reply-To: <20231017-strncpy-drivers-net-wireless-broadcom-brcm80211-brcmfmac-cfg80211-c-v3-0-af780d74ae38@google.com>
From: Franky Lin <franky.lin@broadcom.com>
Date: Tue, 17 Oct 2023 14:27:21 -0700
Message-ID: <CA+8PC_euoeTyvhm8ANWD0KawzZxYsEdRqys8COoez0dGvFxn6A@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] wifi: brcm80211: replace deprecated strncpy
To: Justin Stitt <justinstitt@google.com>
Cc: Arend van Spriel <aspriel@gmail.com>, Hante Meuleman <hante.meuleman@broadcom.com>, 
	Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org, 
	brcm80211-dev-list.pdl@broadcom.com, SHA-cyfmac-dev-list@infineon.com, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000d2e02b0607f0314f"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--000000000000d2e02b0607f0314f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 17, 2023 at 1:11=E2=80=AFPM 'Justin Stitt' via
BRCM80211-DEV-LIST,PDL <brcm80211-dev-list.pdl@broadcom.com> wrote:
>
> Hi,
>
> This series used to be just one patch in [v2] but I've split it into two
> separate patches.
>
> The motivation behind this series is that strncpy() is deprecated for
> use on NUL-terminated destination strings [1] and as such we should
> prefer more robust and less ambiguous string interfaces.
>
> In cases where we expect the destination buffer to be NUL-terminated
> let's opt for strscpy() as this guarantees NUL-termination. Other cases
> are just simple byte copies with pre-determined bounds; for these let's
> use plain-ol' memcpy().
>
> Each change is detailed in its accompanying patch message.
>
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strn=
cpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.h=
tml [2]
> Link: https://github.com/KSPP/linux/issues/90
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Reviewed-by: Franky Lin <franky.lin@broadcom.com>

> ---
> Changes in v3:
> - split up into two separate patches (thanks Franky)
> - use better subject line (thanks Franky + Kalle)
> - Link to v2: https://lore.kernel.org/r/20231016-strncpy-drivers-net-wire=
less-broadcom-brcm80211-brcmfmac-cfg80211-c-v2-1-6c7567e1d3b8@google.com
>
> Changes in v2:
> - add other strncpy replacements
> - Link to v1: https://lore.kernel.org/r/20231016-strncpy-drivers-net-wire=
less-broadcom-brcm80211-brcmfmac-cfg80211-c-v1-1-4234807ca07e@google.com
>
> ---
> Justin Stitt (2):
>       wifi: brcm80211: replace deprecated strncpy with strscpy
>       wifi: brcmsmac: replace deprecated strncpy with memcpy
>
>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 2 +-
>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c      | 2 +-
>  drivers/net/wireless/broadcom/brcm80211/brcmsmac/channel.c  | 6 +++---
>  drivers/net/wireless/broadcom/brcm80211/brcmsmac/dma.c      | 3 +--
>  drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.c     | 4 ++--
>  5 files changed, 8 insertions(+), 9 deletions(-)
> ---
> base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
> change-id: 20231016-strncpy-drivers-net-wireless-broadcom-brcm80211-brcmf=
mac-cfg80211-c-a20108421685
>
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
>

--000000000000d2e02b0607f0314f
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
BZrfei1PlO2m9d3AfpeD7Y1pVL1SrZC1yvhXeDO463M8rGKz/l8XZrJY1P6qU8U6QwxjFgXr5o5B
9N6Yw9IhwXhZI3m6F1pe3mMdZ9cFC3xS3Ke+awIDAQABo4IB2DCCAdQwDgYDVR0PAQH/BAQDAgWg
MIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUFBzABhjVo
dHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMDBNBgNV
HSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2ln
bi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRwOi8vY3Js
Lmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAiBgNVHREEGzAZ
gRdmcmFua3kubGluQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAW
gBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU0v383z+6bcUXkukYi4fq7VBiM6swDQYJ
KoZIhvcNAQELBQADggEBABUIiuJPuLq9vbb6/7d0VJ6LS6osA6kNs0Tph9iEX49TxPQJtvA97oy4
AgPCjWNiAMLkmu+kNQKlNZG3Vl3S4A+VMOogB6aKtiLlz73Cs0sPgpohw6GSS41TKVt17PrAzo0o
/xuXczzIbtvrpoi6OnGlsW4aVCqQSOqKUamG8wU8u3/h+iPM1rr4z6ZHdyrllNi+ukH/Z6Dpn6wF
ATUa+n5ReFZpli4TzcqVHw7i+OaB23TMHCwed4OPFm0H3zcCJgVtgt3z95IPak7bBuYLAGMT2c3K
Xkdn27MnpydqZw5mnP970DgyUMHXY3Jvj65UAVioJUr4LkNBL7Tsk/6q0FExggJtMIICaQIBATBr
MFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9i
YWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxcbvtv+NUbtJoPDWwwDQYJYIZI
AWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEILT1iC3aQyymafY12H4b/+tMNcXJx2JOomwQDhhi
fJSfMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTAxNzIxMjc0
OVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQB
AjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkq
hkiG9w0BAQEFAASCAQATZBnt3TWrBgxd2UDG44w+DvkKxKBjSUHEKRGiQA7WF4OTNZFNMea/bZxq
7eL8p2mtwx0/PZmhUYKJB4HMODXuE+6rPuqwtZ4mxlp0QmnP9qEu1vnflVIpLmVaa9+0Vf1ZHECE
DZysuq+2R3sa0IhBNhPLavnPyV7awNxrd7EDtZ0wlwyQuBR1UsfQNngq2wacUJniWa423kxuZuqi
JRX4uKEsVgi1LiFO1SKRlQZZKyTFCvBSFCD54o8rbqmuq4zSDedlRCcGN2YS3sXiRdy7FZmQRG19
M1DugJQP9QwykW73z96O7zqZic4Kcih0tKvNR7XJTECIvJqZrdro76WH
--000000000000d2e02b0607f0314f--
