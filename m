Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793714395;
	b=xu6ZUcA5ibatsXs6YwRm2yeBTItj7syAqUq2j+ku8AaF/ggHrg/bbLgagZuUOQ4CB3ft
	 SUNXD0q232hXo2bS2s4d48zd3z7Phf2LrR1XQhvJNox46i6V1SkJk8tp5ICU5ovQs5fdm
	 6b+d+grsYwrnShEYnzGVhA0hUrBqe2/BCgzJSxjGBLVDGKuvigp8yovJ5DBDbDYHDi2bV
	 TWB+7U6l3l8o4SOtVW/iGursEfAPorJYvqOm0ExvSOVy3tYrr97uCUkq1a6k8GkcssSgT
	 XbDN4JSkblGXrTkH66PVFt1oLy+RP89nIPNUGt60EbpiP65BRLmb2xCIriYzrP125Uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793714395;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=FwIVVnYhvvjMTysTggNf76en9r3AUtCzAUuv63rWer0=;
	b=Efzkp66GiZREgiEO2lKPTd243yD0MyIgZk9f1k0SNof+CJhE5gh4/4mc73sAo0NxbPIC
	 bIwVth/J/e1H7lzdGud324YQLfD0RquT/Ljm6EwQCNB/9dMIsR9nuCIIOQ+6hK/nf1UC7
	 A8lPRw5TqxZjJfSuTF5bWPtrPnfdugh82qaKBjWrFrxojirCEbL6NS7y0mJ+ExNGj7zeN
	 5q3xc9YyVw+Sx31IBQH9NHzns85iEgH9oKD4Y2DHClOLabPuprwcbkwqjWYIw2E0QXALb
	 Cp1JQiivFD+8NxJcEm9yf8aPuU6zXKrUGPV/3uElr0OV/eGZVCKj5jmB/WbOtIjU60Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b="Ir+iDq/x";
	arc=none smtp.remote-ip=209.85.160.228
Received: from mail-qt1-f228.google.com (mail-qt1-f228.google.com [209.85.160.228])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595E9606A331
	for <linux-hardening@vger.kernel.org>; Tue,  3 Nov 2026 13:59:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 595E9606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Ir+iDq/x
Received: by mail-qt1-f228.google.com with SMTP id d75a77b69052e-5495d549924so13941281cf.1
        for <linux-hardening@vger.kernel.org>; Tue, 03 Nov 2026 05:59:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793714394; x=1794319194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FwIVVnYhvvjMTysTggNf76en9r3AUtCzAUuv63rWer0=;
        b=kxz/ZDQeh8MMAA1CKNPrv3ItQI3XLOcaic5aqf1YBQ3/TtSi3A4batPuD4mICuQ5YU
         PHvJurlGuFl6lQYdH76YSQPhk3gFeuHv3yz9frEObHH66t4pyaiC1NkjfBLlCUvjmLFl
         TfzRyREKlbom9sqPXfvQhVi9yjy4a/UkqZIMmpKW2gEdmGJkblBYq+xImoOwkMHtU7By
         UoSXIZhplW3v55x0c6QkPmv0bRFgsFsmHKTQt7kGyRawjSKaL89RVJtOWmtYohEsA5ug
         4E4JRs6GF83/Cdb8m3XML65cxMPD0GhfRd0UmPfsWz6YIdUzs3qF0w9ZZbLEYNyjD73u
         z/Tg==
X-Forwarded-Encrypted: i=1; AKwUvByKuYjARB2PcCaDLfMNTu0gPpPHHFIWs6UwWq8X3TKP8GILCG8aplHTSOqVW/EpfxdvgjSE80ju36/RD5wv9D0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Fll6M41tlWtcNS4y2liWr+x58URk5nLF0PjfcBsHJiHgilYGI
	UU4wzGVxlJdxypuS4sxQ7eCDH2ERHwYzuOzPd/dBbNPh3DGrVOkeEA4cXDCQEX4LuolshFmnpyC
	Nv+d9iue3dYyxXQu9DJbej4m7vS8obuIXsK57dPGiC/3arimyATPka4adrj3RjEah+gGNPZjiDW
	ZI0A0tNGS0hOr/t2LLGgflDEipkuuU4h6gGxvkRrfRXWJT+V7tlJCrpxNqfI8UDiadBBlmcMDoC
	Bz0ntgJAwZsaU/WXXLpTRpoUAs8Vg==
