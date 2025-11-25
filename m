Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D40318152
	for <linux-hardening@vger.kernel.org>; Tue, 25 Nov 2025 18:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764094018; cv=none; b=NwfCZiWpRvKoDU3/sY4xA9TqW/Sm8A/ZPfQmzf2wh53KmbJ3SRy8uqdagHu5yIirG2Ff9wSmXT4uied9Zlz140fbqp3xt2D4Yf6YOIw2YZHCaYk/5i98o0Y7hKEXd3Kk3veSWFE7BjFrquswkQl43AyNFyD+xpuBP5h962rXAcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764094018; c=relaxed/simple;
	bh=Wx/lSd0yU4CbJNiqGtmjdqvBSmBhckOpTpMpfQcb/zI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LXjvb1UEQsfFxBGLVKQKxyVNMmYYk+q6J0uBQpr985dQK58KgEqylWStNETO4OCj8Qvuvfp29ZIBITPNMs+FI+uwAG2majc4YZiI3lp7KpuM/Dgp2X6/4q5WxpgeU73F4ZUEZoDutWhHz/9+v6oj6B4cvdLj1MdpGwJYHZBPh0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=X/ZMQ81b; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Pl1175js; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=X/ZMQ81b; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Pl1175js; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="X/ZMQ81b";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Pl1175js";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="X/ZMQ81b";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Pl1175js"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7260E5BD12;
	Tue, 25 Nov 2025 18:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764094014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=PoBMvtRuyPn1L+lx0oRz613sdrYJSSZTiHXSKjwJ2ec=;
	b=X/ZMQ81bPp5YhNOurMGqN/N0QlLxCJrRYlRLfQbib3RsTTmFrv36HNtaJ3OVH1aAuE19A6
	Z9ji4892mWP/7j5bFtWq/56pfcJFxitvL+GXG1VJLQMsLMPeuQl+YJgQL7LcBaAhJTFH6M
	4dDZ7Y7cO8Aeuck7VTGFi+jN/Uoy5ZU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764094014;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=PoBMvtRuyPn1L+lx0oRz613sdrYJSSZTiHXSKjwJ2ec=;
	b=Pl1175jsbytc3e/eiXZdFdZQpmmwJMppWaaL68/X/K+eCTiXD9hEwT7PlgsK/jDsxZRihy
	HHq0oPqjI5EuH6Ag==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764094014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=PoBMvtRuyPn1L+lx0oRz613sdrYJSSZTiHXSKjwJ2ec=;
	b=X/ZMQ81bPp5YhNOurMGqN/N0QlLxCJrRYlRLfQbib3RsTTmFrv36HNtaJ3OVH1aAuE19A6
	Z9ji4892mWP/7j5bFtWq/56pfcJFxitvL+GXG1VJLQMsLMPeuQl+YJgQL7LcBaAhJTFH6M
	4dDZ7Y7cO8Aeuck7VTGFi+jN/Uoy5ZU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764094014;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=PoBMvtRuyPn1L+lx0oRz613sdrYJSSZTiHXSKjwJ2ec=;
	b=Pl1175jsbytc3e/eiXZdFdZQpmmwJMppWaaL68/X/K+eCTiXD9hEwT7PlgsK/jDsxZRihy
	HHq0oPqjI5EuH6Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5D9F33EA63;
	Tue, 25 Nov 2025 18:06:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Or8kFT7wJWnFPQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 25 Nov 2025 18:06:54 +0000
Message-ID: <5d0c582f-7e1a-4623-90d9-1dd6db443473@suse.cz>
Date: Tue, 25 Nov 2025 19:06:53 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] mm/mm_init: decouple page checking and
 init_on_{alloc, free}
Content-Language: en-US
To: Michal Hocko <mhocko@suse.com>, Joshua Hahn <joshua.hahnjy@gmail.com>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport
 <rppt@kernel.org>, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kernel-team@meta.com
