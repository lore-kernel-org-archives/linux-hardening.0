Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793714347;
	b=FqidcieCkAKqjoIrbQw9ZH+Iy9ef+sVbMvFVACjD0msW/eyhkWMV6VM3gLd9S+P4GxIj
	 YK9tBj2t+mnKd4XNk2gJsJLI+/sz4xtbK7FS9oH5tH61XnRkpm2xQ+MjWL7UCagmvX0Td
	 Y/Upq/MI9OX/m6VXfkDfB2CYILxkuh5PTEEv/Xm+I3aE4S/u99cbKVULo2Bjj7tjx6sxV
	 slDUstvjwMCEgCeD3SZbkr4ZVTEm1c0+BN3qLkiqjtx1+it4MvHHD6Teua08Ix112lABm
	 WyHsuuRYfuyn8jq03Dbzp3C/j5AdOAQDMWE8AQKBiSllCvNHKcshhpXHgvw+eqNELTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793714347;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=bmndstez1ROjl3SXVUcZnwGvUr5BBU/f9ozJwfuLHnI=;
	b=rfXueF9U54EPx2+zCBqnFkUEZLR4E/PU6PIkas3zQ6rzH0Xmu94bv7tM0Yoh2zhdss5r
	 8Oj6AXe8Zxs576krBD64x4eMuOlKpTIc9c3IFKvdpnuC1CLP33xN0lSTGUdZyZfMYTdU9
	 oeFD/8QTuhEJ0WfGNrKI0zWb6GMnUab/7mfKmMtz4apzNpx3BnFA9qSi03RxflnQ2v3F/
	 MtwW9wJ3n7KYTqZ6gPoJtgyUKfStJofSucl9scXIBZiUu0k4ClUbunzn630N8hRAoMkd+
	 LcZcMLHX2Z5VoIj8ySN2VVQhzn6eRiqLuTlGIJKQPktYJpU/yT7OPfIxKx5kP+ZOenA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Qj5XYort;
	arc=none smtp.remote-ip=209.85.160.226
Received: from mail-qt1-f226.google.com (mail-qt1-f226.google.com [209.85.160.226])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF59606A327
	for <linux-hardening@vger.kernel.org>; Tue,  3 Nov 2026 13:59:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCF59606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Qj5XYort
Received: by mail-qt1-f226.google.com with SMTP id d75a77b69052e-54465f79af8so31166291cf.0
        for <linux-hardening@vger.kernel.org>; Tue, 03 Nov 2026 05:59:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793714346; x=1794319146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bmndstez1ROjl3SXVUcZnwGvUr5BBU/f9ozJwfuLHnI=;
        b=DeDclfuflRoYPEy3+E/lb+XB4MEq9p3LwGAsKxDKVZdYhroTyYHu63ff6EkxhzIQfh
         fsa3ic9T5ZC2/f25Snn2qHcrLHm6P9J6FuOyEL7VTslO6lRXf90tTHSRUZJBFONbLdK3
         QWAhMWN/fUoV32GJzVhxCNLhRGw6pcCqErJY5ICUJhZK1mc41pXkGjRD2b/P+gqLJG2U
         FTS2V/7TxZEvePxb96UBJSVzPr6JreE/GghvkIguWlT60Co2Js8W3yQ8eODlhRdLuHUP
         JLPhPM20sMm/aLp7a/7+YMVxyQezLGLFxHLX7KtdGcePjLkHrwc+k6dMz8Ukfnh1xzZ5
         nyOQ==
X-Forwarded-Encrypted: i=1; AKwUvByp+GbieD4KhJleZmAxdt461JiCnTaWjFP9InDSItmuivcN3gQ6+EzciC2CLac4Uc3S/JcnasctCfLl8qLPJtY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9aR+uzACJreBp5srYZIz4+huYssbwfVKivxxXe5PFmCe5UVZRK
	+EtnGablidu6dDWNi7WoDbFmTSRRr4ICHYPGMH1fMMR32Up0v0hNNGZXkPBOakF/qjtQUyb4yQ+
	P482H0MIoErNVYKsNnAzVz6TwxBJYE0DqIKoJTxn/z+2mTy8m6eAajQTUyx5OzJY+XNf9rxM+m+
	CPKv4yKX6Pjz8tl0STW7rBx/ZOicS98AVYE9VoP6PrPBkKeAu/Q/F1QgbGp//h/R0S/z30nWREd
	uLd91ezQvTKM5Uzdlq143ylBqRytA==
