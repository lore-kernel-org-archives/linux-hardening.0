Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793714385;
	b=Ohvxb8JdW7nX18wu/qQ6DBHmPy6XPzO8nW6m+Ww9SkU3pbuSXU6YvbQkQxA6uX7zp+KQ
	 5bqg92Nnm9/zZ0b+SQtj2SPgyO1jp2RUFhCXzYisBZHOZHXMLEMWMb5qupRVFpjgycNzO
	 f4Fs9cPckOABmGNs6Fm4RyKFi0xU/L3cuQQ3ASn0lGlY9ENoAN4Fo/bQgBdc28aKt0W0A
	 Az5t6vFKc0xDCw83NRytYHov/crCwsvpRHcgcETKzflpwBr1dNADsqg10LFVXpQXtNP3A
	 3ZphycQ3PJ+rVDDPiY6rFvKb1zDwWf6z5k/AK6NDY254hXVqxCWgEIAR2PwcbNyzHXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793714385;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=TR67u4JxnjJub76U3ECbURlUoxwJMuJHoq+jVOWi5Uc=;
	b=thUWARHrx8afE7wQOPm/tEpGIJ4NMmHSieZ3CGBpIo6Qk29ejMX6+3fONrrumMIL0Qxk
	 QqiCBmqyK/RMO9xtTQ9jnJ9ydoMlecdIr2pA9vd5eMOc3E8JurL1J7IMyGRnXJNzkk37t
	 QfiqPfPlQduj7X0O5vdBfaLtI+fmX9AnO98WeFrMZtm7lSdjPfyJMn50ZGgd4fWmUPwD6
	 VgAVz14URQByWgPKLf+IkN/oIxj9l464E+8qNIuem2LTRkb9tyI/t3YasqFBXuCoKToVP
	 a+wLDY8oL2fXCYMnkncfrRQAAWV1GsJnXOUB+zmaaKb43YGYeRHa5hjSOGb60/H6Hgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=eeDjGu8i;
	arc=none smtp.remote-ip=209.85.216.98
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B54606A33D
	for <linux-hardening@vger.kernel.org>; Tue,  3 Nov 2026 13:59:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86B54606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=eeDjGu8i
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-3ad41b47541so3042652a91.1
        for <linux-hardening@vger.kernel.org>; Tue, 03 Nov 2026 05:59:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793714385; x=1794319185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TR67u4JxnjJub76U3ECbURlUoxwJMuJHoq+jVOWi5Uc=;
        b=jqkVRtjtdCpcDEcXQat/1gBJwiExoi35z53cLZyrkTWFyhet+sKtS/wNONHaVLgaYw
         7/oWgSPOY+K86w5RF+Kcftg8ms4B9hMuDExxzM3NZ5DMTdJae5ClG2j/GqFF1KqCtP42
         b7g/w2dB8vVIq8X0wanqrpALuFSKLjOcrir9MRqdwI6KduezyK5ryN73l+9KIK16dtnw
         gHqbC2yM2CWI5BwAFcbRxVoW+Hw9EcNRsqj1MSUEzRNa4uI+KLEZkMy5s7Hkxg6UWjgO
         RabzAY+Oo4bGSVBOTb4Y1qJhb7Wvov0RilP2QK09+49nwxqbokS2a+S8OqdQNzok4P6a
         JcHA==
X-Forwarded-Encrypted: i=1; AKwUvBxz4XIUXBucu2dhFl+zKo+ihmH0a2OGp5lfyB3ghpggbrSZtWTRpYpZsLGn94bk9yZ25PGxoN+DpNvdG024YVA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/PthJux1WxZEfNOobPMMwa20lyPbTrRC8pa/NhdwuPwJzb+diw
	3HhQhxw6PMYAbnLkFeBXCyGnaVrfgj02lzzC6liTMcm0LlMxAsDSDk4MwlLaforgwEVkgoMTiHl
	H6aUIrU3EGUbzr3ouMr+uBfeczqdqYfGrvsHTTdu0IW2PHtizehGaQAaUUS7cd50muTWQKJkEHd
	lVOn6e5B2cdsqWgYCctlQXLr9knEBLrHoas72g23IT1YMwsEZk414Wu6MWHWAEbqOOVFXlUpbjg
	/siR1ROuPsx6H0JwScsfoeRD8Q=
X-Gm-Gg: AYBFou3r4kGqevtcCiHRHSTAs02wW7UapA0cDEvgk4hn+CECr/mHh96SWxAjQgZTuX9
	H0ukmdSxpEivq9WaCtvt5TvHHYZJMpoBF/Fz2wDUjrdFY1a93y1qnNauIDoJmkiGGK33cfPfbiO
	s0+AKS0ECacAh4OOfRbvqYm6UdICs9Vt+3mQGKWgGF452grDCSjfLTADQCnrYr62dSbLW/n2ViG
	HcEESIMoMCq9jl/VRQFdP/Ia5EfJsu/X4nMxW2SHdwWM1i1trLJEcIjdwMSXMDd4y7bF8xwPQzL
	BUkLb4rd5V4slDuCmRSfvhlHtIhtDZ3GFkZ9Gb4ycSxeX5XnPcszbXvSb4czuvHODBDXm8CPLgq
	R3RdSyNlGecf+opBwnSyObClgTKT+B6IR5xH/oLbJSVeMHBO+TlEB4u5TJr+HTaDYIFnACfC38R
	q/M0lcVi6EB7nO20r/XLGeLOAyzme4t9HQdDWCeqM=
