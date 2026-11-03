Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.97
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793714376;
	b=Uh8lTr6Hu2ZrAQXoJxNQGRYVEe6QmvfZTtu9kJX1rAEDdjPozZzLGEAuhWAl23IcyI8P
	 xOQD5a6bAntbyXtB/pptBV/LoohZKP50Pq+QU1FfKNLmJu/4zWDk8+AbaowxSkwGhjTul
	 a4L+ObZeKzOOFj+xVdLwqePrNxwrZW4OC07RQqli2hDloSoT39pX7VRVz1a1UoidLQuJm
	 M2s+rCo5Kf+A/4CnbVj8Yg1K4Y7ymXla0VXTiIAIuuo839upgRabPhtARIEFlVQfFOhoZ
	 r6MsUpYcVHkP0WsfGvr187Un4+NU+9+ZLVpkunQD3X57fl73Zow3D3jPAoK4wrBcCQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793714376;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=43xLL3WpmNZ/pYhKQm6M7yVVXTs8TfUEc4VM7Zt3f3A=;
	b=DBco67SgOkos/EIg4h2+tZ2/tJxRKQcP81kA6cgbgXkvcQErtn9cg8axZ3lgfvYP01r7
	 wcdE1eyMISxF1x7+YRSA1J3nx7gErJctHNzH0T9ZwshamlsafJLZ+joThsDdFIQHEK6MG
	 h4xZibASayByA3ok1xI16d4xWANsqNqQTkfe+1CYOPFmbIwDklQAFj7IOkniflRJEtLpR
	 HsMQuhDhyoTM9IcU5jR4kcL+0KTKNYa1HWeuN3HfMSwmsXbcAymPSVdnJr+9BlLEYjqAY
	 ucHJhf9mHtMUUB/SvkCMDiT+Y2OzXf8nmEpF8BZdFylHcyzWW/6lUfa+5BOCv1c5jBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=ISDU6a6r;
	arc=none smtp.remote-ip=209.85.216.97
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20FB606D82B
	for <linux-hardening@vger.kernel.org>; Tue,  3 Nov 2026 13:59:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E20FB606D82B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=ISDU6a6r
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-3acd21ba21aso3059080a91.1
        for <linux-hardening@vger.kernel.org>; Tue, 03 Nov 2026 05:59:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793714375; x=1794319175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=43xLL3WpmNZ/pYhKQm6M7yVVXTs8TfUEc4VM7Zt3f3A=;
        b=AqoEozc6alSiwsjqhsvjM1GidJyHO8DwRSV+Ys+S4Gjqg7XPLfZIb7W9lbKbYCqorM
         CvCxy+H5meu2l1icCS5uPOkFuEY0H7Hi++bdNz7BCFql3MTfmN5SbYa8QlSZ0mD6m3v9
         mjtHiRFDktiW02grm1FJAKKSxmasE2oP5XH7X0U/f3wwUEnz3Nvjd5wAdkhhpJ1q+jdO
         FYI+Wn3U+QwXtxkY9D77JJsfC1ZeRRsm1o3g+4LfaMtifT5Jkp8fROYFNQapzyaBoaPq
         yv9aiV5R/qN2utB7r8IYxHexCwQOPYRnWkbWNYVIC40LprhCaNOeMU9tKeArOuH6PWcb
         ZImQ==
X-Forwarded-Encrypted: i=1; AKwUvBwNmYAH7zIvlupwC6tvYQmR9/1jjxlYd3DEyoQ43dze8kcJB1gr/nhrg6W9nznywS/qo2ikK85VlefNNnNOtP4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8v+U11/3TBaxhSoCmvCXfIOVYA4IGb6DZazq89yM7SW6P1ENLw
	v2btb9YrdJJs/cYCRxR7fxMl525dNjc9Svwy7pimF5DtV1tES39fK5kK0Aiele75fRLEFmYZMay
	EH0zt7Jjj5f2jZqZCLHyEw00EDl5uvgNSHxnZpgsLGCqWmlLjw+9ULmAPC8Ek0HRFqXH8n+qt3A
	j9QtZKILHn0OyppP4PDnDNvcXrQW80IaLrRYO8R3qvrLlQkSFo2Xtcl24QFR5D1JedGAJ7CTsDZ
	b3PFRulCWWC9QrbeHEsGaozXvnnWA==
