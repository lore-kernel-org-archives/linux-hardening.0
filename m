Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8363B2E975E
	for <linux-hardening@vger.kernel.org>; Tue,  1 Sep 2026 14:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788273778; cv=none; b=Jg+C077YZM/qk8YjHK0Yp6YaQ/RjANweE0ggKF04mLK8faCuAptea6UgxDI8FFgoQ0EeCCI+kZ/V5a1Lvw1Q2hw9de+Xu+/yp1MtQlEZzwDEV6a1ptu1PwytDcerLAIzcdPmScgQLRYkCmZSTM5+AxZUGJWIWg9evznAxuoF7cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788273778; c=relaxed/simple;
	bh=NZvEgAQVOI7lQrreQcbXEtrWMnYe52kjfKk59Vp8xtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dix3vpMzJubrMtBfBjei1Ac1HKqCe70WxV8TXddJG/u3MCf6CJd3loDTOw74O/WcsQUvWH6MKmeA97yuYgDUVA65A2h49EiJZ8OiJeghTyK+RjIoCRtUdsg6pw/wScG02glJ9RNQirlTJb4PNFZZoCuHz8fQ6iNSu9FmjEJJBGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=fSf+J4Un; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="fSf+J4Un"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DE2BD1756;
	Tue,  1 Sep 2026 07:42:51 -0700 (PDT)
Received: from localhost (a079125.arm.com [10.164.21.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E20CA3F882;
	Tue,  1 Sep 2026 07:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788273775; bh=NZvEgAQVOI7lQrreQcbXEtrWMnYe52kjfKk59Vp8xtY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fSf+J4UnW13FN1pFvQV4UEn0YkoWj8JEfy5U3rKMvbTohcXug4Ea3BWkGSt+8ZqZS
	 o5+uj/rcTvrdP0ExVcQ1IlNYH9v/rqsXHNIAm4jVX3qI4omAM3yFbz2Xqd0PButF3W
	 pPrGdJqssc1yVvF6PH0iCjeXSJCJwq2wSyeOvLJ4=
Date: Tue, 1 Sep 2026 20:12:52 +0530
From: Linu Cherian <linu.cherian@arm.com>
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-hardening@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@chromium.org>,
	Joey Gouly <joey.gouly@arm.com>, Kees Cook <kees@kernel.org>,
	Linus Walleij <linusw@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Maxwell Bland <mbland@motorola.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Pierre Langlois <pierre.langlois@arm.com>,
	=?iso-8859-1?Q?Pierre-Cl=E9ment?= Tosi <ptosi@google.com>,
	Quentin Perret <qperret@google.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Vlastimil Babka <vbabka@kernel.org>, Will Deacon <will@kernel.org>,
	Yang Shi <yang@os.amperecomputing.com>,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
	x86@kernel.org, Ira Weiny <iweiny@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>, Thomas Gleixner <tglx@kernel.org>
Subject: Re: [PATCH RFC v9 04/25] arm64: Introduce por_elx_set_pkey_perms()
 helper
Message-ID: <apbkbH6Q4p5KYmpE@a079125.arm.com>
References: <20260818-kpkeys-v9-0-743ad31b2c8f@arm.com>
 <20260818-kpkeys-v9-4-743ad31b2c8f@arm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818-kpkeys-v9-4-743ad31b2c8f@arm.com>

Kevin,

On Tue, Aug 18, 2026 at 03:08:46PM +0100, Kevin Brodsky wrote:
> Introduce a helper that sets the permissions of a given pkey
> (POIndex) in the POR_ELx format, and make use of it in
> arch_set_user_pkey_access().
> 
> new_por now represents the permissions of a single pkey, so rename
> it to new_perms and change its type accordingly.
> 
> Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
> ---
>  arch/arm64/include/asm/por.h |  7 +++++++
>  arch/arm64/mm/mmu.c          | 26 ++++++++++----------------
>  2 files changed, 17 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/por.h b/arch/arm64/include/asm/por.h
> index d913d5b529e4..19b3dd1d43a0 100644
> --- a/arch/arm64/include/asm/por.h
> +++ b/arch/arm64/include/asm/por.h
> @@ -31,4 +31,11 @@ static inline bool por_elx_allows_exec(u64 por, u8 pkey)
>  	return perm & POE_X;
>  }
>  
> +static inline u64 por_elx_set_pkey_perms(u64 por, u8 pkey, u8 perms)
> +{
> +	u64 shift = POR_ELx_PERM_SHIFT(pkey);
> +
> +	return (por & ~(POE_MASK << shift)) | ((u64)perms << shift);

We could use standard bit field access macros here ?

--
Linu Cherian
