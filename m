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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD08C2D0E4
	for <linux-hardening@archiver.kernel.org>; Thu, 19 Nov 2020 09:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB0AC22253
	for <linux-hardening@archiver.kernel.org>; Thu, 19 Nov 2020 09:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UNf5RxgB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgKSJ75 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 19 Nov 2020 04:59:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbgKSJ75 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 19 Nov 2020 04:59:57 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C9DC0613CF;
        Thu, 19 Nov 2020 01:59:55 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id l10so5590912lji.4;
        Thu, 19 Nov 2020 01:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VpSJiDhCgMXVtdc+xXt3tjjyP45VYRI5zWX/U6Fc/KM=;
        b=UNf5RxgBM6QAWh6S84EDomEzoQCpyO0vJWebodKZafTDtazcLhUUgh/yygFNb6xIsM
         3tMcH+T2igfpPb9lwTo8VB64UBVLhzDxExfg+LKgf1EH5uTyPaGsfIVHsl4AUzA0L4CK
         D00Hlj5Wj29KOdUAgbp3FIje8oY5ZWxZFqW3UVgCxEleItbFtGwAnbA5XqgNLsUjZWbo
         s/I8sP4hyPfy3qSJVtsgTkj/OZbFebpUxUwHMCo2bnB7VSJzwC/Z0v+oL64/JTwNt4c5
         NufNMoTKjK0Dkcagvczbm2DhuKuSCOtEBJei9sIrKowjHFX8EXGwGei4Z9zL8VUAQO0m
         EmCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VpSJiDhCgMXVtdc+xXt3tjjyP45VYRI5zWX/U6Fc/KM=;
        b=QrUplEE+USc56F4dF37fWtkmwm0j+Evhdi6UAwDIoc9+h5Vsj1Mp8DY8miNx4vmHrW
         fzdnr27cH+Gezp4RPVuxEuz4kbDBMlcxrsQ6d0zGf7zdINAK+oklD7dzcTfEAHkiofF/
         V9aAarPopHfiUrgpD4wJa5LIIwjj8v3AweZ8qwxKm+773xdh3HvkKX4a3MQdBvASqhLr
         FSye7kSTpn1E5VXsF0lAfLxngj97y/0XvzNhW98I5hAD4hAZN9Qk24VUFxqdrJdaycyp
         K7xcZnLtuicAULd+UHNd/eKqRqXKwGY9nNnkkiDLOZuicBnkfevL9tmKitbqzPIWAgRE
         dOVQ==
X-Gm-Message-State: AOAM533Z5t9aLgADRROyM9FARcqkwU80ypMAreHpSM5/604e4Vo5Y2D6
        y0o2JJmGpR4aya7NQhj/psY=
X-Google-Smtp-Source: ABdhPJwIx4gXUxWoO9R5JXD84YJ9i0wT3CxMjJ5LdJVCqxUNbgYyDpcQBlQbdROI73kV2llxmJujIw==
X-Received: by 2002:a2e:8008:: with SMTP id j8mr5701982ljg.452.1605779993900;
        Thu, 19 Nov 2020 01:59:53 -0800 (PST)
