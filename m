Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.235
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795200367;
	b=l+DBT7pAz0IjHAOM5C4PQJTetNeux7hLNcUmqiQMvDhiDMbmaNFbJLxsRJQsp1MAG/UX
	 QSrNy6QR5yVNshY/M5Kb9gBsUn8cYZAuIv1y6CVQre9jcsTjBY5HyjYEct90W0zxX6pO0
	 DLTvxrrhLqutlrfrpTKpcB8xTiQtptJZHEgssl7nIWDlHV8iCoUEZ1zPQ/mJCg1sS9ztZ
	 lFJBYgOxmRxM9P/EMlRq8JySYDWEySks70FyumDuQqQjs6bBbksGVxhPdp/lr6xMmMEAm
	 6T/5Lp/124GjlPAHeKrFpCOpWF8CMfvm7ulmyaWR3yVQqKZpNFmQOsDTLC4V1ejQDvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795200367;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=SkASd/qNBkxxFs06CQ7eeDuHU5EZJ14PhndgF/1gZLk=;
	b=sxmpb1ORpZZtCTciJrLMJDtt34VVvgLuxxPXWimDq15WQqzDviSMexWmd0nydFXj/8t+
	 eiN8/pkktX5G7MV/ybupJSgI8yJ7OHWuBSnI2KrPyv4KQwbKQW2qIc+Qz3wVWVBACvsZT
	 u4EAugaO6AQ8uQSoM2QKhXrqz7SikipnodtV9sjrBIvD7MZUjRJk4dBxKJE8b3buexFkx
	 BA1Ps1cyWOAV/LtOb0EiFkwlHMn27twslHsr4SzFs7ZdxvIkaD+xnijvqnYv94jnpY2zw
	 u1Z/lLi27gjsp6UiWNbbxtNJFcxIx27KE1Npl49YGfErtB5+5rOKvAzPuiuj8klQnrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=xteX8paw;
	arc=none smtp.remote-ip=95.215.58.235
Received: from mta1.migadu.com (out-235.mta1.migadu.com [95.215.58.235])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F6E60A261A
	for <linux-hardening@vger.kernel.org>; Fri, 20 Nov 2026 18:46:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0F6E60A261A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=xteX8paw
X-Envelope-To: linux-hardening@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=EIH8iRjUa5W8iIljbsoNc3X3NMc7UBZb7RaLAO5PA7Q=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795200362; v=1; x=1795805162;
 b=xteX8paw+ARfkgWbet8X09Evv26cs5EIroZncU8VebEyko21SLXFuqQopFNDRI5Rp+9Y7q9z
 F9jFhP9hDVF8R1Q9uz5oqd927vDR9LrwdIgO8jyir3PqpAce6rlxYOHq6Y7ypz8mfwr7pX6Qj5v
 5KLtbjsco4dPS5i71wM2IhIA=
X-Envelope-To: linux-hardening@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 23cfc07e8818ea36;
	Fri, 20 Nov 2026 18:46:02 +0000
X-Mizu-Trace-ID: 23cfc07e8818ea36
X-Migadu-Flow: FLOW_OUT
Message-ID: <97e94491-ce19-45a1-8737-b30b49e997e8@linux.dev>
Date: Fri, 20 Nov 2026 18:46:01 +0000
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
 Nick Desaulniers <ndesaulniers@google.com>
Cc: tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, kees@kernel.org, hpa@zytor.com,
 gustavoars@kernel.org, ardb@kernel.org, hca@linux.ibm.com,
 nathan@kernel.org, morbo@google.com, justinstitt@google.com,
 linux-hardening@vger.kernel.org, llvm@lists.linux.dev,
 linux-kernel@vger.kernel.org, riel@surriel.com, shakeel.butt@linux.dev,
 kernel-team@meta.com, rkeilty@meta.com, atish.patra@linux.dev,
 dgreid@meta.com
References: <20261119213147.1094488-1-usama.arif@linux.dev>
 <20261119213147.1094488-3-usama.arif@linux.dev>
 <CAKwvOdnzNU_xtLeb4vXSFe3DLN9QmdNSSReUmQahsLX+1pZxCw@mail.gmail.com>
 <20261120113825.234bee1c@pumpkin> <20261120124252.14ff8a74@pumpkin>
