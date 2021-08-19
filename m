Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E9E8C4320A
	for <linux-hardening@archiver.kernel.org>; Thu, 19 Aug 2021 08:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF3DC6112E
	for <linux-hardening@archiver.kernel.org>; Thu, 19 Aug 2021 08:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237339AbhHSI2O (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 19 Aug 2021 04:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237269AbhHSI2N (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 19 Aug 2021 04:28:13 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992AAC061757
        for <linux-hardening@vger.kernel.org>; Thu, 19 Aug 2021 01:27:37 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id i28so11124715lfl.2
        for <linux-hardening@vger.kernel.org>; Thu, 19 Aug 2021 01:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fnux9c4rs4QAwYzHEIhmWyQkib9slllVEKuUIkxZE4U=;
        b=hOYdmFoKoEgNHqgucA6LMg9vfQKBXNg9AF8pFlq42o1xRgIW3yE+LurXE3ntggZBTH
         b7UmQz756HBNv7YCtADHrbPG1UFWZ4SkfysIRSgPbVM2DhcjX0peKKJ7ojvvZjcWFNYA
         dZg/1y9o+kgZmwmu7JL8BuLC1vLmhEZXdESTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fnux9c4rs4QAwYzHEIhmWyQkib9slllVEKuUIkxZE4U=;
        b=Gpyuiwruq9NnXhEF9pSv2ZllkInVnKlpVhOtM647JRRF+7gQTDDMS4NWIFfu/26v9E
         LV53M6JkufJjDTaH9npcc0QnzQP47xvgX5Dd3zdxlOkLMd2qAJwzdDpbXS9/jbGp7tVg
         ZXddiuYJXRZaUHlc6hAwFEgZguTgzyTnPDjFxqclevBx4zyTIw9yf5xok2+4XblZjKfn
         MYkJvf9oUQKdp9WFgpkhfWfR+wra1KHDYUPmFdgvUYyLYGz2ZWKCoKHu4ir4GbS/iNeq
         /gwJbrMMIII7OsJ9NB2LVZYfDQn/BOaOEptSh14bCsNDbk2zd5I19j31t7P3H9+6Bu+k
         w6gQ==
X-Gm-Message-State: AOAM532S6FfoUg8t9ijngZGjvsxzSKIYZWe+EX8kko7b/UAQO5yRXErc
        PL32CXRsTsSYHzcA4EOoa35TMi80C3Lk0nQ9
X-Google-Smtp-Source: ABdhPJyouvHEQUt0g1C4b6sjpes/07r3gE6nWd5YO8P/tYJueCo9kkvIivms2bRFv5I/d17VlOiGTQ==
X-Received: by 2002:ac2:5f0f:: with SMTP id 15mr9840865lfq.25.1629361655585;
        Thu, 19 Aug 2021 01:27:35 -0700 (PDT)
Received: from [172.16.11.1] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id r7sm256655lfr.60.2021.08.19.01.27.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Aug 2021 01:27:35 -0700 (PDT)
Subject: Re: [PATCH v2 4/7] slab: Add __alloc_size attributes for better
 bounds checking
To:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Cc:     Daniel Micay <danielmicay@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        Joe Perches <joe@perches.com>, Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        clang-built-linux@googlegroups.com, linux-kbuild@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20210818214021.2476230-1-keescook@chromium.org>
 <20210818214021.2476230-5-keescook@chromium.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <a54715b4-3d95-293c-6b18-6d84299bd58f@rasmusvillemoes.dk>
Date:   Thu, 19 Aug 2021 10:27:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210818214021.2476230-5-keescook@chromium.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 18/08/2021 23.40, Kees Cook wrote:
> As already done in GrapheneOS, add the __alloc_size attribute for
> regular kmalloc interfaces, to provide additional hinting for better
> bounds checking, assisting CONFIG_FORTIFY_SOURCE and other compiler
> optimizations.
> 

>  #ifdef CONFIG_NUMA
> +__alloc_size(1)
>  void *__kmalloc_node(size_t size, gfp_t flags, int node) __assume_slab_alignment __malloc;

Eh, can we keep all the attributes together instead of having some
before, some after?

I don't necessarily think this is a good idea, but just throwing it out
there: __alloc_size almost always goes along with __malloc, so one could
define __alloc_size in such a way that it implies __malloc, then just
have a "raw" ____alloc_size version to use for krealloc() and similar.
But I guess it's cleaner to keep it this way.

While declared in string.h, kmemdup() is also eligible for alloc_size(2).

Which brings me to an old wishlist item of mine [it's almost christmas]:
that alloc_size could understand more general expressions for the size
of the returned memory, not just the primitive one based on
malloc()/calloc() prototypes. So e.g. kmemdup_nul() returns something of
size $2+1, while it is also very common to have a alloc_foo(void) helper
which returns something of size sizeof(struct foo). Unfortunately I
don't think gcc's attribute parsing machinery can easily be tweaked into
accepting

struct bar *alloc_bars(unsigned count) __new_a_s(count * sizeof(struct bar))

but maybe clang could. If a compiler could understand that kind of
attribute, it would also pave the way for implementing
__attribute__((__buffer_size__(param, size, access)))

e.g.

memchr(src, c, size) __buffer_size(src, size, "r")

clk_bulk_get(struct device *dev, int num_clks, struct clk_bulk_data
*clks) __buffer_size(clks, num_clks * sizeof(*clks), "rw")

which could be used for both static analysis and optional run-time
instrumentation.

Rasmus
