Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795271928;
	b=oTEtix965dSFfuj9EbRD2h7wic6W7uDt3wZpipYTW1HelRmsS7xsATRuEc2UXrJGWz4E
	 VTRAftm+asFbRDfdaRjAULbfq4BzVOFqu3sNOf32keQtHBsf8FcT1bxtBzbPuUoncAy5z
	 45tPdx1KEgIdfAujN7BtVdmr19L0SP68zqeL/XRxKo+dI0bu7ZD+fO6QY5mY3De4gellY
	 cgaCSQEK/CyWU1QTF6Y3RkKPPIEIdoQ/fO9i3enflzU4B+U+g/xUid0llNvTr7nbaGbkw
	 WRg+DSbzZMRhAJU+F3nfUv3KyaeILSQgx/lny5EH3/bbrrcIhu6Bjw7J5vNxesCKyqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795271928;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=kwfbDfUYC3HmLJKxPLVjYyrlsbi80iQOjcAuKR3mfsI=;
	b=RyjHAiDdiKM2pHPaZzCD0IrcTfWgMQl1mcwB+zUvN74Qr4KZjxSvJ2zrxBi2mlhWoWBm
	 yEqqzDYfden6MbqTqo9MwHz70U8QdPHmOJbWJ3x4TrEnpB0OeIVMJLO6aQEbXQ9cP4NjJ
	 0hRzKP4ytrNEQwTfcToP42O+zkfkHb25Hn6AR8b43iug/MUHSShqV8Ukegdcb4V7/Znrw
	 8LSGjQB3hQ7SXykcNYf/4zKz3+8EQZ5PaODF17q1cLITvnLYk7/l9F8IQmwKp+wwZXU+W
	 5rOoaV1ej+h7F1s1gdlbigLgnslTLtTss/fF3WE4f6gi1hBPwZPOt10uCTTFXxDpb6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=HGFauasM;
	arc=none smtp.remote-ip=91.218.175.5
Received: from mta0.migadu.com (out-5.mta0.migadu.com [91.218.175.5])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E850D606A320
	for <linux-hardening@vger.kernel.org>; Sat, 21 Nov 2026 14:38:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E850D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=HGFauasM
X-Envelope-To: linux-hardening@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=DJoNk6njaXjd07iLpBiMNljDnSHhT0VPJ3gnJrq+Kp4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795271925; v=1; x=1795876725;
 b=HGFauasMg5n8tb4cVc/hMGwHYkX1k9ONST2Y7F+pYF3KAkx8cVgyxxOA8eNcMVqZ7OXBA7Zb
 wXR/VkxRq/LtRS1pH2WWHPPWuLeirr3xuyBakf/FDMoNZRcgwGAGvKr7Z308mKGXytDMlK/Qoec
 +xvoNrWf0rh26wewcxudLsKk=
X-Envelope-To: linux-hardening@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 169e1c4f87af6751;
	Sat, 21 Nov 2026 14:38:44 +0000
X-Mizu-Trace-ID: 169e1c4f87af6751
X-Migadu-Flow: FLOW_OUT
Message-ID: <75903c49-841e-4957-b32a-802e107a3f34@linux.dev>
Date: Sat, 21 Nov 2026 14:38:44 +0000
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
To: David Laight <david.laight.linux@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>
Cc: ndesaulniers@google.com, tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, kees@kernel.org, hpa@zytor.com,
 gustavoars@kernel.org, ardb@kernel.org, hca@linux.ibm.com,
 nathan@kernel.org, morbo@google.com, justinstitt@google.com,
 linux-hardening@vger.kernel.org, llvm@lists.linux.dev,
 linux-kernel@vger.kernel.org, riel@surriel.com, shakeel.butt@linux.dev,
 kernel-team@meta.com, rkeilty@meta.com, atish.patra@linux.dev,
 dgreid@meta.com
References: <20261119213147.1094488-1-usama.arif@linux.dev>
 <20261119213147.1094488-3-usama.arif@linux.dev>
 <20261120104534.GO2668564@noisy.programming.kicks-ass.net>
 <20261120122635.GJ2669272@noisy.programming.kicks-ass.net>
 <bad389b1-f4a6-43d4-9531-54b75e067c7a@linux.dev>
 <20261120222211.2f0d5cbc@pumpkin>
