Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843B4EEB3
	for <linux-hardening@vger.kernel.org>; Thu,  3 Sep 2026 05:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788415095; cv=none; b=WH4ttrb0enWhQZHabRlRnBLkzJ8eSa9zyifo1SH1MwPzvPE/7lUk/6bLOeg7fs9RhUHsTpJ94rIAFL0YusCo9FYC8nXa5Io/vu/sF1YR0iPvlrMTma7NY69UoWjywFl4DtZcTk0d8hmKdab1Ga3o0pz4I55smDdv7NI7lJSjqvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788415095; c=relaxed/simple;
	bh=pQigNQ0RH1x3B4WAmoTYWjrUAMlgt0klrdQWZzUN6Qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DTrYxm08dBn4QcrySB+lWpsMRdBtnlXFBb1yyNEN/89iqhk7mUj+NHYFor7zf0YqbSV43Q2bPyIzigdeKsq6GiwiBJC2inAEPb/z7z+DprdPfu6OWju+aEj795qIeHDL0Ykp4KfNWAib6ntpWJ5/byalrOBx6DojS73TGyy1+Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=qCWpIZJy; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="qCWpIZJy"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9DB6F1596;
	Wed,  2 Sep 2026 22:58:08 -0700 (PDT)
Received: from localhost (a079125.arm.com [10.164.21.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A1AE43F673;
	Wed,  2 Sep 2026 22:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788415092; bh=pQigNQ0RH1x3B4WAmoTYWjrUAMlgt0klrdQWZzUN6Qs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qCWpIZJyle1CnxF0mfzL51ZZrc+lgi1FCWufg+fdD4C3LnAhAdqG+yOAQVUktlhQj
	 p1q2ujxe01GN/YlR+g5ypXIuoNQei3uuNybBMEsgxyF8q7twxpCp0dzAIf+vlZyrM1
	 xQJ0F5GV8r0lEw0yR9/mBskoHU06Y0xqJ3sjjJpQ=
Date: Thu, 3 Sep 2026 11:28:08 +0530
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
Subject: Re: [PATCH RFC v9 07/25] arm64: Context-switch POR_EL1
Message-ID: <apkMcHO_Y5Bu9G5o@a079125.arm.com>
References: <20260818-kpkeys-v9-0-743ad31b2c8f@arm.com>
 <20260818-kpkeys-v9-7-743ad31b2c8f@arm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818-kpkeys-v9-7-743ad31b2c8f@arm.com>


On Tue, Aug 18, 2026 at 03:08:49PM +0100, Kevin Brodsky wrote:
> POR_EL1 is about to be used by the kpkeys framework, modifying it
> for (typically small) sections of code. If an exception occurs
> during that window and scheduling occurs, we must ensure that
> POR_EL1 is context-switched as needed (saving the old value and
> restoring the new one). An ISB is needed to ensure the write takes
> effect, so we skip it if the new value is the same as the old, like
> for POR_EL0.
> 
> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
> ---
>  arch/arm64/include/asm/processor.h |  1 +
>  arch/arm64/kernel/process.c        | 10 ++++++++++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
> index c2a627f39314..8d7fa479cd36 100644
> --- a/arch/arm64/include/asm/processor.h
> +++ b/arch/arm64/include/asm/processor.h
> @@ -195,6 +195,7 @@ struct thread_struct {
>  	u64			svcr;
>  	u64			tpidr2_el0;
>  	u64			por_el0;
> +	u64			por_el1;
>  #ifdef CONFIG_ARM64_GCS
>  	unsigned int		gcs_el0_mode;
>  	unsigned int		gcs_el0_locked;
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index 581f80e9b9b7..1dec143decf1 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -51,6 +51,7 @@
>  #include <asm/exec.h>
>  #include <asm/fpsimd.h>
>  #include <asm/gcs.h>
> +#include <asm/kpkeys.h>
>  #include <asm/mmu_context.h>
>  #include <asm/mpam.h>
>  #include <asm/mte.h>
> @@ -431,6 +432,9 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
>  
>  	ptrauth_thread_init_kernel(p);
>  
> +	if (system_supports_poe())
> +		p->thread.por_el1 = POR_EL1_INIT;
> +
>  	if (likely(!args->fn)) {
>  		*childregs = *current_pt_regs();
>  		childregs->regs[0] = 0;
> @@ -681,6 +685,12 @@ static void permission_overlay_switch(struct task_struct *next)
>  		 * of POR_EL0.
>  		 */
>  	}
> +
> +	current->thread.por_el1 = read_sysreg_s(SYS_POR_EL1);
> +	if (current->thread.por_el1 != next->thread.por_el1) {
> +		write_sysreg_s(next->thread.por_el1, SYS_POR_EL1);
> +		isb();
> +	}
>  }
>  
>  /*

Reviewed-by: Linu Cherian <linu.cherian@arm.com>

