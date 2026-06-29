Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F7640D585;
	Mon, 29 Jun 2026 02:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782699977; cv=none; b=CdqljtuuAtEkDaDj3HvByUNqZQl7vP6/dW3Iv9CtB6/M2txS+rQbutD0fg3vcx8PL6dZWfWghske1nIF6vLP1z5lq9nyhIOGuEg5J8D9IyNs77pohHwt8ZMcV4vt1s21GVmIdfzLLRP467Wgqm78CSHxg19aSxSe8+1TKBUPcSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782699977; c=relaxed/simple;
	bh=XhgsQytKZ8LjENTZvqWldZQUOZQCsU2oN7N0G7EvCcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h928y1IoL6wi0rRoMxuokdhGKotpFsYybagY3f/DqoAq5i1mgVouK6OMg5hnKQs9ax3lLO4RAts9jf3TI0zy6KdNA1EBoifdWnx4Zh2eYcsdINR9UOBjS+FCmKYt3sH0WQpGlJTisTmV132UeN9QNPihpOycWhkPURzFuLwkdGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=QYiS6laJ; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="QYiS6laJ"
Received: from [IPV6:2601:646:8081:7da1:29ce:814c:118a:de3f] ([IPv6:2601:646:8081:7da1:29ce:814c:118a:de3f])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 65T29gd13309161
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sun, 28 Jun 2026 19:09:42 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 65T29gd13309161
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026052701; t=1782698984;
	bh=kv5dJD+a62Qg64IepgQhkySKSNHhTKfnqhs3Kx+EjjY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QYiS6laJ6bh/Gvvs2qYuXGqIhK5K9kUoaFspoLYFcbNE+I3wVgLg0vVOi9+DzeH3R
	 rO6O6esbn1KCXDDCOf1UVuLiuRjgSlPruj8f5GOLxwHNgb94YMVOSY+A43KGT3FHwH
	 cvVJhSIQmX6mRDi8juy2LqQCpg0D2Ym71EPwKPF6mqxXlNX3XabiNy4QgRlztRA3Gg
	 NMGIfHAan3qEU3IrfeTVpNLTtbVGYRZBrII61mq4WZ3HNLDMgUAYSreMCFSbo3DpQM
	 59rflZB0TxyCuDmB1Qgqk/M+5uI7b6f88Vg5Mcs3dsnxHckFCn80Nj3aFsnttj/nLE
	 A0B4I8tYzE/SQ==
Message-ID: <499a4e15-34a4-421b-946a-c855199fdbf9@zytor.com>
Date: Sun, 28 Jun 2026 19:09:37 -0700
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/vmalloc: widen guard region to defeat ENTER-based
 stack pivot
To: Xiang Mei <xmei5@asu.edu>, Pedro Falcato <pfalcato@suse.de>
Cc: Kees Cook <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-hardening@vger.kernel.org, Uladzislau Rezki <urezki@gmail.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jennifer Miller <jmill@asu.edu>,
        Tiffany Bao <tbao@asu.edu>, Ruoyu Wang <fishw@asu.edu>,
        Adam Doupe <doupe@asu.edu>, Kyle Zeng <zengyhkyle@asu.edu>,
        Yan Shoshitaishvili <yans@asu.edu>
References: <20260626173444.2252041-1-xmei5@asu.edu>
 <aj7UNceukU9zYeGH@pedro-suse.lan>
 <CAPpSM+RVFDOYJFT2iwgNYdjbwqF-MmrbYizpLYksd1SLb5bT9g@mail.gmail.com>
Content-Language: en-US, sv-SE
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <CAPpSM+RVFDOYJFT2iwgNYdjbwqF-MmrbYizpLYksd1SLb5bT9g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026-06-26 13:05, Xiang Mei wrote:
> 
> Thanks for your questions and attention.
> 
> 1) `enter` can do big enough stack pivoting (where we can't find many
> `add/sub/adc/sbb rsp, ` doing so)

Say what?

Using add/sub/lea on %rsp is probably more common than enter, because enter is
considered kind of slow.

gcc, I believe, will generate "leave" but not "enter" as a result.


> 2) `enter` is not rare since we can take part in the instruction.

This sentence doesn't parse.

	-hpa

