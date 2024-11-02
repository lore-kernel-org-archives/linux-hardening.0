Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B2D4EB50;
	Sat,  2 Nov 2024 20:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730580233; cv=none; b=SsYfiwpxFYcrxNAfGHTLkQ+Z4XgkcqRiVwPEk9ZRueAl0SAokxCsOwTPlUSI2DBQoEb2FSqhVBPS0m51DB8H5UMD1ktr3bueCmkwH9uxOv5mEKVLOrgAoIeXjucK6TucVg8B5MPH7jEQ0T2ymP17a92F1ciF+12zWkhs/AR0Ls4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730580233; c=relaxed/simple;
	bh=R8Ity0l1+p963dlS/UV3AA4DyLL41Dth45YcI9GZVUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FYgjnYuEQqPHascBq1WLhc5uau50+IKPUvF9T3gyvgYbQVuGhg47BhOKft62p9Zh3WgCKxQdx6x7Dqy2DrNvl2KBINKa3qGH1mxb2bnT+9ivKwlmMO4Wu1ct/yQanbPBtCQkmwR+ImwWaXnlLVoOKIBLWWn+XL8cfT67uOHPiZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oyOGDivG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oyOGDivG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AA60C4CEC3;
	Sat,  2 Nov 2024 20:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730580232;
	bh=R8Ity0l1+p963dlS/UV3AA4DyLL41Dth45YcI9GZVUk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oyOGDivGff3v0MBiBcrUq0W1uaAX8clrnMiwnlF8JexJKiXWL/7A9i7PT35QysCqB
	 nfj1faOr4xhJRW8yuD7UoTit0bTqQy+05b2Is7ZtLb/uuqhR2l52oIyUSh8BtlLBwP
	 adlJ+g6hZDi2O3mbz7L3V7q3o2sWcDN9KOFhj70pSk5D1TeDO+iGcYI3H66pv2J17j
	 HuY21rm0VJ9JRKv7SHE4NQC8aH7cshj0hFuTKq2r3eqqU2mQWBAx7Z1GCCkbp/rSV2
	 WI3X45fpVaE2BZUoX1FzxqH9Yfrhqvcz6ZphesbENLA7e4MIT+FdPu7DSdOyQXRrQw
	 nVMooMTwNfaag==
Date: Sat, 2 Nov 2024 13:43:48 -0700
From: Kees Cook <kees@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Fortify compilation warning in __padata_set_cpumask()
Message-ID: <202411021337.85E9BB06@keescook>
References: <db7190c8-d17f-4a0d-bc2f-5903c79f36c2@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <db7190c8-d17f-4a0d-bc2f-5903c79f36c2@t-8ch.de>

