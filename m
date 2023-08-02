Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9FE3C41513
	for <linux-hardening@archiver.kernel.org>; Wed,  2 Aug 2023 19:47:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbjHBTrt (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 2 Aug 2023 15:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjHBTrt (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 2 Aug 2023 15:47:49 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BCA19B9
        for <linux-hardening@vger.kernel.org>; Wed,  2 Aug 2023 12:47:47 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3a5ac84718dso112704b6e.0
        for <linux-hardening@vger.kernel.org>; Wed, 02 Aug 2023 12:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691005666; x=1691610466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4L87AmfstDDXsMddOTC2jJEzr5M0oA6AlC9mE9z9c+A=;
        b=akwji8T2229f+qrK+Rq51gNXo32p1QRhUD4dGXALdNTATBFQemfrtWO2FivhCCxRiJ
         VvmlW1X4pnP6EC1uwCyeFxeQdglkeMeSxL84Jl2O7NK1WJkfBoKSQ6hzBP1xwLeKKpKO
         ZT9qYoIARgUV9n2T+s+oDbhiTtwZQ5Ll4v1qw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691005666; x=1691610466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4L87AmfstDDXsMddOTC2jJEzr5M0oA6AlC9mE9z9c+A=;
        b=LhqsP1nbk43oF1KiobL7qaVSxHxGte7rNhDNOaIaJZkxXhgRlNVE2CHAT2fL7g48sq
         cxdoGsI3AdlF2n28szt0QKUl5jHJW9kYckb/PyO8vpuW7dj2YyFo5VBq8pXnRu9sHsR0
         lUo61yo/IXPlT+FO+z2VQNfrgHyUUK+otrH5Vn+6bs4tNShpc2/tts1cxpiXLppI55HW
         J+Z/pTGyhXVgJLufnpU1+olVN2iliz4YAKqWTQ9Jy5Zkpb6GUdHVb5TEDLrmVLcBiErq
         N01Qxx7HHPuLKAsoBm2rtY+zpwvBAL0FuJGw1/B/QdBAwUdb1Ik0jwfXzeCGZ81vnoOV
         xfig==
X-Gm-Message-State: ABy/qLZxVrYy4FKXBZBBZCViM8Y6475TqhWWwHftppKMxURR8cHb/C3K
        OUDXkQcYFkfh/thNEQDO0yIa5iVoga4PQPMXbUYRFg==
X-Google-Smtp-Source: APBJJlFLFCHsT6m42UaqNpFGu7i2Gs0+OqpUX4M23ViM5aPTWlveYQ/fsldBSTqn3SaWUGzDxXdbYdBGf87sYwOr/Ig=
X-Received: by 2002:a05:6808:bc7:b0:3a3:1424:7258 with SMTP id
 o7-20020a0568080bc700b003a314247258mr21404994oik.3.1691005666696; Wed, 02 Aug
 2023 12:47:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230713143406.14342-1-cyphar@cyphar.com> <CABi2SkVCp_MDh9MgD-UJ_hgJ58ynm22XJ53zE+ZCBSsWFBxiOw@mail.gmail.com>
 <o2tz56m3y2pbbj2sezyqvtw3caqwcqtqqkkfrq632ofpyj4enp@znkxadzn5lmj>
 <CALmYWFs_dNCzw_pW1yRAo4bGCPEtykroEQaowNULp7svwMLjOg@mail.gmail.com> <20230801.032503-medium.noises.extinct.omen-CStYZUqcNLCS@cyphar.com>
In-Reply-To: <20230801.032503-medium.noises.extinct.omen-CStYZUqcNLCS@cyphar.com>
From:   Jeff Xu <jeffxu@chromium.org>
Date:   Wed, 2 Aug 2023 12:47:34 -0700
Message-ID: <CABi2SkXWfup2_UeKqm7C-xkjF5gnhKuxOP7TsRVa5MLbxabFQg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] memfd: cleanups for vm.memfd_noexec
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Jeff Xu <jeffxu@google.com>,
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

On Tue, Aug 1, 2023 at 6:05=E2=80=AFPM Aleksa Sarai <cyphar@cyphar.com> wro=
te:
>
This thread is getting longer with different topics, I will try to
respond with trimmed interleaved replies [1]
There are 3 topics (logging/'migration/ratcheting), this response will
be regarding ratcheting.

[1] https://www.kernel.org/doc/html/latest/process/submitting-patches.html?=
highlight=3Dsigned%20off#use-trimmed-interleaved-replies-in-email-discussio=
ns

>
> > > > >  * The ratcheting mechanism for vm.memfd_noexec doesn't make sens=
e as a
> > > > >    security mechanism because a CAP_SYS_ADMIN capable user can cr=
eate
> > > > >    executable binaries in a hidden tmpfs very easily, not to ment=
ion the
> > > > >    many other things they can do.
> > > > >
> > > > By further limiting CAP_SYS_ADMIN, an attacker can't modify this
> > > > sysctl even after compromising some system service with high
> > > > privilege, YAMA has the same approach for ptrace_scope=3D3
> > >
> > > Personally, I also think this behaviour from YAMA is a little goofy t=
oo,
> > > but given that it only locks the most extreme setting and there is no
> > > way to get around the most extreme setting, I guess it makes some sen=
se
> > > (not to mention it's an LSM and so there is an argument that it shoul=
d
> > > be possible to lock out privileged users from modifying it).
> > > There are many other security sysctls, and very few have this behavio=
ur
> > > because it doesn't make much sense in most cases.
> > >
> > > > In addition, this sysctl is pid_name spaced, this means child
> > > > pid_namespace will alway have the same or stricter security setting
> > > > than its parent, this allows admin to maintain a tree like view. If=
 we
> > > > allow the child pid namespace to elevate its setting, then the
> > > > system-wide setting is no longer meaningful.
> > >
> > > "no longer meaningful" is too strong of a statement imho. It is still
> > > useful for constraining non-root processes and presumably ChromeOS
> > > disallows random processes to do CLONE_NEWUSER (otherwise the protect=
ion
> > > of this sysctl is pointless) so in practice for ChromeOS there is no
> > > change in the attack surface.
> > >
> > > (FWIW, I think tying this to the user namespace would've made more se=
nse
> > > since this is about privilege restrictions, but that ship has sailed.=
)
> > >
> > The reason that this sysctl is a PID namespace is that I hope a
> > container and host can have different sysctl values, e.g. host will
> > allow runc's use of X mfd, while a container  doesn't want X mfd. .
> > To clarify what you meant, do you mean this: when a container is in
> > its own pid_namespace, and has "=3D2", the programs inside the containe=
r
> > can still use CLONE_NEWUSER to break out "=3D2" ?
>
> With the current implementation, this is not possible. My point was that
> even if it were possible to lower the sysctl, ChromeOS presumably
> already blocks the operations that a user would be able to use to create
> a memfd (an unprivileged user cannot CLONE_NEWPID to modify the sysctl
> without CLONE_NEWUSER, which is presumably blocked on ChromeOS due to
> the other security concerns).
>
>
> > > > The code sample shared in this patch set indicates that the attacke=
r
> > > > already has the ability of creating tmpfs and executing complex ste=
ps,
> > > > at that point, it doesn't matter if the code execution is from memf=
d
> > > > or not. For a safe by default system such as ChromeOS, attackers wo=
n't
> > > > easily run arbitrary code, memfd is one of the open doors for that,=
 so
> > > > we are disabling executable memfd in ChromeOS. In other words:  if =
an
> > > > attacker can already execute the arbitrary code as sample given in
> > > > ChromeOS, without using executable memfd,  then memfd is no longer =
the
> > > > thing we need to worry about, the arbitrary code execution is alrea=
dy
> > > > achieved by the attacker. Even though I use ChromeOS as an example,=
 I
> > > > think the same type of threat model applies to any system that want=
s
> > > > to disable executable memfd entirely.
> > >
> > > I understand the threat model this sysctl is blocking, my point is th=
at
> > > blocking CAP_SYS_ADMIN from modifying the setting doesn't make sense
> > > from that threat model. An attacker that manages to trick some proces=
s
> > > into creating a memfd with an executable payload is not going to be a=
ble
> > > to change the sysctl setting (unless there's a confused deputy with
> > > CAP_SYS_ADMIN, in which case you have much bigger issues).
> > >
> > It is the reverse.  An attacker that manages to trick some
> > CAP_SYSADMIN processes into changing this sysctl value (i.e. lower the
> > setting to 0 if no ratcheting), will be able to continue to use mfd as
> > part of the attack chain.
> >  In chromeOS, an attacker that can change sysctl might not necessarily
> > gain full arbitrary code execution already. As I mentioned previously,
> > the main threat model here is to prevent  arbitrary code execution
> > through mfd.  If an attacker already gains arbitrary code execution,
> > at that point, we no longer worry about mfd.
>
> If an attacker can trick a privileged process into writing to arbitrary
> sysctls, the system has much bigger issues than arbitrary (presumably
> unprivileged) code execution. On the other hand, requiring you to reboot
> a server due to a misconfigured sysctl *is* broken.
>
> Again, at the very least, not even allowing capable(CAP_SYS_ADMIN) to
> change the setting is actually broken.
>
> > > If a CAP_SYS_ADMIN-capable user wants to change the sysctl, blocking =
it
> > > doesn't add any security because that process could create a memfd-li=
ke
> > > fd to execute without issues.
> > >What practical attack does this ratcheting
> > > mechanism protect against? (This is a question you can answer with th=
e
> > > YAMA sysctl, but not this one AFAICS.)
> > >
> > > But even if you feel that allowing this in child user namespaces is
> > > unsafe or undesirable, it's absolutely necessary that
> > > capable(CAP_SYS_ADMIN) should be able to un-brick the running system =
by
> > > changing the sysctl. The alternative is that you need to reboot your
> > > server in order to un-set a sysctl that broke some application you ru=
n.
> > >
> >
> > > Also, by the same token, this ratcheting mechanism doesn't make sense
> > > with =3D1 *at all* because it could break programs in a way that woul=
d
> > > require a reboot but it's not a "security setting" (and the YAMA sysc=
tl
> > > mentioned only locks the sysctl at the highest setting).
> > >
> > I think a system should use "=3D0" when it is unsure about its program'=
s
> > need or not need executable memfd. Technically, it is not that this
> > sysctl breaks the user, but the admin  made the mistake to set the
> > wrong sysctl value, and an admin should know what they are doing for a
> > sysctl. Yes. rebooting increases the steps to undo the mistake, but
> > that could be an incentive for the admin to fully test its programs
> > before turning on this sysctl - and avoid unexpected runtime errors.
>
> I don't think this stance is really acceptable -- if an admin that has
> privileges to load kernel modules is not able to disable a sysctl that
> can break working programs without rebooting there is
>
> When this sysctl was first proposed a few years ago (when kernel folks
> found out that runc was using executable memfds), my understanding is
> that the long-term goal was to switch programs to have
> non-executable-memfds by default on most distributions. Making it
> impossible for an admin to lower the sysctl value flies in the face of
> this goal.
>
> At the very least, being unable to lower the sysctl from =3D1 to =3D0 is
> just broken (even if you use the yama example -- yama only locks the
> sysctl at highest possible setting, not on lower settings). But in my
> view, having this sysctl ratchet at all doesn't make sense.
>
To reiterate/summarize the current mechanism for vm.memfd_noexec

1> It is a pid namespace sysctl,  init ns and child pid ns can have
different setting values.
2> child pid ns inherits parent's pid ns's sysctl at the time of fork.
3> There are  3 values for the sysctl, each higher value is more
restrictive than the lower one. Once set, doesn't allow downgrading.

It can be used as  following:
1>
init ns: vm.memfd_noexec =3D 2 (at boot time)
Not allow executable memfd for the entire system, including its containers.

2>
init ns: vm.memfd_noexec =3D 0 or 1
container (child init namespace) vm.memfd_noexec =3D 2.
The host allows runc's usage of executable memfd during container
creation. Inside the container, executable memfd is not allowed.

The inherence + not allow downgrading is to reason with how
vm.memfd_noexec is applied in the process tree.
Without it, essentially we are losing the hierarchy view across the
process tree and  a process can evaluate its capability by modifying
the setting. I think that is a less secure approach I would not
prefer.

Thanks

-Jeff
