Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08414C433EF
	for <linux-hardening@archiver.kernel.org>; Tue, 14 Sep 2021 20:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5DD060FED
	for <linux-hardening@archiver.kernel.org>; Tue, 14 Sep 2021 20:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233794AbhINUcQ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 14 Sep 2021 16:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233680AbhINUcQ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 14 Sep 2021 16:32:16 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8577EC061762
        for <linux-hardening@vger.kernel.org>; Tue, 14 Sep 2021 13:30:58 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id r4so828781ybp.4
        for <linux-hardening@vger.kernel.org>; Tue, 14 Sep 2021 13:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9szN+UFlw1GIeZx0sVo7UxtVCzmXzz7h/G+9wB5zgds=;
        b=cyqojXb+1eFD4ixGqPc3jaLiKl5OPJm3FzipodDOoi6lg5iwnrf2a/0qJ7IeAfr+3Y
         mXjHeXAFwSRsItGNBpG7qId+PxMtkHkCiVvi4zoQRD2XKugX9B9rq36YWaEjhsSwOd5g
         KC0aK88VaNGa48WyMGJ70O3GrcMBC+sdaMRfthFhjyCkUgIxiGyrud9XA0cZh/wuc/cp
         Yj5VVCzVBMSZSqi8x5lBl/G730iq9f17fzl8oID3AhCOUx2e1sBvmkyqLCN9xiYCp5fh
         k/+fGF2lufL27puzFU+edsD3oLQdW5/qmsPGUCrxc8dMvUzQuIWO2s4c+ksTh2WDfECt
         u45w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9szN+UFlw1GIeZx0sVo7UxtVCzmXzz7h/G+9wB5zgds=;
        b=y68xRYK+R9kMlt4rg47mdHiwcZgMS2TPEyalt1VlI6M+AV5hcs4Zhyt/bLRIB+Dot9
         nz2GYzdPI1omNCQfywllReMwQPqQUW7KgDnUUooDPUBxVGTWMJ3RS4n3d8HjxDybbohW
         0YtnIjbfWtC9tF9tk4cg439nt8ve58LzGkarYHm/cqymBiHYitxuElVuJA/WtWnBpnZC
         X7sCoLY+EePztv4BOylKaZCv4HFmuJfuxAyRLZsNLAUGTtbv5hGphcp2BBo+Zd1cCFGv
         mWmoEHwhS6SYz3wsvhgdkzXEnRbsLp+2mME49LsiCYt8E5o++k86i6TJdkWQnQndwDnq
         FGlA==
X-Gm-Message-State: AOAM530c0bFd49nnUQ3IwEBtjUF8aq1JsskrChQ43M4GUa205hvNX7n4
        swVa8nP3Ud1NYJ3HJ/XWsgTBkYC8t0AcKzzeV21bug==
X-Google-Smtp-Source: ABdhPJxwVQHHC2WSmxPsE4hUgfKToYHhnryc6Vbvs74/iZrsmlv3/47pVqyYw1HTGfhT038nd/ODGJ4nEc5QY07M7jI=
X-Received: by 2002:a25:fc02:: with SMTP id v2mr1420442ybd.444.1631651457419;
 Tue, 14 Sep 2021 13:30:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210914191045.2234020-1-samitolvanen@google.com>
 <20210914191045.2234020-12-samitolvanen@google.com> <CAKwvOd=OvR8iZogXhMxkbt5qT7jbhaARgk5NsCzhpkjoZ7yy5Q@mail.gmail.com>
In-Reply-To: <CAKwvOd=OvR8iZogXhMxkbt5qT7jbhaARgk5NsCzhpkjoZ7yy5Q@mail.gmail.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Tue, 14 Sep 2021 13:30:46 -0700
Message-ID: <CABCJKudRDcwfkSK205Pb__hzLWQPUFhbjUtFPbctdPAycSOKQw@mail.gmail.com>
Subject: Re: [PATCH v3 11/16] x86/purgatory: Disable CFI
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     X86 ML <x86@kernel.org>, Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Sep 14, 2021 at 1:02 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Tue, Sep 14, 2021 at 12:11 PM Sami Tolvanen <samitolvanen@google.com> wrote:
> >
> > Disable CONFIG_CFI_CLANG for the stand-alone purgatory.ro.
> >
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
>
> I kind of prefer the existing convention that has explicit guards on
> specific configs (ie. CONFIG_FUNCTION_TRACER, CONFIG_STACKPROTECTOR,
> CONFIG_STACKPROTECTOR_STRONG, CONFIG_RETPOLINE); it's more obvious
> which configs may introduce which flags that are problematic. This
> patch is ok as is, but it kind of makes this Makefile more
> inconsistent.  I would prefer we had the explicit checks.

The Makefile does already use DISABLE_STACKLEAK_PLUGIN in a similar
way, but I don't have a strong preference here. I can move this into
an ifdef if it makes things cleaner.

> Does CFI actually do any instrumentation in these object files? I
> guess issues in purgatory cause silent/hard to debug kexec failures?

The compiler shouldn't add any actual CFI instrumentation here right
now, but I would prefer to avoid issues in future.

Sami
