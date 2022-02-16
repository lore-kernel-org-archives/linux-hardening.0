Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F58C433EF
	for <linux-hardening@archiver.kernel.org>; Wed, 16 Feb 2022 22:13:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236831AbiBPWNs (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 16 Feb 2022 17:13:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236628AbiBPWNr (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 16 Feb 2022 17:13:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 472772AED85
        for <linux-hardening@vger.kernel.org>; Wed, 16 Feb 2022 14:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645049612;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GInsY8EWMmzWnfSQud73Z6xT/DOtOKlNQiWr2Elb/hk=;
        b=gt5ZzQS+E8Z3cPcIVhuK8DF2rNR9fyTOuDz3K96kuuPwEroSyKNmOLex9kHvGVOJo5oiyF
        +ywTazmMs0hwVa1svmxjp7UxiSqntfingy5+UVIe0/B8uuqkOj5LQJJvjZ5xBvHe9tIyai
        0cH+sGqwyxebOoafOky5qYzJRNFEeos=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-611-T9fupWnoOWab1FRbcuaTGw-1; Wed, 16 Feb 2022 17:13:31 -0500
X-MC-Unique: T9fupWnoOWab1FRbcuaTGw-1
Received: by mail-qk1-f197.google.com with SMTP id bi17-20020a05620a319100b0050850bdcbb2so2429473qkb.17
        for <linux-hardening@vger.kernel.org>; Wed, 16 Feb 2022 14:13:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GInsY8EWMmzWnfSQud73Z6xT/DOtOKlNQiWr2Elb/hk=;
        b=uR1xOZQ5CfN0z8xk6zappJfE9X1M+0JHQbrt9BN0L9/ZY08u9SsRSxRLnE/f8x0Fjc
         Ur11bTvarRNRCh+8b//9cmsW86oO9/PNY649Zoj1wZvMYq0OYXR5hGY8DOkNnuokpr3n
         F8/MIdqz50pVM9/K39qbicaubAZNY6rqZjV5vxq7hfnfEb5dz9B2yygeewUF9N1ISmtn
         xHIBVSCorfFjJKveuYhuGJs9GeBlDzv1I/7TCw8mqsshAZ7fvC5twPkNjb1LquL2tStV
         WA7VO740WY7e5LQO6LD69A7pCXzWB7/OFmADJFp7a7xsTgMFbOd+42BcVw/uNoI8Y9aN
         gKvw==
X-Gm-Message-State: AOAM530AbuNzEAVxbz+S+FgIyCMIZAG8xKj+rDrfXVHG+1nrZqE0rbiq
        pnNZfGjAIewQjAZOfH96O92wlohE+3lbaoVop9+XqU8BcasYgIZqi/m+tuZuN+zv/Wgl4vRF9mu
        juOkPTgfhSCkGZbduyg7JQSqrfKSm
X-Received: by 2002:a37:bcd:0:b0:508:19df:59ac with SMTP id 196-20020a370bcd000000b0050819df59acmr2498051qkl.227.1645049610689;
        Wed, 16 Feb 2022 14:13:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJylNMRi17SxjrpZK57rI6C9v3gwc8m6LOiygd1+pTiydJMqSsqj+XSkhj9zykPsZ8CKxgwdIw==
X-Received: by 2002:a37:bcd:0:b0:508:19df:59ac with SMTP id 196-20020a370bcd000000b0050819df59acmr2497996qkl.227.1645049610346;
        Wed, 16 Feb 2022 14:13:30 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id m22sm19966780qkn.35.2022.02.16.14.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 14:13:29 -0800 (PST)
Date:   Wed, 16 Feb 2022 14:13:24 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Joe Lawrence <joe.lawrence@redhat.com>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        =?utf-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>,
        linux-hardening@vger.kernel.org, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Ard Biesheuvel <ardb@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Bruce Schlobohm <bruce.schlobohm@intel.com>,
        Jessica Yu <jeyu@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Marios Pomonis <pomonis@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Nicolas Pitre <nico@fluxnic.net>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, live-patching@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v10 02/15] livepatch: avoid position-based search if `-z
 unique-symbol` is available
Message-ID: <20220216221324.4b4avd5l3qdmqfcv@treble>
References: <20220209185752.1226407-1-alexandr.lobakin@intel.com>
 <20220209185752.1226407-3-alexandr.lobakin@intel.com>
 <20220211174130.xxgjoqr2vidotvyw@treble>
 <CAFP8O3KvZOZJqOR8HYp9xZGgnYf3D8q5kNijZKORs06L-Vit1g@mail.gmail.com>
 <20220211183529.q7qi2qmlyuscxyto@treble>
 <20220214122433.288910-1-alexandr.lobakin@intel.com>
 <20220214181000.xln2qgyzgswjxwcz@treble>
 <Yg1fab6h1rTjVbYO@redhat.com>
MIME-Version: 1.0
In-Reply-To: <Yg1fab6h1rTjVbYO@redhat.com>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jpoimboe@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Feb 16, 2022 at 03:32:41PM -0500, Joe Lawrence wrote:
> > Right, so we'd have to abandon position-based search in favor of
> > file+func based search.
> > 
> > It's not perfect because there are still a few file+func duplicates.
> > But it might be good enough.  We would presumably just refuse to patch a
> > duplicate.  Or we could remove them (and enforce their continued removal
> > with tooling-based warnings).
> > 
> 
> You're talking about duplicate file+func combinations as stored in the
> symbol table?

Right.

> ...
>       6 OBJECT core.c::__func__.3
>       6 OBJECT core.c::__func__.5
>       7 OBJECT core.c::__func__.1
>       8 OBJECT core.c::__func__.0
>       8 OBJECT core.c::__func__.2
> 
> We could probably minimize the FUNC duplicates with unique names, but
> I'm not as optimistic about the OBJECTs as most are created via macros
> like __already_done.X.  Unless clever macro magic?

Good point about objects, as we rely on disambiguating them for klp
relocations.  Luckily, the fact that most of them are created by macros
is largely a good thing.  We consider most of those to be "special"
static locals, which don't actually need to be correlated or referenced
with a klp reloc.

For example:

- '__func__' is just the function name.  The patched function shouldn't
  need to reference the original function's function name string.

- '__already_done' is used for printk_once(); no harm in making a new
  variable initialized to false and printing it again; or converting
  printk_once() to just printk() to avoid an extra print.

- '__key' is used by lockdep to track lock usage and validate locking
  order.  It probably makes sense to use a new key in the patched
  function, since the new function might have different locking
  behavior.

> Next question: what are the odds that these entries, at least the ones
> we can't easily rename, need disambiguity for livepatching?  or
> kpatch-build for related purposes?

I would guess the odds are rather low, given the fact that there are so
few functions, and we don't care about most of the objects on the list.

If duplicates were to become problematic then we could consider adding
tooling which warns on a duplicate file:sym pair with the goal of
eliminating duplicates (exculding the "special" objects).

-- 
Josh

