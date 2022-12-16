Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41170C3DA6E
	for <linux-hardening@archiver.kernel.org>; Fri, 16 Dec 2022 23:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbiLPXko (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 16 Dec 2022 18:40:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbiLPXkm (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 16 Dec 2022 18:40:42 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7AB63D2
        for <linux-hardening@vger.kernel.org>; Fri, 16 Dec 2022 15:40:39 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id t17so3915764pjo.3
        for <linux-hardening@vger.kernel.org>; Fri, 16 Dec 2022 15:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qP9LUFiQr+YzMaH2ADs5X+hQzeakrlDwPsVjntwjyKc=;
        b=QHKlHgQ1SzOIzUJocmAx5UWtJH/8UTsiopsrrQZvH1zE7NKYBI7QA1k69C3WspE3EB
         cAqpZjDgJFTiNFWtE6zxGdaN+tOzQzzwkdgWMVbn1bEL9HKTH/s4j497z/nwE/CcRcLB
         +Q2wumAjgS0yMxfGDA2LGAm12Y1hqhdwlnmZEC+VanIJeCME5xkm6+FK7stiHSX/9FnK
         AL9shkX2H3c0Kt1HCPn3P32sufLL8+IsdFCeHNp3aqlRk+FsDlnTD9CnVcqy5StZXAO4
         O+scEOSYPiSRG7sxcIfrwfwBKnz7YVYfAEzeB06iw9tNKiFkNqraNV3hUkX0Ed9kiNgr
         fRzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qP9LUFiQr+YzMaH2ADs5X+hQzeakrlDwPsVjntwjyKc=;
        b=oYF6NWuW0v1k7T+CG54+3WbFDyhY8NFSBlOnyUuccnR9Vh9N+rUlaL8mR0pxYbIz+n
         4Q+YMrqFNFgTeqfW87pUqNfbnSu1BOMAXHuAKQr5PkeAgtabKt3rmkgOthakqQK0cUD8
         wqms1WOGrfyrYfZFr80G1wnB1QhXp2DVzlGz+0Uwbz10xjopi0yWi4TliTgTxbYDYpzK
         OYVpZqJQek+nND/C0f4sO0SCHZK0ol2EcxaZ01fA6sT4NG1nIy6C/4kIFomOG7kYZLHD
         f7W9ahGNMs7jCYjMu9JdOT/AtpmPUDl3VQgr6wQE1M0pjmeU79eUjrty203QvRNPTZVW
         0ZPA==
X-Gm-Message-State: AFqh2kpbkbByrc4UJKPrHGG9R9yim54M9MtEm87lkESGJ2aKxmwMyfta
        2bYv6ExjeDYvv1IyZXYtxzzl4g8qVGelRfz5HCAKIA==
X-Google-Smtp-Source: AMrXdXtnXsl2q7hOtIge/2/gsR8kvTNLB45QiArxl/ifC+j9uYnyXPKDu+v21IXOSAosloDINV72J/F8O6tmKW34wwM=
X-Received: by 2002:a17:90a:4612:b0:219:a43b:1006 with SMTP id
 w18-20020a17090a461200b00219a43b1006mr1290642pjg.195.1671234038717; Fri, 16
 Dec 2022 15:40:38 -0800 (PST)
MIME-Version: 1.0
References: <20221207154939.2532830-1-jeffxu@google.com> <20221207154939.2532830-4-jeffxu@google.com>
 <202212080821.5AE7EE99@keescook> <CALmYWFuKR538vHxqYH1p6mb9iShOohf5bpHZXSfUN4KQHYiwaA@mail.gmail.com>
 <Y5yS8wCnuYGLHMj4@x1n> <CALmYWFsDhX76zbcyhYAW-u0BBwD+m+TKpt4_pZTMt+22zHhrGQ@mail.gmail.com>
 <20221216094259.bec91e4abd6cf54a05ce2813@linux-foundation.org>
 <CALmYWFsNp87a5uVQUAb4PG0khFN8Xxd=ibh9Q7g-Y0XW1Mn-8Q@mail.gmail.com>
 <202212161233.85C9783FB@keescook> <CALmYWFuENPRvCAOF6of=Ufct5jjAbJ=iDyH7eODhdbm24uAK3Q@mail.gmail.com>
 <20221216140641.bf6e47b7c4f5a53f34c8cf9a@linux-foundation.org>
In-Reply-To: <20221216140641.bf6e47b7c4f5a53f34c8cf9a@linux-foundation.org>
From:   Jeff Xu <jeffxu@google.com>
Date:   Fri, 16 Dec 2022 15:40:00 -0800
Message-ID: <CALmYWFuqAruM=Brh_54hWL+HiKD+RABK4y+hzd4phOzOZ_0=CA@mail.gmail.com>
Subject: Re: [PATCH v6 3/6] mm/memfd: add MFD_NOEXEC_SEAL and MFD_EXEC
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>, Peter Xu <peterx@redhat.com>,
        jeffxu@chromium.org, skhan@linuxfoundation.org,
        dmitry.torokhov@gmail.com, dverkamp@chromium.org, hughd@google.com,
        jorgelo@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        jannh@google.com, linux-hardening@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Dec 16, 2022 at 2:06 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Fri, 16 Dec 2022 13:46:58 -0800 Jeff Xu <jeffxu@google.com> wrote:
>
> > On Fri, Dec 16, 2022 at 12:35 PM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > On Fri, Dec 16, 2022 at 10:11:44AM -0800, Jeff Xu wrote:
> > > > Once per boot seems too little, it would be nice if we can list all processes.
> > > > I agree ratelimited might be too much.
> > > > There is a feature gap here for logging.
> > > >
> > > > Kees, what do you think ?
> > >
> > > I agree once per boot is kind of frustrating "I fixed the one warning,
> > > oh, now it's coming from a different process". But ratelimit is, in
> > > retrospect, still too often.
> > >
> > > Let's go with per boot -- this should be noisy "enough" to get the
> > > changes in API into the callers without being too much of a hassle.
> > >
> > Agreed.  Let's go with per boot.
> >
> > Hi Andrew, what is your preference ? I can send a patch  or you
> > directly fix it in mm-unstable ?
>
> Like this?
>
Yes. Thanks!

> --- a/mm/memfd.c~mm-memfd-add-mfd_noexec_seal-and-mfd_exec-fix-3
> +++ a/mm/memfd.c
> @@ -308,7 +308,7 @@ SYSCALL_DEFINE2(memfd_create,
>                         flags |= MFD_NOEXEC_SEAL;
>                         break;
>                 default:
> -                       pr_warn_ratelimited(
> +                       pr_warn_once(
>                                 "memfd_create(): MFD_NOEXEC_SEAL is enforced, pid=%d '%s'\n",
>                                 task_pid_nr(current), get_task_comm(comm, current));
>                         return -EINVAL;
> @@ -316,7 +316,7 @@ SYSCALL_DEFINE2(memfd_create,
>  #else
>                 flags |= MFD_EXEC;
>  #endif
> -               pr_warn_ratelimited(
> +               pr_warn_once(
>                         "memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL, pid=%d '%s'\n",
>                         task_pid_nr(current), get_task_comm(comm, current));
>         }
> _
>
