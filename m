Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793714399;
	b=MyEXJ8JKGVSwQE1NruT065wt2SX47KG4nPC1tZCmSNqM0fv4pNfIkvqXtrTiLjxMmznb
	 qsPDBnpMkIyBJrjK+v/aD1g/RHMYJl917Z8HR1C1sC+HijIX3reXwripD8DtO6VsTtpWz
	 e+BMQExE9dJAE3gZuINtlI8cKbgI1zWTymICVM3ixZ6FBc4S5UowNwpLCGFZm2C0cJRUj
	 oin/c1EkEiLmJXA9y1NeX/hP+/tSejlvDfCnlN3bBJR7XEDGv/OvfTLASmFoWjNse/JQr
	 u5XeK/g/v72KCKX0gZuS+NZJIvnNaUr8heiyFV6chER0VTWTL2R8b5BR8SfIH3CJQZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793714399;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=xnAMlverv3/IjELyJ32hRjwWOMBKoAty6kX1tfLCe1g=;
	b=Ovb6LxG6DgLqd73ua/Iig1qgLYH0mvTBhTTQiQxYigADI3FJrETXNds8X8Y2zYjG1y+1
	 Icq/S/D/1sTEY0B6SqUO8ui5bJEKJhn99fFCiZtqpr1KewfhgfOD3esdN4zvic51lUuMu
	 RJcI7UfMxWmH7KKvkPygSsvt1G0BNmCrVufasEyME1tkpDNf2qRDy4mjDxpcP2rFXmUsz
	 ia8/Bm6u5AInPSWplbAOoMBsHBqe4Ytsql1gnQ7kubAaj9gUbFzv+NCUn1hhoaYA5a1JU
	 OUOPqwFDtarexy3QsuaK3KwFFSJnEDQJ1k58z1vrSnN4DUO/toBdnSANph5lf6pMPqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=LG3GQdL8;
	arc=none smtp.remote-ip=209.85.215.225
Received: from mail-pg1-f225.google.com (mail-pg1-f225.google.com [209.85.215.225])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8288C6085086
	for <linux-hardening@vger.kernel.org>; Tue,  3 Nov 2026 13:59:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8288C6085086
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=LG3GQdL8
Received: by mail-pg1-f225.google.com with SMTP id 41be03b00d2f7-cd8ca57ef64so318400a12.0
        for <linux-hardening@vger.kernel.org>; Tue, 03 Nov 2026 05:59:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793714399; x=1794319199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xnAMlverv3/IjELyJ32hRjwWOMBKoAty6kX1tfLCe1g=;
        b=NP0QR0R0mPj//gV6BvPS/D1tCYB4HIcT62ZU4GX8uS62aUKGHb70SIuZfd5M4nPmkF
         tmva8zSZKzdSrX4IbIJSinyeb7j5f5pGdlPvLRlfVaEtSR7d+t+ZJuARNCtLnkisawZx
         J1r5XPQ+H85qiOpgDIBgXXew4TJk20i0a7qnfTTabGb8DGfO254rh3AnzWRsW4n/7FZN
         xpdA1ecXZUshYac8SIyRzREiT+2xMUpRdsfnt8BbaGLbA7cZX/PtF1Pv7kUnmTvc8+Gj
         cGfqSI5x3jHpmA23GH0CyFMjv3mUSIvAGNq9Z0cI/zYFf8wVVe+/G4BN9jlIb4mKwnjI
         A79g==
X-Forwarded-Encrypted: i=1; AKwUvBw/HLjmVfEYA11KXoRpJ+Cr3t3ryPtFfO3x7ubm4wq4HcH/23xZ0z7bdYQ8d9T68enEZpPf9i+ye2aGnDNkVXo=@vger.kernel.org
X-Gm-Message-State: APuU4Z83RgwSc9gpm4yGOSNe0nzH/2kD7NSiT8SU1E5EKR6lpM4M3D6o
	RPLkqJpM7y9bgGAo37+kqJrQ+Dl/2sA98e9hSqsNqUazrsehVLNz9aS4EXXsXkilWhURtheb4/v
	E74tBgA0q07/FHW9TKOGhm3U2++7ztmLIXXO73YnXg5oN2Hpqd8SaeB1vG89fu+SBbParnqSbhO
	oFtQzuM74Kzu6GNooYEVbED7sZV27rHCYwhlzANvF8O4XjAIE8Ew5dJvbwEsLJdENBKXJqkcFxP
	sFimU6PCgjMIWrBxRZY4dQxJsuuKA==