Content-Language: en-US
From: Usama Arif <usama.arif@linux.dev>
In-Reply-To: <20261120222211.2f0d5cbc@pumpkin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 20/11/2026 14:22, David Laight wrote:
> On Fri, 20 Nov 2026 18:43:38 +0000
> Usama Arif <usama.arif@linux.dev> wrote:
> 
>> On 20/11/2026 04:26, Peter Zijlstra wrote:
>>> On Fri, Nov 20, 2026 at 11:45:34AM +0100, Peter Zijlstra wrote:  
>>>> On Thu, Nov 19, 2026 at 01:31:08PM -0800, Usama Arif wrote:  
>>>>> +#ifdef CONFIG_X86_64
>>>>> +#define __stackleak_poison __stackleak_poison
>>>>> +static __always_inline void __stackleak_poison(unsigned long erase_low,
>>>>> +					       unsigned long erase_high,
>>>>> +					       unsigned long poison)
>>>>> +{
>>>>> +	unsigned long count;
>>>>> +
>>>>> +	/* Short spans do not amortize the startup cost of REP STOSQ. */
>>>>> +	if (erase_high <= erase_low + 512) {
>>>>> +		while (erase_low < erase_high) {
>>>>> +			*(unsigned long *)erase_low = poison;
>>>>> +			erase_low += sizeof(unsigned long);
>>>>> +		}
>>>>> +		return;
>>>>> +	}
>>>>> +
>>>>> +	count = (erase_high - erase_low) / sizeof(unsigned long);
>>>>> +	asm volatile("rep stosq"
>>>>> +		     : "+D" (erase_low), "+c" (count)
>>>>> +		     : "a" (poison)
>>>>> +		     : "memory");
>>>>> +}
>>>>> +#endif  
>>>>
>>>> Gemini seems to suggest 16-32 words would be sufficient to amortize the
>>>> REP STOS setup. It was also adamant I try and unroll that earlier loop.
>>>>
>>>> How about something like so, does that make sense? Also, I suppose we
>>>> should make memset64() __always_inline if we use it here. I'm not at all
>>>> sold on the unroll here, the asm is pretty horrid for what it does.  
>>>
>>> This one is much improved:
>>>
>>> --- a/arch/x86/include/asm/processor.h
>>> +++ b/arch/x86/include/asm/processor.h
>>> @@ -28,6 +28,7 @@ struct vm86;
>>>  #include <asm/vmxfeatures.h>
>>>  #include <asm/vdso/processor.h>
>>>  #include <asm/shstk.h>
>>> +#include <asm/string.h>
>>>  
>>>  #include <linux/personality.h>
>>>  #include <linux/cache.h>
>>> @@ -580,6 +581,35 @@ static __always_inline bool on_thread_st
>>>  			       current_stack_pointer) < THREAD_SIZE;
>>>  }
>>>  
>>> +#ifdef CONFIG_X86_64
>>> +#define __stackleak_poison __stackleak_poison
>>> +static __always_inline void __stackleak_poison(unsigned long erase_low,
>>> +					       unsigned long erase_high,
>>> +					       unsigned long poison)
>>> +{
>>> +	unsigned long count = (erase_high - erase_low) / sizeof(unsigned long);
>>> +
>>> +	/* Amortize the startup cost of REP STOSQ. */
>>> +	if (count < 32) {
>>> +		unsigned long *ptr = (unsigned long *)erase_low;
>>> +
>>> +		while (count) {
>>> +			unsigned long mod = (count-1) % 4;
>>> +			count -= mod+1;
>>> +			switch (mod) {
>>> +			case 3: ptr[count+3] = poison; fallthrough;
>>> +			case 2: ptr[count+2] = poison; fallthrough;
>>> +			case 1: ptr[count+1] = poison; fallthrough;
>>> +			case 0: ptr[count+0] = poison; break;
>>> +			}
>>> +		}
>>> +		return;
>>> +	}
>>> +  
>>
>> Hello Nick, Peter and David,
>>
>> Thanks for the reviews! I should have used memset64 from the get go :)
>>
>> I have tested 2 possible revisions now as well as this one from Peter,
>> have added both of them at the end of the reply.
>>
>> - v2.1 where you loop upto 512B and then memset
>> - v2.2: 4 stores per loop up to 512 B, then 64-byte aligned memset64()
>>
>> I timed stackleak_erase() in a Zen 5c guest over a futex/epoll/procfs/unix
>> syscall:
>>
>>   No patch                             68.3 ns per erase
>>   v1 (loop up to 512 B, then REP)           46.6 ns
>>   v2.1 (loop up to 512 B, memset64())       46.6 ns
>>   this version                              46.4 ns
>>   v2.2 (4 stores/iteration, aligned REP)    43.7 ns
> 
> What are the lengths of those erases?

