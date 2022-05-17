Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D27C433F5
	for <linux-hardening@archiver.kernel.org>; Tue, 17 May 2022 20:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236563AbiEQU0h (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 17 May 2022 16:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbiEQU0g (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 17 May 2022 16:26:36 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755D95253D
        for <linux-hardening@vger.kernel.org>; Tue, 17 May 2022 13:26:35 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-2fed823dd32so2848587b3.12
        for <linux-hardening@vger.kernel.org>; Tue, 17 May 2022 13:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wkLF6OT1t2YOSmlQuHNSc8YMQFZWsweJNSK3A1X9WFc=;
        b=lRLBJQQGJdCf/Vu5j6vHzWkLG9PUWk/gz7qLmFYdfdeMrVMiDYwEGSqEgimFBRs/WR
         O4fzMukpLDP635Z0lxkIi/bGO+6noGtP3ot9Q6tPrpn5Qgc8EBWqdICI1eFCMI80Ma8f
         3pmbS7srfTEV/kcWtkPkbs4OUB9yf9NtfT3b3XSlogZZaNp0x1O7QOpDXUpYtygcePvN
         r44Nl5IDZG3YlfUztaaVn5/rsfAb7pQG3FUP3uVcOUwlKpzvjWE1Js0p/1TuDq4NRwPT
         ySAm9/hX9TNiNyu3JgtBpjTrtlclAwH3eZZ8opRa481V27pvCsGDX/3oZhvbvnsW3dLn
         tX0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wkLF6OT1t2YOSmlQuHNSc8YMQFZWsweJNSK3A1X9WFc=;
        b=cTTv1GeTgYUb91umYgmDeJi9roEEyh9FAgfvN1UM9sdbVSo12b54ZGAKBQJ0ZxjedW
         9UXqDLcGGSuJNKWJJvltgL8/fHVg/B+LzraVC/kfzVtNZznLaOG2aUo/M6TjbmlB6kn5
         1SmKnCc13kRV6DGFodPDcu7rmXd6i9QI42vyxn5LQ9d4u81G4ePtjJ2TizKLpW8GM76n
         6BBm/VS5fe80CKbzZMSqYkkx7QQjX9GcTr6cTsxtnDRBh4fR7/Q3pv9LNoWUXM2f469d
         0OCEL9HDPcHhfg2MuAIQ+WKL2k/mH93Lw9QetsciajIXHX0k6vYwmSOP6lgWANJfZh2u
         hP7A==
X-Gm-Message-State: AOAM531wBaSR7gZslD/o5CT05mK7AW3vYUSM5s/04UdlcHvbC+pN0/gj
        k1GDqd9NJQWePV7FMQjr5lH2iG3WX9bRsWaRhacvmQ==
X-Google-Smtp-Source: ABdhPJyUXGOqF8+tBvLpsGWh5ahMBfxg2ZLY5vD+1aR0edc0om38+5POyM0OXwEuZ9R6X5KTM2qgFqwhL5XOumOXyK0=
X-Received: by 2002:a81:2008:0:b0:2f8:3968:e70a with SMTP id
 g8-20020a812008000000b002f83968e70amr28536127ywg.321.1652819194477; Tue, 17
 May 2022 13:26:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220513202159.1550547-1-samitolvanen@google.com> <YoNjjjb3ygIKnwfj@hirez.programming.kicks-ass.net>
In-Reply-To: <YoNjjjb3ygIKnwfj@hirez.programming.kicks-ass.net>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Tue, 17 May 2022 13:25:58 -0700
Message-ID: <CABCJKufWy0QrZbpe7CyZOxse60rVHp8fF0iv3D7rS67gjy+E7g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/21] KCFI support
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, X86 ML <x86@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, May 17, 2022 at 1:58 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, May 13, 2022 at 01:21:38PM -0700, Sami Tolvanen wrote:
> > KCFI is a proposed forward-edge control-flow integrity scheme for
> > Clang, which is more suitable for kernel use than the existing CFI
> > scheme used by CONFIG_CFI_CLANG. KCFI doesn't require LTO, doesn't
> > alter function references to point to a jump table, and won't break
> > function address equality. The latest LLVM patch is here:
> >
> >   https://reviews.llvm.org/D119296
> >
> > This RFC series replaces the current arm64 CFI implementation with
> > KCFI and adds support for x86_64.
>
> You have some weird behaviour vs weak functions (I so hate those)...
>
> 100: 0000000000000980     9 FUNC    LOCAL  DEFAULT    2 __cfi_free_initmem
> 233: 0000000000000989    35 FUNC    WEAK   DEFAULT    2 free_initmem
>
> With the result that on the final link:
>
>    179: 00000000000009b0     9 FUNC    LOCAL  DEFAULT    1 __cfi_free_initmem
>   8689: 00000000000007f0     9 FUNC    LOCAL  DEFAULT   65 __cfi_free_initmem
> 173283: 00000000000007f9   198 FUNC    GLOBAL DEFAULT   65 free_initmem
>
> This is getting me objtool issues (I'll fix them) but perhaps it's
> something you can do something about as well.

Good catch, I'll fix this.

Sami
