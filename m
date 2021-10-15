Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF114C433EF
	for <linux-hardening@archiver.kernel.org>; Fri, 15 Oct 2021 19:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A130610D2
	for <linux-hardening@archiver.kernel.org>; Fri, 15 Oct 2021 19:11:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242531AbhJOTNK (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 15 Oct 2021 15:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238486AbhJOTNJ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 15 Oct 2021 15:13:09 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3DF7C061762
        for <linux-hardening@vger.kernel.org>; Fri, 15 Oct 2021 12:11:02 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id i24so44561094lfj.13
        for <linux-hardening@vger.kernel.org>; Fri, 15 Oct 2021 12:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oI0JQpdNcS1rPABaNRpOZ/cT39QBnr4F5JH8mM3KD1w=;
        b=KItGKghbFy6S8IwlkpEtP4HNbtAfKfSjgliZYr6bPw6mL8dfVSVPPw+Lu6A3D6KYGG
         JL6+RBOsqVCU63RCfXhpXlk9/+Od7crS2PHmqiaTBP4vaYWJC8bpMmWXSDhfIaJCfV9x
         KV7yHlxcxqHOZl3G2UPtEQbwkzn4SeJokDnkr5D6uE1SuAkNwE+Os6wBth3CI/ZCjZnJ
         Fl7nxdD3gZBsmghjKmNQyoN/DtGfjys0qypNRPMsb730as0k1sPUN9PL7I8LoXNold+W
         oKG8PJms0LcTJcgMvueNQDJMwRWsCmSQyRGJoWkFMc6KF85C5Nc8KvAQE9EebTj1WNR7
         yqUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oI0JQpdNcS1rPABaNRpOZ/cT39QBnr4F5JH8mM3KD1w=;
        b=CfJFl0D4ncyW4CwvyLByS20fcDuBVCi4FudTRyBv5rE5JW2eJZehSX24CkirKTmogl
         BJd2/9a+EPRyi93vpqBFMV7sVlMKxSxVFN0AH5YMjhb3JOkv5i2Nm6AKVILtHQGJ5lVJ
         tv6qK2PeBSuOqSWzFKSkUDKrxj/pXNyMMEB5bELOdvREW8pkDbUpom8E7XnoDUJ5j1nQ
         X7Pd0XGLrHbzfI0WoTxfdpgj1b3k8TDzTdUu2FCwV/Q7kDp/kLlQ4caVEekTkiKY58MX
         IZI/p1kBDpPLlXq9D0dMqgc4XFNAddVWWcoyDppdk2Mwr9BGu/7/Kh7X+QVH1MetfKVB
         nr4Q==
X-Gm-Message-State: AOAM533xyzgMUEM67uGYOH7fGxhI9T81AacKTLWQ0KCK5jDC0Ri7kQUI
        D3940qThHyLCaa9Pycl8Wf9ia1CwL9P3t9TtTsGMsw==
X-Google-Smtp-Source: ABdhPJxJPbFY1d2ckPhtr+TsSG22LMoybIwYHl50ZAsM2+uDTJMohjuxtsNO4gx/E6FVg7uvt9WPFt5c5aoDLal6yWY=
X-Received: by 2002:a05:651c:1108:: with SMTP id d8mr14747364ljo.220.1634325060799;
 Fri, 15 Oct 2021 12:11:00 -0700 (PDT)
MIME-Version: 1.0
References: <1634167668-60198-1-git-send-email-ashimida@linux.alibaba.com>
 <CAKwvOdkv70XDdK-k3n4ycFQsz+h7V-sTiH8RuxxaLofp-okweQ@mail.gmail.com> <722d9662-e27c-2efb-e8cf-d505b6950475@linux.alibaba.com>
In-Reply-To: <722d9662-e27c-2efb-e8cf-d505b6950475@linux.alibaba.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 15 Oct 2021 12:10:49 -0700
Message-ID: <CAKwvOdmfbcT5bWhm5zVhuBRjx4PxLXY8dKUCV0JFrSKRy1Bpwg@mail.gmail.com>
Subject: Re: [PATCH] [PATCH V4]ARM64: SCS: Add gcc plugin to support Shadow
 Call Stack
To:     Dan Li <ashimida@linux.alibaba.com>
Cc:     masahiroy@kernel.org, michal.lkml@markovi.net,
        catalin.marinas@arm.com, will@kernel.org, keescook@chromium.org,
        nathan@kernel.org, tglx@linutronix.de, akpm@linux-foundation.org,
        samitolvanen@google.com, frederic@kernel.org, rppt@kernel.org,
        mark.rutland@arm.com, yifeifz2@illinois.edu, rostedt@goodmis.org,
        viresh.kumar@linaro.org, andreyknvl@gmail.com,
        colin.king@canonical.com, ojeda@kernel.org,
        luc.vanoostenryck@gmail.com, elver@google.com,
        nivedita@alum.mit.edu, ardb@kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-hardening@vger.kernel.org, clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Oct 15, 2021 at 11:29 AM Dan Li <ashimida@linux.alibaba.com> wrote:
>
>
>
> On 10/15/21 2:44 AM, Nick Desaulniers wrote:
> > Overall, I'm happy with the patch and am ready to ack it, but I would
> > like to see a link to to the upstream GCC feature request for SCS (and
> > one created if it doesn't exist) cited explicitly in the commit
> > message.  I think that would be a good demonstration that this can or
> > will be upstreamed into the compiler proper for the compiler vendors
> > to maintain, rather than the kernel folks.  The compiler vendors may
> > have further feedback on the approach, such as my question above
> > pertaining to inlining.
> >
> I have submitted a feature request to the gcc community, and waiting
> for a follow-up response.
>
> Is it fine to add the following description in [PATCH V5]?
>
> A similar feature request has also been sent to gcc.
> link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=102768

Yes, and you can include
Acked-by: Nick Desaulniers <ndesaulniers@google.com>
too.

-- 
Thanks,
~Nick Desaulniers
