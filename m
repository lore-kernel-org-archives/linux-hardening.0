Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39FA2C0274;
	Fri, 10 Apr 2026 21:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775855133; cv=none; b=fwKiZV9KdeC+UtqUoCsh0U8afH3DMUuVhzTugmxhi0JVhPC0wA9PLWoay8IFRII5h45kRSnwdoYfBx4soWS+lsSuI2LKapc3mK/FMCzNBS/wZElH4J3NYaX7gSssEuYAhfAz3fIXhBoySHDsmeQfgE46J5JtlT4xqFYGDEACIUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775855133; c=relaxed/simple;
	bh=aTY7HaAHJNoUfzoVRn+4fGYAVoD0UvSzgWr/MMffVdc=;
	h=Message-ID:Date:MIME-Version:Subject:Cc:References:From:
	 In-Reply-To:Content-Type; b=jL9tviXVhbs2tpFmJC6toHgb1MPXfqWWCNI/Afn5VxmulEdSpNAluckD77hv7ACD3UzR9WHlGWWpA16Ij4Rlg2k2fs48N+k1miUzmaVAlQMUunhUee5p+Jck4BdGDb5Sr7NPmkPK61D/W9xfa+nDADxvEU8EgZiNiedz4l+sRyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=O6X54eDN; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="O6X54eDN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=mFsw0Lkelz3AIkc/JWZQd+vTGfwLTaELzd9XWzqURW4=; b=O6X54eDNYkkQ9xrIVkGtMkfKBH
	rsxFkXWGwHx3VHVX/52gQxXCyVXPek2E4cLir9Kx/qGlxHY6i9swO9RtwNeeGwtfnQqmVXrsaKBZz
	Z1V5aD/A5MCupsDS9wD7II2CUNlEaUO5fnCWzbBjnz/u33T0YIBz2ImyvSud+DOgEd8Das1FyKD3C
	K3Vp6m13znJpaESOM8xJw0ilI2+9P1yOIIaP2qL52Kk67StDseZ8puHHwX2iwbuK97I8TwAupU/Gk
	BN37XPn04mHIwwHH9uDDVCebidNtHAbO5m0a8ET1A1gagjXOXbvTBtK1VU5fmltsFMz5iDvtGjzIv
	11fVEkAw==;
Received: from [177.189.74.94] (helo=[192.168.1.54])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1wBJ2e-00EYxS-RR; Fri, 10 Apr 2026 23:05:29 +0200
Message-ID: <bba97897-4afb-0049-b054-9ed7b0fed2ac@igalia.com>
Date: Fri, 10 Apr 2026 18:05:25 -0300
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH V2] pstore/ftrace: Factor KASLR offset in the core kernel
 instruction addresses
Content-Language: en-US
Cc: linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>,
 linux-kernel@vger.kernel.org, tony.luck@intel.com, kernel-dev@igalia.com,
 kernel@gpiccoli.net, Steven Rostedt <rostedt@goodmis.org>
References: <20260409153830.2560633-1-gpiccoli@igalia.com>
 <177575155448.470733.612810320980206517.b4-ty@kernel.org>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <177575155448.470733.612810320980206517.b4-ty@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/04/2026 13:19, Kees Cook wrote:
> On Thu, 09 Apr 2026 12:12:29 -0300, Guilherme G. Piccoli wrote:
>> The pstore ftrace frontend works by purely collecting the
>> instruction address, saving it on the persistent area through
>> the backend and when the log is read, on next boot for example,
>> the address is then resolved by using the regular printk symbol
>> lookup (%pS for example).
>>
>> Problem: if we are running a relocatable kernel with KASLR enabled,
>> this is a recipe for failure in the symbol resolution on next boots,
>> since the addresses are offset'ed by the KASLR address. So, naturally
>> the way to go is factor the KASLR address out of instruction address
>> collection, and adding the fresh offset when resolving the symbol
>> on future boots.
>>
>> [...]
> 
> Applied to for-next/pstore, thanks!
> 
> [1/1] pstore/ftrace: Factor KASLR offset in the core kernel instruction addresses
>       https://git.kernel.org/kees/c/187e3865f298
> 
> Take care,
> 

Closing the loop: due to a problem reported by the kernel robot in the
V1, patch was removed from the for-next/pstore tree;

V3 here:
https://lore.kernel.org/r/20260410205848.2607169-1-gpiccoli@igalia.com/

Thanks,


Guilherme
