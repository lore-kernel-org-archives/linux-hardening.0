Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB2F2264A7;
	Sat, 28 Mar 2026 21:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774734465; cv=none; b=UpJlKWAVzCOGhXLIVSWnDeca3oaU26602rok+TV9ph7XzORXmgnGHJk/C0HfuxzWFJc9ePApKLU923C1uAZl3hJ+x7E58IdpXTSL65l/txciE3S5mNKyZ5j/YQq5ZiEGj3SMUT1bGhp4kSg1vfEgIfbonK4SsG7cxmAQWz3tmRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774734465; c=relaxed/simple;
	bh=O+XIcTn2/dfvtEMvpJRdQ7ehCWE7UipeXD0TLdr109c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n7sOFZzWjiX9vOfLU7lxyFEfqLikdFbD44oCwMybkkLwPiBVk/Us+95P7Xkpl8IAPKPs63IfGh5GJJrB7w1x2KI/mUzNj1whOyTUpILTTXdiO17UHf8QnHwKMRw6pjtdzEleWd9LmMJ1NXMD2yvyq4VKzycXBGB1S5uCk6MYh5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=WbxECUUh; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="WbxECUUh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=LJ0U52fV+r3cZTVwkIgP6Ll/KicnrvAlY4fpvmQpM90=; b=WbxECUUh5bYH4CgNLA+Zn2jjb+
	+607iLQ8nt97hr+/GQXUkVlVmDtqcufe4pkNTlY6yZcj9XdFam6qLhM4Fw8pKqRqNBr7n/ESbUG1c
	Y/RpWM+gXVIY5WOBioaA06VMuUvyvQYsk1D/eBbzLow0B6GJa5Heh2vcTt0+u/6eUbaKjJC0AlrgR
	wQm4putuUGfFJEXsDdJUDkmCxDjaFCz4ipXC38DpC55+aen1fZJVYGRDkNj/9HtEaaj8PNtH7ls7r
	yUV5I13qp85kT9LwARRl8TtwlpZTjHKrXaR+IpBuomHPQbyiUuU4yrU4AFzUwuJPwLdAMC7fxvjwY
	CDkciuqw==;
Received: from [179.93.13.238] (helo=[192.168.1.54])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1w6bVD-007hwI-52; Sat, 28 Mar 2026 22:47:31 +0100
Message-ID: <deba7cb8-9cbe-0166-4c1a-843a3767b33e@igalia.com>
Date: Sat, 28 Mar 2026 18:47:27 -0300
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] pstore/ftrace: Factor KASLR offset in the core kernel
 instruction addresses
Content-Language: en-US
To: kees@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 tony.luck@intel.com, kernel-dev@igalia.com, kernel@gpiccoli.net,
 Steven Rostedt <rostedt@goodmis.org>
References: <20260313201010.1622406-3-gpiccoli@igalia.com>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20260313201010.1622406-3-gpiccoli@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/03/2026 17:00, Guilherme G. Piccoli wrote:
> The pstore ftrace frontend works by purely collecting the
> instruction address, saving it on the persistent area through
> the backend and when the log is read, on next boot for example,
> the address is then resolved by using the regular printk symbol
> lookup (%pS for example).
> 
> Problem: if we are running a relocatable kernel with KASLR enabled,
> this is a recipe for failure in the symbol resolution on next boots,
> since the addresses are offset'ed by the KASLR address. So, naturally
> the way to go is factor the KASLR address out of instruction address
> collection, and adding the fresh offset when resolving the symbol
> on future boots.
> 
> Problem #2: modules also have varying addresses that float based
> on module base address and potentially the module ordering in
> memory, meaning factoring KASLR offset for them is useless.
> So, let's hereby only take KASLR offset into account for core
> kernel addresses, leaving module ones as is.
> 
> And we have yet a 3rd complexity: not necessarily the check range
> for core kernel addresses holds true on future boots, since the
> module base address will vary. With that, the choice was to mark
> the addresses as being core vs module based on its MSB. And with
> that...
> 
> ...we have the 4th challenge here: for some "simple" architectures,
> the CPU number is saved bit-encoded on the instruction pointer, to
> allow bigger timestamps - this is set through the PSTORE_CPU_IN_IP
> define for such architectures. Hence, the approach here is to skip
> such architectures (at least in a first moment).
> 
> TL;DR: let's factor KASLR offsets on pstore/ftrace for core kernel
> addresses, leaving module addresses out and also leaving the
> architectures that define PSTORE_CPU_IN_IP.
> 
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> ---
> 
> 
> Hi folks, first of all thanks in advance for reviews and comments!
> 
> I was testing a pstore/ftrace patch the other day and noticed
> the lack of the KASLR support. But to my surprise, it was not
> as easy to fix up as I expected heh
> 
> Main reason is the obvious thing with modules: the way to
> go, I think, is to somehow save the module name (or some other
> id?) and the instruction offset inside such module, to then
> resolve that in next boot, when printing. But that would require
> more intrusive changes in the way pstore/ftrace saves the IP
> (which is quite simple now), leading to some potentially
> meaningful perf overhead.
> 
> Hence, I've decided to just mess with core kernel addresses
> so far, lemme know WDYT - should I somehow pursue fixing
> modules addr resolution as well? Or doesn't worth the changes?
> Any ideas on how to approach that? I noticed that currently,
> modules' symbols are sometimes resolved fine, sometimes they're
> bogus but point to the module at least (not some other random
> code), but eventually they are just nonsense addresses.
> 
> Regarding the choice of using the MSB to store if an addr is core
> kernel or module, well this was also a choice taking into account
> simplicity and performance, lemme know please if it's no good and
> any suggestions on how to better do it, I can easily re-implement!
> Thanks again,
> 
> Guilherme
> 

Hi Kees, gentle ping about this one - lemme know if you have suggestions
or questions, and thanks in advance =)


Guilherme

