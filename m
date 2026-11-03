Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793714362;
	b=jPiJLWaFaypsTArtJNjYm3KWsBaD153arlVRmw/3Iu19AGtlv44B4wR87chXzrW6I6uS
	 tFvI96RO3g44g0aL47QhM/Y7BcFdarO39nqNpwyd7wSBCnN8qYkwnwLaA9VrKZWtyziYc
	 TQbVZpj5TdqeT/NhsRyUjZaAwoyRQLKowsj/vguRXTmkPqN2KAM3KGGd+VPFAO0m1P8mP
	 k05y+SpWo6GxUpAnH0WOIkEPXxejt/5xTI0B2UlmDGpsJlflPNvMN+WbqTz0YfGb5WuiT
	 dBwqFyb3UOlpYocMe9OXaNL5arWMNvpSH1KwxqpSzq+LMMldg9PHBml/nI/tWvGdCgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793714362;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=ApeHudjpRw1j4fPKuyoZlTN6SSSk0BmJ7DVYBxcf3Y4=;
	b=udR+G1eXyq8BRNFmKsxKXBieHhB1CoXCFFvtEcZSWHCmq0augQAr+zYepqQ0Yt8eMeSr
	 sKJ36chJuHlW0XI/SrwYHRkXXIYwVdGiJnwNWyuJVNvvy1+GvCsOekdPsAeEK8ivhe66q
	 GOa8Aj6VCM5JMcLf43o/8jA3scUG1OQ38flssBZdqnCA6soT4jePDP2tYfTvIlRqeCMb1
	 Rn3WOCM1QkawBlsP5EvkzWQ8eBV6zRCn2RGEoH1NyQS/ItzTO9e0W5qQDzeyRkiELULJP
	 0TRM02eqQm11lMEpNM7NEhwVHY9sQNiWvwrEr7Xq6Juwq0GsG/5Wf/BiJr+qut1TLLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=RLtOpmE1;
	arc=none smtp.remote-ip=209.85.216.99
Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A3C606D80C
	for <linux-hardening@vger.kernel.org>; Tue,  3 Nov 2026 13:59:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26A3C606D80C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=RLtOpmE1
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-3ad2b3b1c02so2300131a91.1
        for <linux-hardening@vger.kernel.org>; Tue, 03 Nov 2026 05:59:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793714361; x=1794319161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ApeHudjpRw1j4fPKuyoZlTN6SSSk0BmJ7DVYBxcf3Y4=;
        b=eUWxNyeWX/F+JtBjUa9FVOcRMMy8kFmCJ1H7KHpO3ICrhX8cRZP4lwuX1upNqvPW8I
         /c+TJDQMmf6haOcSGx3LPl0CbQlikpDyAYuhpFgxiMKxZnAF3vEofypy36ncR5CCsV7V
         O+pKpYtl+lR4gZ5qiSXp7jlsT4Ao/oK8vvtTlC16FCe34PBrWoYw4/JVyVIhW4eCL87j
         8Z9j1IgThduA2020cJt7jnT63TCB4FKv4ADAkurld8GxuVqN/LGZEaHQkAcGEn5SzdsS
         9iR2xZ56EWKsuI8DeszseQoN3rFGkRd9lvuV4zS9PEVQuo5WMJHsA2uG69eVNetEL2Yt
         dlVw==
X-Forwarded-Encrypted: i=1; AKwUvBwgEKzDrT/0lERwJFWLUsaqibb9JsZY5c8aqAV06zqzF7i572fW8xAb9BQXwsOwth3YqZJMZezmHFKdZBXAjhw=@vger.kernel.org
X-Gm-Message-State: APuU4Z87fJb63AXcK2NNuoDkh5/+yf/iN9r60xxaHZQcq+K3Rp1t9wjQ
	1VSirAkAKe9KL2iT0L/mjZA9cBhnWKK5Cca3PfQTJro83R1FFFBCYrWmHiFcL+gaJQpKrYvOwzB
	gXXjqz3R+8ph8FKxj/OZlVDDHG2ezS4GZSgr6ven6Xzw/vDAxky/2mXuW1nKuI8p48YbtdIlLRZ
	Vo1xm1fMZNem/1qEEiAMw8VNOjtm/WOHVRIa1+XMpXme6BRTrc8orPsFcoiROZOIZhwKmD/tYNF
	YtPxlZEztfzqSqby+UxmDfgp+BHIg==
