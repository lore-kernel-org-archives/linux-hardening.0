Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.228.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793809993;
	b=D4H3sgzJjcch5A2SbMhn4br+a2TCyxpJ9KfuUp+vaDQif+5Z9Cqhp5AliQc6beghrl33
	 EtuB1Qe9OvAEt7wK2PgW+Lm4yP6ye4SouHB+KELNSiLVxLnvSX0BSQsnfQ/0hWKDvVtqL
	 9ahNl8qOZV8Zkc44pcpjm0UuPsHyl/5P5MwDQ5goEYDjojpGnFkIVdxlig0/WcP7vtNOa
	 W9XjhCVAy5ENVqgAqBmG2WxReb/ewoYwJ625F2wR81bJNEdXtL/6CGbU/xqvgfDBM1iKR
	 +DB+8uiP+oUEm3+kvT9RDEtYcCMdz+4VPz3Y9qUTuw0AyxGljvF+OZX1FKAryEIe8rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793809993;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:Mail-Followup-To:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=WUuEMcW2y0Pk1LSyzuy5CzYSgNsbEsC5pDpoND1JIlI=;
	b=Y5qCwh/fQuQp7bnxo9a4/j/3OB9sPH7G7L7ZCCsC9qbtF1n5NW4COQ7FziJAbeuRT3Y+
	 jLd+4cXR3EbveRl1lq4nzyunv7oMIe1cAYU1cRd6uPtMfVa/IFsuWpOefAEgReuQ6WJ2v
	 oC/9Lf5UAddLwk9Tj21ykCRnZ13DxhV9hdM+lSDM2yGFyxwsZzjvpudFT08nGDcNof0O1
	 FEOaAq7t8jzP+no1tsBlcUgktrE1KqaCtmm+YL8fT6mYpit75uroxauRhICjYShxGtWRp
	 wSgqh25nCSGuBJMIAfwCckKRvAMvCahF+CYgdDrH5DlBFY77uit71lcMlQRz9/04fLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fsRCd8bw;
	arc=none smtp.remote-ip=74.125.228.9
Received: from mail-pz2-f9.google.com (mail-pz2-f9.google.com [74.125.228.9])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED20606A330
	for <linux-hardening@vger.kernel.org>; Wed,  4 Nov 2026 16:33:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BED20606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fsRCd8bw
Received: by mail-pz2-f9.google.com with SMTP id 41be03b00d2f7-cd697a57d7eso315306a12.0
        for <linux-hardening@vger.kernel.org>; Wed, 04 Nov 2026 08:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793809992; x=1794414792; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WUuEMcW2y0Pk1LSyzuy5CzYSgNsbEsC5pDpoND1JIlI=;
        b=fsRCd8bw1VaW/FUdm/x5df/xZRxMEuPhoQfa4aceQ5hTpY2tLfKPRvrkw6NnJ3E7T2
         pg1y6766lH0bbeB2956Pil7wCQzy8WJFRTd+sW3e0yFQUxRp/4pSyMu1ZTMeud1eJkg4
         sURn4xaS0qewmdL3Gjw30AQYO45iU49ttRPe0ARjCZuirjTDeL6vzWALtqYX1agqbnVP
         A0ctlZ5JBWCS4/jLNl+cttzqyA0Ijx6x9q+aePujoKXpCwDbbR3aRvEYPfgnSsOdoCLb
         rxvW3Vs2qPcnxbd8hOFTNMHBgOpgdRvpjrZBxvv7KwpVL0KV0RFtnUWmz073kklfnRWw
         7flQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793809992; x=1794414792;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WUuEMcW2y0Pk1LSyzuy5CzYSgNsbEsC5pDpoND1JIlI=;
        b=Q1I//4hN+C5+8zw0WoSiZootB8k1A10s9gmR9v4hRSqR3U0URhRHZwojAd7sm4qkRl
         /b1nLqt9XT1BZvyBTbcprB3HzQMwKbb53ceiUndYbKkmO80EmYbFnAcCmOreOe971H07
         lW8MKVenbVGSE1DX5m6CVQX1z2TczKGnEU75USpmZtzb+fQCFynjE7XxtwRJQp8zPojx
         pgaWN+XFkDOKcfh460FUwF9j8dLTPjI5yq1a+bblz97m2OYdRuJ36ky6xlFskiPoQUb7
         hcgb3c9Rw1vrDmwXW0RbquSqyUNfMjED4yrEe8Apcfiv+zaiBhEFcmxTtPNtgib/Q9OW
         XxgA==
