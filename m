Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.79.88.28
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795624084;
	b=DqpXV+YVrolQal7YS6Nt9ivElRXHnLoVp5uOxDwEWNJqc4Ljkb26XlJlqC3asaMP5JTB
	 helBupbtE7e7/7E5pYw6+dgsczjoTSeKxRroU88ZSx/o2jeTX0l93KhnRPg78Z3ZQudwn
	 SQQ2TYjckhL+E5CROB6VT+0BJXNR48aopge3niHt1P/EwPwq7auFECUzB88X4bXRBQTHo
	 w6c5scx5hFZJ6xaL7BiOclvXr0IKKZppPyITW0I9YhLkpUC11t/DIfENuur2dcpsIRCc4
	 qtR2DZ8phRVL1f3u3b+2ldQCVoDMn+waB8Dwkwu4ChcBEZSbnpM42L6C7+wndxCfEJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795624084;
	h=DMARC-Filter:DKIM-Filter:DKIM-Signature:Received:From:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
	bh=KC9kQxeHZ76XiJpzcnKl74l0T9w0iam6Tpv78NX5QEY=;
	b=nktYIJJ/t4BZyeFRvqcX1ztyIszUnDEzvUdwqYTZk2EyqSgEXqwhc/MxCwccZIrtUVY/
	 wcW6eS7jig3asWueP9tuJMiQghSTJOey0hhiGfbojghn5C3Ey8pYmAaF5r7d0L1mIq1B3
	 CbhlsWfSNJfMXRkR024HBdKJi8zW6L0Ws+cIomowSh8vN6sZg7UdsDTydkVOLmI3AIUi3
	 P1MycKb6wP19XL3O9LuqDkfldY4j2buWRBgZhStfAA8ELwnQRH+luLg89qkhZvTgSTBSG
	 GzoCOHPAKgPY0tvLiRCRj0+9gwmmqbxGbioPadMOcYpYB5e00heDOydwYX+jrIBSzDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lwn.net;
	spf=pass smtp.mailfrom=lwn.net;
	dkim=pass header.d=lwn.net header.i=@lwn.net header.a=rsa-sha256 header.s=20201203 header.b=s1AqJYiz;
	arc=none smtp.remote-ip=45.79.88.28
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F507606A321;
	Wed, 25 Nov 2026 16:28:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F507606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.a=rsa-sha256 header.s=20201203 header.b=s1AqJYiz
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 18CE2410D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1795624083; bh=KC9kQxeHZ76XiJpzcnKl74l0T9w0iam6Tpv78NX5QEY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=s1AqJYizr+FvP5iYZcPd+N/BfMZmAh5TIpB0LduRqooTCOwLal+xqVZ5FyvkSvlZI
	 mCpFutShYef3q0d46mkEQfZXNUKhmREQjPQ/1wyvKRmf18uybNZ8+2hjuezRIGwxIA
	 fsuwa4nGpgsjccM6M8KggnJpguVkCnsEc5l5PkxmcsIF8AW+XjCrMnQ2CvU6eTMBX+
	 Chnf5IiblTLURG7e8NsZqfy/mEiL7SzpQjF4mI8Lc8RNeijq0SUOgZWPNRlqLvOQaU
	 NFr9EjMsZLMSxGfTFrQwTjsp/VqjWvUevlgqcFxU0YZoZC++uMEAEaJpM8LNZp4MwG
	 EhSTOP1n29hyg==
Received: from localhost (unknown [205.220.129.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 18CE2410D0;
	Wed, 25 Nov 2026 16:28:02 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Kees Cook <kees@kernel.org>
Cc: Kees Cook <kees@kernel.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] CREDITS: Regularize email address for Kees Cook
In-Reply-To: <20261113174357.i.748-kees@kernel.org>
References: <20261113174357.i.748-kees@kernel.org>
Date: Wed, 25 Nov 2026 09:27:54 -0700
Message-ID: <87qzg8x4dx.fsf@trenco.lwn.net>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Kees Cook <kees@kernel.org> writes:

> Update my email address to better reflect reality: company-specific things
> (hw embargo) to Google, everything else to @kernel.org, drop less-used
> aliases, but leave copyright-associated email comments as-is.
>
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> I am happy to carry this via pstore or hardening, but figured I'd send
> it via docs just to avoid any collisions with translation updates.
> ---
>  Documentation/process/embargoed-hardware-issues.rst           | 2 +-
>  .../translations/pt_BR/process/embargoed-hardware-issues.rst  | 4 ++--
>  .../translations/sp_SP/process/embargoed-hardware-issues.rst  | 2 +-
>  .../translations/zh_CN/process/embargoed-hardware-issues.rst  | 2 +-
>  .../translations/zh_TW/process/embargoed-hardware-issues.rst  | 2 +-
>  fs/pstore/blk.c                                               | 2 +-
>  fs/pstore/zone.c                                              | 2 +-
>  lib/test_firmware.c                                           | 2 +-
>  lib/test_module.c                                             | 2 +-
>  CREDITS                                                       | 3 +--
>  10 files changed, 11 insertions(+), 12 deletions(-)

I've applied this, thanks.

jon