Content-Language: en-US
From: Usama Arif <usama.arif@linux.dev>
In-Reply-To: <20261120124252.14ff8a74@pumpkin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 20/11/2026 04:42, David Laight wrote:
> On Fri, 20 Nov 2026 11:38:25 +0000
> David Laight <david.laight.linux@gmail.com> wrote:
> 
>> On Thu, 19 Nov 2026 14:28:04 -0800
>> Nick Desaulniers <ndesaulniers@google.com> wrote:
>>
>>> On Thu, Nov 19, 2026 at 1:32 PM Usama Arif <usama.arif@linux.dev> wrote:  
>>>>
>>>> With KSTACK_ERASE, every return to user space poisons the part of the
>>>> task stack that was used since the previous return. The generic
>>>> __stackleak_poison() does that one word per loop iteration, so a syscall
>>>> that went 1-2 KiB deep pays for 128-256 separate stores. On Meta hosts
>>>> running many small VMs, stackleak_erase() accounts for about 1.5% of
>>>> non-idle host kernel cycles.
>>>>
>>>> Override __stackleak_poison() on x86-64, as s390 already does, through
>>>> the hook added by commit 491a78663e03 ("stackleak: allow to specify arch
>>>> specific stackleak poison function"). Fill spans larger than 512 bytes
>>>> with REP STOSQ and keep the word loop for shorter ones, where the fixed
>>>> startup cost of REP STOSQ does not pay off. REP STOSQ starts to win at
>>>> about 300-400 bytes on Zen 5c and Cooper Lake, so on both no span gets
>>>> slower.
>>>>
>>>> The fill is inline asm, so the noinstr function still makes no calls.
>>>> memset64() would be the same instruction, but it is only static inline,
>>>> and with KMSAN it is an out-of-line function.
>>>>
>>>> In a Zen 5c KVM guest, stackleak_erase() got about 35% cheaper per return
>>>> to user space (71 ns to 46 ns, scan included) over a futex, epoll, procfs
>>>> and Unix socket syscall mix. Same-vCPU futex wake/wait and Unix socket
>>>> sendmsg()/recvmsg() ping-pong round trips got 5-8% faster.
>>>>
>>>> Signed-off-by: Usama Arif <usama.arif@linux.dev>
>>>> ---
>>>>  arch/x86/include/asm/processor.h | 25 +++++++++++++++++++++++++
>>>>  1 file changed, 25 insertions(+)
>>>>
>>>> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
>>>> index 77488ff5eb8c7c..049231d484ad0e 100644
>>>> --- a/arch/x86/include/asm/processor.h
>>>> +++ b/arch/x86/include/asm/processor.h
>>>> @@ -580,6 +580,31 @@ static __always_inline bool on_thread_stack(void)
>>>>                                current_stack_pointer) < THREAD_SIZE;
>>>>  }
>>>>
>>>> +#ifdef CONFIG_X86_64
>>>> +#define __stackleak_poison __stackleak_poison
>>>> +static __always_inline void __stackleak_poison(unsigned long erase_low,
>>>> +                                              unsigned long erase_high,
>>>> +                                              unsigned long poison)
>>>> +{
>>>> +       unsigned long count;
>>>> +
>>>> +       /* Short spans do not amortize the startup cost of REP STOSQ. */
>>>> +       if (erase_high <= erase_low + 512) {
>>>> +               while (erase_low < erase_high) {
>>>> +                       *(unsigned long *)erase_low = poison;
>>>> +                       erase_low += sizeof(unsigned long);
>>>> +               }
>>>> +               return;  
>>
>> gcc 13 onwards makes a meal of that - https://godbolt.org/z/KPP4h8xz6
>> It does manage to unroll the loop once - which is good because the intel
>> cpu (I've got) won't execute a 'one clock loop' (the zen5 will); but the
>> setup code is horrid.
>> But I also think some of the more recent cpu can execute more than
>> one write per clock.
>> If you unroll the loop 4 times it may run a lot faster.
>> Perhaps:
>> 	long count = (erase_high - erase_low) / sizeof(unsigned long);
>> 	if (count <= 64) {
>> 		while ((count -= 4) >= 0) {
>> 			*(unsigned long *)erase_low = poison;
>> 			*(unsigned long *)(erase_low + 8) = poison;
> 
> The add (probably) needs to be in the middle...
>  			erase_low += 32;
>> 			*(unsigned long *)(erase_low - 32 + 16) = poison;
>> 			*(unsigned long *)(erase_low - 32 + 24) = poison;
>> 		}
>> 		if (count & 2) {
>> 			*(unsigned long *)erase_low = poison;
>> 			*(unsigned long *)(erase_low + 8) = poison;
>> 			erase_low += 16;
>> 		}
>> 		if (count & 1)
>> 			*(unsigned long *)erase_low = poison;
>> 	} else {
>> 		...
>> 	}
>>
>> Except that gcc makes a mess of it again.
>> I don't think the 'erase_low += 32' is going to execute at the
>> same time as the last (two probably) writes so costs a clock.
>> So it may need to be asm.
> 
> I threw in enough OPTIMIZER_HIDE_VAR() to stop the optimiser breaking
> the code. https://godbolt.org/z/nx477T4M1
> gcc then generates:
>         movq    %rdx, (%rdi)
>         movq    %rdx, 8(%rdi)
>         addq    $32, %rdi
>         movq    %rdx, -16(%rdi)
>         movq    %rdx, -8(%rdi)
> .L32:
>         subq    $4, %rcx
>         jns     .L22
> for the code loop (clang is a bit worse - but should be ok).
> I think that will be a 'two clock loop' on cpu that can do
> two writes/clock; zen3 and ice lake).
> For 'stack splatting' rounding up to a multiple of 32 bytes
> will save all the 'remainder' code.


The range can't be rounded: erase_low is wherever the poison search
stopped, and erase_high is the stack pointer or the bottom of pt_regs
(168 bytes, so only 8-byte aligned). Rounding up writes live stack,
rounding down can write STACK_END_MAGIC when the stack was used to the
end.


> 
> David
> 
>>
>>>> +       }
>>>> +
>>>> +       count = (erase_high - erase_low) / sizeof(unsigned long);
>>>> +       asm volatile("rep stosq"
>>>> +                    : "+D" (erase_low), "+c" (count)
>>>> +                    : "a" (poison)
>>>> +                    : "memory");    
>>>
>>> Surely this isn't the only place using `rep stosq` in the tree, right?
>>> It's not, see memset64 in arch/x86/include/asm/string_64.h.  
>>
>> Which seems to have very few users.
>> memset_p() and memset_l() have almost no users.
>>
>> David
>>
>>>   
>>>> +}
>>>> +#endif
>>>> +
>>>>  #ifdef CONFIG_PARAVIRT_XXL
>>>>  #include <asm/paravirt.h>
>>>>  #else
>>>> --
>>>> 2.53.1-Meta
>>>>    
>>>
>>>   
>>
> 

