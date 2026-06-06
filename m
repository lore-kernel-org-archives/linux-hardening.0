Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6017D78C9C;
	Sat,  6 Jun 2026 19:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780774591; cv=none; b=bLycfzTti6QQQ/DJU5MLBs1GqTa3QetIH057EtRLQsat3xOpuPfEq9TxbN7VGAav+dZDXhTQvmfmVRPvl5YFHPZRQyR8EJOgXkJnEdaG9B9oFA++/F1IPAQiBB/1iPWWe6fZ9UE85mZGmxcUCOHlfpJ222FyN0Yb0cYUkyr53Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780774591; c=relaxed/simple;
	bh=7fbbCNfM8QB0F2+KJw49ucJeet+q95TfB3QJq47jJao=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X9tjWlgTsjnMrkgaDgyq2Q531qyKBSBJgcPcPOhwLDz1U1fi8D3dfZuFlUuIC+82d2WmpdjUb6B9/MrM1z9G0ZrUn3C6n27W//JH+7D9BWcpUycQhOeW8QK9vSkX8uiF4x7+RNaWuqzpMhQkZjQyUpyWirCMS97ROdT5QQpGFvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=qDIoFcav; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="qDIoFcav"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 9103240E33
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1780774583; bh=7fbbCNfM8QB0F2+KJw49ucJeet+q95TfB3QJq47jJao=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=qDIoFcavkomeO718/o6FLB4OChv9WwAgx7i7tBWbQ6MmmpQ9fXCbo/2qI4LRIAI3P
	 ATLQlrx2OFpFC3oKaXSfF/hsU4UchJSfbCdSgPBJDzwm+auIIvdFsSXc6ISj6Ao3M2
	 CiYpizcz20MSSt9r5J5LuDP/sevLvZOHUkR1sZDIqGNdzQeUIClBr2cPjeXMEWrfiG
	 BZIK0mHS7+TW0HaFLCuvyNiN9eCa/SJXaaVrpdl8KuiG2b1fdFo8r4R0FmOz8FGElQ
	 zC9G31y4thvT6ptNpIfyp8mgtC58TnCjJ2VrANZd+0avTLB2po8k9Iw4Ndin7hZ9nG
	 s+/uUePPlOZ7w==
Received: from localhost (unknown [IPv6:2601:280:4600:27b:67c:16ff:fe81:5f9b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 9103240E33;
	Sat,  6 Jun 2026 19:36:23 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mohammed EL Kadiri <med08elkadiri@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka
 <vbabka@suse.cz>, David Hildenbrand <david@redhat.com>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, Kees Cook <kees@kernel.org>,
 linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs/mm: document slab cache isolation with SLAB_NO_MERGE
In-Reply-To: <20260606174412.4843-1-med08elkadiri@gmail.com>
References: <20260606155856.15548-1-med08elkadiri@gmail.com>
 <874ijfvec2.fsf@trenco.lwn.net>
 <20260606174412.4843-1-med08elkadiri@gmail.com>
Date: Sat, 06 Jun 2026 13:36:22 -0600
Message-ID: <87v7bvtqa1.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mohammed EL Kadiri <med08elkadiri@gmail.com> writes:

> Hi Jonathan,
>
> Thank you for the review.
>
> Yes, I used AI assistance in writing this document.

Please see Documentation/process/coding-assistants.rst for information
on how to document that use.

I would also consider starting to fill out Documentation/mm/slab.rst
rather than creating a new standalone file.

Thanks,

jon
