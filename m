Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF1ECD37AE
	for <linux-hardening@archiver.kernel.org>; Fri, 15 Sep 2023 21:14:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237514AbjIOVOL (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 15 Sep 2023 17:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238078AbjIOVNg (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 15 Sep 2023 17:13:36 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D762CCF
        for <linux-hardening@vger.kernel.org>; Fri, 15 Sep 2023 14:13:05 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-573ccec985dso2048537a12.2
        for <linux-hardening@vger.kernel.org>; Fri, 15 Sep 2023 14:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694812385; x=1695417185; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AZHk7vThpLpskZtqajJEmCcHKvsPyXWDUd5X6GjbEhM=;
        b=oc7I+p+6FvfuU9el2G07pmZZeSF2QT32N24IMQTgseIYtZ+zm+hxwT+p5D7B239YdE
         JgNQ6SKWIt1wCWtz2CjTxBLR7cOFgHfhDt97dVKoIwWoohYv6zLWXU0Jb1UZV8uCrnMb
         qMRhQEU3J+aoYsqOLIesAlKpcVBPW9rqGgMRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694812385; x=1695417185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AZHk7vThpLpskZtqajJEmCcHKvsPyXWDUd5X6GjbEhM=;
        b=WWbOg/5o9OZgsFaT1Ov8ZUbAP4CWu5ux8key6Q0duVo9KyBEdw9T3+xMyBqRoRc85F
         +RZGm8vJKs0RAQCMxBd2kwImvIgAE4cvgcNyWmlz7Aqwo1FI2U46DCB8O4NGOptDE2hR
         T/zV1jrkoGrlJqPFfPJXfUHaRadHmVx5tXND4+O4S8trMGrsJD9iXAihhD8MX2MQ7foZ
         PJ9nDwQYu1SaJBDYI3KiE6CGBbkzkwsMJsabA4PMxZnYU7JL9QTBp8PuHJqxVAYsoNcL
         T8cRjGmg7gzNcWkZwuKKCB19faaXN3JImVNIgtY96JRx5XTrarXwODrC4wWTyONCPNCF
         iVgw==
X-Gm-Message-State: AOJu0YxrEoVbVxTSpoyudcdvKkXTQD7SiYVi0zGyPXnOcrkdoNiyPYHr
        UXvCOFUs2STMCK3w672phHYBqw==
X-Google-Smtp-Source: AGHT+IHm6HySe6IHe1hP6qL3CE05/JQnD5U2WP+Yncfwbd9pJNQNoXCcc43i0dypm9WA1Axo89FeCA==
X-Received: by 2002:a17:90b:1952:b0:268:14a0:f8a with SMTP id nk18-20020a17090b195200b0026814a00f8amr2739464pjb.39.1694812384792;
        Fri, 15 Sep 2023 14:13:04 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ie18-20020a17090b401200b0026971450601sm3428843pjb.7.2023.09.15.14.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 14:13:04 -0700 (PDT)
Date:   Fri, 15 Sep 2023 14:13:03 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Matteo Rizzo <matteorizzo@google.com>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        corbet@lwn.net, luto@kernel.org, peterz@infradead.org,
        jannh@google.com, evn@google.com, poprdi@google.com,
        jordyzomer@google.com, ardb@google.com
Subject: Re: [RFC PATCH 10/14] x86: Create virtual memory region for SLUB
Message-ID: <202309151410.E65B8300F@keescook>
References: <20230915105933.495735-1-matteorizzo@google.com>
 <20230915105933.495735-11-matteorizzo@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915105933.495735-11-matteorizzo@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Sep 15, 2023 at 10:59:29AM +0000, Matteo Rizzo wrote:
> From: Jann Horn <jannh@google.com>
> 
> SLAB_VIRTUAL reserves 512 GiB of virtual memory and uses them for both
> struct slab and the actual slab memory. The pointers returned by
> kmem_cache_alloc will point to this range of memory.

I think the 512 GiB limit may be worth mentioning in the Kconfig help
text.

And in the "640K is enough for everything" devil's advocacy, why is 512
GiB enough here? Is there any greater risk of a pathological allocation
pattern breaking a system any more (or less) than is currently possible?
> 
> Signed-off-by: Jann Horn <jannh@google.com>

But, yes, I'm still a fan, and I think it interacts well here with the
rest of the KASLR initialization:

Reviewed-by: Kees Cook <keescook@chromium.org>

Have you tried to make this work on arm64? I imagine it should be
roughly as easy?

-- 
Kees Cook
