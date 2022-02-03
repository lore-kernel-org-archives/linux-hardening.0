Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C86D7C433EF
	for <linux-hardening@archiver.kernel.org>; Thu,  3 Feb 2022 20:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354927AbiBCUrG (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 3 Feb 2022 15:47:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356641AbiBCUqd (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 3 Feb 2022 15:46:33 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8193AC061751
        for <linux-hardening@vger.kernel.org>; Thu,  3 Feb 2022 12:46:02 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id l27so3738753lfe.1
        for <linux-hardening@vger.kernel.org>; Thu, 03 Feb 2022 12:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fm6/WM1aXFuwaAFInnacEGjjm7HROSKZyaeunWFy85Q=;
        b=EB+7VDo0oio3AfLjXuLSp6iozLxATOVsRvDCRYSKDC4dRHRa8GuGMgzNBg4tg2Xtaq
         uu3+nm502DKtfpnMjfCLhX47RbFHaPcqZ1Ap/cehsIkyFRU0CD109PV/k2UlXJs84mZk
         7Aft+fARjfKRk60pMw3eyxJoTpD+7y+rf4d478kXyMFZVg54TRtrY8xmylU8MmXJ9gmE
         qIsC8G8P8vgijQ6+XICJ4axatcywgPRfBO4gE8gGWY4b6j/mNfakbxaUe/IEeCuTE3K2
         fDz2vxKnxjagXfbK+K866SRGzKhDCVY9JxQOclVZz1dgNk13Zh0i2G4OkyCCxinuGBQ5
         nVTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fm6/WM1aXFuwaAFInnacEGjjm7HROSKZyaeunWFy85Q=;
        b=QLbWJmH+INtSK5Iq4La+s5m+Uz5zuSlvf1hW0Q7GulAREg4+Oqjk9uyQmVRpZbhQb7
         hRYHu/YzGWqRcaTYYpBSNi1kbF/O5wygs2vDyN8iWj7GPtuKUuQwgco6EIlTj2uAnZ3T
         H0hRtkXoCEEzTrFDm3O1PUiVdyEWn7VpHT/nUC92+vR1LdiW3mitZ+GAIh8jevh9t/NU
         5o/ytO04JYPr2NeC4y7I1ZkTh9t9AoKZySfPeOX6nNlGLoMbZTX1ndpSXOlhG1ggJWAe
         px6O6ymfObD/RBFxODj4h2WqdmJi8iDAL4Ok09JPqYoOxkYTwGHJkdWp2RuYEscZt1Du
         vaxA==
X-Gm-Message-State: AOAM5306wGfiT+Kpx/4ppuMRUxCDTfPRWBQ29weVYeIYlH1zYJseijF3
        4qMvkGPrGcSMBBgWL+1aesGX+sCSY0Ewf0MjLQSXDw==
X-Google-Smtp-Source: ABdhPJzordyV/vbntEzNKU3NgMfL1TqdSMWainolMPsf5aYHMJtZbYurIZW+6FnXNlOUlgdQ/qO9YpSPM8DquTXJTP4=
X-Received: by 2002:a19:6449:: with SMTP id b9mr28158247lfj.82.1643921160689;
 Thu, 03 Feb 2022 12:46:00 -0800 (PST)
MIME-Version: 1.0
References: <20220203204025.1153397-1-keescook@chromium.org>
In-Reply-To: <20220203204025.1153397-1-keescook@chromium.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 3 Feb 2022 12:45:49 -0800
Message-ID: <CAKwvOd=7ZDMhnX6Da5_ZMM9yLgrnhjwwPhYwO-RT-3yrPy+RLw@mail.gmail.com>
Subject: Re: [PATCH v2] x86/build: don't build CONFIG_X86_32 as -ffreestanding
To:     Kees Cook <keescook@chromium.org>
Cc:     x86@kernel.org, Arvind Sankar <nivedita@alum.mit.edu>,
        Fangrui Song <maskray@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Feb 3, 2022 at 12:40 PM Kees Cook <keescook@chromium.org> wrote:
>
> From: Nick Desaulniers <ndesaulniers@google.com>
>
> -ffreestanding typically inhibits "libcall optimizations" where calls to
> certain library functions can be replaced by the compiler in certain
> cases to calls to other library functions that may be more efficient.
> This can be problematic for embedded targets that don't provide full
> libc implementations.

While the bcmp shenanigans were ultimately resolved by
commit 5f074f3e192f ("lib/string.c: implement a basic bcmp")
(and this popped up again in
commit 1e1b6d63d634 ("lib/string.c: implement stpcpy")
).  I'm still very much in favor of this patch, and should have
pursued it. Thanks for resending!

-- 
Thanks,
~Nick Desaulniers
