Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F13C4320A
	for <linux-hardening@archiver.kernel.org>; Thu, 19 Aug 2021 20:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C51B6610A5
	for <linux-hardening@archiver.kernel.org>; Thu, 19 Aug 2021 20:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235399AbhHSUiS (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 19 Aug 2021 16:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235364AbhHSUiS (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 19 Aug 2021 16:38:18 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316F0C061575
        for <linux-hardening@vger.kernel.org>; Thu, 19 Aug 2021 13:37:41 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id h9so13549571ljq.8
        for <linux-hardening@vger.kernel.org>; Thu, 19 Aug 2021 13:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HgXymfqgLxB55cygt9ZhuDY1NRwbRIl68JfwaLHFxU8=;
        b=MceR7MtQuMc4MmHD20XUcnrhWaX0y7Pv84DU/6PNFNUkZl6vYjYv+XP2za7cYFWX+Y
         4XR3BlXpVnb4zj1YPJq4lKKIOOQqXZ9vr//f/7JgmeaUJ3yBBLGCORXwGnhFBJvZP1s3
         oAXhWUma+gSbrJUF5XAndd1SKKPWftW/RUHuM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HgXymfqgLxB55cygt9ZhuDY1NRwbRIl68JfwaLHFxU8=;
        b=OLXQtyw/c3JYT543RfN1CwBSVc4prixnD/TOo3Ax2spKoDLcMc2DvseWk8OTidvhbH
         zXGNP4rJi4KkcNlH23JyGjYO7btsqGCTLUxwHiT1m9E8lqCRDQl5Kuss6rZaWVAXFYFI
         xxX8++HRBEpD8BR1JommuxHyj7b+3/Z5S4ZH3I189VxwV+Lq4IwUqh9ave6OUta0yQA3
         zxC+3BWTruhEyhVVMBATxWFEWDHzbiv7f2Xy1mSXgpmnZkga6oBAwbSokqAPDq52kd7X
         VCGzBSUlXI+Xt26B9Gff++j8VMi+ZgaHsXRJk51jGPcGCE9CpTDhYPjkxP+6GMhk46uW
         U4aA==
X-Gm-Message-State: AOAM532QSDJpehbtNiQ1mx6HDYS5wywPNxfoU3xhYelW82aNsv3BlKw7
        iDsA/E53GrHUAkMRr69ul2Ba7WGlRM385mwjPwY=
X-Google-Smtp-Source: ABdhPJy7NyPN6jjO0EgLKi38a4iAy/6thZ96ATfqe8SAtD7NPLsIcveMg3HGEFJJIoXcEbAs+lnLCw==
X-Received: by 2002:a2e:97cf:: with SMTP id m15mr3547696ljj.125.1629405457351;
        Thu, 19 Aug 2021 13:37:37 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id t12sm410170lfg.151.2021.08.19.13.37.36
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Aug 2021 13:37:37 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id u22so15526157lfq.13
        for <linux-hardening@vger.kernel.org>; Thu, 19 Aug 2021 13:37:36 -0700 (PDT)
X-Received: by 2002:a19:4f1a:: with SMTP id d26mr11522879lfb.377.1629405456647;
 Thu, 19 Aug 2021 13:37:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210819040517.GA329693@embeddedor> <CAHk-=whXUJbqhjkRSjOQ2Tm5OmyKv3_JUTh8pxxvykGaC+fM0Q@mail.gmail.com>
 <9ef3265b-a5e7-d21b-68a8-ad137ac6ebfd@kernel.org>
In-Reply-To: <9ef3265b-a5e7-d21b-68a8-ad137ac6ebfd@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 19 Aug 2021 13:37:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=whPU-SA2L=wiDGHGQBL_K-qtpu5EzQLwmV0qk7LSZKQrA@mail.gmail.com>
Message-ID: <CAHk-=whPU-SA2L=wiDGHGQBL_K-qtpu5EzQLwmV0qk7LSZKQrA@mail.gmail.com>
Subject: Re: [GIT PULL] Enable -Wimplicit-fallthrough for Clang for 5.14-rc7
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Aug 19, 2021 at 1:17 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> For what it's worth, clang's version of -Wimplicit-fallthrough would
> have caught the bug in commit 652b44453ea9 [..]

The thing is, any warning can catch a bug. The "signed pointer"
warnings could catch things too if people really care about "unsigned
char *" vs just plain "char *".

But warnings that have too many false positives are more likely to
hide bugs than expose them. So it's very much a balancing act.

I personally think that false positives are deadly: I'd much rather
have a c completely clean build where are the warnings are big red
flags, than a build that has warnings that _may_ be signs of bugs, but
where you have known false positives that have no sane workaround.

Because with even a _single_ false positive, people will immediately
just stop caring about any other warnings at all. We've seen that over
and over again.

This is why a compiler warning - to be useful - has to be completely
unambiguously about bad code, or at least have a alternate "good code
pattern" that is no worse than the code that the warning about.

> However, if you are truly opposed to a version check, can we at least
> just check for the presence of -Wunreachable-code-fallthrough as I
> suggested before?

I'm ok with that, since at that point there are no false warnings.

But even then, it's much too late for 5.14 by now, considering that
this has had issues, and that we already enable the warnings on the
common gcc builds.

                Linus