X-Gm-Gg: AYBFou02+G0wS0MyfUstFH/xnQ5hA2ofA+DZIOT/XFCqCNVyXK/vQ4OZ4jfdPB24nse
	XxrCJdt/I4mfwNTvC1ICBq03tqKf68NMiEmV/sxofq0qh+AsEuVQnsy/7mgPe4uQBBPB+Q3WUEr
	zn0JjoBTSk1cvIftT2otvVTc3ozwKACoj6rDAg1sUyTKEG9CAdZiaTTraIR7HzIz4s1jakW0QwA
	77U6cMaGznsrEshh/lbr3URnYm3n9PmV7nvQ5d38FmgqJ8bgw9ZoB5AuOqbKRynBDbmYxBMZlCM
	RM9Xx8fbkdkJzw3tW+WYhkgqu4g62IH1uDI1qaYRLU5jPoRzEuWNcv7XHxuTqGfO3vnzCqv3DWx
	ARRV/gdpv0A/aUjw4NUtSTptk4y+uR4nQxK03kjmS8txg+3ZWjcsYJ92jmbyC86plO5wmwNnxvs
	I+t6godDOLg3tvZQMhCxwQljvqIhWdcKEFj52RRbo=
X-Received: by 2002:ac8:610a:0:b0:536:575b:8dd6 with SMTP id d75a77b69052e-542b0b83425mr224494981cf.0.1793714345554;
        Tue, 03 Nov 2026 05:59:05 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-5498c479e25sm240431cf.33.2026.11.03.05.59.05
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Nov 2026 05:59:05 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-147be78cd56so10472764c88.1
        for <linux-hardening@vger.kernel.org>; Tue, 03 Nov 2026 05:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793714344; x=1794319144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bmndstez1ROjl3SXVUcZnwGvUr5BBU/f9ozJwfuLHnI=;
        b=Qj5XYorta1jw+8PbfZqY71LtnJoR1VdZw+gTUwW6/ozIzSv0aM10Tyy7BI2/uYiYCA
         FFvVmgp8cNb/J02cehNMBCQNCabMVVX+SMB+ewHIIaQBee38RYLRWMlG4CbQBgoiVPtS
         H1SC9bf9/blmL5n2lOHDZfwrGjSvAf63thBc8=
X-Forwarded-Encrypted: i=1; AKwUvBwk7qcKklE2UCWMDCghnzM0WH0GO/WY3+ieXKihS1Fi12VRM7vgBcy3/TgVIJltdjw2zsN3rCDqUhzUeqgMHrg=@vger.kernel.org
X-Received: by 2002:a05:7022:ea55:20b0:1a2:a5b1:884f with SMTP id a92af1059eb24-1ac5da7726bmr20328252c88.31.1793714344032;
        Tue, 03 Nov 2026 05:59:04 -0800 (PST)
X-Received: by 2002:a05:7022:ea55:20b0:1a2:a5b1:884f with SMTP id a92af1059eb24-1ac5da7726bmr20328216c88.31.1793714343237;
        Tue, 03 Nov 2026 05:59:03 -0800 (PST)
Received: from bld-bun-02.bun.broadcom.net ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac18458e07sm41658755c88.8.2026.11.03.05.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 05:59:02 -0800 (PST)
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
Subject: Re: [PATCH 04/13] wifi: brcmfmac: Support newer PCIe core startup and interrupts
Date: Tue,  3 Nov 2026 14:58:44 +0100
Message-ID: <20261103135856.3676311-1-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260925-brcm4388-submit-v1-4-b5cbc2cde2fb@gmail.com>
References: <20260925-brcm4388-submit-v1-4-b5cbc2cde2fb@gmail.com>
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

On Fri, 25 Sep 2026 23:43:39 +1000, Michael Reeves <michael.reeves077@gmail.com> wrote:
> From: Hector Martin <marcan@marcan.st>
>
> Newer Broadcom chips, such as BCM4388, require changes to PCIe register
> access, watchdog reset, and RAM size detection. PCIe core revision 64
> and higher uses a different BAR0 register window. ChipCommon revision 65
> and higher requires a different watchdog reset sequence.
>
> Update register access and reset for these revisions. Decode the SYSMEM
> bank counts according to the core revision and exclude ROM banks from
> RAM size calculation. Disable all detected D11 cores during CA7 setup
> and select H2D doorbells based on the firmware DAR flag.
>
> In MSI mode, firmware can clear the mailbox interrupt status before the
> host reads it. Requiring a nonzero status can therefore discard valid
> interrupts. Process ring events without that requirement when MSI is
> enabled. Use release/acquire ordering on irq_ready to publish the
> initialized rings before the interrupt thread accesses them.
>

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

Regards,
Arend

> Signed-off-by: Hector Martin <marcan@marcan.st>
> Co-developed-by: Michael Reeves <michael.reeves077@gmail.com>
> Signed-off-by: Michael Reeves <michael.reeves077@gmail.com>
> ---
>  .../wireless/broadcom/brcm80211/brcmfmac/chip.c    |  35 +++-
>  .../wireless/broadcom/brcm80211/brcmfmac/pcie.c    | 197 ++++++++++++++++-----
>  .../broadcom/brcm80211/include/chipcommon.h        |   5 +
>  3 files changed, 183 insertions(+), 54 deletions(-)
