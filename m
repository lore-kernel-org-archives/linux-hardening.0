Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793714352;
	b=UkKsj6ek3pwB+4UoKohi35WsDdphouvNzMBEESkMkjCkPg407eS3IHCbT8CStqJN1fQU
	 fOaV/Vzh5omahuAJlF8dNfhBNaNl3285ZeGXzZnbln83JrZyUGl/1ipCzq185xBnITR88
	 UH6rQtD8hq8KTXa8vBQNIOL3aVVke4QFiBRyPggamrQ+XSuangYNv11ikeQUeTy312rZg
	 5NC0llrXOU1pxAhuztcBKJ0QDBuwQLRn2ytJFf5/l2vzDiJ3pJMxvL0pX798Qc+RL3acA
	 pkkQ6pFncm5LkzkWx05f9m8hGeGmODgrsBKdb4jc42pBArhwD4IFpDXQTHr1xZ3vsKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793714352;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=ccP5HEXTeJ0Y3jbzqMoy8v3yamoeB3mTuClgVh9AD5I=;
	b=FWCaqFUoASGzqZDTKLYd4E9kqlGSM9790sFLcOZkQetQ3gtwZjtswMgFin/AugS9et7e
	 tol37S18ekoNUv9zGQJYXLo4c/5QCdx91779IM4wyBKrR2i7Fo59W22yXYWcb9CWOx5Hz
	 CxvvJqGnRtjf38lTSHSFNNzOxfG4Ht52hNUhHPZWwxZMDYhRkm5GKJCcKa1nnWM7U0LBp
	 m4jekSgjf3sFodsJveS39WGcQLBO1cw2x57w0V8ENtZHTu5hyptZqnaNLONChh83W8nP9
	 chVphMfURwdWM2QYnIIE99ScA1/W4Py0UBRW2EaKYrNg99VHZm8rvuXUuVbu+6fHhaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=RMAZnIWi;
	arc=none smtp.remote-ip=209.85.214.227
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20A5606D80D
	for <linux-hardening@vger.kernel.org>; Tue,  3 Nov 2026 13:59:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E20A5606D80D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=RMAZnIWi
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2e99b1e5b4cso25521705ad.0
        for <linux-hardening@vger.kernel.org>; Tue, 03 Nov 2026 05:59:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793714351; x=1794319151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ccP5HEXTeJ0Y3jbzqMoy8v3yamoeB3mTuClgVh9AD5I=;
        b=jY5sd9W41v/yEcRXSbKnKAel0F1FNw7czz0UFu78DFUgRtJgi+yC4Qu6rn7M9G0MMA
         IhSl1Vy8x+fPA7p8SCLDDKDeQvKb6fYfMj6eWMqtElS46fjWiicXagE4bItUdrBPpkDw
         C7pZDYtpdytggEgisXmj6x4+dSUDfK+c498jVgU8zbh6tb+TGjMmYLOLr5KcLGln0kKA
         GyFSoEi34TfqknfgmUvkHDAbJPQ6hmhKXg50ne+H2T6xslMHJtZW5/WogI0tJGvNQGN/
         eb+cNYHJsBbutPEr71US6v5C9TctykdbT6QqoRnQ6AGKJanCu/FaHl7UU2k503a22clW
         Hlxg==
X-Forwarded-Encrypted: i=1; AKwUvBxINZj0tcFB2yZOgImZFu+WR2+WJsJH85rr8OueBKQGV+wtRFOeKWsu4vZceICJNGe6IFb3GOyCpIGUFcxuY4I=@vger.kernel.org
X-Gm-Message-State: APuU4Z87z2ahx49KnFjlN6FFusjjt5dc0SgfQLkzCEVrgEtq5CG642zI
	8qQAvqMMDB+ryfsGwbkBvycpk6Satgs4H5BWo/yLB02rVgVFcQAlfgwaWAuyCFoIaQnDpBkygtc
	IiU5b+abfeCHruMYGc4hpX8Ic5biCi1va8GIpY1mNp3VGrSL059ZjRKRDNTcGcT9mgjcmjHCPFJ
	+CPBoQXkUs+oCoC/fpZ2Mh/gM3V2A2LLiN/5Vz0Uc8EdBqGhpz6EdkNz23SiOQTNdPQd3pRiKTk
	nYUIRSv8J+X2qMKsFwthswtee3Qcg==
