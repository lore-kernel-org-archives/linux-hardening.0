Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA5F334374;
	Mon, 29 Jun 2026 12:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782737472; cv=none; b=A0v4Hz/4aUg1Vgd+7X/AN7uCmtCckVCGLuEcilwz7EAGxmvWPn8qtURuvnJ0lMH574Y+rM2nOqpcO3LzeqjSvUtBWSwlMRyeLE/uxgnZ6GVb9xAyY3cBccx+KZRq6pdvMxJ4/gp0D71WuhnVUOP8zma6dDeL5bpFrTCvblTJfxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782737472; c=relaxed/simple;
	bh=Sf2ujpg/Rw5tZYc9Z4kjo7IjiQSaj0etzo1ySbqjL8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dPgSXTlSz+AhogXzun7sGHFxVT/63OcW2gj0cdXYWuNdnxBUICf/wbFpOIehRB7Eupri+mBbc1bivONy+AMruBShd24rffT2LR0TFNgsEe/cCufdPp9iX/G1+7qJv6+qLasJeSgBSsHpcHdYjBzCkvM9qgqIyas8nhZ4/wcTBeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=Js7hPGLW; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Js7hPGLW"
Received: from [IPV6:2601:646:8081:7da1:4462:691a:e05c:b745] ([IPv6:2601:646:8081:7da1:4462:691a:e05c:b745])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 65TCoD8T244601
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 29 Jun 2026 05:50:14 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 65TCoD8T244601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026062701; t=1782737416;
	bh=fRdbBuAywd2/yTywAa2lmTsqxPePV+KffkY5n9Y48hM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Js7hPGLWS5LTsb/3bMqBHhoVGIEj0VMpjxMvYFT2YIS6f3nHXeLALfVUDkd+j1wkV
	 nWUug3QAfVgal8LCz0dJ+sOdkzS+uELoC3ObibQVmQU7Joi0u/rYGI9WpA1dIX8YcH
	 Q1Jn+GhyBywHcndGzVYJ+QZ6Zum7Q8wLdpRTMu/8V9g8voVNG41Q8Bjqf/WBLWDW2B
	 h2dbJ1kQ29c77xr5O7maE+enOLuuXL+5UXjMD/MaTsmmkcK25Gpk9a9sQw9lrss5ss
	 26PFDqL2qXOJRWI+K9ckx1oVcM3YMb4bPv63pNLC6YD30f9ItKquGx5Fmmc/vCeRII
	 C1hgFlSlEGFZQ==
Message-ID: <3c4094d8-ae5e-4ffd-b28a-0c10db50296c@zytor.com>
Date: Mon, 29 Jun 2026 05:50:08 -0700
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/vmalloc: widen guard region to defeat ENTER-based
 stack pivot
To: Matthew Wilcox <willy@infradead.org>
Cc: Xiang Mei <xmei5@asu.edu>, Pedro Falcato <pfalcato@suse.de>,
        Kees Cook <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
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
 <499a4e15-34a4-421b-946a-c855199fdbf9@zytor.com>
 <akH34ycu5-q2Yc_D@casper.infradead.org>
Content-Language: en-US, sv-SE
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <akH34ycu5-q2Yc_D@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026-06-28 21:43, Matthew Wilcox wrote:
> On Sun, Jun 28, 2026 at 07:09:37PM -0700, H. Peter Anvin wrote:
>>
>>> 2) `enter` is not rare since we can take part in the instruction.
>>
>> This sentence doesn't parse.
> 
> They mean that we can jump into the middle of an instruction, and it is
> not rare to see a 'c8' byte in the instruction stream.
>

OK, I see the point now. The main difference is that ENTER doesn't require a
REX prefix, whereas ADD/SUB/LEA do (otherwise it truncates RSP and everything
immediately dies as a result of SMAP violations [you are welcome].)

This means that an offending bit combination is far less common.

	-hpa

