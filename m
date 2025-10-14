Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EEE2F5339;
	Tue, 14 Oct 2025 14:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760453947; cv=none; b=ZtU9en8re0BkhPGpFJWN+hBYMsR1yRpI4OedBcCs4wYTefgdwASAvwjLopjlmmSM/OQuiTRCB+3nWyGSOwxhhuCPP11KYFrpH2KpzOWMYCIRtUG4f0BLMnbfI8lWBb+hHx8uW8QxHzqWNxYcI7fRlJFtnkDGLSXpu0+E4J9zCg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760453947; c=relaxed/simple;
	bh=lTpixwap7pMwPWpUbxJaULnTGt3DY5OsC+tHMRhEmFY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WTDMLMtrQzZWVqX0qZt+ghe2Qgb2KJRxDJfCDMqGRSOui2GuVysPUOtR2X+e/v967PdmCgCy8uuHrSmOfDv9cIkkWrmZLWWo7gkSH7+O9nZTZMHC9C6/7Q9DgRuLEXt8rNInAPUqPJqhyffr5AvYUprBynTssJ2EqQThGFjTx0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=Ck6A73zk; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Ck6A73zk"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E08B040B1E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1760453945; bh=yClp+s/hQ2rC4D75oi+tnkKw/aw3tj99GBVJki7e0nA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Ck6A73zkVgs43jbq7vL3OOrTSKSWoLEPCPShlau3DpnvNA1JMnEv5mNKFpqY4l+o9
	 OE3v+sZBpFPeS5ZkNy11CMpN4awmufXzTw0imQdvwhWU3e1ah9saugr7zN7QSngcWi
	 JgP5jBhMjjR0RxXe+YDhEONias/1VPctz/NCdYdkNaYUq+FaaK93T9eRq5oJPuojr5
	 F4nt//39qZT5HZ2ZFZwFig65nUTpnuBOZqHxvu0YXzryOEPYqHzLaajsRvwI+kx7r5
	 +FoyTt46t+OnwfhmJMnvb4l+cHpDMBskh5d8yH5yu9WClda/8P/0KrTiElJSG96MS1
	 XIiSIgaZtjcrw==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id E08B040B1E;
	Tue, 14 Oct 2025 14:59:04 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Akiyoshi Kurita <weibu@redadmin.org>, Kees Cook <kees@kernel.org>,
 linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Tony Luck <tony.luck@intel.com>, "Guilherme G. Piccoli"
 <gpiccoli@igalia.com>, linux-kernel@vger.kernel.org, Akiyoshi Kurita
 <weibu@redadmin.org>
Subject: Re: [PATCH] Documentation: admin-guide: Correct styling of MS-DOS
In-Reply-To: <20250926184824.40270-1-weibu@redadmin.org>
References: <20250926184824.40270-1-weibu@redadmin.org>
Date: Tue, 14 Oct 2025 08:59:04 -0600
Message-ID: <87o6q9bkcn.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Akiyoshi Kurita <weibu@redadmin.org> writes:

> "MS-DOS" with a hyphen is the official styling. Change the
> less common "MSDOS" to "MS-DOS" for correctness and consistency.
>
> Signed-off-by: Akiyoshi Kurita <weibu@redadmin.org>
> ---
>  Documentation/admin-guide/pstore-blk.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/admin-guide/pstore-blk.rst b/Documentation/admin-guide/pstore-blk.rst
> index 1bb2a1c292aa..1e2abb2ef500 100644
> --- a/Documentation/admin-guide/pstore-blk.rst
> +++ b/Documentation/admin-guide/pstore-blk.rst
> @@ -59,7 +59,7 @@ When pstore/blk is built into the kernel, "blkdev" accepts the following variant
>     with no leading 0x, for example b302.
>  #. PARTUUID=00112233-4455-6677-8899-AABBCCDDEEFF represents the unique id of
>     a partition if the partition table provides it. The UUID may be either an
> -   EFI/GPT UUID, or refer to an MSDOS partition using the format SSSSSSSS-PP,
> +   EFI/GPT UUID, or refer to an MS-DOS partition using the format SSSSSSSS-PP,
>     where SSSSSSSS is a zero-filled hex representation of the 32-bit

A quick grep shows a lot of occurrences of "MSDOS" in the kernel source.
I don't think the churn of fixing all of those is worth it...?

Thanks,

jon