Its a mixture of lengths, coming from getppid(), read(), write(),
futex(), unix socket send(), receive(). I asked LLM to come up
with a benchmark with a mixture of syscalls that would target
a real world usecase and it came up with this which I found
to be quite good.

> (and where does the 46ns come from??)

It's the whole stackleak_erase(), the search for the poison plus the
fill, timed with rdtsc_ordered() in the kernel on every return to user,
minus an empty timed region, and averaged over all of the above.

> I'd definitely time 'just the code loop  - various loops' and
> 'just rep stos'.
> 
>> The switch doesn't seem to help.
> 
> To many conditions in the loop.
> You could do it this way:
> 	switch (count & 3) {
> 	case 0: do { *ptr++ = poison;
> 	case 3:      *ptr++ = poison;
> 	case 2:      *ptr++ = poison;
> 	case 1:      *ptr++ = poison;
> 		} while ((count -= 4) > 0);
> 	}
> (give or take some off-by-one here and there).
> But I suspect that using Duff's device is frowned up.
> 
>> Either way I kept 512 bytes: REP STOSQ only wins from ~430 bytes on Zen
>> 5c against the plain loop (~850 against the unrolled one),
> 
> For zen5 you should only need to unroll the loop once (two writes per iteration).
> In my experiments it can execute a loop in one clock.
> Unless the compiler unrolled it for you (and got it right!) the original
> loop would be half the speed 
> 
>> and from ~320 on Cooper Lake.
> 
> I'd also try some older Intel cpu.
> The setup costs are likely to be higher with FRMS and friends.
> 

It will be difficult for me to get access to CPUs older than Cooper Lake
which is 6 years old. I think if we try and profile and fit for every CPU,
this patch wont go anywhere. As seen in [1], the differences between the
the different optimizations are small, IMHO, we should just go for the most
maintainable approach, which I think is you loop upto 512B and then memset.


[1] https://lore.kernel.org/all/bad389b1-f4a6-43d4-9531-54b75e067c7a@linux.dev/