References: <20251124225408.2243564-1-joshua.hahnjy@gmail.com>
 <20251124225408.2243564-2-joshua.hahnjy@gmail.com>
 <aSVssg5c8mNvyLou@tiehlicka>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 xsFNBFZdmxYBEADsw/SiUSjB0dM+vSh95UkgcHjzEVBlby/Fg+g42O7LAEkCYXi/vvq31JTB
 KxRWDHX0R2tgpFDXHnzZcQywawu8eSq0LxzxFNYMvtB7sV1pxYwej2qx9B75qW2plBs+7+YB
 87tMFA+u+L4Z5xAzIimfLD5EKC56kJ1CsXlM8S/LHcmdD9Ctkn3trYDNnat0eoAcfPIP2OZ+
 9oe9IF/R28zmh0ifLXyJQQz5ofdj4bPf8ecEW0rhcqHfTD8k4yK0xxt3xW+6Exqp9n9bydiy
 tcSAw/TahjW6yrA+6JhSBv1v2tIm+itQc073zjSX8OFL51qQVzRFr7H2UQG33lw2QrvHRXqD
 Ot7ViKam7v0Ho9wEWiQOOZlHItOOXFphWb2yq3nzrKe45oWoSgkxKb97MVsQ+q2SYjJRBBH4
 8qKhphADYxkIP6yut/eaj9ImvRUZZRi0DTc8xfnvHGTjKbJzC2xpFcY0DQbZzuwsIZ8OPJCc
 LM4S7mT25NE5kUTG/TKQCk922vRdGVMoLA7dIQrgXnRXtyT61sg8PG4wcfOnuWf8577aXP1x
 6mzw3/jh3F+oSBHb/GcLC7mvWreJifUL2gEdssGfXhGWBo6zLS3qhgtwjay0Jl+kza1lo+Cv
 BB2T79D4WGdDuVa4eOrQ02TxqGN7G0Biz5ZLRSFzQSQwLn8fbwARAQABzSBWbGFzdGltaWwg
 QmFia2EgPHZiYWJrYUBzdXNlLmN6PsLBlAQTAQoAPgIbAwULCQgHAwUVCgkICwUWAgMBAAIe
 AQIXgBYhBKlA1DSZLC6OmRA9UCJPp+fMgqZkBQJnyBr8BQka0IFQAAoJECJPp+fMgqZkqmMQ
 AIbGN95ptUMUvo6aAdhxaOCHXp1DfIBuIOK/zpx8ylY4pOwu3GRe4dQ8u4XS9gaZ96Gj4bC+
 jwWcSmn+TjtKW3rH1dRKopvC07tSJIGGVyw7ieV/5cbFffA8NL0ILowzVg8w1ipnz1VTkWDr
 2zcfslxJsJ6vhXw5/npcY0ldeC1E8f6UUoa4eyoskd70vO0wOAoGd02ZkJoox3F5ODM0kjHu
 Y97VLOa3GG66lh+ZEelVZEujHfKceCw9G3PMvEzyLFbXvSOigZQMdKzQ8D/OChwqig8wFBmV
 QCPS4yDdmZP3oeDHRjJ9jvMUKoYODiNKsl2F+xXwyRM2qoKRqFlhCn4usVd1+wmv9iLV8nPs
 2Db1ZIa49fJet3Sk3PN4bV1rAPuWvtbuTBN39Q/6MgkLTYHb84HyFKw14Rqe5YorrBLbF3rl
 M51Dpf6Egu1yTJDHCTEwePWug4XI11FT8lK0LNnHNpbhTCYRjX73iWOnFraJNcURld1jL1nV
 r/LRD+/e2gNtSTPK0Qkon6HcOBZnxRoqtazTU6YQRmGlT0v+rukj/cn5sToYibWLn+RoV1CE
 Qj6tApOiHBkpEsCzHGu+iDQ1WT0Idtdynst738f/uCeCMkdRu4WMZjteQaqvARFwCy3P/jpK
 uvzMtves5HvZw33ZwOtMCgbpce00DaET4y/UzsBNBFsZNTUBCACfQfpSsWJZyi+SHoRdVyX5
 J6rI7okc4+b571a7RXD5UhS9dlVRVVAtrU9ANSLqPTQKGVxHrqD39XSw8hxK61pw8p90pg4G
 /N3iuWEvyt+t0SxDDkClnGsDyRhlUyEWYFEoBrrCizbmahOUwqkJbNMfzj5Y7n7OIJOxNRkB
 IBOjPdF26dMP69BwePQao1M8Acrrex9sAHYjQGyVmReRjVEtv9iG4DoTsnIR3amKVk6si4Ea
 X/mrapJqSCcBUVYUFH8M7bsm4CSxier5ofy8jTEa/CfvkqpKThTMCQPNZKY7hke5qEq1CBk2
 wxhX48ZrJEFf1v3NuV3OimgsF2odzieNABEBAAHCwXwEGAEKACYCGwwWIQSpQNQ0mSwujpkQ
 PVAiT6fnzIKmZAUCZ8gcVAUJFhTonwAKCRAiT6fnzIKmZLY8D/9uo3Ut9yi2YCuASWxr7QQZ
 lJCViArjymbxYB5NdOeC50/0gnhK4pgdHlE2MdwF6o34x7TPFGpjNFvycZqccSQPJ/gibwNA
 zx3q9vJT4Vw+YbiyS53iSBLXMweeVV1Jd9IjAoL+EqB0cbxoFXvnjkvP1foiiF5r73jCd4PR
 rD+GoX5BZ7AZmFYmuJYBm28STM2NA6LhT0X+2su16f/HtummENKcMwom0hNu3MBNPUOrujtW
 khQrWcJNAAsy4yMoJ2Lw51T/5X5Hc7jQ9da9fyqu+phqlVtn70qpPvgWy4HRhr25fCAEXZDp
 xG4RNmTm+pqorHOqhBkI7wA7P/nyPo7ZEc3L+ZkQ37u0nlOyrjbNUniPGxPxv1imVq8IyycG
 AN5FaFxtiELK22gvudghLJaDiRBhn8/AhXc642/Z/yIpizE2xG4KU4AXzb6C+o7LX/WmmsWP
 Ly6jamSg6tvrdo4/e87lUedEqCtrp2o1xpn5zongf6cQkaLZKQcBQnPmgHO5OG8+50u88D9I
 rywqgzTUhHFKKF6/9L/lYtrNcHU8Z6Y4Ju/MLUiNYkmtrGIMnkjKCiRqlRrZE/v5YFHbayRD
 dJKXobXTtCBYpLJM4ZYRpGZXne/FAtWNe4KbNJJqxMvrTOrnIatPj8NhBVI0RSJRsbilh6TE
 m6M14QORSWTLRg==
