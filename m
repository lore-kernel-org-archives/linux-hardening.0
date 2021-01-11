Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04572C433DB
	for <linux-hardening@archiver.kernel.org>; Mon, 11 Jan 2021 11:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2C68221F5
	for <linux-hardening@archiver.kernel.org>; Mon, 11 Jan 2021 11:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729228AbhAKLDO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 11 Jan 2021 06:03:14 -0500
Received: from mail-ot1-f43.google.com ([209.85.210.43]:42391 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728725AbhAKLDO (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 11 Jan 2021 06:03:14 -0500
Received: by mail-ot1-f43.google.com with SMTP id 11so16471641oty.9;
        Mon, 11 Jan 2021 03:02:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MHCmvXvpGHFVb33mpUBJ2Js02o/EFIeyUQRQPV9z6gY=;
        b=semtb+3PUmv/aRBvc189fiRhk/pGuHpE2MQ+0ka127vjxe/IbNnwdf8B8CguSRb2sS
         ge/2MAvKpXLWtN+8uId4tZzA+MpH+QPwDB9D+NEG7DHqTXLV9s+iUHMVgzdFp9Kt5oWY
         I0jF+Lk1VshivMHRFi1rD8M++yDuO88bQwcQ8fwfRUuilVp7I5nIEqoFcny8SrfYOIgf
         G/i5E4gb4QR13o2VjP1chvAU9ZDHevvujW9Qdyd013pZcmLboGZ1U3GVFP9LT/wLuzZY
         DPTQvrFyuRGhEX7RrL4H43XiFsML7ZZisdf6WyQEV59fO6lL1iItkHH71Gs/l4kOONc5
         wQcQ==
X-Gm-Message-State: AOAM5308ghNTpKfKCldurV6lTVKLEnjX2Yae1rvq1W7odEZDq/7Ucp+Z
        1FUFgPlbaxrDn2AvZDos4hQATrOXF032BjPFZBY=
X-Google-Smtp-Source: ABdhPJykrrMStMJLiiXGwsvMMzaA/CL/vYTUsewatwlV9ffmERCTEPv9/AX+Ak8IvfWQEmIUOn8F8btCmKSctcTMP1Q=
X-Received: by 2002:a9d:c01:: with SMTP id 1mr10417143otr.107.1610362953195;
 Mon, 11 Jan 2021 03:02:33 -0800 (PST)
MIME-Version: 1.0
References: <82487.1609006918@turing-police> <160997457204.3687425.15622431721220616573.b4-ty@chromium.org>
 <CAMuHMdU1YSODgh_T5RxqUqorveAQiy_-gQbF_SwMEj7gvG25qw@mail.gmail.com> <122278.1610362619@turing-police>
In-Reply-To: <122278.1610362619@turing-police>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 11 Jan 2021 12:02:22 +0100
Message-ID: <CAMuHMdXR09QdSiziQQ_XuPcJPOca_+mK1jYYHj3VsP_eCu_KbA@mail.gmail.com>
Subject: Re: [PATCH] gcc-plugins: fix gcc 11 indigestion with plugins...
To:     =?UTF-8?Q?Valdis_Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi Valdis,

On Mon, Jan 11, 2021 at 11:57 AM Valdis Klētnieks
<valdis.kletnieks@vt.edu> wrote:
> On Mon, 11 Jan 2021 10:47:23 +0100, Geert Uytterhoeven said:
> > I guess this is the cause of the new "warning: invalid suffix on
> > literal; C++11 requires a space between literal and string macro
> > [-Wliteral-suffix]" with gcc 4.9 or 5.4?
>
> Well, we fixed a #error, and picked up a warning.  That's progress. ;)
>
> It's probably related. I'm just having a hard time understanding why 4.9 and 5.4
> whine about the lack of a space, while 8.3 and 11 didn't complain...
>
> I'll see if I can cook up a patch that newer gcc are still happy with.  You able
> to easily test with 4.9 or 5.4?

No, I don't have 4.9 or 5.4 cross-compilers anymore.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
