Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B61B9C2D0E4
	for <linux-hardening@archiver.kernel.org>; Fri, 20 Nov 2020 19:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5345622253
	for <linux-hardening@archiver.kernel.org>; Fri, 20 Nov 2020 19:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="loPPpQL1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbgKTThw (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 20 Nov 2020 14:37:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727370AbgKTThv (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 20 Nov 2020 14:37:51 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E92C0613CF;
        Fri, 20 Nov 2020 11:37:51 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id 142so11216934ljj.10;
        Fri, 20 Nov 2020 11:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PH5VJ+8XjiMfSEuEeXBafS706d/XK88qZhLpxbT9Ee8=;
        b=loPPpQL1Ch+10l0KzxoNJx8eP6e6l/4+Htpq7Nls5LRUOqCRU9gPb6k7RsZEW07AP0
         Gi93tj+LAREaYIK6b1GjGojtQ8SbcmUvfnYbmpDvHnpI+6LUwnUgam9hLpb+F0H9FAcK
         +FVH6IAuHbbh1D8zSOhPamcKO6nj5NdrVfxsWudfnqk1dW0de5fP7ClcpBD4SfJpYupr
         uIEUKHROiG7OJOfUI+68sa9yzWHOAwg3NI1P+8Bsvr5sRHI9DfV282o8iXYzxnYcSeAC
         2RVFiZf/fGk8F4BeSAlaIkAkasFO0SfX9S7jxP+FuyPRs7QP0JLrZGADrrKFODL8abHc
         JX5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PH5VJ+8XjiMfSEuEeXBafS706d/XK88qZhLpxbT9Ee8=;
        b=iL0k90nHB6A51RUhsYe3d29t9rgPwoK9B7PXnsqpsV2vMimFGuh/Xqt1ncTf5Wi+j3
         0GG+4upH2cqjNxThGaV+8sgxi7zKf66QUhR7LnqU2WoeOX+uBaRpajECJB5hbyzwqata
         vUua3RSswF5T8iS0AG2iEBxIbJB24BWIuseBA4H5eu4vIh7rq333JNz0fSPUFhOdZAg3
         hfaz9D7OtzPG6SUUlbyyDiRBrda3eSHOdi/aefUNhulbBgiR6sPOYJc5OgZHdCeeIepL
         fMu5b01Jz5tOI6dz+lJMhRd/m+2UV5vBQGJ06ueCF++6uMKSk+ofjNDnlwVTaswEWNCk
         jjVA==
X-Gm-Message-State: AOAM533cmZVTgyGe5QhVrVMF5OC7Naw0tfqckMvAIdhx6/HQa/Ug2+GG
        SUf/O6/b8HOlX5dRfq5HITA=
X-Google-Smtp-Source: ABdhPJzpMoX8zME7u3tEiE4CtvD+6B1xfYoHn9ht/3kkLZwl98eVw4gqpTXs+jpBtFteP0XJ8GK4pw==
X-Received: by 2002:a2e:b0ea:: with SMTP id h10mr8452389ljl.356.1605901069397;
        Fri, 20 Nov 2020 11:37:49 -0800 (PST)
