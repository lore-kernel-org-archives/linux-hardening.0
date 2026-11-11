Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794392811;
	b=R6wwxYAmPjvxXzbqPN9J2H8jKQk13/0ibJgQWpwlSjdN9i6fLp2C8zft5op1XPAEpeRN
	 A8JDeNHMIt2bRTzDONDSl9UsOKnGh6JWkbBw0qd0Q2IYsWtoR5Jga6H1j5d+own8BaIND
	 1a8Hc4zTzhIzan+1Q/sXSEaAVCBoAva0hG5aVbixrp4kvz3jt9COhAUxv6Mh6h4DLjimk
	 Oge9V+uFFlzFmfw/u2oSWicvgzUk7Z15R0n0YgKoZVOquzmMafH3MSdr2e4fqxAvWxbPk
	 7AJ3UkJxBsVCeOqbYfN5a7D2gZaoBQVpN7vG5bg6HiTKTDyOp6r8i8oRBXgjhhRV9YA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794392811;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=5V9jRlyh7Ihg0NTQ3+KjZaPOqstTGKiqiBozrCfwUxY=;
	b=Q5c2d+X6k00h7Hh7GdEEJETPTRXDHIbyWhAy31zxSmDL5jkplkEJDDjRfY6o6q3FZP3M
	 u37UXryNUGRm0RfKVCZn7EL5da0wtBexnVR/2m+xCFzH0Sy50l0BQj2VLlFwGeP6kxSCu
	 Vwd+KjtYMiZ8xRT3aurA16emRbVz+lZ8XcQx/mlnuo2xXD5KZ979Mu+OKVXjWHLQEs8bf
	 TW2h2An0BUPf+AOlp+s46cGvtmmq84WYU4cyMGvOAuk/d7+IdjSr0lKpvf0rQghIpuaDI
	 qkZ5r6DtFNjxqZjxs6BEkDdAUAXKFIa8IXspPbEq5YLMM26XrnxhW2oKf8h/3RHKcDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=MWmswE93;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D15606A31C;
	Wed, 11 Nov 2026 10:26:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1D15606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=MWmswE93
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2EBED2F;
	Wed, 11 Nov 2026 02:26:47 -0800 (PST)
Received: from [10.57.63.24] (unknown [10.57.63.24])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9770F3F632;
	Wed, 11 Nov 2026 02:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794392810; bh=5p/zP+v+C50UsZoAhPNAyBGrgi2Vxw0z5RAhgrPcN0k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MWmswE93spZbG2V0obRVIKBymfeULcFqEbj2cVnHxFaY5kyeW/5QiG+uLZDVflVGi
	 2C77Gaqu/MzBzW/w8VmfSod584m9JMJoYwQ5iuh3UEd4+jjlIHFkwwezDCHM5pGV6p
	 M+ch4d/6NeEOTwtoO+eqNyC1tAY1uTMp8qcFSlgM=
Message-ID: <45b19233-741e-46c8-a6c1-28775c4d646d@arm.com>
Date: Wed, 11 Nov 2026 11:26:39 +0100
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
Subject: Re: [PATCH RFC v10 04/22] arm64: Implement asm/kpkeys.h using POE
To: Mark Brown <broonie@kernel.org>
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
 Yeoreum Yun <yeoreum.yun@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, x86@kernel.org,
 Ira Weiny <iweiny@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>
References: <20261109-kpkeys-v10-0-aa6c4d9603bc@arm.com>
 <20261109-kpkeys-v10-4-aa6c4d9603bc@arm.com>
 <07b55bf9-e116-4731-9f84-49cd1b55fa50@sirena.org.uk>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <07b55bf9-e116-4731-9f84-49cd1b55fa50@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/11/2026 15:19, Mark Brown wrote:
> On Mon, Nov 09, 2026 at 03:58:29PM +0000, Kevin Brodsky wrote:
>
>> +#define POR_EL1_INIT	POR_ELx_PERM_PREP(0, POE_RWX)
>> +
>> +#ifndef __ASSEMBLY__
> Everything else in arch/arm64 was converted to __ASSEMBLER__.

Good catch, copy/pasted the wrong one when I first wrote this!

- Kevin
