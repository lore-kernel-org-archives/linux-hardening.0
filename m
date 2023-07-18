Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE35BEB64DC
	for <linux-hardening@archiver.kernel.org>; Tue, 18 Jul 2023 00:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbjGRArd (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 17 Jul 2023 20:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbjGRArc (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 17 Jul 2023 20:47:32 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACE510E4
        for <linux-hardening@vger.kernel.org>; Mon, 17 Jul 2023 17:47:28 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3a04e5baffcso3743325b6e.3
        for <linux-hardening@vger.kernel.org>; Mon, 17 Jul 2023 17:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689641247; x=1692233247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7/VGkzHeIng6LZLdOiE8OpcvdoSFO1a2yPPXY5DYMhI=;
        b=ECb0Wdft3jRCG9h52I3ITA9rl8b2YQZCzZYMMw31VNkSX+I+t5WHZwOOQfPmn8zeBa
         N+PYlgS5IUX7+Ypav9vAtroMcd1Tnn7ArinCligpgu7iSl/WPZT09n6AMum5BceEjJdA
         3z7n5FFsFHBYvtPCDNEVrcA0GSfExQJDHnTsY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689641247; x=1692233247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7/VGkzHeIng6LZLdOiE8OpcvdoSFO1a2yPPXY5DYMhI=;
        b=Qw7JhqhSY/7DOOzUTNy2d4WkVERMi17bxYBG+vGNxG6cAjtQQBKK06hSI2jS+qR48y
         Bo1ypx7Id7P5nnLkHDDHH9x3BqtNwuOWo8U7cyaIsaCZPEd8k8zm912hnUQSQ6MptX7v
         FnmLURxv9K3x8NvqOM/CvaXbKluMfS9L5B3hFdSbiUOiO5enmGXk2ANa0qAvMAVy9J0k
         H42B4w6eLq5LKIPLRccW9o1jDQ+V9MM503agGILO22ItmzgdtesO76Y58JQXrpNNU2UP
         kOB3AUHUFzsvLMaPrQ9bHiabVIyBgjgbAl1rcsrjpQ/WQblFZzRZfP9PqZO92C0Ejk7F
         T7iQ==
X-Gm-Message-State: ABy/qLYtomokUSkXqnfcbNu+KMsfBS7rxRXjqpv6aBv9Jlcjm5qF5KAM
        uReVZU5JLiW1oGvGj+mfSPYGYSFGVYWFwA1JzELpOQ==
X-Google-Smtp-Source: APBJJlEkHGBdA1cguyGDTJ5pV21jq1ebwIyWijB1g6YkxugTSCb61Iq1bkrcdJbb3GlCtLaqKHcYq2ZixMKY5yCNcw0=
X-Received: by 2002:a05:6808:1926:b0:3a4:3b56:68f0 with SMTP id
 bf38-20020a056808192600b003a43b5668f0mr1352445oib.41.1689641247628; Mon, 17
 Jul 2023 17:47:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230713143406.14342-1-cyphar@cyphar.com>
In-Reply-To: <20230713143406.14342-1-cyphar@cyphar.com>
From:   Jeff Xu <jeffxu@chromium.org>
Date:   Mon, 17 Jul 2023 17:47:15 -0700
Message-ID: <CABi2SkVCp_MDh9MgD-UJ_hgJ58ynm22XJ53zE+ZCBSsWFBxiOw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] memfd: cleanups for vm.memfd_noexec
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Jeff Xu <jeffxu@google.com>,
        Kees Cook <keescook@chromium.org>,
        Daniel Verkamp <dverkamp@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        YueHaibing <yuehaibing@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hello Aleksa,

Thanks for your email and patches for discussion.

On Thu, Jul 13, 2023 at 7:34=E2=80=AFAM Aleksa Sarai <cyphar@cyphar.com> wr=
ote:
>
> It seems that the most critical issue with vm.memfd_noexec=3D2 (the fact
> that passing MFD_EXEC would bypass it entirely[1]) has been fixed in
> Andrew's tree[2], but there are still some outstanding issues that need
> to be addressed:
>
>  * The dmesg warnings are pr_warn_once, which on most systems means that
>    they will be used up by systemd or some other boot process and
>    userspace developers will never see it. The original patch posted to
>    the ML used pr_warn_ratelimited but the merged patch had it changed
>    (with a comment about it being "per review"), but given that the
>    current warnings are useless, pr_warn_ratelimited makes far more
>    sense.
>
Ya, This was discussed in [1]
Replacing pr_warn_once with pr_warn_ratelimited won't address Peter
Xu's observation that "ratelimited" will fill syslog [2],  I'm not
sure it is acceptable to ones who is not interested in memfd, I will
defer this to maintainers.

[1] https://lore.kernel.org/lkml/202212161233.85C9783FB@keescook/
[2] https://lwn.net/ml/linux-kernel/Y5yS8wCnuYGLHMj4@x1n/

>  * vm.memfd_noexec=3D2 shouldn't reject old-style memfd_create(2) syscall=
s
>    because it will make it far to difficult to ever migrate. Instead it
>    should imply MFD_EXEC.
>
Though the purpose of memfd_noexec=3D2 is not to help with migration  -
but to disable creation of executable memfd for the current system/pid
namespace.
During the migration,  vm.memfd_noexe =3D 1 helps overwriting for
unmigrated user code as a temporary measure.
Additional functionality/features should be implemented through
security hook and LSM, not sysctl, I think.

>  * The ratcheting mechanism for vm.memfd_noexec doesn't make sense as a
>    security mechanism because a CAP_SYS_ADMIN capable user can create
>    executable binaries in a hidden tmpfs very easily, not to mention the
>    many other things they can do.
>
By further limiting CAP_SYS_ADMIN, an attacker can't modify this
sysctl even after compromising some system service with high
privilege, YAMA has the same approach for ptrace_scope=3D3

In addition, this sysctl is pid_name spaced, this means child
pid_namespace will alway have the same or stricter security setting
than its parent, this allows admin to maintain a tree like view. If we
allow the child pid namespace to elevate its setting, then the
system-wide setting is no longer meaningful.

The code sample shared in this patch set indicates that the attacker
already has the ability of creating tmpfs and executing complex steps,
at that point, it doesn't matter if the code execution is from memfd
or not. For a safe by default system such as ChromeOS, attackers won't
easily run arbitrary code, memfd is one of the open doors for that, so
we are disabling executable memfd in ChromeOS. In other words:  if an
attacker can already execute the arbitrary code as sample given in
ChromeOS, without using executable memfd,  then memfd is no longer the
thing we need to worry about, the arbitrary code execution is already
achieved by the attacker. Even though I use ChromeOS as an example, I
think the same type of threat model applies to any system that wants
to disable executable memfd entirely.

>  * The memfd selftests would not exit with a non-zero error code when
>    certain tests that ran in a forked process (specifically the ones
>    related to MFD_EXEC and MFD_NOEXEC_SEAL) failed.
>
I will test this code and follow up.


Thanks!




-Jeff Xu

> (This patchset is based on top of Jeff Xu's patches[2] fixing the
> MFD_EXEC bug in vm.memfd_noexec=3D2.)
>
> [1]: https://lore.kernel.org/all/ZJwcsU0vI-nzgOB_@codewreck.org/
> [2]: https://lore.kernel.org/all/20230705063315.3680666-1-jeffxu@google.c=
om/
>
> Aleksa Sarai (3):
>   memfd: cleanups for vm.memfd_noexec handling
>   memfd: remove racheting feature from vm.memfd_noexec
>   selftests: memfd: error out test process when child test fails
>
>  include/linux/pid_namespace.h              | 16 +++------
>  kernel/pid_sysctl.h                        |  7 ----
>  mm/memfd.c                                 | 32 +++++++----------
>  tools/testing/selftests/memfd/memfd_test.c | 41 ++++++++++++++++++----
>  4 files changed, 51 insertions(+), 45 deletions(-)
>
> --
> 2.41.0
>
>
