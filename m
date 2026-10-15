Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E80397B09;
	Thu, 15 Oct 2026 04:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792040163; cv=none; b=DbffaUfEurEfW72bxW7lpb6uu2Cia4aZCjD4FqPxaSwEGbLlcPgbAmAwZeTi1Uy74dnlrNGuzukhZK98RJpiuq6H+gOcmMxJgbl7lG0xFyKtAVBTP3asaBopHo9iTI6Iih+9CzpVaaGgUrwbUDlT6uVWzn13ZUcVtCckX9UwPMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792040163; c=relaxed/simple;
	bh=DYm+etoHR3zNYbhtHG1R4AN3vVGImJ6ZW5Qomh/pmDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hExixbB6v4SV7NVyY7SB28s5VCUkkNB5DMrxKU+Z9Qd20MMc2EUoi63VSMTKq+YuiInqNI+BPntgbjQoay6nUQaQdR4XW+Yc5FpdQpg/1b+zOHp0CkOpYar23hBWldQ1dLB1C03dAB2Fyyw6gccnsAQ5QxKzCHIvwJ1s7czEmDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=h7HAF7FY; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="h7HAF7FY"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 679981516;
	Wed, 14 Oct 2026 21:55:49 -0700 (PDT)
Received: from localhost (a085714.arm.com [10.164.19.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ED25A3F871;
	Wed, 14 Oct 2026 21:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1792040152; bh=DYm+etoHR3zNYbhtHG1R4AN3vVGImJ6ZW5Qomh/pmDg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h7HAF7FYATg4eCjmDj57DAFLfy1kQnGIC3BWZg/3co7F6JU2g8y8pjOMgelGFqZlE
	 LBGHqxwBERJhTrUahiwBtYFiRjEfGLd5NVrb0JSkWybp537bI3UXql1Br2Xc3srC7u
	 iz22Ot6G3DXMOnu23/ii8tkQIKAI6LSf/K2nw03E=
Date: Thu, 15 Oct 2026 10:25:49 +0530
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: Iurii Trukhin <yuri@trukhin.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Kees Cook <kees@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Ard Biesheuvel <ardb@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: raise default ARCH_MMAP_RND_BITS for 48-bit and
 52-bit VA
Message-ID: <x4iu6sii7fsxksdfur3wcpu4kb63eubsp5d6pzklxuhta7xtj7@rskyoy7ajncj>
References: <CAOx7e9Jm0N9O_ndL1UApMPrXUN=P4RiptSNibdDP+9prUsNPOw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOx7e9Jm0N9O_ndL1UApMPrXUN=P4RiptSNibdDP+9prUsNPOw@mail.gmail.com>

On Wed, Oct 14, 2026 at 07:26:48PM -0500, Iurii Trukhin wrote:
> Since commit f101c5644771 ("arm64: Support ARM64_VA_BITS=52 when
> setting ARCH_MMAP_RND_BITS_MAX"), arm64 supports up to 33, 31, and 29
> bits of mmap ASLR entropy on 48-bit and 52-bit virtual address spaces
> for 4K, 16K, and 64K pages respectively. However, ARCH_MMAP_RND_BITS
> still defaults to ARCH_MMAP_RND_BITS_MIN (18, 16, and 14 bits), which
> was set in commit 8f0d3aa9de57 ("arm64: mm: support ARCH_MMAP_RND_BITS")
> when 39-bit VA was the 4K default.
> 
> Set the default ARCH_MMAP_RND_BITS for 48-bit and 52-bit VA to 28 (4K
> pages), 26 (16K pages), and 24 (64K pages), matching x86_64's 1 TiB
> randomization range (5 bits below ARCH_MMAP_RND_BITS_MAX) while keeping
> ARCH_MMAP_RND_BITS_MIN unchanged for smaller VA configurations.
> 
> Closes: https://github.com/KSPP/linux/issues/371
> Signed-off-by: Iurii Trukhin <yuri@trukhin.com>
> ---
>  arch/arm64/Kconfig | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index cab741a695f5..59a53d7a75c5 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -313,6 +313,11 @@ config ARCH_MMAP_RND_BITS_MAX
>  	default 16 if ARM64_16K_PAGES
>  	default 18
> 
> +config ARCH_MMAP_RND_BITS
> +	default 24 if (ARM64_VA_BITS=48 || ARM64_VA_BITS=52) && ARM64_64K_PAGES
> +	default 26 if (ARM64_VA_BITS=48 || ARM64_VA_BITS=52) && ARM64_16K_PAGES
> +	default 28 if (ARM64_VA_BITS=48 || ARM64_VA_BITS=52)
> +

Overriding ARCH_MMAP_RND_BITS inside the platform effectively makes this config
look something like the following on arm64.

config ARCH_MMAP_RND_BITS
	int "Number of bits to use for ASLR of mmap base address" if EXPERT
	range ARCH_MMAP_RND_BITS_MIN ARCH_MMAP_RND_BITS_MAX
	-------------
	default 24 if (ARM64_VA_BITS=48 || ARM64_VA_BITS=52) && ARM64_64K_PAGES
	default 26 if (ARM64_VA_BITS=48 || ARM64_VA_BITS=52) && ARM64_16K_PAGES
	default 28 if (ARM64_VA_BITS=48 || ARM64_VA_BITS=52)
	-------------
	default ARCH_MMAP_RND_BITS_MIN
	depends on HAVE_ARCH_MMAP_RND_BITS
	help
	  This value can be used to select the number of bits to use to
	  determine the random offset to the base address of vma regions
	  resulting from mmap allocations. This value will be bounded
	  by the architecture's minimum and maximum supported values.

	  This value can be changed after boot using the
	  /proc/sys/vm/mmap_rnd_bits tunable

ARCH_MMAP_RND_BITS_MIN still gets used when VA_BITS != 48 or 52. But this seems
like a subtle detail. Just wondering - should a comment explaining this default
random bits fallback sequence be added here as well ?

>  config ARCH_MMAP_RND_COMPAT_BITS_MIN
>  	default 7 if ARM64_64K_PAGES
>  	default 9 if ARM64_16K_PAGES
> -- 
> 2.56.0