X-Received: by 2002:a17:90b:2252:b0:3ac:e9d4:5530 with SMTP id 98e67ed59e1d1-3ae8974ae3cmr11596547a91.24.1793714384926;
        Tue, 03 Nov 2026 05:59:44 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae87fdab62sm4077553a91.2.2026.11.03.05.59.44
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Nov 2026 05:59:44 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-15c16792146so2612721c88.1
        for <linux-hardening@vger.kernel.org>; Tue, 03 Nov 2026 05:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793714383; x=1794319183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TR67u4JxnjJub76U3ECbURlUoxwJMuJHoq+jVOWi5Uc=;
        b=eeDjGu8i626ywMWsC59NcSQKW2UIVjT7DC1IeTC1ssUNVkLLiCocmLBJL+KrAZ4Gx9
         9Zix8yQZjzoFgqJy3tG274SoaGz+WZkFKd3iWCDDmLkvjSVrdzKurWiu+laVs7mfZdIj
         0N0PvuMh7tHUxMhouuEw5iixQ3HpowdvAklto=
X-Forwarded-Encrypted: i=1; AKwUvByspqfyPlMhEuLbjfIfWUYUUR04xFtSpYjzQt72PmeUWSuVS3OhiHRQPJ0pF5wTcabviQXgCecSsv74ExnEqks=@vger.kernel.org
X-Received: by 2002:a05:7022:ea56:10b0:176:a225:e364 with SMTP id a92af1059eb24-1ac5de547afmr19489903c88.35.1793714382829;
        Tue, 03 Nov 2026 05:59:42 -0800 (PST)
X-Received: by 2002:a05:7022:ea56:10b0:176:a225:e364 with SMTP id a92af1059eb24-1ac5de547afmr19489867c88.35.1793714382225;
        Tue, 03 Nov 2026 05:59:42 -0800 (PST)
Received: from bld-bun-02.bun.broadcom.net ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac18458e07sm41658755c88.8.2026.11.03.05.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 05:59:40 -0800 (PST)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Michael Reeves <michael.reeves077@gmail.com>
Cc: Pieter-Paul Giesberts <pieterpg@broadcom.com>,
	"Franky Lin (Zhenhui)" <frankyl@broadcom.com>,
	Mathy Vanhoef <vanhoefm@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	asahi@lists.linux.dev,
	Hector Martin <marcan@marcan.st>,
	Daniel Berlin <dberlin@dberlin.org>,
	Janne Grunau <j@jannau.net>,
	linux-kernel@vger.kernel.org,
	Hante Meuleman <meuleman@broadcom.com>,
	linux-hardening@vger.kernel.org,
	Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: Re: [PATCH 07/13] wifi: brcmfmac: Use event_msgs_ext for event masks
Date: Tue,  3 Nov 2026 14:58:52 +0100
Message-ID: <20261103135856.3676311-9-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260925-brcm4388-submit-v1-7-b5cbc2cde2fb@gmail.com>
References: <20260925-brcm4388-submit-v1-7-b5cbc2cde2fb@gmail.com>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On Fri, 25 Sep 2026 23:43:42 +1000, Michael Reeves <michael.reeves077@gmail.com> wrote:
> From: Michael Reeves <michael.reeves077@gmail.com>
>
> BCM4388 firmware rejects the legacy event_msgs query during preinit but
> supports the structured event_msgs_ext command.
>
> Probe event_msgs_ext during feature detection and initialize the event
> mask after feature flags are set. Use the extended command when
> supported and retain the legacy path otherwise.
>

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

Regards,
Arend

> Co-developed-by: Hector Martin <marcan@marcan.st>
> Signed-off-by: Hector Martin <marcan@marcan.st>
> Signed-off-by: Michael Reeves <michael.reeves077@gmail.com>
> ---
>  .../wireless/broadcom/brcm80211/brcmfmac/common.c  |  23 ----
>  .../wireless/broadcom/brcm80211/brcmfmac/core.c    |   5 +-
>  .../wireless/broadcom/brcm80211/brcmfmac/feature.c |  39 +++++++
>  .../wireless/broadcom/brcm80211/brcmfmac/feature.h |   2 +
>  .../wireless/broadcom/brcm80211/brcmfmac/fweh.c    | 130 ++++++++++++++++++++-
>  .../wireless/broadcom/brcm80211/brcmfmac/fweh.h    |   1 +
>  .../broadcom/brcm80211/brcmfmac/fwil_types.h       |  26 +++++
>  7 files changed, 199 insertions(+), 27 deletions(-)
