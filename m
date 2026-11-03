Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793714390;
	b=FllqjlHM1wbzff/YjmEm13iTCHHCESPnQpIMyPafTZu1Q1O8BHWC+dLdMorw4eiK93hx
	 vepRprHmJExydZ4KGjR4aMQMa7swf4Bxu/1wQrE+ND9oNMb4y9caa6mK5+ocAoK1qPmVr
	 WgCZr3+EwOA0KsFGpVe/9dP9RqblD1F6fO+fzwK9YuIMUleWf3EGaiSCw+cg3+7MUbYNW
	 VlstgTp5Dfvn20fCEva4XtOMkPBAICYw/sBIPUh0aGAnCmipRiwo6HDjp4JPapTPcG/RH
	 xVGf07go4+n4Ywk3f5dJE5UKTk8KKU0dcbwO5XFiTJj9jdqbjQQwSpzxWcbwF8tl/AQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793714390;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=BPfwhnSKhhImT2MSjvVFfyGTbJZ+CXv0gKlK5lwoVaI=;
	b=q1g1/jEBLcTf2JkOgAwatlhAttHE6k8t0CPgTdxPaHlAnG+udfcuG/ulIXeDqyGUbNae
	 kSsPgXwwKvXDjsuzSfwlXXM1Vp3s7dDhCc2cwwt6GU6b6x+V7KGEVV1LmehCGTF8BSfrn
	 hf/rvxUowZb6bjyTvX7x7Wv5weGZQLD15dPOb9Iif2/2fAj+1gjw331CE5xszxiiuFo6v
	 kPvFMvesK6jx/dntAnIWEryKgtpol4Gi9bb3QM++vqvCnphQ+YBTaHnQi9wR/LCSUgkC4
	 hcCoUhlQ1jLK5S/894gMfWA7fv4Br/ReNrjCCWEWqgtY5QPVXGNHtWhdMnEGbQEfGrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b="Eks7S/An";
	arc=none smtp.remote-ip=209.85.216.99
Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049CC608360C
	for <linux-hardening@vger.kernel.org>; Tue,  3 Nov 2026 13:59:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 049CC608360C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Eks7S/An
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-3adac5c10e3so2600871a91.0
        for <linux-hardening@vger.kernel.org>; Tue, 03 Nov 2026 05:59:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793714389; x=1794319189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BPfwhnSKhhImT2MSjvVFfyGTbJZ+CXv0gKlK5lwoVaI=;
        b=BrasCkv/Nk3Oei1uSrh4AUWBD2KeibIt1W7NDfeCjo1aXe3MgqSXBltAZff2ircMbE
         oOl+lOl46yN88NDSEQwe0RbHSbKkuEBvTyNonFePdY0YlR9wklh4OqUxJUdd8IQwq87o
         HP/J3BgBXWzf8lOtwNEHa8n+cjPA1Nt5LFfwd80hg6YZMs9/NtoNHJAGrwJNsKoLheHK
         m2jsB1ackbKpstWJ3bRZiNRdARl6Bi7Zcys9hB5sIx2hWroRf8COdFVT49t7PP/C4eL/
         Gk0KAbWd/zNSvfnNw1FpAnxxlKI6MmbvawbyYIkRnbyZqxANchIpQJfCcorZKP1n6yn7
         ry+g==
X-Forwarded-Encrypted: i=1; AKwUvBwiiMYZcuSmoSdAslc1b4HQ+f+O1quePgi6d8uwhxYOzeY4zHiGaYjiu5QrwlFXNDgHEwxkqfWRxITg4t3AJTo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/+s0Cw6GIkJYd/3H2uRhQaJVi5OiPW1CpZjMwSnud76L+DHRZN
	zjyy1gQowkDV8mtmomJz3iW+UggOZSwFs1PPwjDbDfWanFjwddMBgJCUEIDLGSUPJd3IML4XWDk
	ZKjTIejfHX34Lp9Gpa8vsDOKkrj1MfJgUhN3nlRRP7kI1vBElSpNdtAxKqdE3EQbWMgPiPNn4MW
	4zrN8237maE3j/Ye0VFeBytQ9Pm+d5BVKYRkQ62svpocvZ5poCEijhm7h/4tgXJqYAanY4SAMXk
	kmKFglnzuSMUqQ4Xjx/slH1k/kLQQ==
