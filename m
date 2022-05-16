Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95061C433EF
	for <linux-hardening@archiver.kernel.org>; Mon, 16 May 2022 15:45:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242048AbiEPPo7 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 16 May 2022 11:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233711AbiEPPo6 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 16 May 2022 11:44:58 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F0727CC5
        for <linux-hardening@vger.kernel.org>; Mon, 16 May 2022 08:44:57 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id o80so7942324ybg.1
        for <linux-hardening@vger.kernel.org>; Mon, 16 May 2022 08:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gh4thbZicieh5pA9EvCDqIWgLAD7rreDAsKJIQexD5c=;
        b=NAoEVeLyn9HY8sQK4KikjOwjCyegVnBTeL5zoWuK82YfpVeeInRkemfpzAO6Hr7SSx
         rREBMz9IyEZgBDaS/b2j7V35XSafSQUxzdT3PPKnWgbj3uFgbhsyyuSoFDFWDwqcvqua
         nCQLyT0v46hhy1pE4trJySbGaEWVSGPA/k0jpZvgChCHIb6+zlcaQL0dSmM7PaXvlkfz
         TTFRbsF8RVb15dpwhIDsgTD//g1y2accfif7dNoz991SFFzDD4UmDRuoVyUnBQIzDz9e
         dkRhMg5PSDInh8OuDu+jriCSbDtLVRXI8Uxt5OUZqSYXUmofr4ZAtRVMo3AWfs2L+qs6
         SgQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gh4thbZicieh5pA9EvCDqIWgLAD7rreDAsKJIQexD5c=;
        b=pIdSzG7mg/oxL9rNVLaMmiqc+uE781xnRczWVIWdRLs7v22zPY7aXod2eBQJqF/A3O
         uCBcrDwkuurRTF6u3Uk1WFAe2yJ890DFe45TDSxbwmOAonOU5exJh5PBxim7Qnmgta+c
         k4uiiT3Re5v75QTNI68QJodbcYEEAWGI7yE0vONs1iVx7otBB+VqcIFqnYDar5ik8fJQ
         jDPdRFz6XsJvmMy9EB5Ep4jA9WtWHcpC+4wSlQDHfvQZROHaxK+5XWLcMstdM9tD7gWg
         ZsxfIOZek3tCciVL4vOowY/rIeiDrSrJVgZX9hOZ/YqGPpom7Jso2rF3BndXVvBydWmV
         O2pw==
X-Gm-Message-State: AOAM533RJBN3S2Mk/8OmPEFtvItSuagaDHVHELxnNLTajAH3rNiYfUFQ
        Q7NtQWoa0FJckL7oUP9T+GgoBzCBDwqgqH1koqs6kA==
X-Google-Smtp-Source: ABdhPJw+DA403J2xHjG+VNvIXpIT/pRyykNE9Phm+VFTfI7c4mG4JJRypFFd1P2SboeRIFqLY6YvBU4iZcfiwmbMapg=
X-Received: by 2002:a05:6902:90b:b0:64b:233d:8e03 with SMTP id
 bu11-20020a056902090b00b0064b233d8e03mr17872541ybb.428.1652715896186; Mon, 16
 May 2022 08:44:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220513202159.1550547-1-samitolvanen@google.com>
 <20220513202159.1550547-2-samitolvanen@google.com> <202205141441.C3B7CF6@keescook>
In-Reply-To: <202205141441.C3B7CF6@keescook>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 16 May 2022 08:44:20 -0700
Message-ID: <CABCJKud-aV+B9-2T=jTLqSpXgzmFB=4c8_rKtnreZ6Xa3QEh2A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 01/21] efi/libstub: Filter out CC_FLAGS_CFI
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sat, May 14, 2022 at 2:42 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, May 13, 2022 at 01:21:39PM -0700, Sami Tolvanen wrote:
> > Explicitly filter out CC_FLAGS_CFI in preparation for the flags being
> > removed from CC_FLAGS_LTO.
> >
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
>
> Is it worth merging all the "existing" CC_FLAGS_LTO/CFI splits into a
> single patch? Either way:

Sure, I can merge them in the next version.

Sami
