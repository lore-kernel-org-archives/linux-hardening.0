Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACBB15667B
	for <linux-hardening@vger.kernel.org>; Thu,  9 Jan 2025 07:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736407068; cv=none; b=mfJzuMe8vmg1Oxiu94jOBsZCmEBPtbzQvxjzEOSEbnLDV6Df9iyPixPm3uaDOdv3Y5aRllDUhC639xCERujQH8a+axfL6in6MwTIIzmowWPxcbp2EzXmIP8hXzoF7k+97ZRKZdjDi7EYpxfT3OBuXSGMFzOA+ExLGgrd4ERsDNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736407068; c=relaxed/simple;
	bh=8gVcxzeqzL/+fcERlltM6grRSzLHAAtdaECOnc63yrM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mxlFFJR9scoQ98o83vpo+49jeC7iAL4stTcZvtT2XFqR6FM3hdhfdB+YKSRXlI2A647p8ghaM43mjxpyuvaJZHJbnrg1zbnAlkaBbU7KGM7Szi2TUSZEuvI7VOPJPgv7fWxnhajEtkwdm+fNbf9KAmtDv+mkMKcVXZFD64WIKZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ZdgOnCB1; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ZdgOnCB1"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21675fd60feso11340785ad.2
        for <linux-hardening@vger.kernel.org>; Wed, 08 Jan 2025 23:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1736407066; x=1737011866; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=goDrdg8W+niPDn8ee1CTbptL4R9YVIAcGFLpDdY+Uh8=;
        b=ZdgOnCB1hBn1oxXNNPsuhDzxDNs4GfZUBnWgnLRLusOgyleBeEkfDb/XTKiBFV/37v
         6MhCw87QqTWJMj6ZNOdvdt58wTRz6qEzVNkRCDUhA5w0S7pwt1PbysjZXg+indAg4MuK
         mxNbtDGnsxkkCh7RMVtW+1/fHXc2/b9MnaYIHSUAcQiSlNyUoo4goV0Jaa3A4Tg7s0S3
         9EYorCE5XkEbSu/v/J2yLEKJ/xqhgRfl2Mn0LeOOHGByOHend7hv2DFgWyVCTLB6ecIQ
         21rJ9f+VPqa4O071ab8bvHFlpJY+jDJAQBpzrqo+CphSQ5dvCRyAr+jxeNfJskNEPHQF
         tJeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736407066; x=1737011866;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=goDrdg8W+niPDn8ee1CTbptL4R9YVIAcGFLpDdY+Uh8=;
        b=CgFLPn/2ZuzPqiwJInYH46qw0sbcVe4qpfU1yDpMSnASNcxOuLFyz3PXB8n4Y6yE+U
         llYiE7uHjg6tV/SoTSwqQ9INq2T/Ywxrc5L365fzrMdFLlli3mXrVUDmFPOQgfgITbiy
         /cIXslocV1hG6TN4twzQ3SMw8mv1mevLTpq0KWgmrVkSQpUGqAW9Ee2wiF8+mQrH8dRv
         bNnnaP1TivQIr/sA+KJWZsKtlcaCeWykNYutYDwCg8dQdMtTkoHoIYJe4LCnKNseTPuo
         ridANDYx1NmPpLzcYNp5DYvhJh+2E0N8SxhtL/MPlBZJA57AyLRnaUqQj17r0j7Zx3YK
         0SFw==
X-Gm-Message-State: AOJu0YyyP2IC8qx0K4uExAwl7j+HTzT2JWKtFJ2CAtbwNm8c7azkMx1r
	8RkrdttztUImspjm2872A1LmJ8Ex9qyNd81mNk4YQwVIfOFhjh1uxCZmzwHcqTw=
X-Gm-Gg: ASbGnctzD6EOfIYCGwKuWFRD8wJPGVCD43/3vf4YxZcaogGrEpBQY39dBKi/OXJMCcM
	Y4Jg2vTrBrSd3eJhWC2U5U2ETJbSDeJGtUBZoOFgYg2QK/ClB6rW8mVziQx8pjoisrWrqd0O3Y3
	t4vFUHTRIwKzRjJDgHlzlRSw1GAikGHfruRHDKSkWs9/M04bdoDQ2YwORB1Dy3erER2Vx7sCH7v
	J2q2mem+xeMO4I5Byj5ZQ2P+OaRMd0VAW/Ow/dmcezr2tW3tXkfaoE5aaqUGcLc45dNmPXdFVH4
	U0zE
