Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A53EBC433FE
	for <linux-hardening@archiver.kernel.org>; Wed, 23 Nov 2022 01:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235246AbiKWBbB (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 22 Nov 2022 20:31:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234457AbiKWBa7 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 22 Nov 2022 20:30:59 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54A68DA7B
        for <linux-hardening@vger.kernel.org>; Tue, 22 Nov 2022 17:30:58 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id q71so15510470pgq.8
        for <linux-hardening@vger.kernel.org>; Tue, 22 Nov 2022 17:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DKO5lR4cLz6p7NWkfnd0y6rPCWBH2+knxhaYnv/yN7g=;
        b=NXD0++W1grzconoV0x+G2IAlIiJtVCOGTMBnUhvmAstsMhj6jtOs7BcAJGgKzdSGxJ
         6WRKCQPUQQdVSYMLLzc9pngh3MZKR8YrFD8d/E9qcP1+rhgI4WqDBdm04K8qAIi5/dCs
         l/OF72+iUkIrkggctoMI3+D8SQLzptPdnkw+nsDBb4TjXNCOUZkK4+AEHFZDAycjlOeW
         mSZqXSpomAhvM2koEPenAJbEQl7m64YkqH7+NoPou3o3g13CGO3qQd3jpsYENN9pD+95
         KZWGcbJIpU5W+68tUnqzWFjs0R7CLIucsBRjr7AHpne6oOJ+/xKUwsr2KtjsxZjhRTVc
         Zt7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DKO5lR4cLz6p7NWkfnd0y6rPCWBH2+knxhaYnv/yN7g=;
        b=51Nt6wCZ4lTBHZ828PdVAhFX760ADYeMvzRJTwQgcidFZmEhB2RNVRcQtTI7ERSc/Z
         KcQyrh2p1bwJbQzrkQXPMrEP0WtHHTfpxXRbDFlT4LeumJyoeorWGKcJkFEzAcgRd76O
         Pax3VlrcbXiUR2c/6WiZqoW4ZLdmBHbcZD40coTixfNtvTCKSb1WgiljzljJxJEmdzmc
         ZL5Gr8ch8hKaiqK6ah+OMEIoNT9l6nBV8qwOH79J9wpcB97ZI9ciPjJ+lkBSRI8PWrTD
         N49hZVXBkZtB387AarYnkFp9XPxwk9ubPw5no9H/xm8rJPOhljTImk9aXa7prjtKRd3C
         XIzw==
X-Gm-Message-State: ANoB5pkU3EL1CiCLv2mGY36F+y05bSLsncZ97VP/HP+kAhcrkfJpoxVE
        M3shiuG1sLTXfM03x9Pq264rYA==
X-Google-Smtp-Source: AA0mqf7QekbcagrdW2ZDZzvV7seCNJVnDeErvb+ZQk78iSZep5oGbGV2XKOj4eOZEI3kIJGB0bxSpg==
X-Received: by 2002:a05:6a00:1a14:b0:572:5be2:505b with SMTP id g20-20020a056a001a1400b005725be2505bmr6959442pfv.52.1669167058288;
        Tue, 22 Nov 2022 17:30:58 -0800 (PST)
Received: from [2620:15c:29:203:2520:fc16:115d:2f43] ([2620:15c:29:203:2520:fc16:115d:2f43])
        by smtp.gmail.com with ESMTPSA id r8-20020a170902be0800b00176e6f553efsm12647970pls.84.2022.11.22.17.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 17:30:57 -0800 (PST)
Date:   Tue, 22 Nov 2022 17:30:57 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Kees Cook <keescook@chromium.org>
cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-mm@kvack.org, kasan-dev@googlegroups.com,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] mm: Make ksize() a reporting-only function
In-Reply-To: <20221118035656.gonna.698-kees@kernel.org>
Message-ID: <d49df494-7c42-1d2a-97c8-62972c0d6c03@google.com>
References: <20221118035656.gonna.698-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, 17 Nov 2022, Kees Cook wrote:

> With all "silently resizing" callers of ksize() refactored, remove the
> logic in ksize() that would allow it to be used to effectively change
> the size of an allocation (bypassing __alloc_size hints, etc). Users
> wanting this feature need to either use kmalloc_size_roundup() before an
> allocation, or use krealloc() directly.
> 
> For kfree_sensitive(), move the unpoisoning logic inline. Replace the
> some of the partially open-coded ksize() in __do_krealloc with ksize()
> now that it doesn't perform unpoisoning.
> 
> Adjust the KUnit tests to match the new ksize() behavior.
> 
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Pekka Enberg <penberg@kernel.org>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Cc: linux-mm@kvack.org
> Cc: kasan-dev@googlegroups.com
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: David Rientjes <rientjes@google.com>