X-Gm-Gg: AYBFou3VtZxK+vzewwhCbEiYW1P+a10PLIFDMtNSFAIeCmIz3tmkvjNvVJsbExO1J1/
	e2HUSHL/183+4ePjzm+S59DBYjLo61IqfL+KcH6nAzxmaY54x6/1/YbDmlQ1zhXy1pU8V2S2jtk
	QO0m5ScmVufcs5Ep9y4cTu/qrEdwpGWa+GnelFnML8fxtr/cbjlez2K5/hKUzBPbZrmTc6OUeXi
	lrjSWQ4FoQ00proSrUxCW1ZhmooTPX/DBpr2IwFlqbq0iyRzKKG7DZuHZjMxA5s933+1pSPUDyQ
	Q8AThDugLs+njl9hhaQlP3Xf7KoqV3gZkQ9WNrCN5hoP92sumKK4x034wwiSzk0R3OxEG7ZSY3q
	Fw4GhSGnzHPPL50PhfmmP/deWpTity0eXHmD8/kSVBZOxXXN+5Lje57iNbyf+jRUwMRZ0q7YsT2
	cHVJX3ACZGS9Nu0iAI9PvomOt1fZwCJMvqc0XL/+k=
X-Received: by 2002:a17:90b:2fcd:b0:3ac:a7ee:6780 with SMTP id 98e67ed59e1d1-3ae8986606fmr11586430a91.66.1793714389352;
        Tue, 03 Nov 2026 05:59:49 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae881d509fsm4794794a91.5.2026.11.03.05.59.48
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Nov 2026 05:59:49 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-359b81ad4e8so5532688eec.0
        for <linux-hardening@vger.kernel.org>; Tue, 03 Nov 2026 05:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793714387; x=1794319187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BPfwhnSKhhImT2MSjvVFfyGTbJZ+CXv0gKlK5lwoVaI=;
        b=Eks7S/An1hyagSxN5dfkvPIOkwIavxcld/oFEZrgYcPjnme/MeuLwIl3b8Sp0Z0ric
         enUwWWNkH01zOHdfH9wPHpH+BtQt5wS1K+TCP2sHwyxpCoh/sdl9sC/qiPIWzA6IqGTd
         np9TxEOMd+p6ZUL+khP6LB9JldlJQoPXuJGgc=
X-Forwarded-Encrypted: i=1; AKwUvByduhnEv8CrzN+gcWam2mEY8xDwkZXqoQEDoJh3rbV9gsELv2sN8c1C4wQhYTakCfV1karqC6H0gU1h33boHoA=@vger.kernel.org
X-Received: by 2002:a05:7022:b059:20b0:1ad:3402:733f with SMTP id a92af1059eb24-1ad3420f9a1mr19288279c88.44.1793714387412;
        Tue, 03 Nov 2026 05:59:47 -0800 (PST)
X-Received: by 2002:a05:7022:b059:20b0:1ad:3402:733f with SMTP id a92af1059eb24-1ad3420f9a1mr19288228c88.44.1793714386672;
        Tue, 03 Nov 2026 05:59:46 -0800 (PST)
Received: from bld-bun-02.bun.broadcom.net ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac18458e07sm41658755c88.8.2026.11.03.05.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 05:59:46 -0800 (PST)
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
Subject: Re: [PATCH 06/13] wifi: brcmfmac: Load signed PCIe firmware images
Date: Tue,  3 Nov 2026 14:58:53 +0100
Message-ID: <20261103135856.3676311-10-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260925-brcm4388-submit-v1-6-b5cbc2cde2fb@gmail.com>
References: <20260925-brcm4388-submit-v1-6-b5cbc2cde2fb@gmail.com>
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

On Fri, 25 Sep 2026 23:43:41 +1000, Michael Reeves <michael.reeves077@gmail.com> wrote:
> From: Hector Martin <marcan@marcan.st>
>
> Signed PCIe firmware needs a signature and a memory map describing the
> image, signature, verification status, and bootloader heap.
>
> Request an optional .sig file and write the signature and reverse-TLV
> metadata to device memory. Describe an aligned heap after the firmware
> image, keeping the metadata and end footer outside it. Require NVRAM for
> signed images and preserve their reset vector.
>
> Request the IRQ before starting firmware on chips that use signatures,
> while keeping ring processing disabled until initialization completes.
>

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

Regards,
Arend

> Signed-off-by: Hector Martin <marcan@marcan.st>
> Co-developed-by: Daniel Berlin <dberlin@dberlin.org>
> Signed-off-by: Daniel Berlin <dberlin@dberlin.org>
> Co-developed-by: Michael Reeves <michael.reeves077@gmail.com>
> Signed-off-by: Michael Reeves <michael.reeves077@gmail.com>
> ---
>  .../wireless/broadcom/brcm80211/brcmfmac/pcie.c    | 267 ++++++++++++++++++---
>  1 file changed, 233 insertions(+), 34 deletions(-)
