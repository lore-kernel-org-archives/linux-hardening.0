Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AA9353EF7
	for <linux-hardening@vger.kernel.org>; Thu,  3 Sep 2026 05:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788414997; cv=none; b=agyMjCphYbMdgk2IAIGODO7bGMVh8oRYeMv3XxA5QUMMzyf9iqsSEyGkl+RvI20riNiqVmPGsMBzAyaY1KFKt0d3tYcg2Pmz70f+YIUh668GewuoGLssnb0w2mT90pcaLefUNMY9xVErTOTxLcpP6umwEhTExrhRYgJ3juMHAM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788414997; c=relaxed/simple;
	bh=DY/csfhtR5YKRxNjL+v1oA5BkKG7eZTRM1aibwpAHZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CRJopdl3JjcLMpjPsGedE7r+MCxGGuP/c93KXQ7Ds+4HB+dd4hoZU2wl2rXxhBpjJAQNr1SYdmtsZUoH2PyXT7qQZy6ylyvJBvYtmw/WYKqeQf2lUQ6Ich9XSiHJVUfw0GxuNdzjQmJtRRbO/RDG/tBk72t6f0/k1tjtt7ep9kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=jy33b5SC; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="jy33b5SC"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B4631596;
	Wed,  2 Sep 2026 22:56:29 -0700 (PDT)
Received: from localhost (a079125.arm.com [10.164.21.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8FDCE3F673;
	Wed,  2 Sep 2026 22:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788414993; bh=DY/csfhtR5YKRxNjL+v1oA5BkKG7eZTRM1aibwpAHZw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jy33b5SC5V6MzaplebERlNq+BFlc9TRUI4ImbVVvxIHngkHgnbxv0tzSSVfsfKXe3
	 im25pVnAOzQ05+j8tOYvftqbvXK5fe2BOtxDIf0L3t+U05xyFehzWRhUpXS4solPgf
	 W74ItVMEC3SFf0Ed9IfLCQ/BgE1K1Fiix7t9JZPo=
Date: Thu, 3 Sep 2026 11:26:29 +0530
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
Subject: Re: [PATCH RFC v9 08/25] arm64: Initialize POR_EL1 register on
 cpu_resume()
Message-ID: <apkMDaRKqX3TTINV@a079125.arm.com>
References: <20260818-kpkeys-v9-0-743ad31b2c8f@arm.com>
 <20260818-kpkeys-v9-8-743ad31b2c8f@arm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818-kpkeys-v9-8-743ad31b2c8f@arm.com>

Kevin,

On Tue, Aug 18, 2026 at 03:08:50PM +0100, Kevin Brodsky wrote:
> From: Yeoreum Yun <yeoreum.yun@arm.com>
> 
> The POR_EL1 register is reset to an unknown value after cpu_suspend().
> Since POR_EL1 always holds POR_EL1_INIT when entering cpu_suspend(),
> initialize POR_EL1 with POR_EL1_INIT before cpu_do_resume().
> 
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
> ---
>  arch/arm64/kernel/sleep.S | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/kernel/sleep.S b/arch/arm64/kernel/sleep.S
> index f093cdf71be1..e0a6ad85cd24 100644
> --- a/arch/arm64/kernel/sleep.S
> +++ b/arch/arm64/kernel/sleep.S
> @@ -3,6 +3,7 @@
>  #include <linux/linkage.h>
>  #include <asm/asm-offsets.h>
>  #include <asm/assembler.h>
> +#include <asm/kpkeys.h>
>  #include <asm/smp.h>
>  
>  	.text
> @@ -134,6 +135,17 @@ SYM_FUNC_START(_cpu_resume)
>  	/* load sp from context */
>  	ldr	x2, [x0, #CPU_CTX_SP]
>  	mov	sp, x2
> +
> +#ifdef CONFIG_ARM64_POE
> +alternative_if_not ARM64_HAS_S1POE
> +	b	.Lskip_por_set
> +alternative_else_nop_endif
> +	mov_q	x2, POR_EL1_INIT
> +	msr_s	SYS_POR_EL1, x2
> +	/* isb can be skipped since cpu_do_resume() will do it. */
> +.Lskip_por_set:
> +#endif /* CONFIG_ARM64_POE */

Would it be better to move this under__cpu_setup ?

--
Linu Cherian