X-Gm-Gg: AYBFou2+RDBM1hQfkZaJKR01wVPNnut7NCeB+phNHArqFEq91lPjxG/wv92ZN19NwE+
	V3/BZrmBXjTzLsiZ7bvMKVQNF8s/ueobjYEea1Ek39jevlcP8+6rd2kfPQcUm0wp41faIradYjz
	sQc/8txKWoPrUPk/sTkIneH6t9xTxtSy/e/1M+ncon0T1kc4AyEsR2+AwZrvkPhTdlBdTFn9d0z
	jbl6ocH3yz5Ua1qUWVu0ddTWoWCgilmJenwTDMUNTBdxNQfqFARb33roDinxtTdB9pnTWNRmIw0
	YBBt4aAzFbir9/BBc3bV960YTwbtYRkSrwcPV1P9IJyMjRpckpSDnVHpN3hECKgS+QvgxMCzkMo
	9BwZwRr3vSMLIR+7OeFt+4tjYOkPv/LKLM+X1tTkINIj/1xHKYx1IsAEIJLiSkvLAuWcDN+JSuB
	t5tpypPYgluAZJyj1/4GlrSYeU2ufReSFwO3etG+U=
X-Received: by 2002:a17:90b:2ecd:b0:3ab:b39f:41ca with SMTP id 98e67ed59e1d1-3ae8979834cmr6799772a91.31.1793714398821;
        Tue, 03 Nov 2026 05:59:58 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae85d695e3sm4759618a91.0.2026.11.03.05.59.58
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Nov 2026 05:59:58 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-36a26fe9521so770513eec.1
        for <linux-hardening@vger.kernel.org>; Tue, 03 Nov 2026 05:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793714397; x=1794319197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xnAMlverv3/IjELyJ32hRjwWOMBKoAty6kX1tfLCe1g=;
        b=LG3GQdL8JLA+f1gF3PhukAabS/i+7KSmdZY2Ckifi9iWeJZKBTMPjvgUVyir6qLfis
         9pSwkAly3zfmJDAhGoVNSJCHzwTU11wtH9i2xlWmaD/US1PujHyWad3jLjKo1DJIvebL
         z8NdWHIpde09qOmtJzxc27G+LD9KmeP/VOrdY=
X-Forwarded-Encrypted: i=1; AKwUvBy02IdTCuE81N0xIoxv5d6VEAsrTVDNsDZgLNFSs92CUioVgZOiUT3qOsYxa187q7I5aR+FchXDoX7/Yd8+GaQ=@vger.kernel.org
X-Received: by 2002:a05:701b:271b:b0:148:ece:8cc3 with SMTP id a92af1059eb24-1a94adc93b7mr20492413c88.24.1793714396640;
        Tue, 03 Nov 2026 05:59:56 -0800 (PST)
X-Received: by 2002:a05:701b:271b:b0:148:ece:8cc3 with SMTP id a92af1059eb24-1a94adc93b7mr20492387c88.24.1793714395934;
        Tue, 03 Nov 2026 05:59:55 -0800 (PST)
Received: from bld-bun-02.bun.broadcom.net ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac18458e07sm41658755c88.8.2026.11.03.05.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 05:59:55 -0800 (PST)
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
Subject: Re: [PATCH 11/13] wifi: brcmfmac: Support versioned join requests
Date: Tue,  3 Nov 2026 14:58:55 +0100
Message-ID: <20261103135856.3676311-12-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260925-brcm4388-submit-v1-11-b5cbc2cde2fb@gmail.com>
References: <20260925-brcm4388-submit-v1-11-b5cbc2cde2fb@gmail.com>
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

On Fri, 25 Sep 2026 23:43:46 +1000, Michael Reeves <michael.reeves077@gmail.com> wrote:
> From: Hector Martin <marcan@marcan.st>
>
> Newer firmware uses version 1 join and association structures with
> explicit version headers.
>
> Query join_ver and build version 1 requests when required. Retain legacy
> layouts for older firmware and fall back to BRCMF_C_SET_SSID when the
> join iovar returns -EBADE. Use the selected association layout for IBSS
> joins too. Report unsupported join versions rather than guessing their
> request layout.
>

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

Regards,
Arend

> Signed-off-by: Hector Martin <marcan@marcan.st>
> Signed-off-by: Daniel Berlin <dberlin@dberlin.org>
> Co-developed-by: Michael Reeves <michael.reeves077@gmail.com>
> Signed-off-by: Michael Reeves <michael.reeves077@gmail.com>
> ---
>  .../broadcom/brcm80211/brcmfmac/cfg80211.c         | 73 +++++++++++++++++++---
>  .../wireless/broadcom/brcm80211/brcmfmac/core.h    |  1 +
>  .../wireless/broadcom/brcm80211/brcmfmac/feature.c | 19 ++++++
>  .../broadcom/brcm80211/brcmfmac/fwil_types.h       | 29 +++++++++
>  4 files changed, 113 insertions(+), 9 deletions(-)