X-Gm-Gg: AYBFou3xdrDtcgBxSfUIXCEeuQcWMpcv9kVbiYSvg1NbWwjUo7BgEUoVtFUhVBK/Z2S
	OAG9NOn+GAyE12VN3jVahS/UN+oka5Y5dYkt1+rXFZUIz6mkkdegIVOqasdB81e4ylIQxK9MjzY
	p14XJ9IW4ZwmNvhoJkXRSfu1wHkJ+fUbs7gulwflUAM30Pi+zZkNeOXuhNuwXiV8bQIZsTq1Q5b
	MfMJJnpH+8by0dYCz+3L4Szc5PclP2qR612uPlB191Sb82ReGOObfodsMZDBtttvumk8ui4a4WO
	TS4xzwy2olduGlFhlLXFPjEZ5rvAX1hNHtDK0nzCL9V3sYKIZCKnm0Nd912aF7bFkWbnM3+hx+3
	428+GDLWnJtRuE7RgIznuKq69xh+OK4qyJ9jsCyWITgqP+G1EnDevO67LD3bQMQJyhV4Nc6an8S
	bTySsI/06YqGiXxts8dlUy3NFqDyB9SzaLb575Jck=
X-Received: by 2002:a05:622a:2306:b0:535:a5fb:6449 with SMTP id d75a77b69052e-542b81fe338mr225764431cf.67.1793714394297;
        Tue, 03 Nov 2026 05:59:54 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-5498bf8b2f3sm299291cf.24.2026.11.03.05.59.53
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Nov 2026 05:59:54 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-1aa0fb7f157so6462998c88.0
        for <linux-hardening@vger.kernel.org>; Tue, 03 Nov 2026 05:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793714392; x=1794319192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FwIVVnYhvvjMTysTggNf76en9r3AUtCzAUuv63rWer0=;
        b=Ir+iDq/xiO6xCn6mnXr/0NRhsA0/MegfrRxIQaWgLmnp6ae3A59/41UTHw8v4vcl+p
         DwQiYn2r6u9ZTyjIjMrv3/GLN5k0iwkzYTKfAzNxYxSnPKB940fLE38+kX5NJxPv4wE7
         KKHcG2DTbW/i84JFn1K3XMHBRYLtCZamQioZA=
X-Forwarded-Encrypted: i=1; AKwUvBy20oaEXLEcqRisXYWOqOzArctn06fVW2Bgratncyvay/PNuCH4vI3ClH7UdZYp8pOQUBich6ctnNVXmLgbxSI=@vger.kernel.org
X-Received: by 2002:a05:7023:a56:20b0:1b2:3742:828e with SMTP id a92af1059eb24-1b23742830emr5949729c88.3.1793714392101;
        Tue, 03 Nov 2026 05:59:52 -0800 (PST)
X-Received: by 2002:a05:7023:a56:20b0:1b2:3742:828e with SMTP id a92af1059eb24-1b23742830emr5949684c88.3.1793714391367;
        Tue, 03 Nov 2026 05:59:51 -0800 (PST)
Received: from bld-bun-02.bun.broadcom.net ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac18458e07sm41658755c88.8.2026.11.03.05.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 05:59:50 -0800 (PST)
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
Subject: Re: [PATCH 13/13] wifi: brcmfmac: Add BCM4388 support
Date: Tue,  3 Nov 2026 14:58:54 +0100
Message-ID: <20261103135856.3676311-11-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260925-brcm4388-submit-v1-13-b5cbc2cde2fb@gmail.com>
References: <20260925-brcm4388-submit-v1-13-b5cbc2cde2fb@gmail.com>
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

On Fri, 25 Sep 2026 23:43:48 +1000, Michael Reeves <michael.reeves077@gmail.com> wrote:
> From: Hector Martin <marcan@marcan.st>
>
> Add BCM4388 firmware mappings, RAM base and OTP handling, and increase
> the RX posting and completion ring capacities to 2048 items.
>
> On BCM4388, DMA_FROM_DEVICE mappings for posted receive buffers cause
> DART read-permission faults followed by firmware DMA failure. Map these
> buffers with DMA_BIDIRECTIONAL to allow device reads as well as writes.
> Keep the existing mapping direction for other chips.
>

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

Regards,
Arend

> Signed-off-by: Hector Martin <marcan@marcan.st>
> Co-developed-by: Michael Reeves <michael.reeves077@gmail.com>
> Signed-off-by: Michael Reeves <michael.reeves077@gmail.com>
> ---
>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c      |  1 +
>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/msgbuf.c    |  8 +++++---
>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/msgbuf.h    |  4 ++--
>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c      | 12 +++++++++++-
>  .../net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h    |  2 ++
>  5 files changed, 21 insertions(+), 6 deletions(-)
