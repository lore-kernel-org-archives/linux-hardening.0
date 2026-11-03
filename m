Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793714358;
	b=F2X3AKrZhViPVKMjuKhztuLIx0niPuJ7F3T4ctBVCRUpf4/rub06obEZMsTcRBMqDbL7
	 BRSKfksdW+aOOBfsOWM1T6aZdXeqcrndyK3P23zRDp2cCOqzMjbAj3KcFVqGhGQqLM8o1
	 CFWfyqgvlfmwwdjovgQLNJrFibwFNRb4L4OrwulFyFM3V46u2Wtz3+9SVa86OwRSF93SU
	 G5b6NheF6GfNtxfVBZxV4FsJ0ixQQ+fQ+Zhm+ihRLUwOXZo9VFjZJYXitbmhRagk1+jmF
	 bfeO5kzK/ADQcSCSYyz+atBdyZmhQTAvS+bo9SmQ+JUnt6aZhamSae9q4zqyQJ8SnMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793714358;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=cvUJ5Fu74/yRvPGwst9m0ry7+LODDEe2Sn2iPk6DIvU=;
	b=oCNmHZU870gsk1Ew1LENjG6447cxY4rTAqZ4fItXPPdqRGJg54STmkus/ojBCpCvu0eB
	 GWfposn1IVnutba0SUXHCttHDaVL2rj/10MSqOFdhDv5pdMg0DN9I+0ta3O2D9W/xzbp0
	 sk+KD84kBjGWQpqjCUndWRVGy3qgmxTNEv7VK6VKwDqp3WC5ip6lBg7ndY3p34b6ZMlo/
	 e2GOw9KFpuAzkGLXPpgsVo9Qr6RQxDyz7nP0v1ttwax8SCjXW7HR9po6QGOE7LbJLNmdC
	 Eqw2XtrcMNFqOikvpl8E4Nkds8UnIMQ1Rmlh+aQstO/VPyNAtaPCVYQh+SG/PDuOftQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=EqGmpEv6;
	arc=none smtp.remote-ip=74.125.82.100
Received: from mail-dl1-f100.google.com (mail-dl1-f100.google.com [74.125.82.100])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C7D606A324
	for <linux-hardening@vger.kernel.org>; Tue,  3 Nov 2026 13:59:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4C7D606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=EqGmpEv6
Received: by mail-dl1-f100.google.com with SMTP id a92af1059eb24-1438d9363fbso700788c88.0
        for <linux-hardening@vger.kernel.org>; Tue, 03 Nov 2026 05:59:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793714357; x=1794319157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cvUJ5Fu74/yRvPGwst9m0ry7+LODDEe2Sn2iPk6DIvU=;
        b=hrTiZ3Yana/1BG5EFtG7DTI/MYg32TmzyqvrXeSYHdVm4gRKQO1LVUGM3O7kDIMMAl
         Qnho8uBCS9eKwlQFsFpRFPBcDQ1T5FRo6BqHXg1XuzxAliFdSQSiZa9XqYXKrXSdl2zH
         YdSU9tyObQsleOsMNSt/n3ehIk+aSAYdt+5/v7mw1KKWFGpHs4qddW01pUD1IsaxWd2F
         EetlwP/33Um/4ES9sFXs8mKpKaAYM5mpCK+b9fQicIaozPm3yDJpSTvge/Jx7E8ZaCBP
         UR0n/Gm8LWxflO9eszhVL/Bkh82UA1yhpO3tb4hWCPUGnPudGf9yMza45VDQsYuQ3+kG
         mZgw==
X-Forwarded-Encrypted: i=1; AKwUvBzh1/eNBMCVPWeNI0H48KYv6aTnapGxdXzBR2N1OZ5IlUvXXtxETO6VFxO0+akfQ5mInLN7gWoxaurmAvSGeEg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9EqO2ToLvFgVllG4ZTB5YhoRrZPBhOoTf52oy+KirRrvaMGsjl
	mAvyeqxd8XPUUr8g73zjJTqiMYBswfz5vE43022KklH6e2HdZJjLhmzD4JgzPLKDMc3p+nTziiW
	BR1+/Wb3jlPZ706uG6wdgkg/HZLPJg0jxkCNmu4Qh1isQiz/vguKQSIjgmqr3Pb3m/AoC0k/diM
	e3CaLADOr25GEJsicmoFjIT/GVXiXVZVU8EFf9JKkJzI8gkDrjw1dEdeIy36zNlKAkOlTrL6fKn
	DKODF1jUUWSlpZpTQJ72TO2r+mtlg==
