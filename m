Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68731C433F5
	for <linux-hardening@archiver.kernel.org>; Tue,  2 Nov 2021 18:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FFEF60E78
	for <linux-hardening@archiver.kernel.org>; Tue,  2 Nov 2021 18:59:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbhKBTC0 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 2 Nov 2021 15:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbhKBTC0 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 2 Nov 2021 15:02:26 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009ADC061714
        for <linux-hardening@vger.kernel.org>; Tue,  2 Nov 2021 11:59:50 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id i26so34596885ljg.7
        for <linux-hardening@vger.kernel.org>; Tue, 02 Nov 2021 11:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=78i/6onah1wD3WH0ZmVwkLw2NEIPagEIZOA+0zXUqcs=;
        b=OU85Ce6F62Olh1fhYan44oz3yHZvskd5SPoq7r/pIdvEz5p9b8GUpyuoEeaw0gmWkS
         dY+6LbFk1IVosRH7v6gBfbEduDUwBI0GimHShP/s2joR6wagL1C0hR5cM7s1KnqDV8C6
         hvNiJygVDP7uUt5wrGZeEIAK5RWDoy6cB/0gjBgRFQf4RE3UFgX5AyYKIek41ZZZLl3x
         OM2cunpKwnANVsBqaT3LS9kUs1CGjoyftCNXJ+rQ/kcwsu3P6wg2bFHZHwnUEIXf/EsG
         rDRFc4grOPDOLyEfo/+bZzvAE8Bqlmc7vc0KUKkyXtfg5TYyUsbtcMmK8brkuk3cY0Py
         jYmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=78i/6onah1wD3WH0ZmVwkLw2NEIPagEIZOA+0zXUqcs=;
        b=l9+h/9npew+tHEWundzTSn2eOtWCrceudAo7QbCmwmOLeEHm362YZ2Scn8MwzZJGiu
         GmunQjLFcj9RyoxHeHjEkBE0D/1OWXlR6GZntN+CYxIaDAgGUdgjrv+VgM7PaDuesgO7
         P94wHNJDgN8Ht2nYIa3k7utoIiXHIzwRTIYuWPYprxi+x5fHrgODIT3qu6P7nUbTpozA
         59iLEeTGV5y58mfwIIhHOa50O65nFYGRm0rtDpqBwAK/SdaUJtQjBe7ABvwiaIExI688
         Fg6484VJ0LFtbwufSt5FcfKBmNWXMNn7El7K4FLJVnbCyYZMsLrgbL1wFRbroZLFjTaH
         GbJA==
X-Gm-Message-State: AOAM531PwG6i1rvmDZVXReHdNF07itNi7fXGyQQBgMNgk49XsFtH6TRu
        GUGuv1WfQhIMH0r9lnEmbNaQynFInoPpdiQmg2KAdA==
X-Google-Smtp-Source: ABdhPJzqcmYeRcc05HDoaGddBiM9N7Rz0Ku7intCPoAvsnhEtKtIC+RtvjzicO/eWv/D4ZAmMYaIn4JQVNv+eSEVHtI=
X-Received: by 2002:a05:651c:548:: with SMTP id q8mr17492682ljp.220.1635879589100;
 Tue, 02 Nov 2021 11:59:49 -0700 (PDT)
MIME-Version: 1.0
References: <20211102075812.122715-1-ashimida@linux.alibaba.com>
 <CANiq72meBX1g6z2-vfNpMw2C8S-BavuA4CTyPLpD4zUcX193Sw@mail.gmail.com>
 <CAKwvOd=0GpX59U1ndzahJ8mh26C-Gb54pjwUk4eYigb0ZoCiwg@mail.gmail.com> <CANiq72=xQ4-bcm7csNJH2C9pfVqAdLypc8n_JTL2PBYr9vQgqA@mail.gmail.com>
In-Reply-To: <CANiq72=xQ4-bcm7csNJH2C9pfVqAdLypc8n_JTL2PBYr9vQgqA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 2 Nov 2021 11:59:37 -0700
Message-ID: <CAKwvOdn6GPc=g2451Lszaq_Vg4TVPpDr4y9hBVXyCsGRi470ug@mail.gmail.com>
Subject: Re: [PATCH] [RFC/RFT] AARCH64: Add gcc Shadow Call Stack support
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Dan Li <ashimida@linux.alibaba.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, frederic@kernel.org,
        yifeifz2@illinois.edu, Steven Rostedt <rostedt@goodmis.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, andreyknvl@gmail.com,
        Colin King <colin.king@canonical.com>,
        Miguel Ojeda <ojeda@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Marco Elver <elver@google.com>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Nov 2, 2021 at 11:51 AM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Tue, Nov 2, 2021 at 7:42 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
> >
> > Do we want to move this to include/linux/compiler_attributes.h?
> > Respecifying these repeatedly in each include/linux/compiler-*.h feels
> > excessively redundant.
>
> Note that they are spelled differently, which is one of the reasons to
> keep them separate (and why I invoked my hopes of Clang and GCC
> agreeing).

Ah, that's right. The sanitizers differ here...I missed `__noscs`
definition in include/linux/compiler-clang.h during my initial code
review.
-- 
Thanks,
~Nick Desaulniers
