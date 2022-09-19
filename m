Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C46C6FA82
	for <linux-hardening@archiver.kernel.org>; Mon, 19 Sep 2022 19:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbiIST01 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 19 Sep 2022 15:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiIST0Z (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 19 Sep 2022 15:26:25 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C54340BDF
        for <linux-hardening@vger.kernel.org>; Mon, 19 Sep 2022 12:26:24 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id o99-20020a17090a0a6c00b002039c4fce53so2934122pjo.2
        for <linux-hardening@vger.kernel.org>; Mon, 19 Sep 2022 12:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=RmR4iKksLM46UToapAYzrq41XElOopC0q9ix9wCyuKs=;
        b=PVp6YfOyhZha6HJBZg4yMtXtA6aL/+bfSb1OxdA/ZExOmbVQM2yfYZsTWjQ6063o+g
         O/WXQa7b/F65Rx7p9dmtXDkLgZhqolfdom4zM4hw974cbNh9+jBHQds5pbZU4LQk7WHZ
         1voIXAXh0NcOJOcUipffT2wyw4qSXZ8I5NPMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=RmR4iKksLM46UToapAYzrq41XElOopC0q9ix9wCyuKs=;
        b=co/bMX4FvfIdGQUgcdgr153/BPGYpeeBWQcFw0Q2hvCrkuuMcHfrCccl3Fby9ykd6B
         p9pSR9JOlfN9FEdNNAICixFmN0YuiGZ8nbXmxxK6k0H8AyQ7ueIdyv+nszj45pwBYnzg
         vD0A3AWgBMYCxLXx35G29CF6l4eYKkz43efFEHDd8CKEhUZbsJMyyj/N/bK4c3tYwMlh
         PCjc+LTdUi1fhV6Z5ab1PbzceuN6ASECgDH+JhJsh+Ry4bLwmS5/yppJRlzAn+P6K8dB
         DnfP2+2X2sAXVm8bOdLd7B6XMZ2/h6AGJUDt8DnYeTROeuIjeXWpNZxdAFVMIVjtzCDn
         QKrA==
X-Gm-Message-State: ACrzQf24cKx29zXFdfLYT9cKQmhKnRM8CWUnEQTQ0OQEalOTdwLK0OEB
        4/dW6sjYsbXSCQjq+Rz99m37eA==
X-Google-Smtp-Source: AMsMyM7jddefl5071rxvDEg9p60KFOEMQVhTHRe5BfeqSqt5aIP+GxxXxhHHyIaoiGWYhH5Gh+7ztw==
X-Received: by 2002:a17:90a:ab91:b0:202:a520:56c9 with SMTP id n17-20020a17090aab9100b00202a52056c9mr33416244pjq.1.1663615583818;
        Mon, 19 Sep 2022 12:26:23 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n17-20020a170902e55100b001752cb111e0sm21243619plf.69.2022.09.19.12.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 12:26:23 -0700 (PDT)
Date:   Mon, 19 Sep 2022 12:26:22 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Yu Zhao <yuzhao@google.com>, dev@der-flo.net,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-perf-users@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH 0/3] x86/dumpstack: Inline copy_from_user_nmi()
Message-ID: <202209191225.B3A759134@keescook>
References: <20220916135953.1320601-1-keescook@chromium.org>
 <20220916125723.b4c189d09bcd8fd211a73c32@linux-foundation.org>
 <YyiAz4gs4TvTqrvI@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyiAz4gs4TvTqrvI@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Sep 19, 2022 at 04:46:39PM +0200, Peter Zijlstra wrote:
> On Fri, Sep 16, 2022 at 12:57:23PM -0700, Andrew Morton wrote:
> > Why is this so complicated.
> > 
> > There's virtually zero value in running all those debug checks from within
> > copy_from_user_nmi().
> > 
> > --- a/arch/x86/lib/usercopy.c~a
> > +++ a/arch/x86/lib/usercopy.c
> > @@ -44,7 +44,7 @@ copy_from_user_nmi(void *to, const void
> >  	 * called from other contexts.
> >  	 */
> >  	pagefault_disable();
> > -	ret = __copy_from_user_inatomic(to, from, n);
> > +	ret = raw_copy_from_user(to, from, n);
> >  	pagefault_enable();
> >  
> >  	return ret;
> 
> I'm with Andrew here; this looks a *LOT* saner than all the other stuff.

Yeah, I'd agree -- it's a special case of a special case. I'll send a
new patch.

Thanks!

-- 
Kees Cook
