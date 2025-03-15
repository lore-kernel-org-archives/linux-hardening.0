Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEC7204085;
	Sat, 15 Mar 2025 18:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742061830; cv=none; b=Sm2/ZtA4oQfRfc/nHcJ1r0tnXktvvrNHVpXQxsXIZEsAdXSRwdSFhtAkJJbJHjnn0858GAMfIqMYomoyr6a09vgi7cVcFS9IJOac7LHxueqytcAmp7cM6RJQ+QsdrII7UYNrPec82CpweYhDIrD6L6d6fekuTUY8YLsJLGcUeKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742061830; c=relaxed/simple;
	bh=+Y44pJkK2drE1ZjpcjI0oXLOIywGAfeMnU9+my8wLzU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SrZbDl7oMV+quBLE+pOJHFJuFJZ5XdsCmvCHV/K/34iRw2M2ZwK+4jO2tHQViNGkxktT/f74ewjh9PkBj/F4NfEETHlKoi9Imfwy7scMoy6Sk41fo3ZIMm6jm0m7yTMcHHmzHXUZzL1Bdlba0F8NA2qBi6dJtmz9/TVRtyu3kRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pOvvnAfv; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pOvvnAfv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=TxcYWvWfTpFytX2D5Aa/xv5rAouDt22VcPR3LokvoEw=; b=pOvvnAfvZ7o61cTyL4/lUajVig
	9YiQVI4OybWgNI5DYghOhAKjcN6VInSb+GgUAfY3a4e4c2kD/lCDg1tqroTn8KKftmYcnNRcUjS6Q
	5wkiyNJHELVsy9EDSUSJePFsyZCYBJqPjs8fHAm13PY9/Q+tuAGqMvwTtDKjdtI3kX5Jg0pd+4+x+
	FDTlCX2XXmLVo12aJuWxHXhSEdJR59hC5wn+aEOLQN70li/VQuhSYzF7U0t5D3rQ3K0sBSrvvdPMO
	RZAgzcBVAHep/5DORO2meRd3PiTyxg6g/CDIpD0jZ/1wT92ImW/ooHNUXdQDENm1r3fYbrU0S6iGa
	VzYUNgJQ==;
Received: from [50.53.2.24] (helo=[192.168.254.17])
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1ttVq1-000000044np-2gfS;
	Sat, 15 Mar 2025 18:02:45 +0000
Message-ID: <04ea2c10-39c5-46ad-a4f9-e5dc98c77eff@infradead.org>
Date: Sat, 15 Mar 2025 11:02:12 -0700
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] slab: Introduce kmalloc_obj() and family
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 Kees Cook <kees@kernel.org>, Vlastimil Babka <vbabka@suse.cz>
Cc: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>,
 "Gustavo A . R . Silva" <gustavoars@kernel.org>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Jann Horn <jannh@google.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Marco Elver <elver@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>, linux-mm@kvack.org,
 Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Jakub Kicinski <kuba@kernel.org>,
 Yafang Shao <laoar.shao@gmail.com>, Tony Ambardar <tony.ambardar@gmail.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Jan Hendrik Farr <kernel@jfarr.cc>, Alexander Potapenko <glider@google.com>,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 linux-doc@vger.kernel.org, llvm@lists.linux.dev
References: <20250315025852.it.568-kees@kernel.org>
 <20250315031550.473587-2-kees@kernel.org>
 <17076519-33fd-4fac-a718-784b9597c9e6@embeddedor.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <17076519-33fd-4fac-a718-784b9597c9e6@embeddedor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 3/14/25 10:18 PM, Gustavo A. R. Silva wrote:
> 
>> These each return the assigned value of ptr (which may be NULL on
>> failure). For cases where the total size of the allocation is needed,
>> the kmalloc_obj_sz(), kmalloc_objs_sz(), and kmalloc_flex_sz() family
>> of macros can be used. For example:
>>
>>     info->size = struct_size(ptr, flex_member, count);
>>     ptr = kmalloc(info->size, gfp);
>>
>> becomes:
>>
>>     kmalloc_flex_sz(ptr, flex_member, count, gfp, &info->size);
> 
> I wonder if it'd be better to keep the gfp flags as the last argument
> for all these `*_sz()` cases:

That was my reaction when I reviewed the patch also. [I just didn't express it.]

> 
>     kmalloc_flex_sz(ptr, flex_member, count, &info->size, gpf);
> 
> Probably, even for __alloc_objs()


-- 
~Randy