X-Gm-Gg: AYBFou1BzAsTAelWLMOB2yJt5wXlcDVxRUsWYkQlYzE9knUayOmPXp7LGrEpneCJ5SG
	28YiYxYtRClGGZtz+sLz8cSdCxNB1zZqCG1LDmH4PEURreMk0ZDslk0cXca+T9GLMvH/7LyjBrk
	VJFBedigID/1Nbo5AmL94Fjs4/AqO5oUTokXQOEsjpYJWZa23ilQQaw+CZV4sEm3BVGnbG9ZpDh
	MiEuPQf2+BokNq6kn1X0SPfdxUlBpb0bBzqhBp6VouKkP2XHTKIPKAaz5ltnB+I4u5O+NtELOe5
	yCaoYNLO8O44vGBgYW4ZFCOdxyCmkvP3fRPjj7Bsoc2GPFxqhvJ4X7+mGZyHFiBpOcGWE+PpLgJ
	YRH9MDGsAAaoBuh6xZybh0oM/VsFXYnqD25ccN1YDmbmD+5G11v1R3bhF7OqHJI8q2cHfY2aWiU
	nZvYCezTGYOgfwqRGeNX5S7QpgH/hc6G3IZprJWso=
X-Received: by 2002:a17:90b:268d:b0:3ac:762d:79ae with SMTP id 98e67ed59e1d1-3ae895a5c65mr10176824a91.2.1793714375185;
        Tue, 03 Nov 2026 05:59:35 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b07c8a16ecsm1949704a91.5.2026.11.03.05.59.34
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Nov 2026 05:59:35 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-30bcb065bfdso7626353eec.0
        for <linux-hardening@vger.kernel.org>; Tue, 03 Nov 2026 05:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793714373; x=1794319173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=43xLL3WpmNZ/pYhKQm6M7yVVXTs8TfUEc4VM7Zt3f3A=;
        b=ISDU6a6rW4p2f+cGo6Neyxj5GI/ethEwfEGXvxQQEBa7XK0VqV0LEZcmo9AN2czJCj
         Yx529j5gOxKgSEViEgGlkfdZ9SFDMH3Ip02HXgqRaVYrY7pV/cJzFAIEJRp3ZxA8KNVb
         /3N7MlbT9ntoy/GR/G0rn3HMtR1EsGBgWEREA=
X-Forwarded-Encrypted: i=1; AKwUvBwHLlPIVx4vLCQ6NlWnNhIgy+5MoHHslAXRNQFv9ta3Sf7tIQ4rbOMDJK9cFaIjc/XnmVR2Zpg9ljeyAn7aZhY=@vger.kernel.org
X-Received: by 2002:a05:701b:450f:20b0:17d:7b45:f905 with SMTP id a92af1059eb24-1ac5f36ca91mr19014237c88.31.1793714373159;
        Tue, 03 Nov 2026 05:59:33 -0800 (PST)
X-Received: by 2002:a05:701b:450f:20b0:17d:7b45:f905 with SMTP id a92af1059eb24-1ac5f36ca91mr19014203c88.31.1793714372513;
        Tue, 03 Nov 2026 05:59:32 -0800 (PST)
Received: from bld-bun-02.bun.broadcom.net ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac18458e07sm41658755c88.8.2026.11.03.05.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 05:59:31 -0800 (PST)
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
Subject: Re: [PATCH 05/13] wifi: brcmfmac: Negotiate PCIe mailbox transport with firmware
Date: Tue,  3 Nov 2026 14:58:50 +0100
Message-ID: <20261103135856.3676311-7-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260925-brcm4388-submit-v1-5-b5cbc2cde2fb@gmail.com>
References: <20260925-brcm4388-submit-v1-5-b5cbc2cde2fb@gmail.com>
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

On Fri, 25 Sep 2026 23:43:40 +1000, Michael Reeves <michael.reeves077@gmail.com> wrote:
> From: Hector Martin <marcan@marcan.st>
>
> Shared protocol version 6 and later allows mailbox messages over the
> control ring as an alternative to the shared-memory mailbox.
>
> Advertise host capabilities using the negotiated shared protocol
> version. Select the control-ring transport when firmware does not set
> BRCMF_PCIE_SHARED_USE_MAILBOX, and dispatch received mailbox data
> through bus operations.
>

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

Regards,
Arend

> Signed-off-by: Hector Martin <marcan@marcan.st>
> Co-developed-by: Michael Reeves <michael.reeves077@gmail.com>
> Signed-off-by: Michael Reeves <michael.reeves077@gmail.com>
> ---
>  .../net/wireless/broadcom/brcm80211/brcmfmac/bus.h |  9 +++
>  .../wireless/broadcom/brcm80211/brcmfmac/msgbuf.c  | 57 +++++++++++++++
>  .../wireless/broadcom/brcm80211/brcmfmac/msgbuf.h  |  5 ++
>  .../wireless/broadcom/brcm80211/brcmfmac/pcie.c    | 83 ++++++++++++++++++----
>  4 files changed, 139 insertions(+), 15 deletions(-)
