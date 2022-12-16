Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F86C001B2
	for <linux-hardening@archiver.kernel.org>; Fri, 16 Dec 2022 19:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbiLPTDu (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 16 Dec 2022 14:03:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231551AbiLPTDq (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 16 Dec 2022 14:03:46 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2A069A98
        for <linux-hardening@vger.kernel.org>; Fri, 16 Dec 2022 11:03:45 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id f9so2391493pgf.7
        for <linux-hardening@vger.kernel.org>; Fri, 16 Dec 2022 11:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t2+6atgOOmHW3Y6/BjOreIZzNs1w8s58OfIYvMq9s2c=;
        b=KBlw0Zv85xGI/f7zBeWNnuUhEAWd6AP8p/mVZ2PvNRpLPQgPs5oHJLEvhdVVP+B/5Y
         MayQdYEgqMBwio68fP0vm2Qz0up6cD/PL9x1VK/v9WDid5KE3veOXRX3FhrQZJaQFYE/
         fE4afr/+6N/WiVRjMAWr0r4VZlmt4FdcqdaR10I58q0Shh7pPeCT/9Uxh6XucorzU28o
         hgtM9QZnXfLyQLSmR+YN647tiOBOZPrsE+TDEAgCjBnA0WIx0yMkrBEQloA9pmRjdJSm
         pb45b4OboWwjXatSLEsxZQpwjg1rmP0yzkDqI4FCrhCcbOF2gEik9DTz4x2LyRGdF1gq
         3+tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t2+6atgOOmHW3Y6/BjOreIZzNs1w8s58OfIYvMq9s2c=;
        b=KDCDwuRwycrLstK/avPR1+ZbcUPp4bHulD4ncNMPMSQzlUz5pcY69TcNxC2igP0+wV
         a72b3OxQeeoTzNSvCOIkLVIxwyGJs/mzMmV9IsTNJIEXjTOB6yF1v76lPUUUgsM4sRG2
         onUC1Wa1jAkthiJd850kUhUQlsq9YbRxdEO9rBatBUhJlm6vUq4bSjZEzq6HJhtoHnWc
         ZvgvLic2u7dwcdbnHj/Hlwr6EX2xSJaLtPZWUGVFlG/TusupX1ZaZyqOecqpvVSrTdse
         CXIJbZ2JGfQWyqhtKukpuRuN2H1XO9dwPYV9M1OYsLD01OiS/f+2Bq3zmLjvCs9nVWEC
         GHSA==
X-Gm-Message-State: ANoB5pmQyk+z+9UJBI7Tf0dIM3zmgIXMZrfOJOg6guQO4GStrGDl636E
        BIJAUcT/7+U/xyqntrFR5akX7yhCAdNZHlqmV+eIwQ==
X-Google-Smtp-Source: AA0mqf4uSuXyJGdBNnh0dTcrZ0uIDUxHYk0iKl8jaNcFx16JMkfVp7+9/n6i4JcZxOXpKjDBUCLM51XCRF7NvsRCoh0=
X-Received: by 2002:aa7:8487:0:b0:56c:3bb4:28a8 with SMTP id
 u7-20020aa78487000000b0056c3bb428a8mr80681452pfn.83.1671217424499; Fri, 16
 Dec 2022 11:03:44 -0800 (PST)
MIME-Version: 1.0
References: <20221209160453.3246150-4-jeffxu@google.com> <20221216183949.169779-1-sj@kernel.org>
In-Reply-To: <20221216183949.169779-1-sj@kernel.org>
From:   Jeff Xu <jeffxu@google.com>
Date:   Fri, 16 Dec 2022 11:03:06 -0800
Message-ID: <CALmYWFtfdL=1Nrwyj7je+o8dciDL76CCoga5aE3hZPOh-SFUpA@mail.gmail.com>
Subject: Re: [PATCH v7 3/6] mm/memfd: add MFD_NOEXEC_SEAL and MFD_EXEC
To:     SeongJae Park <sj@kernel.org>
Cc:     skhan@linuxfoundation.org, keescook@chromium.org,
        akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, hughd@google.com, jorgelo@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, jannh@google.com,
        linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Dec 16, 2022 at 10:39 AM SeongJae Park <sj@kernel.org> wrote:
>
> Hi Jeff,
>
> > From: Jeff Xu <jeffxu@google.com>
> >
> > The new MFD_NOEXEC_SEAL and MFD_EXEC flags allows application to
> > set executable bit at creation time (memfd_create).
> >
> > When MFD_NOEXEC_SEAL is set, memfd is created without executable bit
> > (mode:0666), and sealed with F_SEAL_EXEC, so it can't be chmod to
> > be executable (mode: 0777) after creation.
> >
> > when MFD_EXEC flag is set, memfd is created with executable bit
> > (mode:0777), this is the same as the old behavior of memfd_create.
> >
> > The new pid namespaced sysctl vm.memfd_noexec has 3 values:
> > 0: memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL acts like
> >         MFD_EXEC was set.
> > 1: memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL acts like
> >         MFD_NOEXEC_SEAL was set.
> > 2: memfd_create() without MFD_NOEXEC_SEAL will be rejected.
> >
> > The sysctl allows finer control of memfd_create for old-software
> > that doesn't set the executable bit, for example, a container with
> > vm.memfd_noexec=1 means the old-software will create non-executable
> > memfd by default. Also, the value of memfd_noexec is passed to child
> > namespace at creation time. For example, if the init namespace has
> > vm.memfd_noexec=2, all its children namespaces will be created with 2.
> >
> > Signed-off-by: Jeff Xu <jeffxu@google.com>
> > Co-developed-by: Daniel Verkamp <dverkamp@chromium.org>
> > Signed-off-by: Daniel Verkamp <dverkamp@chromium.org>
> > Reported-by: kernel test robot <lkp@intel.com>
> > ---
> [...]
> > diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
> > index f4f8cb0435b4..8a98b1af9376 100644
> > --- a/kernel/pid_namespace.c
> > +++ b/kernel/pid_namespace.c
> > @@ -23,6 +23,7 @@
> >  #include <linux/sched/task.h>
> >  #include <linux/sched/signal.h>
> >  #include <linux/idr.h>
> > +#include "pid_sysctl.h"
> >
> >  static DEFINE_MUTEX(pid_caches_mutex);
> >  static struct kmem_cache *pid_ns_cachep;
> > @@ -110,6 +111,8 @@ static struct pid_namespace *create_pid_namespace(struct user_namespace *user_ns
> >       ns->ucounts = ucounts;
> >       ns->pid_allocated = PIDNS_ADDING;
> >
> > +     initialize_memfd_noexec_scope(ns);
> > +
> >       return ns;
> >
> >  out_free_idr:
> > @@ -455,6 +458,8 @@ static __init int pid_namespaces_init(void)
> >  #ifdef CONFIG_CHECKPOINT_RESTORE
> >       register_sysctl_paths(kern_path, pid_ns_ctl_table);
> >  #endif
> > +
> > +     register_pid_ns_sysctl_table_vm();
> >       return 0;
> >  }
> [...]
> >
> > diff --git a/kernel/pid_sysctl.h b/kernel/pid_sysctl.h
> > new file mode 100644
> > index 000000000000..90a93161a122
> > --- /dev/null
> > +++ b/kernel/pid_sysctl.h
> > @@ -0,0 +1,59 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef LINUX_PID_SYSCTL_H
> > +#define LINUX_PID_SYSCTL_H
> > +
> > +#include <linux/pid_namespace.h>
> > +
> > +#if defined(CONFIG_SYSCTL) && defined(CONFIG_MEMFD_CREATE)
> > +static inline void initialize_memfd_noexec_scope(struct pid_namespace *ns)
> [...]
> > +static inline void register_pid_ns_sysctl_table_vm(void)
> > +{
> > +     register_sysctl_paths(vm_path, pid_ns_ctl_table_vm);
> > +}
> > +#else
> > +static inline void set_memfd_noexec_scope(struct pid_namespace *ns) {}
> > +static inline void register_pid_ns_ctl_table_vm(void) {}
> > +#endif
> [...]
>
> I found this patch makes build fails whne CONFIG_SYSCTL or CONFIG_MEMFD_CREATE
> are not defined, as initialize_memfd_noexec_scope() and
> register_pid_ns_sysctl_table_vm() are used from pid_namespace.c without the
> configs protection.
>
> I just posted a patch for that:
> https://lore.kernel.org/linux-mm/20221216183314.169707-1-sj@kernel.org/
>
> Could you please check?
>
Hi SeongJae,
Thanks for the patch ! I responded to the other thread.

Andrew,
From a process point of view, should I update this patch to V9 to
include the fix ?
or add a patch directly on top in the mm-unstable branch.

Thanks
Jeff

>
> Thanks,
> SJ