X-Gm-Gg: AYBFou1QRQHZ0BUkvy05u8CqdkYtgQHGWnZQ+CW5XSvuJ8ZY1tt/oUtRBaQp1AGRijl
	LwQTwor4bZYTbLgkzKyfBrJtrrga0rMJ7WDflXaT1M43pJE4RxeaGXdExgQypdCB9MUYcrMnjpK
	0AkyVo1O11K0Cb/cl/7u3qFJNDOpJaA7sBbtih3WatFkk84KtXdRp8BLiUcY/pkN2v5cT+s3pXo
	T49P/pl+MTwDtlupoQwldU6gdUTB8YDCzEY2ZmxwYouP+hmvUemvjDTFbLYKcl7jKvXvym18yXl
	ivXVr0OlucV3eGf48e+fF4y+13J5fDzP5y4kpRKE7QX2n+hBN7qJ1ZIxJGlMaDMK5w4TvKDxrPW
	fSKaqdK5PrUmEgbDsIgvlBm0CvzQGUrvTqG6GLFAWy4YZNEllDzHdbhP5Snk9yvBLu656Y03Lou
	RJyAmoKdiS8I6PGN6p8XU9dPTCbzMT38lzhEPQMw8=
X-Received: by 2002:a05:7022:4588:b0:1a7:4c5f:57e9 with SMTP id a92af1059eb24-1a94b852aabmr31815757c88.27.1793714356511;
        Tue, 03 Nov 2026 05:59:16 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-36c9c66193bsm6773eec.16.2026.11.03.05.59.16
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Nov 2026 05:59:16 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-3425098ae4bso1030499eec.0
        for <linux-hardening@vger.kernel.org>; Tue, 03 Nov 2026 05:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793714355; x=1794319155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cvUJ5Fu74/yRvPGwst9m0ry7+LODDEe2Sn2iPk6DIvU=;
        b=EqGmpEv6Uifhv7En22atUOes1uvdDqxZ6XccAiwoodEK0HrXblsV2WcYHL+WXzATLp
         vxJ+bkZOlBEr+zsp1KmM0vm3P4EwxJqb3B0a0tFd5nwUh0kmn9a/Eq7FWzAy7hBOAYPI
         pSQyxlGssdlApZ4g4TXfQwJeapvaxWZQnXDPA=
X-Forwarded-Encrypted: i=1; AKwUvBzWjEaszqFWqIiOkjOMKXtN+4HVCWr5lyC5+11/9SKI8qaY4p1wD/vtAjV00mqBtgL0cTcUlRdmHKGZAJZsruM=@vger.kernel.org
X-Received: by 2002:a05:7022:7f0b:b0:1ad:1574:aa9d with SMTP id a92af1059eb24-1ad1574aab4mr16954560c88.0.1793714354601;
        Tue, 03 Nov 2026 05:59:14 -0800 (PST)
X-Received: by 2002:a05:7022:7f0b:b0:1ad:1574:aa9d with SMTP id a92af1059eb24-1ad1574aab4mr16954509c88.0.1793714353901;
        Tue, 03 Nov 2026 05:59:13 -0800 (PST)
Received: from bld-bun-02.bun.broadcom.net ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac18458e07sm41658755c88.8.2026.11.03.05.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 05:59:11 -0800 (PST)
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
Subject: Re: [PATCH 02/13] wifi: brcmfmac: Match complete firmware capability names
Date: Tue,  3 Nov 2026 14:58:46 +0100
Message-ID: <20261103135856.3676311-3-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260925-brcm4388-submit-v1-2-b5cbc2cde2fb@gmail.com>
References: <20260925-brcm4388-submit-v1-2-b5cbc2cde2fb@gmail.com>
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

On Fri, 25 Sep 2026 23:43:37 +1000, Michael Reeves <michael.reeves077@gmail.com> wrote:
> From: Michael Reeves <michael.reeves077@gmail.com>
>
> BCM4388 firmware advertises "hp2p" without advertising "p2p". Substring
> matching incorrectly treats "hp2p" as P2P support, causing userspace to
> attempt Wi-Fi Direct interface creation that the firmware rejects.
>
> Match complete whitespace-separated capability names instead. Remove the
> trailing-space workarounds for SAE and FBT and reserve a terminating
> byte outside the firmware response buffer.
>
> Fixes: ec64241c9fd2 ("brcmfmac: obtain feature info using 'cap' firmware command")

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

Regards,
Arend

> Signed-off-by: Michael Reeves <michael.reeves077@gmail.com>
> ---
>  .../wireless/broadcom/brcm80211/brcmfmac/feature.c   | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
