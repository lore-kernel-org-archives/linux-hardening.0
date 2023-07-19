Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3724C001DE
	for <linux-hardening@archiver.kernel.org>; Wed, 19 Jul 2023 07:17:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjGSHRq (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 19 Jul 2023 03:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjGSHRp (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 19 Jul 2023 03:17:45 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D22B1E47
        for <linux-hardening@vger.kernel.org>; Wed, 19 Jul 2023 00:17:43 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-401d1d967beso584741cf.0
        for <linux-hardening@vger.kernel.org>; Wed, 19 Jul 2023 00:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689751063; x=1692343063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KJz9sA4DGP6CgYLkAjY0lAz1lGElKDaYsD0QJhJ6STM=;
        b=C3xFynKwxg1DRU1+DuE5DhOV3wV/h9i3th7GM3Hn84DsD3AQDvuahPMaPfjZB92a1q
         6cIdh8+OnPrq4dvRj+K/sq62IkYMUpNuHyqjtxJa/x3zG8o5bg7Qao2szql97Y0NpCQa
         /97J2LFKn0RnI73D9Cr12stBt9oevdC/try31WjZwCXLrgWP4DFzzGX3lnkfpogOn5iG
         bg0ps36g+1B4WpO9/V8EvUDmammOUTf1nISCcj9rU0r7LYuh7l7EublxkySIWZG8u7bx
         nSMqoCSyCX89BpM3rGcrI7i52hLLUrxMNyS0PPdUZtp9nru/EPjOGPcH/2hfjHIAXimE
         lDfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689751063; x=1692343063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KJz9sA4DGP6CgYLkAjY0lAz1lGElKDaYsD0QJhJ6STM=;
        b=lQpg2iNzg9gg5Md8XYw9caYYqzYJ6PivgsiuNiQlOvVPBWXlK/aSoG7IKe+ILyWX+l
         xaxmabgA8/G1pYvGNZYT9hlIMf/8VC1YK8QCiHsI8aMZFIEBBudcN19JYysNKMcSGv98
         TFq+IQGtIT4AEEafRCmNQVHrkMW3o6CdFqJ/CMzfPPuHNp0RnGIU0SlkfvDEtHbMax/s
         9WMBmLRdjrUleYn7PgCHJbP208/H3p+xrYCh8/aT2h3pFD93ckoTlGWWZJ5Jo+6llPPy
         vLNnoBle3Z9NrdIE/CBEiy63jsGpshvx5pOgbe019lK0KC3vYATAShatgTnp6j+0n0u+
         Ocog==
X-Gm-Message-State: ABy/qLZyRlGeyyz2hW2oOPVxD2GDT6FvDSZXueAWJqgML9+wXncxUx+H
        CWmgDW8JUP9ip5xx+oucRV+iHpoP31szTIqrKgCDJg==
X-Google-Smtp-Source: APBJJlG5E2lpIv0SvgSx7L4QeWU+mDNg17bE+ImlToYqKL1M7i7rZzz+Kp7fxMaIuOYd3Pa9EnKRQ2/MS1NsTY3vl3s=
X-Received: by 2002:ac8:7e8d:0:b0:3f5:2006:50f1 with SMTP id
 w13-20020ac87e8d000000b003f5200650f1mr546839qtj.12.1689751062793; Wed, 19 Jul
 2023 00:17:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230713143406.14342-1-cyphar@cyphar.com> <CABi2SkVCp_MDh9MgD-UJ_hgJ58ynm22XJ53zE+ZCBSsWFBxiOw@mail.gmail.com>
 <o2tz56m3y2pbbj2sezyqvtw3caqwcqtqqkkfrq632ofpyj4enp@znkxadzn5lmj>
In-Reply-To: <o2tz56m3y2pbbj2sezyqvtw3caqwcqtqqkkfrq632ofpyj4enp@znkxadzn5lmj>
From:   Jeff Xu <jeffxu@google.com>
Date:   Wed, 19 Jul 2023 00:17:06 -0700
Message-ID: <CALmYWFs_dNCzw_pW1yRAo4bGCPEtykroEQaowNULp7svwMLjOg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] memfd: cleanups for vm.memfd_noexec
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Jeff Xu <jeffxu@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
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

On Tue, Jul 18, 2023 at 8:10=E2=80=AFPM Aleksa Sarai <cyphar@cyphar.com> wr=
ote:
>
> On 2023-07-17, Jeff Xu <jeffxu@chromium.org> wrote:
> > Hello Aleksa,
> >
> > Thanks for your email and patches for discussion.
> >
> > On Thu, Jul 13, 2023 at 7:34=E2=80=AFAM Aleksa Sarai <cyphar@cyphar.com=
> wrote:
> > >
> > > It seems that the most critical issue with vm.memfd_noexec=3D2 (the f=
act
> > > that passing MFD_EXEC would bypass it entirely[1]) has been fixed in
> > > Andrew's tree[2], but there are still some outstanding issues that ne=
ed
> > > to be addressed:
> > >
> > >  * The dmesg warnings are pr_warn_once, which on most systems means t=
hat
> > >    they will be used up by systemd or some other boot process and
> > >    userspace developers will never see it. The original patch posted =
to
> > >    the ML used pr_warn_ratelimited but the merged patch had it change=
d
> > >    (with a comment about it being "per review"), but given that the
> > >    current warnings are useless, pr_warn_ratelimited makes far more
> > >    sense.
> > >
> > Ya, This was discussed in [1]
> > Replacing pr_warn_once with pr_warn_ratelimited won't address Peter
> > Xu's observation that "ratelimited" will fill syslog [2],  I'm not
> > sure it is acceptable to ones who is not interested in memfd, I will
> > defer this to maintainers.
> >
> > [1] https://lore.kernel.org/lkml/202212161233.85C9783FB@keescook/
> > [2] https://lwn.net/ml/linux-kernel/Y5yS8wCnuYGLHMj4@x1n/
>
> I see Kees's point, but in that case the logging should be tied to the
> sysctl being the non-default value (I can post this version next if you
> prefer). The current logging setup doesn't make sense.
>
Is there a best practice in kernel for this problem: too much log  vs
too little log
In other products, usually the log level or compiler flag (ifdef) are
for such a situation.

> > >  * vm.memfd_noexec=3D2 shouldn't reject old-style memfd_create(2) sys=
calls
> > >    because it will make it far to difficult to ever migrate. Instead =
it
> > >    should imply MFD_EXEC.
> > >
> > Though the purpose of memfd_noexec=3D2 is not to help with migration  -
> > but to disable creation of executable memfd for the current system/pid
> > namespace.
> > During the migration,  vm.memfd_noexe =3D 1 helps overwriting for
> > unmigrated user code as a temporary measure.
>
> My point is that the current behaviour for =3D2 means that nobody other
> than *maybe* ChromeOS will ever be able to use it because it requires
> auditing every program on the system. In fact, it's possible even
> ChromeOS will run into issues given that one of the arguments made for
> the nosymfollow mount option was that auditing all of ChromeOS to
> replace every open with RESOLVE_NO_SYMLINKS would be too much effort[1]
> (which I agreed with). Maybe this is less of an issue with
> memfd_create(2) (which is much newer than open(2)) but it still seems
> like a lot of busy work when the =3D1 behaviour is entirely sane even in
> the strict threat model that =3D2 is trying to protect against.
>
It can also be a container (that have all memfd_create migrated to new API)

One option I considered previously was "=3D2" would do overwrite+block ,
and "=3D3" just block. But then I worry that applications won't have
motivation to ever change their existing code, the setting will
forever stay at "=3D2", making "=3D3" even more impossible to ever be used
 system side.

> To me, using =3D1 as a migration path (and in fact, calling =3D1 a migrat=
ion
> path further argues that the warning for not setting _EXEC or
> _NOEXEC_SEAL should be tied to =3D1) would mean finding every program tha=
t
> uses executable memfds and changing it to stop doing that. Not that you
> use =3D1 to go and rewrite every userspace program that uses
> memfd_create(2) at all, without using executable memfds (rebooting each
> time to test the behaviour because we use pr_warn_once).
>
I tend to think logging and sysctl are orthogonal, tie them together
making it more complex than necessary. If we need more logging, we
should find what is the best practice in the kernel for that.

> If you want to block syscalls that don't explicitly pass NOEXEC_SEAL,
> there are several tools for doing this (both seccomp and LSM hooks).
>
> [1]: https://lore.kernel.org/linux-fsdevel/20200131212021.GA108613@google=
.com/
>
> > Additional functionality/features should be implemented through
> > security hook and LSM, not sysctl, I think.
>
> This issue with =3D2 cannot be fixed in an LSM. (On the other hand, you
> could implement either =3D2 behaviour with an LSM using =3D1, and the
> current strict =3D2 behaviour could be implemented purely with seccomp.)
>
By migration, I mean  a system that is not fully migrated, such a
system should just use "=3D0" or "=3D1". Additional features can be
implemented in SELinux/Landlock/other LSM by a motivated dev.  e.g. if
a system wants to limit executable memfd to specific programs or fully
disable it.
"=3D2" is for a system/container that is fully migrated, in that case,
SELinux/Landlock/LSM can do the same, but sysctl provides a convenient
 alternative.
Yes, seccomp provides a similar mechanism. Indeed, combining "=3D1" and
seccomp (block MFD_EXEC), it will overwrite + block X mfd, which is
essentially what you want, iiuc.However, I do not wish to have this
implemented in kernel, due to the thinking that I want kernel to get
out of business of "overwriting" eventually.

> > >  * The ratcheting mechanism for vm.memfd_noexec doesn't make sense as=
 a
> > >    security mechanism because a CAP_SYS_ADMIN capable user can create
> > >    executable binaries in a hidden tmpfs very easily, not to mention =
the
> > >    many other things they can do.
> > >
> > By further limiting CAP_SYS_ADMIN, an attacker can't modify this
> > sysctl even after compromising some system service with high
> > privilege, YAMA has the same approach for ptrace_scope=3D3
>
> Personally, I also think this behaviour from YAMA is a little goofy too,
> but given that it only locks the most extreme setting and there is no
> way to get around the most extreme setting, I guess it makes some sense
> (not to mention it's an LSM and so there is an argument that it should
> be possible to lock out privileged users from modifying it).
> There are many other security sysctls, and very few have this behaviour
> because it doesn't make much sense in most cases.
>
> > In addition, this sysctl is pid_name spaced, this means child
> > pid_namespace will alway have the same or stricter security setting
> > than its parent, this allows admin to maintain a tree like view. If we
> > allow the child pid namespace to elevate its setting, then the
> > system-wide setting is no longer meaningful.
>
> "no longer meaningful" is too strong of a statement imho. It is still
> useful for constraining non-root processes and presumably ChromeOS
> disallows random processes to do CLONE_NEWUSER (otherwise the protection
> of this sysctl is pointless) so in practice for ChromeOS there is no
> change in the attack surface.
>
> (FWIW, I think tying this to the user namespace would've made more sense
> since this is about privilege restrictions, but that ship has sailed.)
>
The reason that this sysctl is a PID namespace is that I hope a
container and host can have different sysctl values, e.g. host will
allow runc's use of X mfd, while a container  doesn't want X mfd. .
To clarify what you meant, do you mean this: when a container is in
its own pid_namespace, and has "=3D2", the programs inside the container
can still use CLONE_NEWUSER to break out "=3D2" ?
And what makes the user namespace a better choice than pid namespace
for this sysctl ?

> > The code sample shared in this patch set indicates that the attacker
> > already has the ability of creating tmpfs and executing complex steps,
> > at that point, it doesn't matter if the code execution is from memfd
> > or not. For a safe by default system such as ChromeOS, attackers won't
> > easily run arbitrary code, memfd is one of the open doors for that, so
> > we are disabling executable memfd in ChromeOS. In other words:  if an
> > attacker can already execute the arbitrary code as sample given in
> > ChromeOS, without using executable memfd,  then memfd is no longer the
> > thing we need to worry about, the arbitrary code execution is already
> > achieved by the attacker. Even though I use ChromeOS as an example, I
> > think the same type of threat model applies to any system that wants
> > to disable executable memfd entirely.
>
> I understand the threat model this sysctl is blocking, my point is that
> blocking CAP_SYS_ADMIN from modifying the setting doesn't make sense
> from that threat model. An attacker that manages to trick some process
> into creating a memfd with an executable payload is not going to be able
> to change the sysctl setting (unless there's a confused deputy with
> CAP_SYS_ADMIN, in which case you have much bigger issues).
>
It is the reverse.  An attacker that manages to trick some
CAP_SYSADMIN processes into changing this sysctl value (i.e. lower the
setting to 0 if no ratcheting), will be able to continue to use mfd as
part of the attack chain.
 In chromeOS, an attacker that can change sysctl might not necessarily
gain full arbitrary code execution already. As I mentioned previously,
the main threat model here is to prevent  arbitrary code execution
through mfd.  If an attacker already gains arbitrary code execution,
at that point, we no longer worry about mfd.

> If a CAP_SYS_ADMIN-capable user wants to change the sysctl, blocking it
> doesn't add any security because that process could create a memfd-like
> fd to execute without issues.
>What practical attack does this ratcheting
> mechanism protect against? (This is a question you can answer with the
> YAMA sysctl, but not this one AFAICS.)
>
> But even if you feel that allowing this in child user namespaces is
> unsafe or undesirable, it's absolutely necessary that
> capable(CAP_SYS_ADMIN) should be able to un-brick the running system by
> changing the sysctl. The alternative is that you need to reboot your
> server in order to un-set a sysctl that broke some application you run.
>

> Also, by the same token, this ratcheting mechanism doesn't make sense
> with =3D1 *at all* because it could break programs in a way that would
> require a reboot but it's not a "security setting" (and the YAMA sysctl
> mentioned only locks the sysctl at the highest setting).
>
I think a system should use "=3D0" when it is unsure about its program's
need or not need executable memfd. Technically, it is not that this
sysctl breaks the user, but the admin  made the mistake to set the
wrong sysctl value, and an admin should know what they are doing for a
sysctl. Yes. rebooting increases the steps to undo the mistake, but
that could be an incentive for the admin to fully test its programs
before turning on this sysctl - and avoid unexpected runtime errors.

Thanks!
-Jeff

> > >  * The memfd selftests would not exit with a non-zero error code when
> > >    certain tests that ran in a forked process (specifically the ones
> > >    related to MFD_EXEC and MFD_NOEXEC_SEAL) failed.
> > >
> > I will test this code and follow up.
>
> Thanks!
>
> --
> Aleksa Sarai
> Senior Software Engineer (Containers)
> SUSE Linux GmbH
> <https://www.cyphar.com/>
