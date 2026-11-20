Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795200226;
	b=vxQYq1XExk0pBl/MkYdDlFZm6XK9i3DQfK+NhxOlwa12m/V2Eb5PthtSJFcgVPz3LaOr
	 1t3U4MOXO54K7k6FgCrzaGuddvew6yhfAnH2Z5ZUfSTZkI8plX5Gl50s9NJ7RlgqMqzo2
	 EPAWOGCoBIVyRUSmw9CumNeBDKKd8GjcxlYLUIVB1znDeUsIDPqh7TmLiO9uB2GF6lo1i
	 +rbmPVBp8y0VTkn21fbCsyL6n8aJ7LUYiPypVeSHcWSRs+280nPS1dFP/dbxTlISWBLch
	 frrBFrcYo0U8QE7+qU0ZuBd5wtLkVH7jrqxm9WukeXL/aFddWVQtipqIzQPD1hXa+og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795200226;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=IMJq8Im5jvUubCjaXWzkBzQ8ky3UlCewww95Sx3qer4=;
	b=NFYum6Yzb6KzJNS5ilfv8Fo6yurzIC1XWUX+O7/9aWDrg+YbQHfj+7J4AyWc+xblkYU7
	 AwBRH695flx17A97cEV/jO8/FBnEW/IlVxu5GLsyrn3JVHoY8Oc+qZxFl8Bjr5/u4O8Ox
	 ijuUWVLujYSJddmCct4nDDqfuzfetyGCfo8qwosuJY2uhzWgD95VsBdpYiWJrcrDXkWUT
	 2vFNExj4a3IU1oWRmlQvbiMD3Inn7DUTD6i8Z5NHiIBXQaGcH2/B4AySJ5ZToTvrtgFFd
	 qFezq5MX0B/WfBK/E/1kYwOm9n5je6mItMuUMXCa3cpijgBFXrelmOWIZqrb9XV16OQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=NIGqwzcq;
	arc=none smtp.remote-ip=91.218.175.72