In-Reply-To: <aSVssg5c8mNvyLou@tiehlicka>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[suse.com,gmail.com,kernel.org,vger.kernel.org];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

On 11/25/25 09:45, Michal Hocko wrote:
> On Mon 24-11-25 14:54:07, Joshua Hahn wrote:
>> init_on_alloc and init_on_free protect the kernel by initializing
>> allocated and freed pages to 0 on allocation time / deletion.
>> Commit 700d2e9a36b93601270c1e15550acde2521386c5 ("mm, page_alloc: reduce
>> page alloc/free sanity checks") removed page checking from hot pcp
>> drain and refill paths, and instead coupled it with CONFIG_DEBUG_VM,
>> debug_pagealloc, page poisoning, and init_on_{alloc, free}.
>> 
>> As the commit suggests, the first three turn the kernel into a debug
>> kernel, while the last hardens the kernel against leaking sensitive memory.
>> While enabling page checking is relatively low-cost and tying it
>> together with page initialization is not unreasonable, it does feel like
>> a bit of a side-effect, rather than an obvious consequence.
>> 
>> With page checking now pulled out as a boot time parameter that can be
>> set independently, let's decouple page checking and init_on_alloc and
>> init_on_free.
>> 
>> As a direct side effect, systems that have init_on_alloc or init_on_free
>> will no longer have page checking enabled by default; they will either
>> have to pass the check_pages boot parameter, build the kernel with
>> CONFIG_DEBUG_VM, or enable debug_pagealloc / page poisoning.
> 
> How come this will not break existing users? What is an actual upside to
> get for the risk involved?

+Cc hardening people for input if they are fine with the decoupling and if
docs for hardening recommendations or something similar needs updating

The upside is mainly reducing the side effects i.e. being more explicit than
implicit. In practice I'd however assume people running init_on_alloc/free
and paying the cost also want to do page flags checking anyway. The more
important patch here is 1/2.

