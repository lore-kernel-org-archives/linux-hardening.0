Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3984C433EF
	for <linux-hardening@archiver.kernel.org>; Wed, 25 May 2022 20:02:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240115AbiEYUCe (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 25 May 2022 16:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237829AbiEYUCc (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 25 May 2022 16:02:32 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244CE6833F
        for <linux-hardening@vger.kernel.org>; Wed, 25 May 2022 13:02:32 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id o10-20020a17090a4e8a00b001df2fcdc165so2585711pjh.0
        for <linux-hardening@vger.kernel.org>; Wed, 25 May 2022 13:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AWaeHfIqso2uarSrq2voc6y6tcqWng3SnNIxku0tA0k=;
        b=ezecxoS1sA3vkGGfwUxIzhGQpcMdwdQ/B9z2SvvAPRmDulRg7UxU9szNANvQ24Y57r
         ivBiwI1khWN3D600by1SoMY+gQ2uvqvLzdj6JqyC3GStB1oKR0vo010PlPD/Ov4uDDMX
         PcNzCUpi4CzTj7LRLePIkozu7t9ZfSWN2y7Ik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AWaeHfIqso2uarSrq2voc6y6tcqWng3SnNIxku0tA0k=;
        b=cbg+BarE+pzY4X+6LhHKJBwv41WlnpMusJooEaDXEuN2bu+VmWn++hO7xdvlzWI0nJ
         v3kyxFLEPqf0b/goJyfzPBnXZvpptb3La5w3rygyphUWM5uxxkV6Xg/yt9iPu00ElNFy
         rT8ki72QmJS9vJ77PK2i8NfgK0amozkPYrlkb/TLYY8wroRzMNow6IeYyOyqbFGjtSUC
         59iQ9HwxAkhoghNSd2d8DBkBvqLHnQtK/ckqpL/e6N8wJRa0bsefCa1b0QJAd46gfEIL
         7SQssUPo7itDqdWHFAJo97VcDK758fWkZF3Vwv2ZWmaiXeNQvb51lW0x2zr3yZHft4b/
         KxQA==
X-Gm-Message-State: AOAM530coGhgC/3LXqCBAGAIiTxHUCNtFqJkcLiPUdtasbwQEnRrpRlf
        ZVW95NZGb+RboShPNAY9XVqcGA==
X-Google-Smtp-Source: ABdhPJyhTlIBPpX3HR10hM9NOmXQk/4SBxH2F1TSa7CgOZddaoOpxfLS37lZuJOm1uIRUa88qkEuyw==
X-Received: by 2002:a17:90b:4b82:b0:1e0:c609:69d7 with SMTP id lr2-20020a17090b4b8200b001e0c60969d7mr2258619pjb.119.1653508951535;
        Wed, 25 May 2022 13:02:31 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f13-20020a056a00228d00b0050dc762819esm11876635pfe.120.2022.05.25.13.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 13:02:29 -0700 (PDT)
Date:   Wed, 25 May 2022 13:02:28 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        x86@kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev
Subject: Re: [RFC PATCH v2 20/21] x86: Add support for CONFIG_CFI_CLANG
Message-ID: <202205251241.FDC27BC9@keescook>
References: <20220513202159.1550547-1-samitolvanen@google.com>
 <20220513202159.1550547-21-samitolvanen@google.com>
 <YoIfWENLV1AR2ijj@hirez.programming.kicks-ass.net>
 <CABCJKucXA2jbTc9TF1mLUsEDKu52t71tzxpnsGOXY3_ks+W4Bg@mail.gmail.com>
 <20220516183047.GM76023@worktop.programming.kicks-ass.net>
 <CABCJKudmrBOkoDvDPOA-aEyrs9evHPWpzMpDZ10n8vXDBRdCxQ@mail.gmail.com>
 <20220516203723.GN76023@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516203723.GN76023@worktop.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, May 16, 2022 at 10:37:23PM +0200, Peter Zijlstra wrote:
> On Mon, May 16, 2022 at 12:39:19PM -0700, Sami Tolvanen wrote:
> 
> > > > With the current compiler patch, LLVM sets up function arguments after
> > > > the CFI check. if it's a problem, we can look into changing that.
> > >
> > > Yes, please fix that. Again see that same patch for why this is a
> > > problem. Objtool can trivially find retpoline calls, but finding this
> > > kCFI gadget is going to be hard work. If you ensure they're
> > > unconditionally stuck together, then the problem goes away find one,
> > > finds the other.
> > 
> > You can use .kcfi_traps to locate the check right now, but I agree,
> > it's not quite ideal.
> 
> Oohh, indeed.
> [...]

Hi Peter,

Sami investigated moving the CFI check after arg setup, and found that
to do it means making LLVM's CFI logic no longer both architecture
and call-type agnostic. The CFI logic needs put at a lower level,
requiring it be done in per-architecture code, and then additionally
per-call-type. (And by per-call-type, AIUI, this means various types of
indirect calls: standard, tail-call, etc.) Sami has it all working for
x86, but I'm concerned about the risk/benefit in doing it this way. I
only see down-sides:

- Linux cannot enable CFI for a new architecture without also
  implementing it within LLVM first.

- LLVM CFI code becomes more complex, making it harder to
  maintain/bug-fix/etc.

I actually see the first issue as the larger problem: I want to make it
easy for the kernel to use CFI, rather than harder. :P The first user
of CFI already cleared the way for other architectures by adjusting the
bulk of core kernel code, etc, so adding another architecture should be
as trivial as possible, and not require yet newer releases of LLVM, etc,
etc.

So, since using .kcfi_traps already solves the issue for finding the
checks, can we not require moving the CFI check? I think it would be a
mistake to have to do that.

-Kees

-- 
Kees Cook