Received: from mta0.migadu.com (out-72.mta0.migadu.com [91.218.175.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0049A606A339
	for <linux-hardening@vger.kernel.org>; Fri, 20 Nov 2026 18:43:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0049A606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=NIGqwzcq
X-Envelope-To: linux-hardening@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=h2XsgNE9NNIRa2pO1XoeMNvVdBFBn17o1mxzypbSArw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795200219; v=1; x=1795805019;
 b=NIGqwzcqsBbGBirPSnXcqypOpVK/y9EN4QIbMMgiREDGf1I4HXaxR5zosOecCUT9r93U3Vok
 ScuTNlkZG+xFEIr8MqupcNQyZoxIX1GgHdUlLxGw60/LpE4hTc6yEoLVjc9y1DGTPrXi0WTZXdL
 Iv4Cka+ju4W7nM5e1rtuUOZU=
X-Envelope-To: linux-hardening@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 6fc50e7af3291122;
	Fri, 20 Nov 2026 18:43:38 +0000
X-Mizu-Trace-ID: 6fc50e7af3291122
X-Migadu-Flow: FLOW_OUT
Message-ID: <bad389b1-f4a6-43d4-9531-54b75e067c7a@linux.dev>
Date: Fri, 20 Nov 2026 18:43:38 +0000
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] x86/kstack_erase: Use REP STOSQ for large stack fills
To: Peter Zijlstra <peterz@infradead.org>, ndesaulniers@google.com,
 David Laight <david.laight.linux@gmail.com>
Cc: tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, kees@kernel.org, hpa@zytor.com,
 gustavoars@kernel.org, ardb@kernel.org, hca@linux.ibm.com,
 nathan@kernel.org, ndesaulniers@google.com, morbo@google.com,
 justinstitt@google.com, linux-hardening@vger.kernel.org,
 llvm@lists.linux.dev, linux-kernel@vger.kernel.org, riel@surriel.com,
 shakeel.butt@linux.dev, kernel-team@meta.com, rkeilty@meta.com,
 atish.patra@linux.dev, dgreid@meta.com
References: <20261119213147.1094488-1-usama.arif@linux.dev>
 <20261119213147.1094488-3-usama.arif@linux.dev>
 <20261120104534.GO2668564@noisy.programming.kicks-ass.net>
 <20261120122635.GJ2669272@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Usama Arif <usama.arif@linux.dev>
In-Reply-To: <20261120122635.GJ2669272@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 20/11/2026 04:26, Peter Zijlstra wrote:
> On Fri, Nov 20, 2026 at 11:45:34AM +0100, Peter Zijlstra wrote:
>> On Thu, Nov 19, 2026 at 01:31:08PM -0800, Usama Arif wrote:
>>> +#ifdef CONFIG_X86_64
>>> +#define __stackleak_poison __stackleak_poison
>>> +static __always_inline void __stackleak_poison(unsigned long erase_low,
>>> +					       unsigned long erase_high,
>>> +					       unsigned long poison)
>>> +{
>>> +	unsigned long count;
>>> +
>>> +	/* Short spans do not amortize the startup cost of REP STOSQ. */
>>> +	if (erase_high <= erase_low + 512) {
>>> +		while (erase_low < erase_high) {
>>> +			*(unsigned long *)erase_low = poison;
>>> +			erase_low += sizeof(unsigned long);
>>> +		}
>>> +		return;
>>> +	}
>>> +
>>> +	count = (erase_high - erase_low) / sizeof(unsigned long);
>>> +	asm volatile("rep stosq"
>>> +		     : "+D" (erase_low), "+c" (count)
>>> +		     : "a" (poison)
>>> +		     : "memory");
>>> +}
>>> +#endif
>>
>> Gemini seems to suggest 16-32 words would be sufficient to amortize the
>> REP STOS setup. It was also adamant I try and unroll that earlier loop.
>>
>> How about something like so, does that make sense? Also, I suppose we
>> should make memset64() __always_inline if we use it here. I'm not at all
>> sold on the unroll here, the asm is pretty horrid for what it does.
> 
> This one is much improved:
> 
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -28,6 +28,7 @@ struct vm86;
>  #include <asm/vmxfeatures.h>
>  #include <asm/vdso/processor.h>
>  #include <asm/shstk.h>
> +#include <asm/string.h>
>  
>  #include <linux/personality.h>
>  #include <linux/cache.h>
> @@ -580,6 +581,35 @@ static __always_inline bool on_thread_st
>  			       current_stack_pointer) < THREAD_SIZE;
>  }
>  
> +#ifdef CONFIG_X86_64
> +#define __stackleak_poison __stackleak_poison
> +static __always_inline void __stackleak_poison(unsigned long erase_low,
> +					       unsigned long erase_high,
> +					       unsigned long poison)
> +{
> +	unsigned long count = (erase_high - erase_low) / sizeof(unsigned long);
> +
> +	/* Amortize the startup cost of REP STOSQ. */
> +	if (count < 32) {
> +		unsigned long *ptr = (unsigned long *)erase_low;
> +
> +		while (count) {
> +			unsigned long mod = (count-1) % 4;
> +			count -= mod+1;
> +			switch (mod) {
> +			case 3: ptr[count+3] = poison; fallthrough;
> +			case 2: ptr[count+2] = poison; fallthrough;
> +			case 1: ptr[count+1] = poison; fallthrough;
> +			case 0: ptr[count+0] = poison; break;
> +			}
> +		}
> +		return;
> +	}
> +

Hello Nick, Peter and David,

Thanks for the reviews! I should have used memset64 from the get go :)

I have tested 2 possible revisions now as well as this one from Peter,
have added both of them at the end of the reply.

- v2.1 where you loop upto 512B and then memset
- v2.2: 4 stores per loop up to 512 B, then 64-byte aligned memset64()

I timed stackleak_erase() in a Zen 5c guest over a futex/epoll/procfs/unix
syscall:

  No patch                             68.3 ns per erase
  v1 (loop up to 512 B, then REP)           46.6 ns
  v2.1 (loop up to 512 B, memset64())       46.6 ns
  this version                              46.4 ns
  v2.2 (4 stores/iteration, aligned REP)    43.7 ns


The switch doesn't seem to help.

Either way I kept 512 bytes: REP STOSQ only wins from ~430 bytes on Zen
5c against the plain loop (~850 against the unrolled one), and from ~320
on Cooper Lake.


My personal preference is v2.1, as its much simpler code and the difference
in performance between v2.1 and v2.2 isn't actually that much. But if there is
a stronger preference for v2.2, I can send that as it is faster.


v2.1:

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 77488ff5eb8c7c..3d205ae8566114 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -28,6 +28,7 @@ struct vm86;
 #include <asm/vmxfeatures.h>
 #include <asm/vdso/processor.h>
 #include <asm/shstk.h>
+#include <asm/string.h>

 #include <linux/personality.h>
 #include <linux/cache.h>
