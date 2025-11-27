Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030D3334690;
	Thu, 27 Nov 2025 15:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764255985; cv=none; b=BvMX59hKRwstws13qMoFZp0sqFOpbQHBB5oSSXLlsjYiZNe9yvq9SI5r2mCNm7+PRkJCM0waGMqTw5so221+lL+k23aYNwT66YoMmO8PPsGG+W1QaqBbOHCW7xxJza6wvlb9o8hSvgKtxRAeLUCpRTExJWqzaJftmMN7SBPLX5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764255985; c=relaxed/simple;
	bh=G7+IVXJVYeH4PF5lDJcVywt+QuCjWu92bAdVRt2faTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lFXOLNGM/JCWyc/KvSlyHhLrIm/7AF3EckkgR5a7C41ES1eYqYGjGv/inO8rK20pKjA2owiC3hut1wRO3xPl2VjrFDkEaj2ms1QTKFKB8LtKAhpGaoaKVdgpoV77BBh8qczypUszP4QFXffSjsDGZ0ZH29uO0NB2qRA8r30e6zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E84211063;
	Thu, 27 Nov 2025 07:06:15 -0800 (PST)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3461F3F66E;
	Thu, 27 Nov 2025 07:06:21 -0800 (PST)
Date: Thu, 27 Nov 2025 15:06:14 +0000
From: Joey Gouly <joey.gouly@arm.com>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-hardening@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Kees Cook <kees@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
	Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Catalin Marinas <Catalin.Marinas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [RFC/RFT PATCH 2/6] arc: Wire up cmpxchg64_local() to generic
 implementation
Message-ID: <20251127150614.GA3271003@e124191.cambridge.arm.com>
References: <20251127092226.1439196-8-ardb+git@google.com>
 <20251127092226.1439196-10-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251127092226.1439196-10-ardb+git@google.com>

On Thu, Nov 27, 2025 at 10:22:29AM +0100, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> Provide cmpxchg64_local() for hexagon so we can start using it in
> generic code.

nit: this is for arc, not hexagon.

Thanks,
Joey

> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/arc/include/asm/cmpxchg.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arc/include/asm/cmpxchg.h b/arch/arc/include/asm/cmpxchg.h
> index 76f43db0890f..f2d55823645c 100644
> --- a/arch/arc/include/asm/cmpxchg.h
> +++ b/arch/arc/include/asm/cmpxchg.h
> @@ -12,6 +12,7 @@
>  
>  #include <asm/barrier.h>
>  #include <asm/smp.h>
> +#include <asm-generic/cmpxchg-local.h>
>  
>  #ifdef CONFIG_ARC_HAS_LLSC
>  
> @@ -142,4 +143,6 @@
>  
>  #endif
>  
> +#define arch_cmpxchg64_local __generic_cmpxchg64_local
> +
>  #endif
> -- 
> 2.52.0.107.ga0afd4fd5b-goog
> 
> 