X-Google-Smtp-Source: AGHT+IEsAuvKeLfnjNnQ0YmOJjZ/KDeiDHrFAudvPLzZf1ylAUBvPZmXYBm85/H4yI4Dr4XRcKGbcw==
X-Received: by 2002:a05:6a00:3910:b0:728:e906:e446 with SMTP id d2e1a72fcca58-72d220077b5mr9905948b3a.24.1736407066229;
        Wed, 08 Jan 2025 23:17:46 -0800 (PST)
Received: from [10.4.51.182] ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad848020sm36417198b3a.81.2025.01.08.23.17.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 23:17:45 -0800 (PST)
Message-ID: <6b4c4abb-8d53-4b17-8a1c-1d28fb4d5f88@bytedance.com>
Date: Thu, 9 Jan 2025 15:17:33 +0800
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 13/15] arm64: mm: Guard page table writes with
 kpkeys
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Mark Brown <broonie@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Jann Horn <jannh@google.com>,
 Jeff Xu <jeffxu@chromium.org>, Joey Gouly <joey.gouly@arm.com>,
 Kees Cook <kees@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Andy Lutomirski <luto@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Pierre Langlois <pierre.langlois@arm.com>,
 Quentin Perret <qperret@google.com>, "Mike Rapoport (IBM)"
 <rppt@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
 Matthew Wilcox <willy@infradead.org>, linux-arm-kernel@lists.infradead.org,
 x86@kernel.org
References: <20250108103250.3188419-1-kevin.brodsky@arm.com>
 <20250108103250.3188419-14-kevin.brodsky@arm.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
Content-Language: en-US
In-Reply-To: <20250108103250.3188419-14-kevin.brodsky@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Kevin,

On 2025/1/8 18:32, Kevin Brodsky wrote:
> When CONFIG_KPKEYS_HARDENED_PGTABLES is enabled, page tables (both
> user and kernel) are mapped with a privileged pkey in the linear
> mapping. As a result, they can only be written under the
> kpkeys_hardened_pgtables guard, which sets POR_EL1 appropriately to
> allow such writes.
> 
> Use this guard wherever page tables genuinely need to be written,
> keeping its scope as small as possible (so that POR_EL1 is reset as
> fast as possible). Where atomics are involved, the guard's scope
> encompasses the whole loop to avoid switching POR_EL1 unnecessarily.
> 
> This patch is a no-op if CONFIG_KPKEYS_HARDENED_PGTABLES is disabled
> (default).
> 
> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
> ---
>   arch/arm64/include/asm/pgtable.h | 19 +++++++++++++++++--
>   arch/arm64/mm/fault.c            |  2 ++
>   2 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index f8dac6673887..0d60a49dc234 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -39,6 +39,7 @@
>   #include <linux/mm_types.h>
>   #include <linux/sched.h>
>   #include <linux/page_table_check.h>
> +#include <linux/kpkeys.h>
>   
>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>   #define __HAVE_ARCH_FLUSH_PMD_TLB_RANGE
> @@ -314,6 +315,7 @@ static inline pte_t pte_clear_uffd_wp(pte_t pte)
>   
>   static inline void __set_pte_nosync(pte_t *ptep, pte_t pte)
>   {
> +	guard(kpkeys_hardened_pgtables)();
>   	WRITE_ONCE(*ptep, pte);
>   }
>   
> @@ -758,6 +760,7 @@ static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
>   	}
>   #endif /* __PAGETABLE_PMD_FOLDED */
>   
> +	guard(kpkeys_hardened_pgtables)();
>   	WRITE_ONCE(*pmdp, pmd);
>   
>   	if (pmd_valid(pmd)) {

I noticed a long time ago that set_pte/set_pmd/... was implemented
separately by each architecture without a unified entry point. This
makes it difficult to add some hooks for them.

Taking set_pte() as an example, is it possible to do the following:

1) add a generic set_pte() in include/asm-generic/tlb.h (Or other more
    appropriate files)

static inline void set_pte(pte_t *ptep, pte_t pte)
{
	arch_set_pte(ptep, pte);
}

2) let each architecture include this file and rename the original
    set_pte() to arch_set_pte().

3) then we can add hooks for generic set_pte():

static inline void set_pte(pte_t *ptep, pte_t pte)
{
	guard(kpkeys_hardened_pgtables)();
	arch_set_pte(ptep, pte);
}

4) in this way, the architecture that supports
    ARCH_HAS_KPKEYS_HARDENED_PGTABLES only needs to implement
    the kpkeys_hardened_pgtables(), otherwise it is no-op.

Just some immature ideas, and the related set/clear interfaces
are currently quite messy. ;)

Of course, this does not affect the feature to be implemented
in this patch series.

Thanks!