Received: from [192.168.1.112] (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id x132sm442285lff.244.2020.11.20.11.37.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2020 11:37:48 -0800 (PST)
Subject: Re: [PATCH v4] mm: Optional full ASLR for mmap() and mremap()
To:     Cristiano Giuffrida <c.giuffrida@vu.nl>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>, Kees Cook <keescook@chromium.org>
References: <20201026160518.9212-1-toiwoton@gmail.com>
 <20201117165455.GN29991@casper.infradead.org>
 <19373af5-2272-7615-27a7-6734c584f8bd@gmail.com>
 <6810b874c8df456b890d1092273b354a@pexch011a.vu.local>
 <CANWxqZ=fSi15fi6n-Ei4KJ8MtPcfiU8j=cQS-DycMig6s1oQBA@mail.gmail.com>
 <0da9cb0a4d1a494d9ec15404f8decf01@pexch011a.vu.local>
 <CANWxqZkdSMFM4T2J-KNK_K-SHfbRnk3EUcgHAF9Xj+SRqDxXHw@mail.gmail.com>
 <d7e759c8ac444aa4b0ba6932563aca00@pexch011a.vu.local>
 <CANWxqZmkRWPjLcq8Nmw-GR90qOacp=nwEuKcB9hGDYZ8w2psog@mail.gmail.com>
From:   Topi Miettinen <toiwoton@gmail.com>
Message-ID: <05e62166-7e05-569a-7247-e622d620db61@gmail.com>
Date:   Fri, 20 Nov 2020 21:37:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CANWxqZmkRWPjLcq8Nmw-GR90qOacp=nwEuKcB9hGDYZ8w2psog@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 20.11.2020 16.10, Cristiano Giuffrida wrote:
> On Fri, Nov 20, 2020 at 9:38 AM Topi Miettinen <toiwoton@gmail.com> wrote:
>>
>> On 20.11.2020 0.20, Cristiano Giuffrida wrote:
>>> On Thu, Nov 19, 2020 at 10:59 AM Topi Miettinen <toiwoton@gmail.com> wrote:
>>>>
>>>> On 18.11.2020 20.49, Cristiano Giuffrida wrote:
>>>>> Interesting mitigation and discussion!
>>>>>
>>>>> Regarding the impact on the AnC attack, indeed fine-grained (or full)
>>>>> mmap() randomization affects AnC in two ways: (i) it breaks the
>>>>> contiguity of the mmap() region, crippling the sliding primitive AnC
>>>>> relies on; (ii) it ensures an attacker leaking an address in a
>>>>> particular VMA can't easily infer addresses in other VMAs. So, in
>>>>> short, the mitigation does raise the bar against AnC-like attacks and
>>>>> I see this as a useful addition.
>>>>
>>>> In your paper the timing for Chrome attacks were not presented, which
>>>> would be interesting if they are comparable to the effect of
>>>> randomize_va_space=3 for Firefox. What's your estimate, how much slower
>>>> it was to break Chrome ASLR vs. Firefox/randomize_va_space=2?
>>> We did present entropy reduction over time for Chrome (see Fig. 8).
>>> But without a proper sliding primitive due to mmap() randomization, we
>>> stopped at 2 bits of residual entropy. Getting the last 2 bits is not
>>> impossible, but indeed slower. Not sure by how much without actually
>>> trying (as mentioned, you might also be able to use other side
>>> channels to compensate).
>>>
>>> I forgot to mention that mmap() randomization actually makes attacks
>>> easier in cases where VMAs are not demand paged (see Section VI.B of
>>> the AnC paper), since proper sliding with nonrandomized mmap() would
>>> otherwise need to allocate too much memory.
>>>
>>>>
>>>>> Indeed, we're aware some vendors implemented a similar randomization
>>>>> strategy in the browser as a mitigation against AnC.
>>>>>
>>>>> Nonetheless, some additional notes on the two points I raised above:
>>>>>
>>>>> - (i) [Sliding] Note that an attacker can do away with sliding
>>>>> depending on the randomization entropy and other available side
>>>>> channels. For instance, with the recent TagBleed, we show how to
>>>>> combine a TLB side channel with AnC to exhaust the KASLR entropy.
>>>>> However, similar attacks should be possible in userland, again
>>>>> depending on the randomization entropy used. See
>>>>> https://download.vusec.net/papers/tagbleed_eurosp20.pdf. Combining
>>>>> side channels with transient/speculative execution attacks can further
>>>>> lower the bar.
>>>>
>>>> I think the equivalent of randomize_va_space=3 for KASLR would be that
>>>> various kernel structures could be placed randomly with full use of all
>>>> bits in the hardware, instead of low numbers like 9, 10 or 15 bits.
>>>> Maybe also each module could be placed in individual random address
>>>> instead of stuffing all modules together and likewise, instead of single
>>>> page_offset_base, vmalloc_base and vmemmap_base, kernel would use the
>>>> full address space to place various internal structures. I suppose this
>>>> is not trivial.
>>> Indeed it's nontrivial to get similar randomization guarantees for the
>>> kernel. I mentioned TagBleed because similar combined AnC + TLB
>>> attacks should also be possible in the browser. We just happened to
>>> focus on the kernel with TagBleed.
>>
>> Perhaps kernel objects could be also compiled as relocatable shared
>> objects, like shared libraries for user applications, so that a they
>> could be relocated independently away from the base address of main
>> kernel. Also compiling the kernel with -mcmodel=large could allow
>> various segments (code, rodata, data) to be located more freely. These
>> would make the attacker to do more probing. Again, pointers between the
>> objects may make these less useful.
>>
>>>
>>>>
>>>>> - (ii) [Leaks] Depending on the software vulnerability used for
>>>>> exploitation, it might not be difficult for an attacker to break
>>>>> fine-grained randomization across VMAs. That is, leak an address from
>>>>> VMA 1, use the vulnerability to trigger a normally illegal access to
>>>>> VMA 2, leak an address from VMA 2, repeat. Of course, the exploit
>>>>> might take much longer depending on how far on the pointer chasing
>>>>> chain the target is.
>>>>
>>>> Pointers between VMAs may also exist, for example libz.so needs to call
>>>> open(), close(), malloc(), free() etc. from libc.so.
>>> Indeed my example above assumed pointers between VMAs. At each step,
>>> you would use a vulnerability to craft a counterfeit object around
>>> existing pointers to other VMAs and move from there.
>>>
>>> Note that without existing pointers between VMAs, you can still mount
>>> similar attacks by crafting your own pointers to probe for other VMAs.
>>> Since you'd be blindly probing the address space, you'd need some page
>>> fault suppression mechanism to keep going. But branch misprediction a
>>> la Spectre and similar can do the trick. See our recent BlindSide for
>>> an example of such an attack against the kernel:
>>> https://download.vusec.net/papers/blindside_ccs20.pdf.
>>
>> In 6.3 the base address of kernel is probed in 0.7s. Wouldn't going from
>> 9 bits to 32 increase this to 2^21 * 0.7s = ~17 days?
> In general, increasing the entropy can make the attack much more
> difficult to complete in bounded time, yes. However:
> - The time to complete a single probe is inherently
> vulnerability-specific and the probe we had was not particularly
> efficient.
> - We didn't really look at optimizations to speed things up, such as
> batching multiple probes in a single syscall.
> - If you're probing in the browser rather than in the kernel, you
> might be able to craft more efficient probes and also more easily fill
> up the address space with objects you want to probe for to reduce the
> entropy. See our thread spraying paper for an example:
> https://www.usenix.net/system/files/conference/usenixsecurity16/sec16_paper_goktas.pdf

Can thread spraying (which allocates lots of large memory blocks) be 
caught by limiting the total address space used by the process via 
cgroup controls and resource limits (for example, systemd directives 
MemoryMax= and LimitAS=)?

(Reading this pre-Spectre paper gave me the same feeling as looking at 
some pre-Covid stuff: the world was so much simpler back then.)

-Topi

> 
>>
>> Another mitigation could be to flush all caches on system call entry or
>> exit. This would of course decrease performance, but maybe if this was
>> done selectively only for critical system services and browsers (maybe
>> even only for its JIT thread but not others), perhaps it could be more
>> acceptable.
> Right. Something to keep in mind with these attacks is that flushing
> the caches only cripples one particular (although the most common)
> kind of covert channel to leak information. But an attacker could in
> principle switch to other microarchitectural side effects and covert
> channels. See SMoTherSpectre for an example.
> 
>>
>> -Topi
>>
>>>
>>>>
>>>> -Topi
>>>>
>>>>> Best,
>>>>> Cristiano
>>>>>
>>>>> On Wed, Nov 18, 2020 at 6:40 PM Mike Rapoport <rppt@kernel.org> wrote:
>>>>>>
>>>>>> (added one of the AnC paper authors)
>>>>>>
>>>>>> On Tue, Nov 17, 2020 at 10:21:30PM +0200, Topi Miettinen wrote:
>>>>>>> On 17.11.2020 18.54, Matthew Wilcox wrote:
>>>>>>>> On Mon, Oct 26, 2020 at 06:05:18PM +0200, Topi Miettinen wrote:
>>>>>>>>> Writing a new value of 3 to /proc/sys/kernel/randomize_va_space
>>>>>>>>> enables full randomization of memory mappings created with mmap(NULL,
>>>>>>>>> ...). With 2, the base of the VMA used for such mappings is random,
>>>>>>>>> but the mappings are created in predictable places within the VMA and
>>>>>>>>> in sequential order. With 3, new VMAs are created to fully randomize
>>>>>>>>> the mappings. Also mremap(..., MREMAP_MAYMOVE) will move the mappings
>>>>>>>>> even if not necessary.
>>>>>>>>
>>>>>>>> Is this worth it?
>>>>>>>>
>>>>>>>> https://www.ndss-symposium.org/ndss2017/ndss-2017-programme/aslrcache-practical-cache-attacks-mmu/
>>>>>>>
>>>>>>> Thanks, very interesting. The paper presents an attack (AnC) which can break
>>>>>>> ASLR even from JavaScript in browsers. In the process it compares the memory
>>>>>>> allocators of Firefox and Chrome. Firefox relies on Linux mmap() to
>>>>>>> randomize the memory location, but Chrome internally chooses the randomized
>>>>>>> address. The paper doesn't present exact numbers to break ASLR for Chrome
>>>>>>> case, but it seems to require more effort. Chrome also aggressively
>>>>>>> randomizes the memory on each allocation, which seems to enable further
>>>>>>> possibilities for AnC to probe the MMU tables.
>>>>>>>
>>>>>>> Disregarding the difference in aggressiveness of memory allocators, I think
>>>>>>> with sysctl.kernel.randomize_va_space=3, the effort for breaking ASLR with
>>>>>>> Firefox should be increased closer to Chrome case since mmap() will use the
>>>>>>> address space more randomly.
>>>>>>>
>>>>>>> I have used this setting now for a month without any visible performance
>>>>>>> issues, so I think the extra bits (for some additional effort to attackers)
>>>>>>> are definitely worth the low cost.
>>>>>>>
>>>>>>> Furthermore, the paper does not describe in detail how the attack would
>>>>>>> continue after breaking ASLR. Perhaps there are assumptions which are not
>>>>>>> valid when the different memory areas are no longer sequential. For example,
>>>>>>> if ASLR is initially broken wrt. the JIT buffer but continuing the attack
>>>>>>> would require other locations to be determined (like stack, data segment for
>>>>>>> main exe or libc etc), further efforts may be needed to resolve these
>>>>>>> locations. With randomize_va_space=2, resolving any address (JIT buffer) can
>>>>>>> reveal the addresses of many other memory areas but this is not the case
>>>>>>> with 3.
>>>>>>>
>>>>>>> -Topi
>>>>>>
>>>>>> --
>>>>>> Sincerely yours,
>>>>>> Mike.
>>>>
>>