On Thu, Oct 31, 2024 at 08:40:33PM +0000, Thomas Weißschuh wrote:
> Hi Kees,
> 
> I'm running into compilation warnings/errors due to fortify-string.h.
> 
> Environment:
> - Commit 0fc810ae3ae110f9e2fcccce80fc8c8d62f97907 (current mainline master)
> - gcc (GCC) 14.2.1 20240910
> - Relevant config (from an Arch Linux distro config):
> 	CONFIG_64BIT=y
> 	CONFIG_X86_64=y
> 	CONFIG_NR_CPUS=320
>         CONFIG_NR_CPUS_RANGE_BEGIN=2
>         CONFIG_NR_CPUS_RANGE_END=512
>         CONFIG_NR_CPUS_RANGE_DEFAULT=64
> 	CONFIG_PADATA=y
> 
> Warning:
> 
>       CC      kernel/padata.o
>     In file included from ./include/linux/string.h:390,
>                      from ./include/linux/bitmap.h:13,
>                      from ./include/linux/cpumask.h:12,
>                      from ./arch/x86/include/asm/paravirt.h:21,
>                      from ./arch/x86/include/asm/irqflags.h:80,
>                      from ./include/linux/irqflags.h:18,
>                      from ./include/linux/spinlock.h:59,
>                      from ./include/linux/swait.h:7,
>                      from ./include/linux/completion.h:12,
>                      from kernel/padata.c:14:
>     In function ‘bitmap_copy’,
>         inlined from ‘cpumask_copy’ at ./include/linux/cpumask.h:839:2,
>         inlined from ‘__padata_set_cpumasks’ at kernel/padata.c:730:2:
>     ./include/linux/fortify-string.h:114:33: error: ‘__builtin_memcpy’ reading between 41 and 536870904 bytes from a region of size 40 [-Werror=stringop-overread]
>       114 | #define __underlying_memcpy     __builtin_memcpy
>           |                                 ^
>     ./include/linux/fortify-string.h:633:9: note: in expansion of macro ‘__underlying_memcpy’
>       633 |         __underlying_##op(p, q, __fortify_size);                        \
>           |         ^~~~~~~~~~~~~
>     ./include/linux/fortify-string.h:678:26: note: in expansion of macro ‘__fortify_memcpy_chk’
>       678 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
>           |                          ^~~~~~~~~~~~~~~~~~~~
>     ./include/linux/bitmap.h:259:17: note: in expansion of macro ‘memcpy’
>       259 |                 memcpy(dst, src, len);
>           |                 ^~~~~~
>     kernel/padata.c: In function ‘__padata_set_cpumasks’:
>     kernel/padata.c:713:48: note: source object ‘pcpumask’ of size [0, 40]
>       713 |                                  cpumask_var_t pcpumask,
>           |                                  ~~~~~~~~~~~~~~^~~~~~~~
>     In function ‘bitmap_copy’,
>         inlined from ‘cpumask_copy’ at ./include/linux/cpumask.h:839:2,
>         inlined from ‘__padata_set_cpumasks’ at kernel/padata.c:730:2:
>     ./include/linux/fortify-string.h:114:33: error: ‘__builtin_memcpy’ reading between 41 and 536870904 bytes from a region of size 40 [-Werror=stringop-overread]
>       114 | #define __underlying_memcpy     __builtin_memcpy
>           |                                 ^
>     ./include/linux/fortify-string.h:633:9: note: in expansion of macro ‘__underlying_memcpy’
>       633 |         __underlying_##op(p, q, __fortify_size);                        \
>           |         ^~~~~~~~~~~~~
>     ./include/linux/fortify-string.h:678:26: note: in expansion of macro ‘__fortify_memcpy_chk’
>       678 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
>           |                          ^~~~~~~~~~~~~~~~~~~~
>     ./include/linux/bitmap.h:259:17: note: in expansion of macro ‘memcpy’
>       259 |                 memcpy(dst, src, len);
>           |                 ^~~~~~
>     kernel/padata.c: In function ‘__padata_set_cpumasks’:
>     kernel/padata.c:713:48: note: source object ‘pcpumask’ of size [0, 40]
>       713 |                                  cpumask_var_t pcpumask,
>           |                                  ~~~~~~~~~~~~~~^~~~~~~~
>     cc1: all warnings being treated as errors
> 
> Code:
> 
>    712	static int __padata_set_cpumasks(struct padata_instance *pinst,
>    713					 cpumask_var_t pcpumask,
>    714					 cpumask_var_t cbcpumask)
>    715	{
>    716		int valid;
>    717		int err;
>    718	
>    719		valid = padata_validate_cpumask(pinst, pcpumask);
>    720		if (!valid) {
>    721			__padata_stop(pinst);
>    722			goto out_replace;
>    723		}
>    724	
>    725		valid = padata_validate_cpumask(pinst, cbcpumask);
>    726		if (!valid)
>    727			__padata_stop(pinst);
>    728	
>    729	out_replace:
>    730		cpumask_copy(pinst->cpumask.pcpu, pcpumask);
>    731		cpumask_copy(pinst->cpumask.cbcpu, cbcpumask);
>    732	
>    733		err = padata_setup_cpumasks(pinst) ?: padata_replace(pinst);
>    734	
>    735		if (valid)
>    736			__padata_start(pinst);
>    737	
>    738		return err;
>    739	}
> 
> 
> The weird thing is, that only the cpumask_copy() in line 730 triggers
> this warning. The one in line 731 doesn't. Also this is the only
> instance of the warning I see in the whole build.
> 
> The warning goes away with the following change, but that introduces
> runtime overhead and feels wrong. Also it doesn't explain why this
> specific call is different from all others.
> 
> diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
> index 9278a50d514f..ded9d1bcef03 100644
> --- a/include/linux/cpumask.h
> +++ b/include/linux/cpumask.h
> @@ -836,7 +838,7 @@ void cpumask_shift_left(struct cpumask *dstp, const struct cpumask *srcp, int n)
>  static __always_inline
>  void cpumask_copy(struct cpumask *dstp, const struct cpumask *srcp)
>  {
> -	bitmap_copy(cpumask_bits(dstp), cpumask_bits(srcp), large_cpumask_bits);
> +	bitmap_copy(cpumask_bits(dstp), cpumask_bits(srcp), MIN(NR_CPUS, large_cpumask_bits));
>  }
>  
>  /**
> 
> Any ideas?

My notes on looking at this:

#define DECLARE_BITMAP(name,bits) \
        unsigned long name[BITS_TO_LONGS(bits)]
...
typedef struct cpumask { DECLARE_BITMAP(bits, NR_CPUS); } cpumask_t;

#ifdef CONFIG_CPUMASK_OFFSTACK
typedef struct cpumask *cpumask_var_t;
#else
typedef struct cpumask cpumask_var_t[1];
#endif /* CONFIG_CPUMASK_OFFSTACK */

