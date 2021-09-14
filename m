Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E40D5C433EF
	for <linux-hardening@archiver.kernel.org>; Tue, 14 Sep 2021 22:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C955060EB4
	for <linux-hardening@archiver.kernel.org>; Tue, 14 Sep 2021 22:31:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235637AbhINWct (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 14 Sep 2021 18:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235645AbhINWcp (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 14 Sep 2021 18:32:45 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC62C061574
        for <linux-hardening@vger.kernel.org>; Tue, 14 Sep 2021 15:31:27 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id o11so1460067ljp.8
        for <linux-hardening@vger.kernel.org>; Tue, 14 Sep 2021 15:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/NVWJihw8+mxkblMeUMKWZHa5HcW57V47+/ryRA4f4g=;
        b=qgFutAKEGpZf/SKejV/Bi2NvnFIej9XU7ZBF5Rsx7JkwnAFyYg3lckowPNJ17rk4mk
         DV3q6AswIVnkJ/uQDSz3gsB946gSRsqJcBwHVi8iqbvUqaSIU04Vgj90096Fmxf+GWdy
         I8Hd6on20wzkR5xl0kJGh5nQw44HLi/F6vtULV3QuN8FIByAMCEvwqyldqODg+2+vVjj
         DOcdlURnGyYkSEVHXi7yl7y9pR9foHVBUJunF6gGn+NLicmzott3wMS8dDUM42YY9UEk
         /LuBflX18x1HOIDjgpG3Svi7P8/2W+Ra1wC0LZa3Lbn8T6PyYcN9w8le+LW0PGIhBRd5
         4Eqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/NVWJihw8+mxkblMeUMKWZHa5HcW57V47+/ryRA4f4g=;
        b=J60FtsrHifUuBXpnm1JKXacPVGe5ytdeO8dGLZC1uBhA0CPx+noj/KMU3gNn3GD4EO
         vmKBGjGaypCHwinOo+D/T1Wh2T7nvI3sxlGtJB//OSf2drHkTWD0DVXSS3JLHbM2vxeY
         aHcxgNSyz9FXa1iB3ot8PP7/lGFxNogT+HNkk1/+Rqo+uhhwB2eOwLB08cE1RF2oATtS
         fTh6rDIYEg5MVCoLkV+x8UpngkzPi1nopNB+6xJlag009mF/fpPmdpkPxqIV8VoihG4k
         FMyAkmtnpuyL95fUskevByrBTyEaHXUXwFjvJVRtht+rnSd9t1xwp9Cd9HWsNwFJNrpZ
         9TjA==
X-Gm-Message-State: AOAM532qYqc4VNfxaRNDxH6J3AWOWrhnrFYbgJeFQcIPYfYMDy1q9NW/
        w6XbFvrJeBX00Nmb+8guV81hAt9bJpsrxxaOgMvHFQ==
X-Google-Smtp-Source: ABdhPJzfSMfk3cB0ZCvwLiGPWOn8ZNgyMxOydEvYDNoBwhQ3myvaaomRVN0JfSKn3Mu8Vcacbr1v4PNVRcOKeKSEf0Q=
X-Received: by 2002:a2e:b551:: with SMTP id a17mr17253096ljn.128.1631658685761;
 Tue, 14 Sep 2021 15:31:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210914191045.2234020-1-samitolvanen@google.com>
 <20210914191045.2234020-12-samitolvanen@google.com> <CAKwvOd=OvR8iZogXhMxkbt5qT7jbhaARgk5NsCzhpkjoZ7yy5Q@mail.gmail.com>
 <CABCJKudRDcwfkSK205Pb__hzLWQPUFhbjUtFPbctdPAycSOKQw@mail.gmail.com>
In-Reply-To: <CABCJKudRDcwfkSK205Pb__hzLWQPUFhbjUtFPbctdPAycSOKQw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 14 Sep 2021 15:31:14 -0700
Message-ID: <CAKwvOd=q1xhn9OEyowWyMeDW8CbWW4=nRmdE1tHggjCZKr7xrA@mail.gmail.com>
Subject: Re: [PATCH v3 11/16] x86/purgatory: Disable CFI
To:     Sami Tolvanen <samitolvanen@google.com>
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

On Tue, Sep 14, 2021 at 1:30 PM Sami Tolvanen <samitolvanen@google.com> wrote:
>
> On Tue, Sep 14, 2021 at 1:02 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > On Tue, Sep 14, 2021 at 12:11 PM Sami Tolvanen <samitolvanen@google.com> wrote:
> > >
> > > Disable CONFIG_CFI_CLANG for the stand-alone purgatory.ro.
> > >
> > > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> >
> > I kind of prefer the existing convention that has explicit guards on
> > specific configs (ie. CONFIG_FUNCTION_TRACER, CONFIG_STACKPROTECTOR,
> > CONFIG_STACKPROTECTOR_STRONG, CONFIG_RETPOLINE); it's more obvious
> > which configs may introduce which flags that are problematic. This
> > patch is ok as is, but it kind of makes this Makefile more
> > inconsistent.  I would prefer we had the explicit checks.
>
> The Makefile does already use DISABLE_STACKLEAK_PLUGIN in a similar
> way, but I don't have a strong preference here.

mmm...DISABLE_STACKLEAK_PLUGIN adds to PURGATORY_CFLAGS. This patch
adds to PURGATORY_CFLAGS_REMOVE.

> I can move this into
> an ifdef if it makes things cleaner.
>
> > Does CFI actually do any instrumentation in these object files? I
> > guess issues in purgatory cause silent/hard to debug kexec failures?
>
> The compiler shouldn't add any actual CFI instrumentation here right
> now, but I would prefer to avoid issues in future.

Ok, good to know.
-- 
Thanks,
~Nick Desaulniers
