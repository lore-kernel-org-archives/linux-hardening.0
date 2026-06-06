Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2902E2DECDE;
	Sat,  6 Jun 2026 16:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780762288; cv=none; b=sg1Jg+sigccLJq+oRetqsqxooHMW6XFQjH+Fqk/pyT3iKhgm3IgHqYYkBF70FgyuU1Cp1QyjG9zC369slsd7Je9S/g0Ofl8KlXD6EZKpFePEyp6zcI2HolFWMfGrpfuOuFpa1g+W4bAZQPSimqw6+ZU0XrYZA19qt4Z84YrWN1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780762288; c=relaxed/simple;
	bh=mb1PpEG8RYFB4Ga6Mdj4igPZk2VoQ3jfb68mA/FlnKw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GWRE3W5re6BC9hmHIUyeXsHhCa+RqzcTXvQMDWC8j+1UFJCE5ctalvRrl/A0WAPyWYT6I3KvRXxvXN43j2OIpkAsEhxniXIAmIb+zzDSPkzpiq3coZqWxYzSnpHQhDpBj3e3KKVCWqeNLlphi4qSiJMy4wXQdDtWpUZA6HanGNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=Zdl3qL0m; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Zdl3qL0m"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 4EBC040E33
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1780762286; bh=DqGXeDqpKIvvW3QQbyRaGwc6KekIm0MprRWgRPkr2tU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Zdl3qL0mTPsA6dWXrgZkxtue29RQ67FMWdoCbH7C1EURLFFPmbcbJZu3qW9J1lYYO
	 xPfdGc3JATslC7hfgaVGhOLRgNZEtQxW/kfDlAWKh2f1wfxYzbHnb/pJZYxcsvDFGA
	 9p8smW9WhagTrBFUl12X65Fq4Rwwz/K5X6xpJcJMHY0+uMNE6qZqKsCYgHV4Aodc9d
	 /JzuvNwAWkaobPXh4Qodlx0Yg7qhPqq0/Ob+yBMnECyWV/hbgToKIy/oIpeJUJjw2i
	 2Hgt/qtdbF95eGHxShpp//CGCUHOR1WOBvcT9u2FfLDo9jVlFnMLnO4bRI8513W69L
	 HNABuMEWjFvTQ==
Received: from localhost (unknown [IPv6:2601:280:4600:27b:67c:16ff:fe81:5f9b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 4EBC040E33;
	Sat,  6 Jun 2026 16:11:26 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mohammed EL Kadiri <med08elkadiri@gmail.com>, Andrew Morton
 <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>
Cc: David Hildenbrand <david@redhat.com>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, Kees Cook <kees@kernel.org>,
 linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, Mohammed EL
 Kadiri <med08elkadiri@gmail.com>
Subject: Re: [PATCH] docs/mm: document slab cache isolation with SLAB_NO_MERGE
In-Reply-To: <20260606155856.15548-1-med08elkadiri@gmail.com>
References: <20260606155856.15548-1-med08elkadiri@gmail.com>
Date: Sat, 06 Jun 2026 10:11:25 -0600
Message-ID: <874ijfvec2.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mohammed EL Kadiri <med08elkadiri@gmail.com> writes:

> Add documentation explaining when and how to use SLAB_NO_MERGE to
> protect security-critical slab caches from cross-cache heap
> exploitation.
>
> The document covers:
> - Criteria for identifying caches that need isolation
> - How the SLUB merge mechanism works and what prevents merging
> - How to verify merge status on a running system
> - The cross-cache attack class with CVE reference
> - Tradeoffs (memory cost vs security benefit)
> - Relationship to CONFIG_RANDOM_KMALLOC_CACHES, SLAB_TYPESAFE_BY_RCU,
>   and the slab_nomerge boot parameter
>
> This information was previously undocumented, requiring developers to
> read mm/slab_common.c to understand when SLAB_NO_MERGE is appropriate.
>
> Signed-off-by: Mohammed EL Kadiri <med08elkadiri@gmail.com>
> ---
>  Documentation/mm/index.rst          |   1 +
>  Documentation/mm/slab-isolation.rst | 113 ++++++++++++++++++++++++++++
>  2 files changed, 114 insertions(+)
>  create mode 100644 Documentation/mm/slab-isolation.rst

Thank you for working to improve our documentation.

Did you write this with machine assistance?

Please review our documentation and adhere to our markup conventions.
For example, function names should just be function(), with no
additional markup.

Thanks,

jon
