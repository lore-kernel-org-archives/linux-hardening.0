Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38EFBC433EF
	for <linux-hardening@archiver.kernel.org>; Thu, 14 Oct 2021 19:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D20561156
	for <linux-hardening@archiver.kernel.org>; Thu, 14 Oct 2021 19:01:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbhJNTDF (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 14 Oct 2021 15:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232535AbhJNTDE (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 14 Oct 2021 15:03:04 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679F3C061753
        for <linux-hardening@vger.kernel.org>; Thu, 14 Oct 2021 12:00:59 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id u21so28008025lff.8
        for <linux-hardening@vger.kernel.org>; Thu, 14 Oct 2021 12:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N65pshGMOSWSb7ytdKQXKm+0kQotiHH1u3g8XlS6SNw=;
        b=MurAIBhAyWvppT1gcNnRicRI9zIENGp8xMMvTyFCuc/Ed0okX64APsncB/biZCuK/W
         YkbhQnbgtIVSbavZyNTA6MaswMyeo76MVVreGHF5lgKUd1Id+FiJuiUwqNeQ6gkiRgJK
         EGbBBUD90fzEUuim+zdEiYSIgfnlmIBH8/VqVRkiHMMu6EtzF/G6soZ8egpcYoDxiJgq
         eJ3lV7IewaWCU8j0LPzOhVLYCRGvzxL1KgHDj10F1AxTAyjKLXZRb7dyg8odmI7bsN6D
         KoGgXsWQ2CA3ZUwikn3n5UuyGQxdOq1v6hSIwdSlMlv5cKIvgZl0x0ihmPu8V09Bz+FO
         H6ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N65pshGMOSWSb7ytdKQXKm+0kQotiHH1u3g8XlS6SNw=;
        b=U3dViniSOC9289zZljsXjdo5a/JZQvuMY7ATQN98L2kASfOxfbzVkjezfAOTa58gXf
         j4OsOTuS5MB1igGUH9o3FoK0aOKLJSUZPa6JAHdZAD1skDw6TGWOmOEJpD9UPPJZTZEn
         HDqCLXikMc/5udd+WG9nNXaq/U6xxrOEzUioo242h7gwNh177ozT8lnZ59TIbfSHIVsx
         fko2opJEO+1ke7U7zWBZbhZi6IxmGZ2Z4/ArVvsKBSvTtwxeJN0hYFOhmulefJyvTeNM
         aftGSZxHhYN7n5u33e6D+Mcx77bzKUzpYtlINCeVLfQA2ZpBc5tR16UwKjWz1h4b1JCH
         dJcw==
X-Gm-Message-State: AOAM530WIdQwOIcNYy6UMfS1ns7Qv9HN7wEJze13bZuFGBQAs6aWHH9R
        bwgIidC+26d8sPyPA7m1f2dhJsHV62y5stmJ1MJAgw==
X-Google-Smtp-Source: ABdhPJx4VtNZo6P/3mvHn2eIoRK5I0Ry6vLL9tIF5Vufdc6MMyrG1tLIRdbjhsp6q+0UJjBwDlR4ikuAI6lCXcOdKO0=
X-Received: by 2002:a05:6512:2284:: with SMTP id f4mr6823396lfu.489.1634238057524;
 Thu, 14 Oct 2021 12:00:57 -0700 (PDT)
MIME-Version: 1.0
References: <20211013181658.1020262-1-samitolvanen@google.com>
 <20211013181658.1020262-10-samitolvanen@google.com> <YWgSwmzPFrRbMC1P@zn.tnic>
 <202110140904.41B5183E@keescook> <YWhpbu/Y6V2p/zlY@zn.tnic> <CABCJKueW+=DfzONAZb-XF=mWYH_S-BeNihZfGhidOGJO=WYmZw@mail.gmail.com>
In-Reply-To: <CABCJKueW+=DfzONAZb-XF=mWYH_S-BeNihZfGhidOGJO=WYmZw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 14 Oct 2021 12:00:46 -0700
Message-ID: <CAKwvOdnw4Ci_z4=y7NDFiWyhRO8W_KXjyBtd-RuNuznA2iMiPg@mail.gmail.com>
Subject: Re: [PATCH v5 09/15] x86: Use an opaque type for functions not
 callable from C
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Borislav Petkov <bp@alien8.de>, Kees Cook <keescook@chromium.org>,
        X86 ML <x86@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Oct 14, 2021 at 11:24 AM Sami Tolvanen <samitolvanen@google.com> wrote:
>
> Anyway, I thought using a macro would make the code easier to
> understand. I'm happy to rename it to something that makes more sense,
> but also fine with switching to a simple extern u8[] if that's
> preferable.

Perhaps `extern u8 []`s with a comment that these symbols are
functions that aren't meant to be called from C, only asm (or compiler
generated code) would suffice?
-- 
Thanks,
~Nick Desaulniers