Received: from [192.168.1.112] (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id j22sm3653895ljb.5.2020.11.19.01.59.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2020 01:59:53 -0800 (PST)
Subject: Re: [PATCH v4] mm: Optional full ASLR for mmap() and mremap()
To:     Cristiano Giuffrida <c.giuffrida@vu.nl>,
        Mike Rapoport <rppt@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
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
From:   Topi Miettinen <toiwoton@gmail.com>
Message-ID: <14367005-a27b-c5b4-ca21-28863264e0fa@gmail.com>
Date:   Thu, 19 Nov 2020 11:59:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CANWxqZ=fSi15fi6n-Ei4KJ8MtPcfiU8j=cQS-DycMig6s1oQBA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 18.11.2020 20.49, Cristiano Giuffrida wrote:
> Interesting mitigation and discussion!
> 
> Regarding the impact on the AnC attack, indeed fine-grained (or full)
> mmap() randomization affects AnC in two ways: (i) it breaks the
> contiguity of the mmap() region, crippling the sliding primitive AnC
> relies on; (ii) it ensures an attacker leaking an address in a
> particular VMA can't easily infer addresses in other VMAs. So, in
> short, the mitigation does raise the bar against AnC-like attacks and
> I see this as a useful addition.

In your paper the timing for Chrome attacks were not presented, which 
would be interesting if they are comparable to the effect of 
randomize_va_space=3 for Firefox. What's your estimate, how much slower 
it was to break Chrome ASLR vs. Firefox/randomize_va_space=2?

> Indeed, we're aware some vendors implemented a similar randomization
> strategy in the browser as a mitigation against AnC.
> 
> Nonetheless, some additional notes on the two points I raised above:
> 
> - (i) [Sliding] Note that an attacker can do away with sliding
> depending on the randomization entropy and other available side
> channels. For instance, with the recent TagBleed, we show how to
> combine a TLB side channel with AnC to exhaust the KASLR entropy.
> However, similar attacks should be possible in userland, again
> depending on the randomization entropy used. See
> https://download.vusec.net/papers/tagbleed_eurosp20.pdf. Combining
> side channels with transient/speculative execution attacks can further
> lower the bar.

I think the equivalent of randomize_va_space=3 for KASLR would be that 
various kernel structures could be placed randomly with full use of all 
bits in the hardware, instead of low numbers like 9, 10 or 15 bits. 
Maybe also each module could be placed in individual random address 
instead of stuffing all modules together and likewise, instead of single 
page_offset_base, vmalloc_base and vmemmap_base, kernel would use the 
full address space to place various internal structures. I suppose this 
is not trivial.

> - (ii) [Leaks] Depending on the software vulnerability used for
> exploitation, it might not be difficult for an attacker to break
> fine-grained randomization across VMAs. That is, leak an address from
> VMA 1, use the vulnerability to trigger a normally illegal access to
> VMA 2, leak an address from VMA 2, repeat. Of course, the exploit
> might take much longer depending on how far on the pointer chasing
> chain the target is.

Pointers between VMAs may also exist, for example libz.so needs to call 
open(), close(), malloc(), free() etc. from libc.so.

-Topi

> Best,
> Cristiano
> 
> On Wed, Nov 18, 2020 at 6:40 PM Mike Rapoport <rppt@kernel.org> wrote:
>>
>> (added one of the AnC paper authors)
>>
>> On Tue, Nov 17, 2020 at 10:21:30PM +0200, Topi Miettinen wrote:
>>> On 17.11.2020 18.54, Matthew Wilcox wrote:
>>>> On Mon, Oct 26, 2020 at 06:05:18PM +0200, Topi Miettinen wrote:
>>>>> Writing a new value of 3 to /proc/sys/kernel/randomize_va_space
>>>>> enables full randomization of memory mappings created with mmap(NULL,
>>>>> ...). With 2, the base of the VMA used for such mappings is random,
>>>>> but the mappings are created in predictable places within the VMA and
>>>>> in sequential order. With 3, new VMAs are created to fully randomize
>>>>> the mappings. Also mremap(..., MREMAP_MAYMOVE) will move the mappings
>>>>> even if not necessary.
>>>>
>>>> Is this worth it?
>>>>
>>>> https://www.ndss-symposium.org/ndss2017/ndss-2017-programme/aslrcache-practical-cache-attacks-mmu/
>>>
>>> Thanks, very interesting. The paper presents an attack (AnC) which can break
>>> ASLR even from JavaScript in browsers. In the process it compares the memory
>>> allocators of Firefox and Chrome. Firefox relies on Linux mmap() to
>>> randomize the memory location, but Chrome internally chooses the randomized
>>> address. The paper doesn't present exact numbers to break ASLR for Chrome
>>> case, but it seems to require more effort. Chrome also aggressively
>>> randomizes the memory on each allocation, which seems to enable further
>>> possibilities for AnC to probe the MMU tables.
>>>
>>> Disregarding the difference in aggressiveness of memory allocators, I think
>>> with sysctl.kernel.randomize_va_space=3, the effort for breaking ASLR with
>>> Firefox should be increased closer to Chrome case since mmap() will use the
>>> address space more randomly.
>>>
>>> I have used this setting now for a month without any visible performance
>>> issues, so I think the extra bits (for some additional effort to attackers)
>>> are definitely worth the low cost.
>>>
>>> Furthermore, the paper does not describe in detail how the attack would
>>> continue after breaking ASLR. Perhaps there are assumptions which are not
>>> valid when the different memory areas are no longer sequential. For example,
>>> if ASLR is initially broken wrt. the JIT buffer but continuing the attack
>>> would require other locations to be determined (like stack, data segment for
>>> main exe or libc etc), further efforts may be needed to resolve these
>>> locations. With randomize_va_space=2, resolving any address (JIT buffer) can
>>> reveal the addresses of many other memory areas but this is not the case
>>> with 3.
>>>
>>> -Topi
>>
>> --
>> Sincerely yours,
>> Mike.

