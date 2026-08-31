Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3876470EA4
	for <linux-hardening@vger.kernel.org>; Mon, 31 Aug 2026 15:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788190545; cv=none; b=NtOlIBblS0veazJpPIR0tFpqJJ685LfT28/E1EBmh31GEGAmy7fPCjXBDKuUQskQBjHRPq/lksE79pQE8dLIMJFkmk036aHGBwouVGcIskHcGZjTszohhpIkh1D3Tvxx2LT1i+iWIfqZyYsAtunSeYuxIUzlXPat7w6vnMJNFEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788190545; c=relaxed/simple;
	bh=dO5NARjIPnbddOZBqS6Mw077IVWkSrTQV6zN63iQdEw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wh8XklMNAjmaRF+/KjbYjKdAHXDt3zkshGV78PcE+jOZIuaLrUMyrSsf0ItClJFc9nWsc5m3FxO5CY4Cyg/UgIm1XpB4OGwBerfsrsvNDt9KsqbkXlJba/TuemVc9epyHkA1NeQplbVcU21iba0/Tn+OY9vCrvesf4Aso9XPL9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=NiZ7OBLg; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="NiZ7OBLg"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F29315A1;
	Mon, 31 Aug 2026 08:35:39 -0700 (PDT)
Received: from [10.57.6.141] (unknown [10.57.6.141])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2598D3F882;
	Mon, 31 Aug 2026 08:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788190543; bh=dO5NARjIPnbddOZBqS6Mw077IVWkSrTQV6zN63iQdEw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NiZ7OBLg9FgNOdnwafeP8+TkHYvmSGkO090szXGMy+MnpplKYOpWuYI1HsHwzEF/T
	 aAL1/ib5Dn9d2tgjkf3EaC2Bnqm+69lSFSxVdYrBehQ+B5lYvj2Ku425wASs32W6/s
	 FyLaXKRQFipKixyjJCom9cJkBsrwl7/vgjh1lXL0=
Message-ID: <8264a299-139e-40ea-be84-3be06adea564@arm.com>
Date: Mon, 31 Aug 2026 17:35:33 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v9 00/25] pkeys-based page table hardening
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: linux-hardening@vger.kernel.org, Andrew Morton
 <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "David Hildenbrand (Arm)" <david@kernel.org>, Jann Horn <jannh@google.com>,
 Jeff Xu <jeffxu@chromium.org>, Joey Gouly <joey.gouly@arm.com>,
 Kees Cook <kees@kernel.org>, Linu Cherian <linu.cherian@arm.com>,
 Linus Walleij <linusw@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Mark Brown <broonie@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Maxwell Bland <mbland@motorola.com>, "Mike Rapoport (IBM)"
 <rppt@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Pierre Langlois <pierre.langlois@arm.com>,
 =?UTF-8?Q?Pierre-Cl=C3=A9ment_Tosi?= <ptosi@google.com>,
 Quentin Perret <qperret@google.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Vlastimil Babka <vbabka@kernel.org>,
 Will Deacon <will@kernel.org>, Yang Shi <yang@os.amperecomputing.com>,
 linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, x86@kernel.org,
 Ira Weiny <iweiny@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>
References: <20260818-kpkeys-v9-0-743ad31b2c8f@arm.com>
 <apBy3nB3_GgBvYpB@e129823.arm.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <apBy3nB3_GgBvYpB@e129823.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/08/2026 19:24, Yeoreum Yun wrote:
> This series looks good to me.
>
> Reviewed-by: Yeoreum Yun <yeoreum.yun@arm.com>

Thanks for the review! The series is (again) going to change quite a bit
in the next version, I'll apply your R-b on the patches that remain
mostly unchanged.

- Kevin
