Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B953CC310;
	Wed, 29 Jul 2026 20:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785358638; cv=none; b=bFbaULRYQUA+h+DWK6fJi9F+/sA5SfuytpYAiJDlAvmieND0TrbxDzsuySAH4ZpdnVq0dedXwXGY6jF7L9ZYRIKnvCAKmUxn5hlHPTtMRfM+s9jBR8SXeXSmaLwOZZwfLi0fW/qeTx0HS+2wW+z/l5lPPbIhEFydVvIy+P66BOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785358638; c=relaxed/simple;
	bh=alUzQHsyKVYHix60luCfjkIXUfXS+Tm9IdW/ljiuGh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E4oF0mh3WyPa4Cc7DCOzw2h9dQSPPVj/0fCBPTSYz6WOBmTNak6LN5YjryzqtrfEDDO30zKfS0lseGeUL0xPhRIZp6tX1eh5kgm4GhLij4dLa8DHN5ssyWpFtOgCwNw8J0/jeyIq0mbi32asoc5iKR3ek+XH6UVyXismL4NJ35M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org; spf=pass smtp.mailfrom=fastmail.org; dkim=pass (2048-bit key) header.d=fastmail.org header.i=@fastmail.org header.b=RBN7x67L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A+YddmUO; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.org header.i=@fastmail.org header.b="RBN7x67L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A+YddmUO"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 2EBA71D00348;
	Wed, 29 Jul 2026 16:57:16 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 29 Jul 2026 16:57:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1785358636; x=1785445036; bh=alUzQHsyKV
	YHix60luCfjkIXUfXS+Tm9IdW/ljiuGh0=; b=RBN7x67LUJuL+kIv2c0ad/G5DT
	UW6CPVbxMAwUg00iNb8BfP+A8uf2c6UOO/Gd6nu/hhdeJdr/2bRCTCsbG6dyUvov
	wucmKcuKRRZFR5WsgODbOTrivJxavIHAtapnqD9Xj5gjijO6JcNbQkTPwfgtIWEt
	RXCLRJAjw8xVOzs/yOuLlkpIuDevx87Ym13beDQNYLHSRZWwpdjOnA55dhC9eDRM
	9HMA11akPnkg8NkJpyZSQcea7BAwcwER2BdwAbIiD/tWK7ih8/3sMsfhzuFb3efR
	gw/iZvGHWR2hx18BvW+nC1FbcNkPKXbku84GjGBFkegyxFQLC3tKvvIfz4ug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785358636; x=1785445036; bh=alUzQHsyKVYHix60luCfjkIXUfXS+Tm9IdW
	/ljiuGh0=; b=A+YddmUO7CTzR9PShODlazODeMCiO22hnIarnPIAuD9s6dN/c8y
	Eg7MXYKE6l1u3PmwV158Kry/uHiBOH1cfUdfmTCXdhYrXbeDXMFxGSAqI3uE0Jrl
	v3rXKxh5zsKFSRrRVmdtJhZ0ccAwb0z1NQ6IFAp5crKqPwrZNKuZn8/LXSf03X8O
	Xenp4WUpvmN34kC/16PuIY1nxxXC5b7AtE5rjeI1UBi7THAEg+n/5ovK4Kc+CYKJ
	xht+rYpSPNZfrCQQYaNF6J58ZzvKg0XBtAcq3w6HqTK6usMgRwuPnKgBkO3vq83I
	OoMGonT2/doeUE5B7ZN7scFaMMcSyB1lbww==
X-ME-Sender: <xms:K2lqagE8iExCk9xvzqtNfD5bjrB_OmhpPPG5NyDlXvok_llAxLj1Xg>
    <xme:K2lqakSRBropnwCwo62pCcla-sswMWiyCqdIuvpRXda_2RQf4E97SphHd8n0i5afV
    cln7eeR8l0xc_RR0ijfZ-IadHMeQHkwtF3KbMQ9in-pPGppZ4Utn30i>
X-ME-Received: <xmr:K2lqapJoBwxTFlbX-ORW7R4Ux7P00me0nmgA9gtOi7CUTBDZE0EgP0TbGLg>
X-ME-Proxy-Cause: dmFkZTE3kqu7On8dWJFzGjaqNjJoZW9aHEiwkzn7JWTm5sk4YSeWPS4vT7UP6ArAzgylZn
    M5AB5KwxxX5Ur2EoC0mQLgdhKeHKljbeIE0dSukNdR/vNuh8wO1JoYqfxd3RVWI7nYn9e6
    t15CPKhl0ojKDpMCh8qVlXLe441nDpiBA5abo4QKEgqsBx/drnv+yDe6Z/iSC5ax6ezT6p
    dwWwQNQ7KjV0hjr+P5Sls0hnRFS8TR/3At1ZiBSCD8ZOvqLEJH1oUbNIOjUJe5t3rf5Fne
    yRmIqPbu76/kyX7Ncp0RfOIsriQ3bilQos/tlv5XOZlDOYD7zeex33jqKjYC5rojGX8qba
    tzyCii98XJwwXUd7bHF5jF6U7MVXQX4jDJeBTKGiGFZY43vGjYh79unPd0CvntS2vj53E/
    ucfBFH9DY388BkzII1gl7es264M1MJ47glrLJ9XHngR2ohZ+DyRQcPRttPAlUKE9jfZzM1
    2McMmtTA9a+uMg9aA6+a6FgkvNAHmRMAbdog0M0ZXaewf8PoQhpYcuIlt9B0vbElKTWYsU
    3cs8OT14UmuJfVEyteNC4Ar0dyktBmXfu+kjuIxrizgGSRQhlmWQ5TWxdQOAyebHoUvLoU
    ukiFU2WUdxicV4YfiBTd5sTGyUK6S//5UsPgmLQFo7NL9LK1gsSzkIePnqPg
X-ME-Proxy: <xmx:K2lqana2gMglExWDoP8S_1DBgdvEAp2hNiM5uaAIvKeyZD4ZZsx_KA>
    <xmx:K2lqaj-Qx3YqdmJ3FPCqBxFEhb6V-5mQCCYitUE6SYjt8u8AEJbE4w>
    <xmx:K2lqagZzVAnTO68OnmVJZSNFiWfnnD9D-2-bVI5XGd51hVirJ7a45w>
    <xmx:K2lqavMxiV2NsrRnkPXC7SzIbPGbpPaPfiUfugSLb34h56qqrShuRg>
    <xmx:LGlqaiJ1n3I2JEI1_mCvvvqcOTPeUIQhiHW5EO_DER-HR41F5G59ASKp>
Feedback-ID: ib53e4b78:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Jul 2026 16:57:15 -0400 (EDT)
Date: Wed, 29 Jul 2026 15:57:14 -0500
From: Ian Bridges <icb@fastmail.org>
To: Robert Richter <rric@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linux-hardening@vger.kernel.org
Subject: Re: [PATCH] EDAC/thunderx: Replace strlcat() with snprintf() and
 seq_buf
Message-ID: <amppKvK6mIJRmoL8@dev>
References: <akYJUdY1hVABUQH6@dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akYJUdY1hVABUQH6@dev>

On Thu, Jul 02, 2026 at 01:46:45AM -0500, Ian Bridges wrote:

Gentle ping. This patch has had no response since it was posted on
July 2. The code it converts is unchanged on ras.git edac-for-next
as of this week, and the patch still applies cleanly. Happy to
resend if that is easier.

Thanks,
Ian
