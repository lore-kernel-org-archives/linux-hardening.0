Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3901741C2FF
	for <linux-hardening@vger.kernel.org>; Thu,  3 Sep 2026 09:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788426847; cv=none; b=IecRf+2+Uixs1PWC05Owv41WVNLM5IbQnG4Aj69Uj9JbcmnutGTR7L+R3Fir/DMJkXOz6T5zyG40LHXO0KmRSJKi6qjQ3mWbsmsLzoFn8UOIfHlTWsCMqLMyzxbuDeN4VCBlvm+DEn0GEegw4XXByOMSyPQSFPvprKGx/8o0CQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788426847; c=relaxed/simple;
	bh=6jwLKj7jhYtsSX186PaK9yCDtesokapjON4y/Vc8cE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fGqzRfth4bw+6D5L/jG94chDvkC7EDKG1+tPBhItVUeRig58bLib9k/NX2/i7Tr07rpbVQIH+RJwFVteighUkgdVZSA5buXwPAddjZxICe++79qIsVHp0QvMr79cd1G8smgLSUIzfo7qcriDA/nnjlzGoDWlC7Ef0Wm5eKyKTLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=pWr0i6pJ; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="pWr0i6pJ"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B52E51596;
	Thu,  3 Sep 2026 02:14:00 -0700 (PDT)
Received: from localhost (a079125.arm.com [10.164.21.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BDF103FA32;
	Thu,  3 Sep 2026 02:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788426844; bh=6jwLKj7jhYtsSX186PaK9yCDtesokapjON4y/Vc8cE0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pWr0i6pJSQywxTkp4y67uTu1Uz+4OfYZRorRJvi0pLgHJR8J81nwbJUoeDUDJ01lN
	 gs+poUT8IJdSKiSw4my0FdJrFI4SIer8s1wLwlKM/GNiLPLLlPwuL4naZC7BLSWzF/
	 6XZSpSTvGCygqlsuwPJ7YWAPSD/ktcswEvNtsNaE=
Date: Thu, 3 Sep 2026 14:44:01 +0530
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
Subject: Re: [PATCH RFC v9 09/25] arm64: Enable kpkeys
Message-ID: <apk6WcSQyvPK_E6L@a079125.arm.com>
References: <20260818-kpkeys-v9-0-743ad31b2c8f@arm.com>
 <20260818-kpkeys-v9-9-743ad31b2c8f@arm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818-kpkeys-v9-9-743ad31b2c8f@arm.com>

Kevin,

On Tue, Aug 18, 2026 at 03:08:51PM +0100, Kevin Brodsky wrote:
> This is the final step to enable kpkeys on arm64. We enable
> POE at EL1 by setting TCR2_EL1.POE, and initialise POR_EL1 to the
> default value, enabling access to the default pkey/POIndex (0).
> An ISB is added so that POE restrictions are enforced immediately.
> 
> Having done this, we can now select ARCH_HAS_KPKEYS if ARM64_POE is
> enabled.
> 
> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
> ---
>  arch/arm64/Kconfig             | 1 +
>  arch/arm64/kernel/cpufeature.c | 5 ++++-
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index b3afe0688919..0afa085c66be 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -2202,6 +2202,7 @@ config ARM64_POE
>  	def_bool y
>  	select ARCH_USES_HIGH_VMA_FLAGS
>  	select ARCH_HAS_PKEYS
> +	select ARCH_HAS_KPKEYS
>  	help
>  	  The Permission Overlay Extension is used to implement Memory
>  	  Protection Keys. Memory Protection Keys provides a mechanism for
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 9a22df0c5120..4f2f54007ed6 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -76,6 +76,7 @@
>  #include <linux/kasan.h>
>  #include <linux/percpu.h>
>  #include <linux/sched/isolation.h>
> +#include <linux/kpkeys.h>
>  
>  #include <asm/arm_pmuv3.h>
>  #include <asm/cpu.h>
> @@ -2463,8 +2464,10 @@ static void cpu_enable_mops(const struct arm64_cpu_capabilities *__unused)
>  #ifdef CONFIG_ARM64_POE
>  static void cpu_enable_poe(const struct arm64_cpu_capabilities *__unused)
>  {
> -	sysreg_clear_set(REG_TCR2_EL1, 0, TCR2_EL1_E0POE);
> +	write_sysreg_s(POR_EL1_INIT, SYS_POR_EL1);

May be we could move this to __cpu_setup. Please see comments on Patch 8.

--
Linu Cherian
