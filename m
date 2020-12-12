Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A4BC4361B
	for <linux-hardening@archiver.kernel.org>; Sat, 12 Dec 2020 22:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F345422D71
	for <linux-hardening@archiver.kernel.org>; Sat, 12 Dec 2020 22:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408089AbgLLWfX (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 12 Dec 2020 17:35:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbgLLWfW (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 12 Dec 2020 17:35:22 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52003C0613CF
        for <linux-hardening@vger.kernel.org>; Sat, 12 Dec 2020 14:34:41 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id w13so20728556lfd.5
        for <linux-hardening@vger.kernel.org>; Sat, 12 Dec 2020 14:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zJ0jbHH7AMH1arKYdIQ2AVOS8WN1cCiUkP26yxPWS/s=;
        b=ExQ3Y8sI+pTTOMR515nJSD8Y3UbHhoCRW7Nf4wReh44vzDH4muNePFAzx3AEg9CX4G
         UbgkETMY6AOLmkpGl7FkM3JowiytrE+wCjc4M7gEiDbgZYF0+BRx994bDE6rPwTraMGB
         1o+HVj7HXiWTYmxJn2XbDwJbWciwRsTuQVO+FLx00W94lDZwtq8y/pAV9U+i1MtPIQt3
         YtoaoGdsWEQEzuMN25f5U6inoM5V4E5Zzt3X2p9ztVFP53SdNpjg0nHs99O+GQjNotey
         1haK1OLbG+9ymGNxcXOW+cLbhGShMs0g+7EIrht3sosMRVmPIOFgIQC8yqm/1Hi7k+JY
         P2rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zJ0jbHH7AMH1arKYdIQ2AVOS8WN1cCiUkP26yxPWS/s=;
        b=m4v7E6m9bBE32tCh2xPS615u3YRkJRK39G6WzK1LmBkt6VNppOty7RiaZ++Ug8sVh3
         Gzam9aiRJB81eiF/3FrCpaqBkhwNN0rfP1EPL/lM86uqI3RsVNTP3ZBlLXumIBZU8ai9
         dvN5XaLOJWQDSqp2m1Z8kgAgRNLpeQN58OJHHnKuIkSDgbMn4kLjKE4IOvyOjPUKtJYr
         sega/OrAni8MtIWeDihEnUkjk3zfwryCxURBuZ0U32+MLlOB7i2QGOVQzUgTS75NbHHz
         Njr6VMG/uqYCXXxMxvjHcpiHaXJSduZj8XC5NYmFn+N/BZ38qDHFVxGLee+goot4voTr
         pbaQ==
X-Gm-Message-State: AOAM532WCMXsI4nh/noU/Vd8WrmGKt0hK1AV/5nDObM3Et9TJRrp69vd
        C8DFPERCs8lX4PPVBT8haSxfuEIX8gbiwEbf1dCh2w==
X-Google-Smtp-Source: ABdhPJwqVRX+1IYSWTXGlWAvNFFKFwkjzJUcd6a2Z5Nyynr2P3VgDxpBI3I7JbIKgy1HGTek959K4O7iWUxjVCYYDBY=
X-Received: by 2002:a05:6512:3497:: with SMTP id v23mr7760412lfr.74.1607812479380;
 Sat, 12 Dec 2020 14:34:39 -0800 (PST)
MIME-Version: 1.0
References: <X9UjVOuTgwuQwfFk@mailbox.org>
In-Reply-To: <X9UjVOuTgwuQwfFk@mailbox.org>
From:   Jann Horn <jannh@google.com>
Date:   Sat, 12 Dec 2020 23:34:12 +0100
Message-ID: <CAG48ez3hO9sEGzxQumSvwkS7PgoEprPJnr6MPzLTwosa+uKzsA@mail.gmail.com>
Subject: Re: Kernel complexity
To:     stefan.bavendiek@mailbox.org
Cc:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sat, Dec 12, 2020 at 9:14 PM <stefan.bavendiek@mailbox.org> wrote:
> Personally I am interested in Linux Kernel Security and especially featur=
es supporting attack surface reduction. In the past I did some work on sand=
boxing features like seccomp support in user space applications. I have bee=
n rather hesitant to get involved here, since I am not a full time develope=
r and certainly not an expert in C programming.

(By the way, one interesting area where upstream development is
currently happening that's related to userspace sandboxing is the
Landlock patchset by Micka=C3=ABl Sala=C3=BCn, which adds an API that allow=
s
unprivileged processes to restrict their filesystem access without
having to mess around with stuff like mount namespaces and broker
processes; the latest version is at
<https://lore.kernel.org/kernel-hardening/20201209192839.1396820-1-mic@digi=
kod.net/>.
That might be relevant to your interests.)

> However I am currently doing a research project that aims to identify ris=
k areas in the kernel by measuring code complexity metrics and assuming thi=
s might help this project, I would like to ask for some feedback in case th=
is work can actually help with this project.
>
> My approach is basically to take a look at the different system calls and=
 measure the complexity of the code involved in their execution. Since code=
 complexity has already been found to have a strong correlation with the pr=
obability of existing vulnerabilities, this might indicate kernel areas tha=
t need a closer look.

Keep in mind that while system calls are one of the main entry points
from userspace into the kernel, and the main way in which userspace
can trigger kernel bugs, syscalls do not necessarily closely
correspond to specific kernel subsystems.

For example, system calls like read() and write() can take a gigantic
number of execution paths because, especially when you take files in
/proc and /sys into consideration, they interact with things all over
the place across the kernel. For example, write() can modify page
tables of other processes, can trigger page allocation and reclaim,
can modify networking configuration, can interact with filesystems and
block devices and networking and user namespace configuration and
pipes, and so on. But the areas that are reachable through this
syscall depend on other ways in which the process is limited - in
particular, what kinds of files it can open.

Also keep in mind that even a simple syscall like getresuid() can,
through the page fault handling code, end up in subsystems related to
filesystems, block devices, networking, graphics and so on - so you'd
probably have to exclude any control flows that go through certain
pieces of core kernel infrastructure.

> Additionally the functionality of the syscall will also be considered for=
 a final risk score, although most of the work for this part has already be=
en done in [1].

That's a paper from 2002 that talks about "UNIX system calls", and
categorizes syscalls like init_module as being of the highest "threat
level" even though that syscall does absolutely nothing unless you're
already root. It also has "denial of service attacks" as the
second-highest "threat level classification", which I don't think
makes any sense - I don't think that current OS kernels are designed
to prevent an attacker with the ability to execute arbitrary syscalls
from userspace from slowing the system down. Fundamentally it looks to
me as if it classifies syscalls by the risk caused if you let an
attacker run arbitrary code in userspace **with root privileges**,
which seems to me like an extremely silly threat model.

> The objective is to create a risk score matrix for linux syscalls that co=
nsists of the functionality risk according to [1], times the measured compl=
exity.

I don't understand why you would multiply functionality risk and
complexity. They're probably more additive than multiplicative, since
in a per-subsystem view, risk caused by functionality and complexity
of the implementation are often completely separate. For example, the
userfaultfd subsystem introduces functionality risk by allowing
attackers to arbitrarily pause the kernel at any copy_from_user()
call, but that doesn't combine with the complexity of the userfaultfd
subsystem, but with the complexity of all copy_from_user() callers
everywhere across the kernel.

> This will (hopefully) be helpful to identify risk areas in the kernel and=
 provide user space developers with an measurement that can help design sec=
ure software and sandboxing features.

I'm not sure whether this would really be all that helpful for
userspace sandboxing decisions - as far as I know, userspace normally
isn't in a position where it can really choose which syscalls it wants
to use, but instead the choice of syscalls to use is driven by the
requirements that userspace has. If you tell userspace that write()
can hit tons of kernel code, it's not like userspace can just stop
using write(); and if you then also tell userspace that pwrite() can
also hit a lot of kernel code, that may be misinterpreted as meaning
that pwrite() adds lots of risk while actually, write() and pwrite()
reach (almost) the same areas of code. Also, the areas of code that a
syscall like write() can hit depend hugely on file system access
policies.

I also don't think that doing something like this on a per-syscall
basis would be very beneficial for informing something like priorities
for auditing kernel code; only a small chunk of the kernel even has
its own syscalls, while most of it receives commands through
more-or-less generic syscalls that are then plumbed through.

> One major aspect I am still not sure about is the challenges regarding th=
e dynamic measure of code path execution. While it is possible to measure t=
he cyclomatic complexity of the kernel code with existing tools, I am not s=
ure how much value the results would have, given that this does not include=
 the dynamic code path behind each syscall. I was thinking of using ftrace =
to follow and measure the execution path. Any feedback and advise on this f=
or this would be appreciated.
