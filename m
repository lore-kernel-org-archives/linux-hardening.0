Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D56C433F5
	for <linux-hardening@archiver.kernel.org>; Sun,  6 Mar 2022 01:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbiCFBvf (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 5 Mar 2022 20:51:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiCFBve (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 5 Mar 2022 20:51:34 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F7A6E7AD
        for <linux-hardening@vger.kernel.org>; Sat,  5 Mar 2022 17:50:43 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id y2so10733629edc.2
        for <linux-hardening@vger.kernel.org>; Sat, 05 Mar 2022 17:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=58mbF6ACvtLKwD1wLhdRNftJy6IldFlDxypD7yDqoKU=;
        b=RrAxfWn79kfu1H3hQPPD3H8+jOi2tQHIm3Gu3d3v3Nf1K9pLiTItZoB6ff+PuRX6LZ
         LdA3vCnr2QRoDbVdOXjnnNswpj6c8HwJWHgBEDEBQ2ZRjmjxRQ1fsWH2WuOcsg4HLGpr
         /p2bMs/2PA9UHhUOLvb9+Jow6ZSXA2Lvo8qQQLYPFVcGUgAaulaSh9W02KLrTvzYjxrm
         bzqxA0mrmvrDFIBx75mtcoUp91XeC3fmbNj6o3ihIiGFO1AuDeBICo9TCpj8Y4ZFD+cL
         GC3VPUoKVcehFUbVMheV60F2qiBIxiyI1+E5YZx2xTPBDuBLGx9x8BaD3JnzpU32zvIG
         xKgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=58mbF6ACvtLKwD1wLhdRNftJy6IldFlDxypD7yDqoKU=;
        b=D1pQfwSiazJCVDexcUdrOKbwaheSHPeDRIzjXT4nJRJC11eDpNZUm30cWu1zfc6hoq
         gz5meNySn4rABsCQd6Ck8M4ST+jwpIIcXrXAYTVMJeuDHFMDfch6wC1kYRymDEHy8hXU
         O0yyK8rkHGfvZ2gF01yRTg6FI6vP0VAynUbtaR64FSwTvljs65lEljT7lG/wOnd4JeDZ
         DaKGmC4QM0p4ChYuOtPmk72tY3/l7VS9xYzf/iQLodduhrQiV7Q1ouWFF6NieofNDhi4
         XVnRCwlmfwatO1eQ+N8Rzli6BRZJMWiMhfoPuMp9JMTUDNK7FD1gFc5HPWdy/hQLr62a
         mMDg==
X-Gm-Message-State: AOAM530oYjCjl97kz+uE6d9QJS6hrRv/W3wLdCkwo2slYF/2a9on8yGs
        lPWG1uy8fImUxCmXC1nZe7BL44BvY9qL5SY5k9frDBb1C+E=
X-Google-Smtp-Source: ABdhPJxPtltrW9Mq1MeyeNBa1YqhnROPB8qLOT1ke2EaLQOzrlM7AOcXdh6MqRq62tO9+F2zHNzjZZi7zcKmR0LM/8Q=
X-Received: by 2002:aa7:cb18:0:b0:413:3a7a:b5d6 with SMTP id
 s24-20020aa7cb18000000b004133a7ab5d6mr4898902edt.254.1646531442228; Sat, 05
 Mar 2022 17:50:42 -0800 (PST)
MIME-Version: 1.0
References: <202202021501.DA6594BFC@keescook> <CAMo8BfKO-ysOrYFGpZNsorZ-zyMWY5CObC1Oie0ubuXVF=ZCbg@mail.gmail.com>
In-Reply-To: <CAMo8BfKO-ysOrYFGpZNsorZ-zyMWY5CObC1Oie0ubuXVF=ZCbg@mail.gmail.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Sat, 5 Mar 2022 17:50:30 -0800
Message-ID: <CAMo8BfLrcK5NOVZeWB-Ut1BKbFaVcrkzNT=_JX++HXWTi1KesQ@mail.gmail.com>
Subject: Re: How large is the xtensa pt_regs::areg array supposed to be?
To:     Kees Cook <keescook@chromium.org>
Cc:     Chris Zankel <chris@zankel.net>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sat, Mar 5, 2022 at 12:43 PM Max Filippov <jcmvbkbc@gmail.com> wrote:
> On Wed, Feb 2, 2022 at 3:03 PM Kees Cook <keescook@chromium.org> wrote:
> > When building with -Warray-bounds, I see this:
> >
> > In file included from ./include/linux/uaccess.h:11,
> >                  from ./include/linux/sched/task.h:11,
> >                  from arch/xtensa/kernel/process.c:21:
> > arch/xtensa/kernel/process.c: In function 'copy_thread':
> > arch/xtensa/kernel/process.c:262:52: warning: array subscript 53 is above array bounds of 'long unsigned int[16]' [-Warray-bounds]
>
> I tried to reproduce this by building with -Warray-bounds added to
> KBUILD_CFLAGS but couldn't get neither gcc-11 nor the current
> gcc trunk to issue this warning. How did you get it?

Never mind, it reproduces with the current -next tree.

-- 
Thanks.
-- Max