X-Gm-Gg: AYBFou19vRxe4MRO/vT7Zhhp6EoE3zUzmmVEZh2Weqnv7tc6q1T6+bmwZYRDRqV3X34
	Z0QYXX2kpmeoF/IkiqHvg0RoxyUJgossIhOgIBMxbwMHbcOLYtGYzn3F3Y+sMu3sQWxz9aGpI3M
	VRtZUQgEnwNfk/n+iT+2h4gVnQAFj4fEMQCyjwrWZzuCe5DGsqN3PTE/C5m4FkKQEAmFMvjcDcu
	1N7WT3DT9XF4oEp5NsdpBqUoN4cfUXfaUI9jTN85BPjU1vudWMsQ3M+/aq+vRRKppMQ/cDBRvIH
	uDCZvTpMOkAxoa1/dsmwrSubQNuMZKm/zrye1rEryKBAAQUgtXDSqEWXtQsa0GpTtWXLYvQEnj+
	2SHGXapZouNrcBUcr2Aht0xmbDw5MfyX6Nc3+YxmyfOvOpr7HdkdK67ppn6gAQGwbyGyCAcW19f
	uifFo8GVTUBf7JOnUCpRwWZRS7rp981FMmpSayJxA=
X-Received: by 2002:a17:90b:1844:b0:3ac:9c37:9429 with SMTP id 98e67ed59e1d1-3ae89838746mr10346573a91.52.1793714361333;
        Tue, 03 Nov 2026 05:59:21 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b0872a3207sm883519a91.8.2026.11.03.05.59.20
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Nov 2026 05:59:21 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1acbaf81bebso893627c88.1
        for <linux-hardening@vger.kernel.org>; Tue, 03 Nov 2026 05:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793714359; x=1794319159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ApeHudjpRw1j4fPKuyoZlTN6SSSk0BmJ7DVYBxcf3Y4=;
        b=RLtOpmE1mIOTbJbge1Tfnyerwmo6zO/iYqBQbf9QWS2xcTOjK0obPShjEMtTt7R7rz
         NQeZ3JrxK7CujzRlbWCtxOO1hHpt9EP+WAqNgsPq6ZaJ2oqio3DzBqqmFTnPcYmoyvy9
         ysRhg1SkNNOfUBU/0ccWKnXhh5FLB+5FNWhWs=
X-Forwarded-Encrypted: i=1; AKwUvBxtINjY8B/PLs6e9MS5Wq840aoLalyPO1GKhX9bC0WJgQM7+klbZ1v7LdglsEZrCEkSA5mwu0jbcLPFwA/JPsQ=@vger.kernel.org
X-Received: by 2002:a05:701b:4211:10b0:1a7:99b9:2eb9 with SMTP id a92af1059eb24-1ac5de4e8a1mr19735554c88.27.1793714359392;
        Tue, 03 Nov 2026 05:59:19 -0800 (PST)
X-Received: by 2002:a05:701b:4211:10b0:1a7:99b9:2eb9 with SMTP id a92af1059eb24-1ac5de4e8a1mr19735501c88.27.1793714358682;
        Tue, 03 Nov 2026 05:59:18 -0800 (PST)
Received: from bld-bun-02.bun.broadcom.net ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac18458e07sm41658755c88.8.2026.11.03.05.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 05:59:17 -0800 (PST)
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
Subject: Re: [PATCH 03/13] wifi: brcmfmac: Fall back to RSSI-only default join preferences
Date: Tue,  3 Nov 2026 14:58:47 +0100
Message-ID: <20261103135856.3676311-4-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260925-brcm4388-submit-v1-3-b5cbc2cde2fb@gmail.com>
References: <20260925-brcm4388-submit-v1-3-b5cbc2cde2fb@gmail.com>
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

On Fri, 25 Sep 2026 23:43:38 +1000, Michael Reeves <michael.reeves077@gmail.com> wrote:
> From: Michael Reeves <michael.reeves077@gmail.com>
>
> BCM4388 firmware rejects the default join preference containing a 5 GHz
> RSSI boost with -EBADE, but accepts an RSSI-only preference.
>
> Retry with RSSI-only selection only after -EBADE. Log other errors
> without retrying.
>

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

Regards,
Arend

> Signed-off-by: Michael Reeves <michael.reeves077@gmail.com>
> ---
>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c | 4 ++++
>  1 file changed, 4 insertions(+)
