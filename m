Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 499E8C433EF
	for <linux-hardening@archiver.kernel.org>; Wed, 13 Oct 2021 19:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A9E1611AD
	for <linux-hardening@archiver.kernel.org>; Wed, 13 Oct 2021 19:09:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238259AbhJMTL6 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 13 Oct 2021 15:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239083AbhJMTLx (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 13 Oct 2021 15:11:53 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EBD2C061765
        for <linux-hardening@vger.kernel.org>; Wed, 13 Oct 2021 12:07:53 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id g13-20020a17090a3c8d00b00196286963b9so5149841pjc.3
        for <linux-hardening@vger.kernel.org>; Wed, 13 Oct 2021 12:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aFfFeFW/0U/lTkuA5hA19RCe0PU9m7+GEoH8ufhonLE=;
        b=lXTG4x+YLiIoWc4IXi2OJS/ALL9MYhs6CDCG5pMw0BUS7Jc80EUj80BVazu8NRJboH
         LUf8eT8d9WO52nesOw+iWiEUlQCceoDZQpeC93cZLxhKd5Hi2MqUyvshrxwDDzTK16yX
         GK2sYrjjuWBvpYgQV5LtJVStwCzUIPMpFfwTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aFfFeFW/0U/lTkuA5hA19RCe0PU9m7+GEoH8ufhonLE=;
        b=FtqSuF4IXYY6hmTbOE+8asiRJYrMRWgPemuphU4Ng0Dyc9XfTB0jjSQ8semnaC3XUE
         4XCYiHt19CJgkvoaJrGn+YMcXCy4z/blfAlhWURxfXBHoF3cK4EEAIfdD4ZY8kTteyQj
         H8h0jWmfdbnAq9htMLlmUE4TzMWEJkUhXkH8orNmklhLKte4MY8DqX+4ZrFhsS5/IFUI
         gn5v/quUM7uVkfSW0DFGmtSyZaFx7AZfYUJzw4EusSh5XlBr8NfBFYTmg190YlXEVNfz
         TIaXQeH6H4PvnDOa5SMmcNpYlUI/6kfDVr3Y7A2PPaa5576FDEPXrGvZODgtWX0/d3Ay
         PK1g==
X-Gm-Message-State: AOAM533No7pzNBFv8wY89fiKkECaOE6ZaRfogdxi1z/bIh1pTdDQQtCC
        +oZWE7Mc6j46EUNN7m0LB28koQ==
X-Google-Smtp-Source: ABdhPJwNGYAgvTtCZCfqoTzrGucnX+Au6SP7AwK9Lksq8TmXWNj5pXjk02YfGRDJ6vy/A2hT+sBLtA==
X-Received: by 2002:a17:90a:10:: with SMTP id 16mr1218998pja.50.1634152072795;
        Wed, 13 Oct 2021 12:07:52 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y2sm262614pjl.6.2021.10.13.12.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 12:07:52 -0700 (PDT)
Date:   Wed, 13 Oct 2021 12:07:51 -0700
From:   Kees Cook <keescook@chromium.org>
To:     x86@kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v5 00/15] x86: Add support for Clang CFI
Message-ID: <202110131206.9D4B6A7F0@keescook>
References: <20211013181658.1020262-1-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013181658.1020262-1-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Oct 13, 2021 at 11:16:43AM -0700, Sami Tolvanen wrote:
> This series adds support for Clang's Control-Flow Integrity (CFI)
> checking to x86_64. With CFI, the compiler injects a runtime
> check before each indirect function call to ensure the target is
> a valid function with the correct static type. This restricts
> possible call targets and makes it more difficult for an attacker
> to exploit bugs that allow the modification of stored function
> pointers. For more details, see:
> 
>   https://clang.llvm.org/docs/ControlFlowIntegrity.html
> 
> Note that v5 is based on tip/master. The first two patches contain
> objtool support for CFI, the remaining patches change function
> declarations to use opaque types, fix type mismatch issues that
> confuse the compiler, and disable CFI where it can't be used.

x86 folks: I'd prefer this series went via -tip, but I can carry it for
-next as well. What would you like to do here? I think it's ready.

Thanks!

-Kees

-- 
Kees Cook