@@ -580,6 +581,26 @@ static __always_inline bool on_thread_stack(void)
                               current_stack_pointer) < THREAD_SIZE;
 }

+#if defined(CONFIG_X86_64) && !defined(CONFIG_KMSAN)
+#define __stackleak_poison __stackleak_poison
+static __always_inline void __stackleak_poison(unsigned long erase_low,
+                                              unsigned long erase_high,
+                                              unsigned long poison)
+{
+       /* Short spans do not amortize the startup cost of REP STOSQ. */
+       if (erase_high <= erase_low + 512) {
+               while (erase_low < erase_high) {
+                       *(unsigned long *)erase_low = poison;
+                       erase_low += sizeof(unsigned long);
+               }
+               return;
+       }
+
+       memset64((u64 *)erase_low, poison,
+                (erase_high - erase_low) / sizeof(u64));
+}
+#endif
+
 #ifdef CONFIG_PARAVIRT_XXL
 #include <asm/paravirt.h>
 #else
diff --git a/arch/x86/include/asm/string_64.h b/arch/x86/include/asm/string_64.h
index 2dae70c2b01465..73cc91254b1381 100644
--- a/arch/x86/include/asm/string_64.h
+++ b/arch/x86/include/asm/string_64.h
@@ -54,7 +54,7 @@ static inline void *memset32(uint32_t *s, uint32_t v, size_t n)
 }

 #define __HAVE_ARCH_MEMSET64
-static inline void *memset64(uint64_t *s, uint64_t v, size_t n)
+static __always_inline void *memset64(uint64_t *s, uint64_t v, size_t n)
 {
        const auto s0 = s;
        asm volatile (





v2.2:

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 77488ff5eb8c7c..5e76e1140908d7 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -28,7 +28,9 @@ struct vm86;
 #include <asm/vmxfeatures.h>
 #include <asm/vdso/processor.h>
 #include <asm/shstk.h>
+#include <asm/string.h>

+#include <linux/align.h>
 #include <linux/personality.h>
 #include <linux/cache.h>
 #include <linux/threads.h>
@@ -580,6 +582,48 @@ static __always_inline bool on_thread_stack(void)
                               current_stack_pointer) < THREAD_SIZE;
 }

+#if defined(CONFIG_X86_64) && !defined(CONFIG_KMSAN)
+#define __stackleak_poison __stackleak_poison
+static __always_inline void __stackleak_poison(unsigned long erase_low,
+                                              unsigned long erase_high,
+                                              unsigned long poison)
+{
+       unsigned long *p = (unsigned long *)erase_low;
+       unsigned long *end = (unsigned long *)erase_high;
+       unsigned long i;
+
+       /* Fewer than four words, or nothing to do. */
+       if (erase_high < erase_low + 4 * sizeof(*p)) {
+               while (p < end)
+                       *p++ = poison;
+               return;
+       }
+
+       /* Four stores per iteration; the last four may overlap. */
+       if (erase_high - erase_low <= 512) {
+               end -= 4;
+               while (p < end) {
+                       p[0] = poison;
+                       p[1] = poison;
+                       p[2] = poison;
+                       p[3] = poison;
+                       p += 4;
+               }
+               end[0] = poison;
+               end[1] = poison;
+               end[2] = poison;
+               end[3] = poison;
+               return;
+       }
+
+       /* REP STOSQ is faster from a 64-byte aligned destination. */
+       for (i = 0; i < 8; i++)
+               p[i] = poison;
+       p = (unsigned long *)ALIGN(erase_low + 1, 64);
+       memset64((u64 *)p, poison, end - p);
+}
+#endif
+
 #ifdef CONFIG_PARAVIRT_XXL
 #include <asm/paravirt.h>
 #else
diff --git a/arch/x86/include/asm/string_64.h b/arch/x86/include/asm/string_64.h
index 2dae70c2b01465..73cc91254b1381 100644
--- a/arch/x86/include/asm/string_64.h
+++ b/arch/x86/include/asm/string_64.h
@@ -54,7 +54,7 @@ static inline void *memset32(uint32_t *s, uint32_t v, size_t n)
 }

 #define __HAVE_ARCH_MEMSET64
-static inline void *memset64(uint64_t *s, uint64_t v, size_t n)
+static __always_inline void *memset64(uint64_t *s, uint64_t v, size_t n)
 {
        const auto s0 = s;
        asm volatile (

> +	memset64((void *)erase_low, poison, count);
> +}
> +#endif
> +
>  #ifdef CONFIG_PARAVIRT_XXL
>  #include <asm/paravirt.h>
>  #else

