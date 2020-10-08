Return-Path: <SRS0=DAdQ=DP=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 906FCC433DF
	for <linux-hardening@archiver.kernel.org>; Thu,  8 Oct 2020 18:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B3E720760
	for <linux-hardening@archiver.kernel.org>; Thu,  8 Oct 2020 18:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMSSEWHZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731154AbgJHSKU (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 8 Oct 2020 14:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731152AbgJHSKU (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 8 Oct 2020 14:10:20 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58C4C061755;
        Thu,  8 Oct 2020 11:10:19 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id j22so2044788lfe.10;
        Thu, 08 Oct 2020 11:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iY2DdIaqED/GpphAr9g0IhgVV6qVeDZXTm/GMY0em2M=;
        b=UMSSEWHZ4rqm9CloQbxNH8hdOC45yMRgYYgviO0VCaUv9HxSl6z7uM7z7mP9GxsK6F
         Ku25gKThBsih72le/NZ24sYhySq3bJ91DuboCIxRQWcv4EKufcwzmt5UC3BIDYTtsMnA
         GibUtNb7OEF/k5+aU9EJMObfgl0dy20A3mLr2XYKmucKeLLM+XHyE5JtUdkAsfqPuf5L
         6E/pQwniXPtza/99MTrO+iHAK9oGHfTfA9ofM22OIcK8oGkvx4jpOtnV7Sg65n74xmLR
         oMyZvA0GJxMHXVk23ZFzg+vOD5Inh6AwniPwaPGAzySdJ/0bWGcSWx5xsekpRNA2ZXc4
         B+Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iY2DdIaqED/GpphAr9g0IhgVV6qVeDZXTm/GMY0em2M=;
        b=rq1zIvPoBU90Tm3iobWurLGO9owVbdbNNTY9iFnNLno90jBlI7wmzVc1LNi9N2S6iX
         8BxevG7EKGfYYWtwPe5fcRqPPFAwIVtxl3Mou/wTAYWNqo+QRoDv+mh/bApOcTj2obHb
         MCS+jP+p9L7snfahV6KHe33uemuyag++eGLCih97qwlnZGNSmSXbvSfyglHmN7GdSjJP
         UZxb4qu14UwUHpI/VGkoA6BSxmJpDc7OfpxgOUH1sSVxYX0lZEk1+ViiLjVUEVfyh/If
         tmWlfDWXhP3kH0NIza1XJ9i6cU8V9nBwlvR4Sgh8R5l7ZLO6Pd+pCkTXq3ecKl6sns4J
         ewqw==
X-Gm-Message-State: AOAM530SviaM2z3zrv9WU3AJ1xOpYr570+BbCBmgGteogk1aQvMsXLd1
        in7hTJIh969p6tsyUjpRY4JJzEhR/2k=
X-Google-Smtp-Source: ABdhPJze4cQ2Qxwcrk+dYMORPwe49g/7a/NHxMhjsv/4UmHKMD609aYukmerxno4NTij0IXsRSKfeA==
X-Received: by 2002:ac2:58d8:: with SMTP id u24mr1181223lfo.415.1602180618002;
        Thu, 08 Oct 2020 11:10:18 -0700 (PDT)
Received: from [192.168.1.112] (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id s16sm1076712ljj.35.2020.10.08.11.10.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2020 11:10:17 -0700 (PDT)
Subject: Re: [PATCH RESEND v2] mm: Optional full ASLR for mmap() and mremap()
To:     Jann Horn <jannh@google.com>
Cc:     linux-hardening@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>
References: <20201008165408.38228-1-toiwoton@gmail.com>
 <CAG48ez1OU9PFQ06mf4L59SEmi6Vwxnao8RuVXH=dCiyMhqVwYA@mail.gmail.com>
From:   Topi Miettinen <toiwoton@gmail.com>
Message-ID: <3413d0c8-17c7-fbae-e5fa-74a918e61239@gmail.com>
Date:   Thu, 8 Oct 2020 21:10:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAG48ez1OU9PFQ06mf4L59SEmi6Vwxnao8RuVXH=dCiyMhqVwYA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 8.10.2020 20.13, Jann Horn wrote:
> On Thu, Oct 8, 2020 at 6:54 PM Topi Miettinen <toiwoton@gmail.com> wrote:
>> Writing a new value of 3 to /proc/sys/kernel/randomize_va_space
>> enables full randomization of memory mappings created with mmap(NULL,
>> ...). With 2, the base of the VMA used for such mappings is random,
>> but the mappings are created in predictable places within the VMA and
>> in sequential order. With 3, new VMAs are created to fully randomize
>> the mappings. Also mremap(..., MREMAP_MAYMOVE) will move the mappings
>> even if not necessary.
> [...]
>> +       if ((flags & MREMAP_MAYMOVE) && randomize_va_space >= 3) {
>> +               /*
>> +                * Caller is happy with a different address, so let's
>> +                * move even if not necessary!
>> +                */
>> +               new_addr = arch_mmap_rnd();
>> +
>> +               ret = mremap_to(addr, old_len, new_addr, new_len,
>> +                               &locked, flags, &uf, &uf_unmap_early,
>> +                               &uf_unmap);
>> +               goto out;
>> +       }
> 
> You just pick a random number as the address, and try to place the
> mapping there? Won't this fail if e.g. the old address range overlaps
> with the new one, causing mremap_to() to bail out at "if (addr +
> old_len > new_addr && new_addr + new_len > addr)"?

Thanks for the review. I think overlap would be OK in this case and the 
check should be skipped.

> Also, on Linux, the main program stack is (currently) an expanding
> memory mapping that starts out being something like a couple hundred
> kilobytes in size. If you allocate memory too close to the main
> program stack, and someone then recurses deep enough to need more
> memory, the program will crash. It sounds like your patch will
> randomly make such programs crash.

Right, especially on 32 bit systems this could be a real problem. I have 
limited the stack for tasks in the whole system to 2MB without problems 
(most use only 128kB) and on 48 bit virtual address systems the 
collision to 2MB area could be roughly 1/2^(48-21) which is a very small 
number. But perhaps this should be still be avoided by not picking an 
address too close to bottom of stack, say 64MB to be sure. It may also 
make this more useful also for 32 bit systems but overall I'm not so 
optimistic due to increased fragmentation.

> Also, what's your strategy in general with regards to collisions with
> existing mappings? Is your intention to just fall back to the classic
> algorithm in that case?

Maybe a different address could be tried (but not infinitely, say 5 
times) and then fall back to classics. This would not be good for the 
ASLR but I haven't seen mremap() to be used much in my tests.

> You may want to consider whether it would be better to store
> information about free memory per subtree in the VMA tree, together
> with the maximum gap size that is already stored in each node, and
> then walk down the tree randomly, with the randomness weighted by free
> memory in the subtrees, but ignoring subtrees whose gaps are too
> small. And for expanding stacks, it might be a good idea for other
> reasons as well (locking consistency) to refactor them such that the
> size in the VMA tree corresponds to the maximum expansion of the stack
> (and if an allocation is about to fail, shrink such stack mappings).

This would reduce the randomization which I want to avoid. I think the 
extra overhead should be OK: if this is unacceptable for a workload or 
system constraints, don't use mode '3' but '2'.

Instead of single global sysctl, this could be implemented as a new 
personality (or make this model the default and add a compatibility 
personality with no or less randomization), so it could be applied only 
for some tasks but not all.

-Topi
