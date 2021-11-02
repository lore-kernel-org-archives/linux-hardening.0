Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D5ADC433EF
	for <linux-hardening@archiver.kernel.org>; Tue,  2 Nov 2021 16:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24D176112D
	for <linux-hardening@archiver.kernel.org>; Tue,  2 Nov 2021 16:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234343AbhKBQmS (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 2 Nov 2021 12:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbhKBQmN (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 2 Nov 2021 12:42:13 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00DCAC079787
        for <linux-hardening@vger.kernel.org>; Tue,  2 Nov 2021 09:16:48 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id h2so22406202ili.11
        for <linux-hardening@vger.kernel.org>; Tue, 02 Nov 2021 09:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4na7Z3qKpK98tLEldwdbursAi8x2ExOOq/m1N9WO/PQ=;
        b=UESeVPFSCoUHKvi/Ne9+LdcyNl0jc6N8ha9gfWbXlyHJY8Vma5Bo3gLLdDwMPp8PCg
         HliVcRg6u1W8vwBy1lI+3W590HzZb0tgNbbr42aXZrWPL6WWNm4YCUJk6RoMhsBdNzf1
         8SvI5PnHJXF6IHUY7j2g1ABUrF8tF0pATMMoukHXdFeBfqfOKF/FtlI0L6sKF0/Xsa/f
         ksZUsat2ryOzRQal0XMqcNSF32nBx/U1/CqHBrJNmuaHhUU7F7gwhr4FEqsFCvG+jHcV
         tWwphkyLBdhYKrvH9v6RZlSTVfXw5F0CElBSC27Frgon1wOmYDuL++5Q4+XMeK3MEPEg
         2yNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4na7Z3qKpK98tLEldwdbursAi8x2ExOOq/m1N9WO/PQ=;
        b=axUdFxdOhOuxoDdxEJlurJrTPX8KcboNFaH0ggBq1e5pBm88KQ1T80ONWVCOyJ04cv
         EMsJ2aLOuQdj6fU/a7K2IsSD9rEMsmcbMPHrGMKfIQykgLXVPL3H6tGYLibKbU9G9DCU
         qRrGut0SyR8EMjnFDxttuzzx4TgACd4peYUJCy51bClUKWcdz9u0lC0vC9CJIWxqMIWh
         s3cqjGoEBDMVKJ2IPAGgjSTe+5jNG778qzwJ85YRms2wTeYen/aoAwgbcbFHB59aBKc4
         m3P64AwhQLsYJljzdS/lKagREhOfn1gcoWSAjOurPc/uh1akRk4oXsSfmkUvMijp4g3K
         3U4w==
X-Gm-Message-State: AOAM533qJ8vfXK2jT6Vn+SJpKFCINLac3EIfWHluTvpwjnm5FJznklKg
        SB2E7XTX+W06XFM6PTst1ikfJgsnu9tMsD8ZuLQ=
X-Google-Smtp-Source: ABdhPJwquvMnsflMdh5mQvl40Zj1TLjOEoWvboAhTLQfaUm8OmWnAFDGDRn8yYYZia25wMugo7vJV3Y5HOoCKKIoQeE=
X-Received: by 2002:a92:c26f:: with SMTP id h15mr16314316ild.72.1635869807514;
 Tue, 02 Nov 2021 09:16:47 -0700 (PDT)
MIME-Version: 1.0
References: <20211102075812.122715-1-ashimida@linux.alibaba.com>
 <CANiq72meBX1g6z2-vfNpMw2C8S-BavuA4CTyPLpD4zUcX193Sw@mail.gmail.com> <b08a94af-f7a4-c228-0ec8-24709385f1d5@linux.alibaba.com>
In-Reply-To: <b08a94af-f7a4-c228-0ec8-24709385f1d5@linux.alibaba.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 2 Nov 2021 17:16:36 +0100
Message-ID: <CANiq72=wKsakjzbA53_29zT4vEHoQ9mRsxzwg_3s88PWf8Ha-A@mail.gmail.com>
Subject: Re: [PATCH] [RFC/RFT] AARCH64: Add gcc Shadow Call Stack support
To:     Dan Li <ashimida@linux.alibaba.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
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

On Tue, Nov 2, 2021 at 5:03 PM Dan Li <ashimida@linux.alibaba.com> wrote:
>
> Thanks, Miguel :)

You're welcome! Thanks for your work on this! :)

With those changes and assuming your feature is merged to GCC 12:

    Reviewed-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel
