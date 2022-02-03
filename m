Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADFABC433F5
	for <linux-hardening@archiver.kernel.org>; Thu,  3 Feb 2022 19:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240903AbiBCTdm (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 3 Feb 2022 14:33:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbiBCTdl (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 3 Feb 2022 14:33:41 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF69DC061714
        for <linux-hardening@vger.kernel.org>; Thu,  3 Feb 2022 11:33:40 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id l5so8180190edv.3
        for <linux-hardening@vger.kernel.org>; Thu, 03 Feb 2022 11:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UKKVvcG+cC8bIALBnZZmaV3K37giZ1xa1O6hFf3r9uc=;
        b=Jkx2j0PYyKcGzbdzVprIgIK3c9UJTJU023+j8kMn6bFfwe79YvJheTw9qL5ryIRa80
         Lh9b7BpjrwhgQhd2J7+B1U+ZMFnZoZUWM9Ajp0Ad4vzpkBa6lrGGNVz1nkoLZyKgapv5
         0hx1nJz7ou0M7Q+16jCAsq70x2y43qYOvrTMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UKKVvcG+cC8bIALBnZZmaV3K37giZ1xa1O6hFf3r9uc=;
        b=z1heKwGXkxEc+hj3CJmOpEb9jStKSmfQXpMWhs5YcfDa7UWPFagojApgBknIg9MoSL
         r3PNyTpdixspwKRF+9vZR+OFJ5Lr/+bFa8OlKMAbictStjRZ1AfY9aVCvMHsmEpaHXjC
         8SanCyQKVeIBYLbQAe8aPplTkJl46XEz9JaF3gUW3DtbegVMQI1RtL0Bwx4PApSNRRuB
         7ZOpeiWAdZCMLOAg8CPuMgZinP8IcKI7VshrXUnG/o68farzWap6MLpG9Pvbs/p3PhXo
         x5Uxcn83xxyUWODrYj1mXqcXzCARaIop9Rm5XOkxtcqhRyutsy78pUFt9bzh9p7/fDje
         pS8Q==
X-Gm-Message-State: AOAM532rcbRJVH+K44GPFdUdRNrz1brtl+2G1T2kweOeVGK5cWmq6BHs
        nH5BEsPM46SHmAlNlP8TpYmOEaF2ZRaT78yy
X-Google-Smtp-Source: ABdhPJzKWbY1CfsK3H6l7xbVrYULK6HOEcNcLh/4fkO/TlhGKubLgO4CAeIgpGalfDa6v+XzrWUkLA==
X-Received: by 2002:aa7:dcd5:: with SMTP id w21mr37746511edu.97.1643916819365;
        Thu, 03 Feb 2022 11:33:39 -0800 (PST)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id j19sm6152152ejm.111.2022.02.03.11.33.35
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Feb 2022 11:33:36 -0800 (PST)
Received: by mail-wr1-f47.google.com with SMTP id s18so7023028wrv.7
        for <linux-hardening@vger.kernel.org>; Thu, 03 Feb 2022 11:33:35 -0800 (PST)
X-Received: by 2002:adf:d087:: with SMTP id y7mr29738280wrh.274.1643916815565;
 Thu, 03 Feb 2022 11:33:35 -0800 (PST)
MIME-Version: 1.0
References: <20220202001918.4104428-1-keescook@chromium.org>
In-Reply-To: <20220202001918.4104428-1-keescook@chromium.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 3 Feb 2022 11:33:19 -0800
X-Gmail-Original-Message-ID: <CAHk-=whkwveB2HDOibk+chAWhpm8LyGBVVjZmV4CAeEdnezZ0w@mail.gmail.com>
Message-ID: <CAHk-=whkwveB2HDOibk+chAWhpm8LyGBVVjZmV4CAeEdnezZ0w@mail.gmail.com>
Subject: Re: [PATCH] gcc-plugins/stackleak: Use noinstr in favor of notrace
To:     Kees Cook <keescook@chromium.org>
Cc:     Alexander Popov <alex.popov@linux.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

I was going to apply your patch, but then I read your note:

On Tue, Feb 1, 2022 at 4:19 PM Kees Cook <keescook@chromium.org> wrote:
>
> Is it correct to exclude .noinstr.text here? That means any functions called in
> there will have their stack utilization untracked. This doesn't seem right to me,
> though. Shouldn't stackleak_track_stack() just be marked noinstr instead?

... and yes, it seems like stackleak_track_stack() should just be
'noinstr' just like you made stackleak_erase().

So I've dropped the patch to see what happens.

If you decide this is the right patch after all, you can just re-send it.

                 Linus