X-Forwarded-Encrypted: i=1; AKwUvBxiKn7SVgcJfMIFKDXp3qKfOvyMbmbkwPn64L32UYZ5HBuGLUIg3GS3/gC6RBBKcB0YDPUY3DbySP/EgAb0yD0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+YHXCGppyPOy8T3nIc9ARx1ErCY9GH+bUqCAb3YDLVcypHalct
	AQNg44EF+2bZlN60vYwMli/SX2sgMl+LOmXzjE6xKpmNH6rJAPT4dAHx
X-Gm-Gg: AYBFou03m5Ur1R8Ut6sQgGyQAa3tWiTgA1qbDr41PZivPjnLHPPu+dOs4etKz+70UFm
	Iopgp51YKRgAfbmjJrQqVSW/JmTrPmzrJJqfmArInHu+ZLq48wybvuv33/YGKm1Z5/iWSxbM9IZ
	ZHdqnJ/iS/kJ1FZzSSgm+S6Ay/HCOmNCWK3RhtwznTBvlnCg1W04eBWlZgBBVRayEhoFLyolJRM
	MRiWbDmQQdSb8e4PL1fTsnbFuip0W5Z0lrKBqtI+RpGAsjiYTepcgYWD/GvtA2B1oK3lvVfjKZj
	EWYdSwIksAmCuDuTqwXMF0a6E6oc8p0ag3HwbZ1D7yUU7PxOPwk+QGP1rnBMRclf4n6tA+Dam0w
	vpdkw/4JLhrzxo71E+3zf4T/61wg9LWD1heSC9BF6kCTZWpTlIeVC/+XX9/A4WuCf0P3pBh3Au+
	XW4rCCjhvR2CrlaiIVgYzcsz2r9RKlwFmiNMe5qFeC6XOf+nC+T3cMZgueIQ29CwMwajrSLuvgb
	2wr4sB9+QW1q7ZY5MJsK/BESnat9JoCDgrFGqa7SB8rRj7Ims2GHatQwi1bdKP5c5h9LgetTz4O
	FzdAHcH45ma1az5Mng5kUaS6OCaejNJWZDswNhZFxc3Cd7aqTtmzuJo=
X-Received: by 2002:a05:6a00:3d43:b0:8a0:3685:239d with SMTP id d2e1a72fcca58-8a9b9a4ecfamr13116937b3a.1.1793809991595;
        Wed, 04 Nov 2026 08:33:11 -0800 (PST)
Received: from J4f-Laptop.localdomain ([183.36.237.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b1209b473dsm912606b3a.36.2026.11.04.08.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 08:33:11 -0800 (PST)
Date: Thu, 5 Nov 2026 00:33:05 +0800
From: Shihuang Liu <shlomojune6@gmail.com>
To: Mariia Nikitash <nikitash.mariiaw@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, kees@kernel.org, 
	justinstitt@google.com, morbo@google.com
Subject: Re: [PATCH] Input: mouse: vsxxxaa: Replace strlcat() with strscpy()
Message-ID: <ttauzj6h5b46f7o72f2irfwsr5vv6zcqtfme5qyery6wtg3eb4@u7iszy34j32k>
Mail-Followup-To: Mariia Nikitash <nikitash.mariiaw@gmail.com>, 
	dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, kees@kernel.org, justinstitt@google.com, morbo@google.com
References: <20261104062319.288360-1-nikitash.mariiaw@gmail.com>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104062319.288360-1-nikitash.mariiaw@gmail.com>

On Tue, Nov 03, 2026 at 10:23:18PM -0800, Mariia Nikitash wrote:
> In preparation for removing the deprecated strlcat() API[1], use
> strscpy() to initialize the mouse device name.
> 
> The destination is zero-initialized, and the constant string fits
> within the buffer. Since the return value is unused, this preserves
> the existing behavior.
> 
> Link: https://github.com/KSPP/linux/issues/370 [1]
> Signed-off-by: Mariia Nikitash <nikitash.mariiaw@gmail.com>

Reviewed-by: Shihuang Liu <shlomojune6@gmail.com>
