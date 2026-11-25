Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.79.88.28
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795624514;
	b=bNW64B9R8OwtOENPeBAOD4BquYGgwdDrDGsLpOezVqwkDQKV5Wf19Eby+X5O5pXc2r2m
	 r8c1jyRRE6hvNq5f90BizQcCsrZGDcgHgKloPL7HrBmduCudMLLjwpNkFta8TJk4oo0tq
	 tAG9x0Y7g2jhoOGgn6muC3G0Y4IiNJ/wvjSmrnUUdzXaLBUM65qdyr31mhZJPCjt+d+U+
	 oAYwKP+obDiB0ZPWMTj+awCb5LJWdy2QpR3gSIgvTUnzBczEiqrIDVXlME3Sef0cBpni4
	 +ck8LgA/xGbS9g7wM3KfefcsDqjQuUnsEhywrEYrDItsEroQGQPDHB8aEVxAHPBm9jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795624514;
	h=DMARC-Filter:DKIM-Filter:DKIM-Signature:Received:From:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
	bh=Hjgt+TFxcPhZLkIHdOXb/NOc51gCKreQtgu/urojjxk=;
	b=hMJ+iig49w4lAyxHys17ANMVlZ+02wN/7QYxVJzye6+74Z4RQoq7BlHzuqegAsnwN49J
	 R7PNmoh1aWnAy4I+4m9HQ3j6DgVxPnHFO5uSfO8n6A5G1B14GKtVm5gJSvRgxjD45yjfI
	 hLYZTOETH4BE7/AcU5HXfsMv4zflSsLoB0OkPMVvHI9f5HYrR43pU3EnOgCjmZtsHmBuT
	 tPXHy8gB69FuIr4lAQS3NtxBmbZTQTUFWOeZOyOGfCBcozpA8TuLznUAushfzE1QYfePP
	 U+R2kA4MvzXiDXLxKi51+OnbG4FkxyCqUFXN1et+/ugbk3FB3O7XSYip+JqTqiybxDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lwn.net;
	spf=pass smtp.mailfrom=lwn.net;
	dkim=pass header.d=lwn.net header.i=@lwn.net header.a=rsa-sha256 header.s=20201203 header.b=F4ZFtXBd;
	arc=none smtp.remote-ip=45.79.88.28
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7B8606A338;
	Wed, 25 Nov 2026 16:35:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB7B8606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.a=rsa-sha256 header.s=20201203 header.b=F4ZFtXBd
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net B48A5410D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1795624512; bh=Hjgt+TFxcPhZLkIHdOXb/NOc51gCKreQtgu/urojjxk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=F4ZFtXBdTsZufllLGA7OuIf1lCn9NzoU9URraJsenDDOnHUYFscs+aucSvgYxUjJA
	 GraSu1g9b8H2VPHHWN/8d5TycxuQIQncGuMxaCx0uk6RG49+/0KLjBj+Ymc9pCc1vs
	 g96A9uf1Zh47I5jf8dpQ7lkCbc9nPtNaEvsJAVZ3VGMCd1WYPmkDumnctgDk9G9zkK
	 uaFPLv+AkeFRSGJ3z86v5fCJM2KsAp+nXWGRM6fMdcrbdO71YKZ4odgj13DL5f0vTg
	 7nY9by5GhGLACbcaEQk3QPYOhtZTwnHK6Mj0lhC8xruY3+2N4qdZjzjSkQ1RI0jcpz
	 oLoq3cFN8j0EQ==
Received: from localhost (unknown [205.220.129.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id B48A5410D0;
	Wed, 25 Nov 2026 16:35:11 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Kees Cook <kees@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Cc: Kees Cook <kees@kernel.org>, CVE Assignment Team <cve@kernel.org>, Randy
 Dunlap <rdunlap@infradead.org>, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH] docs: cve: Describe how security fixes reach users
In-Reply-To: <20261111014419.i.586-kees@kernel.org>
References: <20261111014419.i.586-kees@kernel.org>
Date: Wed, 25 Nov 2026 09:35:04 -0700
Message-ID: <87ik1kx41z.fsf@trenco.lwn.net>
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

> Recent threads on kernel-hardening proposed new mechanisms for
> mitigating kernel CVEs while waiting for distributions to ship their
> fixes. The CVE documentation does not say how fixes reach users, or
> whose job it is to get them into a vendor's kernel. Add a section that
> does, summarizing the answers given in those threads.
>
> Link: https://lore.kernel.org/all/2026110719-zipping-silliness-2443@gregkh/
> Link: https://lore.kernel.org/all/2026111052-spectator-legwarmer-4c1e@gregkh/
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
>  Documentation/process/cve.rst | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)

I've applied this, thanks.  Perhaps tweaks can yet be made to address
Thorsten's concerns.

jon
