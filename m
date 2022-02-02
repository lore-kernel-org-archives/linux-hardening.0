Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB4EC433EF
	for <linux-hardening@archiver.kernel.org>; Wed,  2 Feb 2022 23:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347977AbiBBXDx (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 2 Feb 2022 18:03:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233672AbiBBXDx (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 2 Feb 2022 18:03:53 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00842C061714
        for <linux-hardening@vger.kernel.org>; Wed,  2 Feb 2022 15:03:53 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id i186so655358pfe.0
        for <linux-hardening@vger.kernel.org>; Wed, 02 Feb 2022 15:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=OpHOwgHBrGPuOBvUuh6gegX0rjacKztLoN+r7w2V6Cc=;
        b=kLHpc5FWI8TvPe70KzrjeV3jZKkDbIr+6f4AkB5IWoNluO24vcTskDAWjSaeT658Hq
         jw4G1tCBsiTHGq/IysgcIMLTv5zXECwdgWr58NVHRHRZk4VkLrXQcKmiGZEEX8gMFXWt
         064XeHh93Xb2y2itGHP30w5sodLveLwX2vSbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=OpHOwgHBrGPuOBvUuh6gegX0rjacKztLoN+r7w2V6Cc=;
        b=HryJfBHursZt01NkXxUjvomqQa4s6iuJOvitzmWKmpEzC9vqQG7r++bxQOmVsaQPW9
         Y0bMRN2LAAteYVQ/tzUkp+aLGBBvkg69T+TU49nNVhZ1MqDC0bMVazHIwzFnl5il8F2Q
         OKOe+XaDHWvz7aJPE7BcvAkJaKh8V0ky+GXjT9EauLU5oTpjgtH83F9OPmp3qV6ut7nx
         xBH7qrEyLIzPR9WJypWsyqt2W2J0qcz4/0V2WltJSbKEwSYXlfWiSfOhn/ulF/IA+PuM
         YDuUHGs4gSlsvPN/wJZl+CEi/iNRhl1Qu1EFuHYUegf4u/abpMscf7YX0HF7vG1yq1sR
         JHMg==
X-Gm-Message-State: AOAM533ASsdO1LiExoVaGThMgmf4+7pZ9SRnv8OlPKUfw0Oia1EaEW+t
        FwIKhTTW8dYGmPnKBcLrPaVNiq6d1GBi1A==
X-Google-Smtp-Source: ABdhPJxMgCz9WZjgKwUDwU6lxD19M2Txy+rDJWNiyrtCnk0F6eNhwz7XrkTkl3cQP78CC2G4y02zDw==
X-Received: by 2002:a63:4903:: with SMTP id w3mr1861183pga.5.1643843032435;
        Wed, 02 Feb 2022 15:03:52 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id bf23sm7080295pjb.52.2022.02.02.15.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 15:03:52 -0800 (PST)
Date:   Wed, 2 Feb 2022 15:03:51 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>
Cc:     linux-xtensa@linux-xtensa.org, linux-hardening@vger.kernel.org
Subject: How large is the xtensa pt_regs::areg array supposed to be?
Message-ID: <202202021501.DA6594BFC@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi,

When building with -Warray-bounds, I see this:

In file included from ./include/linux/uaccess.h:11,
                 from ./include/linux/sched/task.h:11,
                 from arch/xtensa/kernel/process.c:21:
arch/xtensa/kernel/process.c: In function 'copy_thread':
arch/xtensa/kernel/process.c:262:52: warning: array subscript 53 is above array bounds of 'long unsigned int[16]' [-Warray-bounds]
  262 |                                 put_user(regs->areg[caller_ars+1],
./arch/xtensa/include/asm/uaccess.h:171:18: note: in definition of macro '__put_user_asm'
  171 |         :[x] "r"(x_), [efault] "i"(-EFAULT))
      |                  ^~
./arch/xtensa/include/asm/uaccess.h:89:17: note: in expansion of macro '__put_user_size'
   89 |                 __put_user_size((x), __pu_addr, (size), __pu_err);      \
      |                 ^~~~~~~~~~~~~~~
./arch/xtensa/include/asm/uaccess.h:62:33: note: in expansion of macro '__put_user_check'
   62 | #define put_user(x, ptr)        __put_user_check((x), (ptr), sizeof(*(ptr)))
      |                                 ^~~~~~~~~~~~~~~~
arch/xtensa/kernel/process.c:262:33: note: in expansion of macro 'put_user'
  262 |                                 put_user(regs->areg[caller_ars+1],
      |                                 ^~~~~~~~
In file included from ./arch/xtensa/include/asm/processor.h:17,
                 from ./arch/xtensa/include/asm/thread_info.h:20,
                 from ./arch/xtensa/include/asm/current.h:14,
                 from ./include/linux/sched.h:12,
                 from arch/xtensa/kernel/process.c:19:
./arch/xtensa/include/asm/ptrace.h:80:23: note: while referencing 'areg'
   80 |         unsigned long areg[16];
      |                       ^~~~


The code is:
                                int callinc = (regs->areg[0] >> 30) & 3;
                                int caller_ars = XCHAL_NUM_AREGS - callinc * 4;
                                put_user(regs->areg[caller_ars+1],
                                         (unsigned __user*)(usp - 12));

It looks like XCHAL_NUM_AREGS is larger than "16", though?

struct pt_regs {
...
        unsigned long areg[16];

What should be happening here?

Thanks!

-- 
Kees Cook