...
#define cpumask_bits(maskp) ((maskp)->bits)
...

int padata_set_cpumask(struct padata_instance *pinst, int cpumask_type,
                       cpumask_var_t cpumask)
...
        struct cpumask *serial_mask, *parallel_mask;
...
                parallel_mask = cpumask;
        ...or...
                parallel_mask = pinst->cpumask.pcpu;
        ...
        err =  __padata_set_cpumasks(pinst, parallel_mask, serial_mask);

...
static int __padata_set_cpumasks(struct padata_instance *pinst,
                                 cpumask_var_t pcpumask,
                                 cpumask_var_t cbcpumask)
...
        cpumask_copy(pinst->cpumask.cbcpu, cbcpumask);
...
static __always_inline
void cpumask_copy(struct cpumask *dstp, const struct cpumask *srcp)
{
        bitmap_copy(cpumask_bits(dstp), cpumask_bits(srcp),
large_cpumask_bits);
}
...
extern unsigned int nr_cpu_ids;
...
#if NR_CPUS <= BITS_PER_LONG // false: 320 <= 64
  #define small_cpumask_bits ((unsigned int)NR_CPUS)
  #define large_cpumask_bits ((unsigned int)NR_CPUS)
#elif NR_CPUS <= 4*BITS_PER_LONG // false: 320 <= 256
  #define small_cpumask_bits nr_cpu_ids
  #define large_cpumask_bits ((unsigned int)NR_CPUS)
#else
  #define small_cpumask_bits nr_cpu_ids
  #define large_cpumask_bits nr_cpu_ids // not a compile-time constant
#endif
...
static __always_inline
void bitmap_copy(unsigned long *dst, const unsigned long *src, unsigned
int nbits)
{
        unsigned int len = bitmap_size(nbits);

        if (small_const_nbits(nbits))
                *dst = *src;
        else
                memcpy(dst, src, len);
}

So the result is:

memcpy(pcpumask->bits, cbcpumask->bits, nr_cpu_ids)

And the error is that the compiler has determined that nc_cpu_ids got
limited to possibly have a value between 41 and 536870904. This is an
odd limit, though: 0x1FFFFFF8, but does feel constructable -- it's close
to some magic numbers.

There are some new diagnostics being added to GCC that might help track
this down[1]. I'm waiting for a v4 before I take it for a spin.

-Kees

[1] https://gcc.gnu.org/pipermail/gcc-patches/2024-October/666870.html

-- 
Kees Cook
