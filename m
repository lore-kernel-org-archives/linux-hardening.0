Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB72C64EC4
	for <linux-hardening@archiver.kernel.org>; Fri,  3 Mar 2023 20:29:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbjCCU3d (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 3 Mar 2023 15:29:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbjCCU30 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 3 Mar 2023 15:29:26 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3405A10A84
        for <linux-hardening@vger.kernel.org>; Fri,  3 Mar 2023 12:29:25 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id i5so3986707pla.2
        for <linux-hardening@vger.kernel.org>; Fri, 03 Mar 2023 12:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1677875364;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ug2Z8EfRGa5wXZv9R1S7FFDl+MMXhp2ajp3G/Mo9nU4=;
        b=NtmQWi9toAZw3wKPMJ7L+bVX7AsKeXEUVZzNc61Sv1eAtGplSPyGYSdSz/thuFy3Ro
         l0ljb+r0Ij9ZZciynPhNjmrA+EYfaAbbaA1b8Cv7CMo4felDMzLv/e23Dpja0c+f6x9r
         vxtGhYy7Vif1k7Be1sRbTvqcEiOxW4Z/ZMvX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677875364;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ug2Z8EfRGa5wXZv9R1S7FFDl+MMXhp2ajp3G/Mo9nU4=;
        b=JW88b+Q0+gdeNQQfFEQzRKaxWYLqw+yYqqEA6keP5M+btQpyA5OQMWlFnvSytcxAmw
         RwQFXSrhI+yL3h9D96aTPrwYYIP18ygbKVJaYrXuFMLv8mWokYHnu70bF45KwR9j8JLe
         KwTyCXR62kyFVo0gu2NbZQpYEr9o074I5EoNdLFoBXq1cYymyGGJOvXMcjEEKvLNzArI
         KvvkaaLkwAIKMC4jQlc2FG8Pn3kO7ju7YG1cwGjonYXr+4wnab/8IXd/AGyHz+j9qQP9
         eJHurVayAArssTCk1tmew3k0kevkTkXJ6cGYfv7Dns8CgXvTQla8EEcf7UG69weiQOrw
         wm9g==
X-Gm-Message-State: AO0yUKVPMuzKcgDPcse6kOu7x7ZDzQ526ND6g+N8cSvMo8/d7lp5oFKU
        2gwXuV1YvY1lYeEypoNLk5HKyw==
X-Google-Smtp-Source: AK7set8Hbguq1EyX4kofN/jOOCOGo1tFROI/fI6a3VBD2O6AZtNvSLeX3ZNdPVBgKunGYTMNZUCjTA==
X-Received: by 2002:a17:90b:4b41:b0:234:a9df:db83 with SMTP id mi1-20020a17090b4b4100b00234a9dfdb83mr2996268pjb.10.1677875364637;
        Fri, 03 Mar 2023 12:29:24 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id r3-20020a17090aa08300b00230befd3b2csm3907348pjp.6.2023.03.03.12.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 12:29:24 -0800 (PST)
Message-ID: <640258a4.170a0220.a298f.8ed5@mx.google.com>
X-Google-Original-Message-ID: <202303031226.@keescook>
Date:   Fri, 3 Mar 2023 12:29:23 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Marco Elver <elver@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>, linux-kbuild@vger.kernel.org,
        llvm@lists.linux.dev,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ubsan: Tighten UBSAN_BOUNDS on GCC
References: <20230302225444.never.053-kees@kernel.org>
 <20230303154433.GA3775@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230303154433.GA3775@dev-arch.thelio-3990X>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Mar 03, 2023 at 08:44:33AM -0700, Nathan Chancellor wrote:
> On Thu, Mar 02, 2023 at 02:54:45PM -0800, Kees Cook wrote:
> > [...]
> >  config CC_HAS_UBSAN_ARRAY_BOUNDS
> >  	def_bool $(cc-option,-fsanitize=array-bounds)
> > +	help
> > +	  The -fsanitize=array-bounds option is only available on Clang,
> > +	  and is actually composed of two more specific options,
> > +	  -fsanitize=array-bounds and -fsanitize=local-bounds. However,
> > +	  -fsanitize=local-bounds can only be used when trap mode is
> > +	  enabled. (See also the help for CONFIG_LOCAL_BOUNDS.)
> 
> The first sentence does not read right to me, you have array-bounds
> twice. I think the first one wants to be just bounds?

Oops, yes. I rewrote that a few times and seem to have gotten lost. I
think it is better written as:

	  Under Clang, the -fsanitize=bounds option is actually composed
	  of two more specific options, -fsanitize=array-bounds and
	  -fsanitize=local-bounds. However, -fsanitize=local-bounds can
	  only be used when trap mode is enabled. (See also the help for
	  CONFIG_LOCAL_BOUNDS.) Explicitly check for -fsanitize=array-bounds
	  so that we can build up the options needed for UBSAN_BOUNDS
	  with or without UBSAN_TRAP.


-- 
Kees Cook
