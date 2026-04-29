Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A55377EDA
	for <linux-hardening@vger.kernel.org>; Wed, 29 Apr 2026 16:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777478719; cv=none; b=ln0bwQYgKEU7/crU0iD7cxO1gouAvgxc24xEhVilU7ZjPHJ17NXRQZ0xLDESkk6YSBjH4uDU8sll7s25DQHmJbJzI6R4u2/Mii8UICqH6qPISxsJstdz4ZcRN8xLV9ILAwXR/Vhd47ljI3xMbFnVHYMwM33LMLjb/c8hjWtrL/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777478719; c=relaxed/simple;
	bh=NcH5K6pu7SVh99cXcMKcTnSb/yy/ZuzgMN5crCu5LkE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LjbgL1f2wdoBM+2IULuIWaw6zMwkEfIiOWBKf8YgcUHRqlEMIy/TMwLk+rfhE6+qLAfiVkX35SHgeU0b4rnQObTO7RdAHGSUfdguwwmDhkSsHgjA+ZB8PcxwGTY9nu4aBxIbKdIXJVOQbnXop8JaM8wjkA0RLZ69NIaHy0+29+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=IeSI53bM; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="IeSI53bM"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4g5MZy5D4Bz9tn4;
	Wed, 29 Apr 2026 18:05:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1777478714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EBEyBa7Rph51aBo1JjddMSs3BFPbJQoH8pdrtEkDmzw=;
	b=IeSI53bMf7UWhWLp7hjI0kjSd6OaZw6ahRuuKpMgPpv03+eWRi+QA8mjNcvrbjOk7S+ADa
	1Lu+Vvm4BPI5U7ztma0W6sFzDWTpN7bVRp+AwGFEZIStrHToKJlnLB8EFwFjBdmAzuQu48
	OHlHKoKsWPvo15s1VL50JQmaBrbhoRvO6jkOTSr6XP4DBFwowa3P1IWLSsTiRC1Q8eqtWj
	Fi2QKLMNlF3b+Pq/q0dTVmBMaoFmZQ7P66rYrzeIUn7o9L7LvHnuOFb6GZOC4rfnqTBjCd
	OjwWTd+JilnYRyjBAr3b/lg/0Q8NeCSF8U/CrOKv8WgQirJC5lItsICyI14OEA==
Message-ID: <69f83cbd-8883-4ead-b570-4520379b86e4@mailbox.org>
Date: Wed, 29 Apr 2026 18:05:06 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: iov_kunit_copy_to_kvec: ASSERTION FAILED at
 lib/tests/kunit_iov_iter.c:63, Expected got == npages, but, got == 1 (0x1),
 npages == 256 (0x100) (v7.0.2, ppc)
To: LEROY Christophe <christophe.leroy2@cs-soprasteria.com>,
 "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
 Kees Cook <kees@kernel.org>, David Howells <dhowells@redhat.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
References: <2708666d-68f8-4cd3-9b25-f14ceeba3a1f@mailbox.org>
 <d8cbbe3b-7eb0-43c4-ada7-0730f7c05f69@cs-soprasteria.com>
Content-Language: en-US, de-DE
From: Erhard Furtner <erhard_f@mailbox.org>
In-Reply-To: <d8cbbe3b-7eb0-43c4-ada7-0730f7c05f69@cs-soprasteria.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: c64d262b5b61b60f041
X-MBO-RS-META: bxhznyrzqwkwj7pbb5n84a5p5sm6zsxr

> This happens in alloc_pages_bulk_noprof(), due to
> 
> 	pcp = pcp_spin_trylock(zone->per_cpu_pageset);
> 	if (!pcp)
> 		goto failed;
> 
> Because:
> 
> #ifdef CONFIG_SMP
> [...]
> /*
>    * On CONFIG_SMP=n the UP implementation of spin_trylock() never fails
> and thus
>    * is not compatible with our locking scheme. However we do not need
> pcp for
>    * scalability in the first place, so just make all the trylocks fail
> and take
>    * the slow path unconditionally.
>    */
> #else
> #define pcp_spin_trylock(ptr)		\
> 		NULL
> 
> 
> So apparently it is expected that alloc_pages_bulk() returns 1 on non-SMP.
> 
> Christophe

I got SMP set as my G4 DP got 2 x 7450 cpus.

I can attach full kernel .config when I return on Saturday.

Regards,
Erhard
