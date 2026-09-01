Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F1D409114
	for <linux-hardening@vger.kernel.org>; Tue,  1 Sep 2026 14:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788274123; cv=none; b=C5emMBIKJs3vTHojcPHli5EKFwmp5LjF3QQaPbOAc40IAXFL3C4RDyZ6lnDrr+BSACATjafUzA09WUPQPtSWt3f3AXE+YfKQzJGGcv/wzyi/bAISHvW2+bAz47TycdIACJuHp4FjwEkCm96NS+6z1fCTGSZKvShS2J2Bt1fI8dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788274123; c=relaxed/simple;
	bh=5GY+SQc88euWmJgqoN2XFz/ZgVOv0qHEWYmDyZeK5BE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LrSfdQrYDS9pyoMngg5H2FLs+Xtc03BlIp3JPmUWqX+Jh4+IgGmKiTv6NDiA5L2Y2SnP+Hp9l8zwtNj77NqKmLosyL2pckmpPQF78ArJauMkoFRvxG5zH4D9W21c4VZKUovUon+IG2ilDQTCv8p3iKwaou198zxKdenSY+J9Lio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=JEltKYEX; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="JEltKYEX"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 283171756;
	Tue,  1 Sep 2026 07:48:37 -0700 (PDT)
Received: from localhost (a079125.arm.com [10.164.21.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2AFB33F882;
	Tue,  1 Sep 2026 07:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788274120; bh=5GY+SQc88euWmJgqoN2XFz/ZgVOv0qHEWYmDyZeK5BE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JEltKYEX2C5ZZ/qepJmekcgZuDMHGo871Mo2hrh8BH4KmIGGofzXJ6IGQtgJXDhPp
	 zKBCcEQPeq+Gu3WEP8GTg8CE3pXDpUyOQkTV05I4itu+glLuCCh7BuPty9T7FfTbkD
	 rDKNjPsACVDZtvgM45KURU6FeTlEBy96apb3J4g8=
Date: Tue, 1 Sep 2026 20:18:37 +0530
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
Subject: Re: [PATCH RFC v9 05/25] arm64: Implement asm/kpkeys.h using POE
Message-ID: <apblxUah9EcQox-Y@a079125.arm.com>
References: <20260818-kpkeys-v9-0-743ad31b2c8f@arm.com>
 <20260818-kpkeys-v9-5-743ad31b2c8f@arm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818-kpkeys-v9-5-743ad31b2c8f@arm.com>

Kevin,

On Tue, Aug 18, 2026 at 03:08:47PM +0100, Kevin Brodsky wrote:
> Implement the kpkeys interface if CONFIG_ARM64_POE is enabled.
> The permissions for pkey 0 are set to RWX as this pkey is also used
> for code mappings. POR_EL1 is left untouched if we have already
> entered the requested context.
> 
> To allow <asm/kpkeys.h> to be included from assembly, also add
> appropriate #ifdef's to <asm/por.h>.
> 
> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
> ---
>  arch/arm64/include/asm/kpkeys.h       | 67 +++++++++++++++++++++++++++++++++++
>  arch/arm64/include/asm/kpkeys_types.h | 15 ++++++++
>  arch/arm64/include/asm/por.h          |  4 +++
>  3 files changed, 86 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/kpkeys.h b/arch/arm64/include/asm/kpkeys.h
> new file mode 100644
> index 000000000000..09fd5a849cb0
> --- /dev/null
> +++ b/arch/arm64/include/asm/kpkeys.h
> @@ -0,0 +1,67 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef __ASM_KPKEYS_H
> +#define __ASM_KPKEYS_H
> +
> +#include <linux/kpkeys_types.h>
> +
> +#include <asm/barrier.h>
> +#include <asm/cpufeature.h>
> +#include <asm/por.h>
> +
> +/*
> + * Equivalent to por_set_kpkeys_context(0, KPKEYS_CTX_DEFAULT), but can also be
> + * used in assembly.
> + */
> +#define POR_EL1_INIT	POR_ELx_PERM_PREP(0, POE_RWX)

IMHO, moving this macro defintion to "arm64: Enable kpkeys" , would be better as
this patch is about implementing arch helpers. 

> +
> +#ifndef __ASSEMBLY__
> +
> +static inline bool arch_supports_kpkeys(void)
> +{
> +	return system_supports_poe();
> +}
> +
> +#ifdef CONFIG_ARM64_POE
> +
> +static inline u64 por_set_kpkeys_context(u64 por, enum kpkeys_ctx ctx)
> +{
> +	por = por_elx_set_pkey_perms(por, 0, POE_RWX);

Guess, we would want to set the pkey index 0 only when,
ctx == KPKEYS_CTX_DEFAULT and it need to be set only once.
IIUC, we wouldnt want to deal with that every time we set a new
context. ie. update only what is relevant. 

--
Linu Cherian
 