> David
> 
>>
>>
>> My personal preference is v2.1, as its much simpler code and the difference
>> in performance between v2.1 and v2.2 isn't actually that much. But if there is
>> a stronger preference for v2.2, I can send that as it is faster.
>>
>>
>> v2.1:
>>
>> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
>> index 77488ff5eb8c7c..3d205ae8566114 100644
>> --- a/arch/x86/include/asm/processor.h
>> +++ b/arch/x86/include/asm/processor.h
>> @@ -28,6 +28,7 @@ struct vm86;
>>  #include <asm/vmxfeatures.h>
>>  #include <asm/vdso/processor.h>
>>  #include <asm/shstk.h>
>> +#include <asm/string.h>
>>
>>  #include <linux/personality.h>
>>  #include <linux/cache.h>
>> @@ -580,6 +581,26 @@ static __always_inline bool on_thread_stack(void)
>>                                current_stack_pointer) < THREAD_SIZE;
>>  }
>>
>> +#if defined(CONFIG_X86_64) && !defined(CONFIG_KMSAN)
>> +#define __stackleak_poison __stackleak_poison
>> +static __always_inline void __stackleak_poison(unsigned long erase_low,
>> +                                              unsigned long erase_high,
>> +                                              unsigned long poison)
>> +{
>> +       /* Short spans do not amortize the startup cost of REP STOSQ. */
>> +       if (erase_high <= erase_low + 512) {
>> +               while (erase_low < erase_high) {
>> +                       *(unsigned long *)erase_low = poison;
>> +                       erase_low += sizeof(unsigned long);
>> +               }
>> +               return;
>> +       }
>> +
>> +       memset64((u64 *)erase_low, poison,
>> +                (erase_high - erase_low) / sizeof(u64));
>> +}
>> +#endif
>> +
>>  #ifdef CONFIG_PARAVIRT_XXL
>>  #include <asm/paravirt.h>
>>  #else
>> diff --git a/arch/x86/include/asm/string_64.h b/arch/x86/include/asm/string_64.h
>> index 2dae70c2b01465..73cc91254b1381 100644
>> --- a/arch/x86/include/asm/string_64.h
>> +++ b/arch/x86/include/asm/string_64.h
>> @@ -54,7 +54,7 @@ static inline void *memset32(uint32_t *s, uint32_t v, size_t n)
>>  }
>>
>>  #define __HAVE_ARCH_MEMSET64
>> -static inline void *memset64(uint64_t *s, uint64_t v, size_t n)
>> +static __always_inline void *memset64(uint64_t *s, uint64_t v, size_t n)
>>  {
>>         const auto s0 = s;
>>         asm volatile (
>>
>>
>>
>>
>>
>> v2.2:
>>
>> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
>> index 77488ff5eb8c7c..5e76e1140908d7 100644
>> --- a/arch/x86/include/asm/processor.h
>> +++ b/arch/x86/include/asm/processor.h
>> @@ -28,7 +28,9 @@ struct vm86;
>>  #include <asm/vmxfeatures.h>
>>  #include <asm/vdso/processor.h>
>>  #include <asm/shstk.h>
>> +#include <asm/string.h>
>>
>> +#include <linux/align.h>
>>  #include <linux/personality.h>
>>  #include <linux/cache.h>
>>  #include <linux/threads.h>
>> @@ -580,6 +582,48 @@ static __always_inline bool on_thread_stack(void)
>>                                current_stack_pointer) < THREAD_SIZE;
>>  }
>>
>> +#if defined(CONFIG_X86_64) && !defined(CONFIG_KMSAN)
>> +#define __stackleak_poison __stackleak_poison
>> +static __always_inline void __stackleak_poison(unsigned long erase_low,
>> +                                              unsigned long erase_high,
>> +                                              unsigned long poison)
>> +{
>> +       unsigned long *p = (unsigned long *)erase_low;
>> +       unsigned long *end = (unsigned long *)erase_high;
>> +       unsigned long i;
>> +
>> +       /* Fewer than four words, or nothing to do. */
>> +       if (erase_high < erase_low + 4 * sizeof(*p)) {
>> +               while (p < end)
>> +                       *p++ = poison;
>> +               return;
>> +       }
>> +
>> +       /* Four stores per iteration; the last four may overlap. */
>> +       if (erase_high - erase_low <= 512) {
>> +               end -= 4;
>> +               while (p < end) {
>> +                       p[0] = poison;
>> +                       p[1] = poison;
>> +                       p[2] = poison;
>> +                       p[3] = poison;
>> +                       p += 4;
>> +               }
>> +               end[0] = poison;
>> +               end[1] = poison;
>> +               end[2] = poison;
>> +               end[3] = poison;
>> +               return;
>> +       }
>> +
>> +       /* REP STOSQ is faster from a 64-byte aligned destination. */
>> +       for (i = 0; i < 8; i++)
>> +               p[i] = poison;
>> +       p = (unsigned long *)ALIGN(erase_low + 1, 64);
>> +       memset64((u64 *)p, poison, end - p);
>> +}
>> +#endif
>> +
>>  #ifdef CONFIG_PARAVIRT_XXL
>>  #include <asm/paravirt.h>
>>  #else
>> diff --git a/arch/x86/include/asm/string_64.h b/arch/x86/include/asm/string_64.h
>> index 2dae70c2b01465..73cc91254b1381 100644
>> --- a/arch/x86/include/asm/string_64.h
>> +++ b/arch/x86/include/asm/string_64.h
>> @@ -54,7 +54,7 @@ static inline void *memset32(uint32_t *s, uint32_t v, size_t n)
>>  }
>>
>>  #define __HAVE_ARCH_MEMSET64
>> -static inline void *memset64(uint64_t *s, uint64_t v, size_t n)
>> +static __always_inline void *memset64(uint64_t *s, uint64_t v, size_t n)
>>  {
>>         const auto s0 = s;
>>         asm volatile (
>>
>>> +	memset64((void *)erase_low, poison, count);
>>> +}
>>> +#endif
>>> +
>>>  #ifdef CONFIG_PARAVIRT_XXL
>>>  #include <asm/paravirt.h>
>>>  #else  
>>
>>
> 

