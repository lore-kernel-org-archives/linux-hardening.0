Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ACC2C433ED
	for <linux-hardening@archiver.kernel.org>; Wed,  5 May 2021 06:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 604D6613B4
	for <linux-hardening@archiver.kernel.org>; Wed,  5 May 2021 06:25:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbhEEG0a (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 5 May 2021 02:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbhEEG0a (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 5 May 2021 02:26:30 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01908C061574
        for <linux-hardening@vger.kernel.org>; Tue,  4 May 2021 23:25:33 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id q2so1218127pfh.13
        for <linux-hardening@vger.kernel.org>; Tue, 04 May 2021 23:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=R97okrrT1ZR3nAmwWW6z4OxB86R8rXbhMKoQVYu9dd4=;
        b=ns8vvV1Qo1QZc0J0GCqe2q2V5F0oFWwYAmbWDMmx7uVV7+gwRXWIDYJREfCKTuxZs2
         wIqUtWMg6NwDe/gc16gCZL7CPHrQcl845Wr7bS9w0L9Igv5JLk8cXPN/m8SY78GMkIXt
         /G/Zy48px0xpleaxPam7W4wMLM3zxCYEEQd94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=R97okrrT1ZR3nAmwWW6z4OxB86R8rXbhMKoQVYu9dd4=;
        b=JQJ7nsXwEp8SvEs2n6hlXMKHGHyPdeXYKgVqxBs9oDIJ1hWbehmrVg5f5h3nW4lP21
         fuX+cU+bfHES0H57q2gZQqnLqZcluTNNLTNlRPGdmXrWzLewO7Y9F8KbUhoBOwdFDjOt
         L2cEYDPgJilVEsK0m9GXp4eYB4Be/qdG0FKIZC8Ys7OS4ki9vT02aBNlQPbnbpiNhclV
         qkdfsJJrbwdv1LnrFFafdmhEozYMA/YG7yVbdojHbG0xyAytlAhfai4/HUz/eX1Ie3ba
         TiSidQL6OHc46pddpoSSx2KrE82rft7n8R6f70LlQXWs6j91tzT2fVXjyirOexcDnCU1
         cNsw==
X-Gm-Message-State: AOAM531x0AElL4PbgT50jpYJXNrucynfJcSLdq52HidSBY8HB+aEMO6p
        ra/3rBg82G/wiMRnNfUYALmQzg==
X-Google-Smtp-Source: ABdhPJyyFwabQwvnS1ulWRW160zd3aj383RgdjKZyVc1Alzp4aC2H+g6nFGuTTkCJgHz/TUp24HBww==
X-Received: by 2002:a63:8f15:: with SMTP id n21mr26183891pgd.366.1620195933437;
        Tue, 04 May 2021 23:25:33 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d18sm5588407pgo.66.2021.05.04.23.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 23:25:32 -0700 (PDT)
Date:   Tue, 4 May 2021 23:25:31 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org,
        linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org,
        linux-hardening@vger.kernel.org,
        kernel-hardening@lists.openwall.com, ira.weiny@intel.com,
        rppt@kernel.org, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/9] PKS write protected page tables
Message-ID: <202105042253.ECBBF6B6@keescook>
References: <20210505003032.489164-1-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210505003032.489164-1-rick.p.edgecombe@intel.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, May 04, 2021 at 05:30:23PM -0700, Rick Edgecombe wrote:
> This is a POC for write protecting page tables with PKS (Protection Keys for 
> Supervisor) [1]. The basic idea is to make the page tables read only, except 
> temporarily on a per-cpu basis when they need to be modified. I’m looking for 
> opinions on whether people like the general direction of this in terms of 
> value and implementation.

Yay!

> Why would people want this?
> ===========================
> Page tables are the basis for many types of protections and as such, are a 
> juicy target for attackers. Mapping them read-only will make them harder to 
> use in attacks.
> 
> This protects against an attacker that has acquired the ability to write to 
> the page tables. It's not foolproof because an attacker who can execute 
> arbitrary code can either disable PKS directly, or simply call the same 
> functions that the kernel uses for legitimate page table writes.

I think it absolutely has value. The exploit techniques I'm aware of that
target the page table are usually attempting to upgrade an arbitrary
write into execution (e.g. write to kernel text after setting kernel
text writable in the page table) or similar "data only" attacks (make
sensitive page writable).

It looks like PKS-protected page tables would be much like the
RO-protected text pages in the sense that there is already code in
the kernel to do things to make it writable, change text, and set it
read-only again (alternatives, ftrace, etc). That said, making the PKS
manipulation code be inline to page-writing code would make it less
available for ROP/JOP, if an attack DID want to go that route.

> Why use PKS for this?
> =====================
> PKS is an upcoming CPU feature that allows supervisor virtual memory 
> permissions to be changed without flushing the TLB, like PKU does for user 
> memory. Protecting page tables would normally be really expensive because you 
> would have to do it with paging itself. PKS helps by providing a way to toggle 
> the writability of the page tables with just a per-cpu MSR.

The per-cpu-ness is really important for both performance and for avoiding
temporal attacks where an arbitrary write in one CPU is timed against
a page table write in another CPU.

> Performance impacts
> ===================
> Setting direct map permissions on whatever random page gets allocated for a 
> page table would result in a lot of kernel range shootdowns and direct map 
> large page shattering. So the way the PKS page table memory is created is 
> similar to this module page clustering series[2], where a cache of pages is 
> replenished from 2MB pages such that the direct map permissions and associated 
> breakage is localized on the direct map. In the PKS page tables case, a PKS 
> key is pre-applied to the direct map for pages in the cache.
> 
> There would be some costs of memory overhead in order to protect the direct 
> map page tables. There would also be some extra kernel range shootdowns to 
> replenish the cache on occasion, from setting the PKS key on the direct map of 
> the new pages. I don’t have any actual performance data yet.

What CPU models are expected to have PKS?

> This is based on V6 [1] of the core PKS infrastructure patches. PKS 
> infrastructure follow-on’s are planned to enable keys to be set to the same 
> permissions globally. Since this usage needs a key to be set globally 
> read-only by default, a small temporary solution is hacked up in patch 8. Long 
> term, PKS protected page tables would use a better and more generic solution 
> to achieve this.
> 
> [1] https://lore.kernel.org/lkml/20210401225833.566238-1-ira.weiny@intel.com/

Ah, neat!

> [2] https://lore.kernel.org/lkml/20210405203711.1095940-1-rick.p.edgecombe@intel.com/

Ooh. What does this do for performance? It sounds like less TLB
pressure, IIUC?

-- 
Kees Cook
