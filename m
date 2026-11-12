Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794487106;
	b=x6KxH+3ajnPGBqufugb6+VHSpEDKYrp/T+EtC/zWtPG3SfPrlF9sksElcPiNcafFQ5WR
	 AdFJAQJZAIh07/TuS+hXiTD0rTfNPUjovgf9aoNkF50+fhX7Wrswn0VIAZNlXHYtrHgoA
	 2lc9602UtSPHc0m3dO9wUQGZ1m0Qv2500g6/1Nbg/3gMvDAwFfhtPqL9vpeCyoe1CeZPH
	 NKvXeXLciMXEhd4ZHpS6uHLQp1JEQ/DsOphvb8toKjgEh+5zNXpM0CkwglbVmQQV6zDv1
	 TNndtBU9Qu9HIDp46PV46h1Mf6EJYHmH/LLKYYVdrUDo12QK4FbYb6bSAh0N03sb2sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794487106;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=qwGHYWqkzjPKzDNH4i/tvvgZ4hxVWyzdRGgiuO5uYi0=;
	b=b8jSOqoEgnwfCIzadTFxAV2BlpBfxRww2J82IaD9qezBG720/dfdul3P5o4NtJpKlTX5
	 gc8SQaPdgOgjYXRlX4JKfEE/67eacQQX8D0mJ2mbBiXPWur0T1flXadX1KUSK9gvddfp8
	 MF88IqdeQkeSTGjzjKBz9FhKtd1Uv1UqAkqu5Nj8F6ND8coFWrxN3KbEuGswhdmCJA43q
	 KKAfuMEcHB5S6iii7GR7DAfjs0+NSEtZy9tay1P/sYAKKw99Fvgo1z17pBaUxHUarjzK+
	 gvEESsq7wIa+VGUbzodpb2MzsRGfySNYT0e9B+Xgpy2RlbZ2URM91ZtwvzkXhY1cJxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=G92ewwS6;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB51606A31C;
	Thu, 12 Nov 2026 12:38:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BB51606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=G92ewwS6
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 354211477;
	Thu, 12 Nov 2026 04:38:21 -0800 (PST)
Received: from [10.57.59.183] (unknown [10.57.59.183])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F0E6E3F673;
	Thu, 12 Nov 2026 04:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794487104; bh=GXDArifiTXzGS/TEyKUeQy694OV8tzZyyHhxUDTufKU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=G92ewwS69xI/sQnwPuFxDuaGeeicD5gWXRAQcqnYkeOnE+1AhuhQD+T9u+2gEnSvA
	 8Tz0b5fy8Nanp500jVMIfPIBqybgWOu28wUx9eUNS6BsJB8hlKLfKfowurrVqb8yg0
	 gegWtANRaNOjC5bAe0P7rnTdXxQKCb9wTnu50CiQ=
Message-ID: <7b92f7c8-1543-447e-8ef3-aba608141699@arm.com>
Date: Thu, 12 Nov 2026 13:38:13 +0100
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v10 07/22] arm64: Initialize POR_EL1 register on
 cpu_resume()
To: Yeoreum Yun <yeoreum.yun@arm.com>, Mark Brown <broonie@kernel.org>
Cc: linux-hardening@vger.kernel.org, Andrew Morton
 <akpm@linux-foundation.org>, Ard Biesheuvel <ardb+git@google.com>,
 Andy Lutomirski <luto@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 "David Hildenbrand (Arm)" <david@kernel.org>, Jann Horn <jannh@google.com>,
 Jeff Xu <jeffxu@chromium.org>, Joey Gouly <joey.gouly@arm.com>,
 Kees Cook <kees@kernel.org>, Linu Cherian <linu.cherian@arm.com>,
 Linus Walleij <linusw@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Matthew Wilcox <willy@infradead.org>, Maxwell Bland <mbland@motorola.com>,
 "Mike Rapoport (IBM)" <rppt@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Pierre Langlois <pierre.langlois@arm.com>,
 =?UTF-8?Q?Pierre-Cl=C3=A9ment_Tosi?= <ptosi@google.com>,
 Quentin Perret <qperret@google.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Vlastimil Babka <vbabka@kernel.org>,
 Will Deacon <will@kernel.org>, Yang Shi <yang@os.amperecomputing.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mm@kvack.org, x86@kernel.org, Ira Weiny <iweiny@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>, Thomas Gleixner <tglx@kernel.org>
References: <20261109-kpkeys-v10-0-aa6c4d9603bc@arm.com>
 <20261109-kpkeys-v10-7-aa6c4d9603bc@arm.com>
 <be361be8-c5ad-4ff7-a6db-7b0815bfe1d0@sirena.org.uk>
 <avNH_AdvK9AqvfF7@e129823.arm.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <avNH_AdvK9AqvfF7@e129823.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/11/2026 17:36, Yeoreum Yun wrote:
> On Tue, Nov 10, 2026 at 03:53:30PM +0000, Mark Brown wrote:
>> On Mon, Nov 09, 2026 at 03:58:32PM +0000, Kevin Brodsky wrote:
>>> From: Yeoreum Yun <yeoreum.yun@arm.com>
>>>
>>> The POR_EL1 register is reset to an unknown value after cpu_suspend().
>>> Since POR_EL1 always holds POR_EL1_INIT when entering cpu_suspend(),
>>> initialize POR_EL1 with POR_EL1_INIT before cpu_do_resume().
>>>> +#ifdef CONFIG_ARM64_POE
>>> +alternative_if_not ARM64_HAS_S1POE
>>> +	b	.Lskip_por_set
>>> +alternative_else_nop_endif
>>> +	mov_q	x2, POR_EL1_INIT
>>> +	msr_s	SYS_POR_EL1, x2
>>> +	/* isb can be skipped since cpu_do_resume() will do it. */
>>> +.Lskip_por_set:
>>> +#endif /* CONFIG_ARM64_POE */
>> cpu_do_resume() will update TCR2_EL1 to enable POE again, a sufficiently
>> unhelpful implementation could potentially decide to do that before this
>> POR_EL1 value takes effect AFAICT given that there's no barriers.
> Thanks. seems required to isb() after initialising SYS_POR_EL1.

Agreed (as Sashiko reported as well). Presumably that means we also need
an ISB after writing to POR_EL1 in cpu_enable_poe(), as that's basically
the same situation.

- Kevin