X-Gm-Gg: AYBFou1F/YGwgjV53Aueft2iwJti09+1DAXLEh48XjZScxeK1HkNSawVM82TO1sfY/t
	eFJ9JCr/1BQ2piFgEWsrpzDZsjtQhhv2LlHiSeq1ykB6gzl6xZZCt/kqWLXzL0bAn6nncDn35Fj
	k7fwvueHfax2XUkKWZfoM65hmc+5Gml/onu1i+o7bAzINyA2Kim/L4eui1iiATDmkyIlCVEmbAq
	dbH5uSxEl5OAw6J8PwFF46oC5GnIzLl5DHnw5ltPD+qLzw81eKNCRQBLcPh/a0zzE0jdmXQ3gov
	0dNkdmMJ53hwOvUBoG3wn/OXV6FJKaJ9ozK1QQJ8/NBS/f468/KQawHmuQYr0zV23ztZML/r7lP
	wsNwwUWNnRoZYGwqcK8Aq2SP+Y9ahAYMgKd3sXEOZJm8RXpEs879A2agLkKCW6WeB3ZbjQw6FS/
	7IVrUSusfShdMRNQOBGELV6nWHukLm3im1xVVzUU8=
X-Received: by 2002:a17:903:3910:b0:2e9:3dd2:a904 with SMTP id d9443c01a7336-2eb3648b6aemr123254465ad.16.1793714351247;
        Tue, 03 Nov 2026 05:59:11 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2eb3922cae2sm2144645ad.14.2026.11.03.05.59.10
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Nov 2026 05:59:11 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-14373747468so5533837c88.1
        for <linux-hardening@vger.kernel.org>; Tue, 03 Nov 2026 05:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793714349; x=1794319149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ccP5HEXTeJ0Y3jbzqMoy8v3yamoeB3mTuClgVh9AD5I=;
        b=RMAZnIWiFfRJoex6o5xMUANJBFWQC6wSRALcRXyo1dHHHP6MEzHp/RwWVLlWZmyxzZ
         0k61IZ0PaWLzU+C/Kk+A4B+gR/AKLjy2ycVL2IFbfNeh7liW6wF9Oi3HXq1dN+9rXYgY
         IqojDwR3yiTYQdSXrgR4s1PP+EvhdtRgkS5IE=
X-Forwarded-Encrypted: i=1; AKwUvBz/JdQ/iSIbpJDr1KVNjot8RNku4RCXWQgqZ3sls479VH0EjOZjw62SFwzSQw7XNptCkqBgIcn+2s7pDqTPvxU=@vger.kernel.org
X-Received: by 2002:a05:701b:2702:b0:143:5cb4:30 with SMTP id a92af1059eb24-1ac5577508cmr18346093c88.3.1793714348712;
        Tue, 03 Nov 2026 05:59:08 -0800 (PST)
X-Received: by 2002:a05:701b:2702:b0:143:5cb4:30 with SMTP id a92af1059eb24-1ac5577508cmr18346046c88.3.1793714347953;
        Tue, 03 Nov 2026 05:59:07 -0800 (PST)
Received: from bld-bun-02.bun.broadcom.net ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac18458e07sm41658755c88.8.2026.11.03.05.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 05:59:07 -0800 (PST)
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
Subject: Re: [PATCH 01/13] wifi: brcmfmac: pcie: Report the detected chip ID to the bus
Date: Tue,  3 Nov 2026 14:58:45 +0100
Message-ID: <20261103135856.3676311-2-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260925-brcm4388-submit-v1-1-b5cbc2cde2fb@gmail.com>
References: <20260925-brcm4388-submit-v1-1-b5cbc2cde2fb@gmail.com>
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

On Fri, 25 Sep 2026 23:43:36 +1000, Michael Reeves <michael.reeves077@gmail.com> wrote:
> From: Michael Reeves <michael.reeves077@gmail.com>
>
> The devinfo->coreid field is never assigned, so bus->chip remains zero
> and chip-specific feature checks cannot match. Assign bus->chip from
> devinfo->ci->chip, which contains the detected chip ID.
>

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

Regards,
Arend

> Signed-off-by: Michael Reeves <michael.reeves077@gmail.com>
> ---
>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
