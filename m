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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46FD8C63697
	for <linux-hardening@archiver.kernel.org>; Tue, 17 Nov 2020 20:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFC32221F1
	for <linux-hardening@archiver.kernel.org>; Tue, 17 Nov 2020 20:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vJ5gRw4O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbgKQUVp (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 17 Nov 2020 15:21:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbgKQUVp (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 17 Nov 2020 15:21:45 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB31C0613CF;
        Tue, 17 Nov 2020 12:21:44 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id a9so30925762lfh.2;
        Tue, 17 Nov 2020 12:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=usYoX1OUo+I43l78t6yKp9KT+NTtewGJzWDSoIma1po=;
        b=vJ5gRw4OgRcSRzP93FGLPxWoOQvh4WwrYZTYKtDXw6DTvxGoZtlgswFl33TrAqlOOS
         BnUzlkx1X6FRwPL6I4TrNcLQRzwHa0JM0loB42eAvhDkMglTsmGFk1aJOzytK/Tgl9le
         /rS5H1dFDiC7wzWz6favYGUd9en8jNofwuk+Aw++oHFM6QmWLoXdx2MKKe+iTS5guEfF
         vdu1H2xPW7QLhlmoS0vi0vfF58fSV1aKJcm8vy58wwil2C8XONlPmtfpRlcNdBp6uxyd
         R6BCk/G/LhUUF3vQYgd/RcsagkvZK9CADRKHeaJGCkftT+obe4Qu9ricwkCW9wcnCxBU
         JAlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=usYoX1OUo+I43l78t6yKp9KT+NTtewGJzWDSoIma1po=;
        b=XqO1enaQ9FX1B88QjR7IAe9Wl6Z9aUZNcnivnwK3HMpm5MkBtqlb2oW/4lws8PiyGM
         +z7DNJ9U2UB/1QBSWj+0gKnpvZNpuhtrh/GnUqiYGTVTbshRe2018POR+SWgvlJryCsk
         qkr3SzEbzqGEID3F92IuYtgEmgBOdcssi2wy/K8w595LGsCQ2sSKFzmZi6Z4+HJ6FH6o
         YEWwJoYhyx2PmAHL7FrpG3wwC63Cm0Cq9/vigc01PEjkz0HR9kXAJgeKaXm01rlB8AiK
         e5uE5j9oBnQAYaIeUeqfFoWLJLqOY/EaeDMGL4655zAX8AWVII+hCGN6LQ1xV4WPlEUx
         4ySg==
X-Gm-Message-State: AOAM531acSjaYNAqI/WdbX7UPXUIP1lJkLeiScVkjFUCBHFLy7MUBeLa
        zeSvFk4GRseGTHZNY31lwMA=
X-Google-Smtp-Source: ABdhPJyIcj5fOJ77BPNWh48VfX9Ra3j2O98tJu12S72MAkpa2AM43C37crl33CQj9R7+XQX+xeqSZQ==
X-Received: by 2002:a19:8396:: with SMTP id f144mr2226096lfd.444.1605644503034;
        Tue, 17 Nov 2020 12:21:43 -0800 (PST)
Received: from [192.168.1.112] (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id z19sm1287729ljn.15.2020.11.17.12.21.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2020 12:21:42 -0800 (PST)
Subject: Re: [PATCH v4] mm: Optional full ASLR for mmap() and mremap()
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-hardening@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@kernel.org>
References: <20201026160518.9212-1-toiwoton@gmail.com>
 <20201117165455.GN29991@casper.infradead.org>
From:   Topi Miettinen <toiwoton@gmail.com>
Message-ID: <19373af5-2272-7615-27a7-6734c584f8bd@gmail.com>
Date:   Tue, 17 Nov 2020 22:21:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201117165455.GN29991@casper.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 17.11.2020 18.54, Matthew Wilcox wrote:
> On Mon, Oct 26, 2020 at 06:05:18PM +0200, Topi Miettinen wrote:
>> Writing a new value of 3 to /proc/sys/kernel/randomize_va_space
>> enables full randomization of memory mappings created with mmap(NULL,
>> ...). With 2, the base of the VMA used for such mappings is random,
>> but the mappings are created in predictable places within the VMA and
>> in sequential order. With 3, new VMAs are created to fully randomize
>> the mappings. Also mremap(..., MREMAP_MAYMOVE) will move the mappings
>> even if not necessary.
> 
> Is this worth it?
> 
> https://www.ndss-symposium.org/ndss2017/ndss-2017-programme/aslrcache-practical-cache-attacks-mmu/

Thanks, very interesting. The paper presents an attack (AnC) which can 
break ASLR even from JavaScript in browsers. In the process it compares 
the memory allocators of Firefox and Chrome. Firefox relies on Linux 
mmap() to randomize the memory location, but Chrome internally chooses 
the randomized address. The paper doesn't present exact numbers to break 
ASLR for Chrome case, but it seems to require more effort. Chrome also 
aggressively randomizes the memory on each allocation, which seems to 
enable further possibilities for AnC to probe the MMU tables.

Disregarding the difference in aggressiveness of memory allocators, I 
think with sysctl.kernel.randomize_va_space=3, the effort for breaking 
ASLR with Firefox should be increased closer to Chrome case since mmap() 
will use the address space more randomly.

I have used this setting now for a month without any visible performance 
issues, so I think the extra bits (for some additional effort to 
attackers) are definitely worth the low cost.

Furthermore, the paper does not describe in detail how the attack would 
continue after breaking ASLR. Perhaps there are assumptions which are 
not valid when the different memory areas are no longer sequential. For 
example, if ASLR is initially broken wrt. the JIT buffer but continuing 
the attack would require other locations to be determined (like stack, 
data segment for main exe or libc etc), further efforts may be needed to 
resolve these locations. With randomize_va_space=2, resolving any 
address (JIT buffer) can reveal the addresses of many other memory areas 
but this is not the case with 3.

-Topi
