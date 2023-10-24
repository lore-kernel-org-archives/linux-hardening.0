Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563692773A
	for <linux-hardening@vger.kernel.org>; Tue, 24 Oct 2023 14:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="MCTpkx6u"
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F9F109
	for <linux-hardening@vger.kernel.org>; Tue, 24 Oct 2023 07:14:42 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-da041ffef81so588128276.0
        for <linux-hardening@vger.kernel.org>; Tue, 24 Oct 2023 07:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1698156881; x=1698761681; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=39/htCYRe9NbFxKs9p8poVgSHtomj8Bq5m3t+aseWC4=;
        b=MCTpkx6uD8LEkK6dh0yqDwAswkAzGzwl4DjplRFodmR2i3NCFEHP0Kj5eb3JzNx4Xv
         Y15xkpqM5w6bGv7ji0I0t3DpvewcKuNLcWCaVDHbiM7hr/HTzzT+bY2ILSyjK2XAxnad
         faOv4FgawBvv+XejEhKJ4MwjLtqyYx1/Abao3giPxcYSFyvTMdAy6mLWAIND6S9AgPDT
         WqRt2GOCpxEDlkg4yFCd1ycgxah8mqEJ3DRJvO6jgjv2zHG35C6kgcDFdQFQq+2n6bzE
         OE+nYJ3awJO9Nz3lDZkTViC7Y7VsgEr6w+8yZeKuYtcf1Z0XQMwgOAPZloWDrGe91n6J
         AInA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698156881; x=1698761681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=39/htCYRe9NbFxKs9p8poVgSHtomj8Bq5m3t+aseWC4=;
        b=s2ga0cIOKRuGQKHsto9BPne2yjI3xP4XVT0r65i44guepPkhADrcSl4AlVxGzLMphO
         DWigbnTp2aDyMb9nkHnSszVolshcwCVXqXLESL6oTQzfl8pP+apLOUPWXRgFNy6vuDYr
         at3qdGhi0W9u5RjHAxkwd1rN1IReC5ju5T0T9tV6T4iJ4DFUUwZuOBbIrsiSnHIPGNhw
         p6tqMZwRiy/ZZGYSDCved7i0q3A59vmjmtbNy7veDpDgOc2wiXh+jxg2nDHJD0nxbxiB
         pHU/V354OMh4SOR4r+RTY7Nf22PJ66UkIfaP1E4kERUMVWmf8GOPUeu96sALqpIfKPgK
         5zCA==
X-Gm-Message-State: AOJu0Yx+TMLR7V4VZpoY77JPbouBIYgtHoOVU8a9lRUPmMqCCNxAV8Mu
	OTMcMrxrGJn2KAHRvR4GHCLV0k964F0QFTtZJzWmGin1/wKJ1/o=
X-Google-Smtp-Source: AGHT+IG7Qnk9seI+6+LHjRaeRYbFDoebTKWAzsyroymjLV7vFpq+o1Bd2VfrtuLgpKeqJg75LiSunq0fD8bfgi56tNY=
X-Received: by 2002:a25:ae67:0:b0:d9a:c7af:bb4d with SMTP id
 g39-20020a25ae67000000b00d9ac7afbb4dmr11126398ybe.37.1698156880636; Tue, 24
 Oct 2023 07:14:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Y59qBh9rRDgsIHaj@mailbox.org> <20231024134608.GC320399@mail.hallyn.com>
In-Reply-To: <20231024134608.GC320399@mail.hallyn.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 24 Oct 2023 10:14:29 -0400
Message-ID: <CAHC9VhRCJfBRu8172=5jF_gFhv2znQXTnGs_c_ae1G3rk_Dc-g@mail.gmail.com>
Subject: Re: Isolating abstract sockets
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Stefan Bavendiek <stefan.bavendiek@mailbox.org>, kernel-hardening@lists.openwall.com, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 9:46=E2=80=AFAM Serge E. Hallyn <serge@hallyn.com> =
wrote:
> On Sun, Dec 18, 2022 at 08:29:10PM +0100, Stefan Bavendiek wrote:
> > When building userspace application sandboxes, one issue that does not =
seem trivial to solve is the isolation of abstract sockets.
>
> Veeery late reply.  Have you had any productive discussions about this in
> other threads or venues?
>
> > While most IPC mechanism can be isolated by mechanisms like mount names=
paces, abstract sockets are part of the network namespace.
> > It is possible to isolate abstract sockets by using a new network names=
pace, however, unprivileged processes can only create a new empty network n=
amespace, which removes network access as well and makes this useless for n=
etwork clients.
> >
> > Same linux sandbox projects try to solve this by bridging the existing =
network interfaces into the new namespace or use something like slirp4netns=
 to archive this, but this does not look like an ideal solution to this pro=
blem, especially since sandboxing should reduce the kernel attack surface w=
ithout introducing more complexity.
> >
> > Aside from containers using namespaces, sandbox implementations based o=
n seccomp and landlock would also run into the same problem, since landlock=
 only provides file system isolation and seccomp cannot filter the path arg=
ument and therefore it can only be used to block new unix domain socket con=
nections completely.
> >
> > Currently there does not seem to be any way to disable network namespac=
es in the kernel without also disabling unix domain sockets.
> >
> > The question is how to solve the issue of abstract socket isolation in =
a clean and efficient way, possibly even without namespaces.
> > What would be the ideal way to implement a mechanism to disable abstrac=
t sockets either globally or even better, in the context of a process.
> > And would such a patch have a realistic chance to make it into the kern=
el?
>
> Disabling them altogether would break lots of things depending on them,
> like X :)  (@/tmp/.X11-unix/X0).  The other path is to reconsider network
> namespaces.  There are several directions this could lead.  For one, as
> Dinesh Subhraveti often points out, the current "network" namespace is
> really a network device namespace.  If we instead namespace at the
> bind/connect/etc calls, we end up with much different abilities.

The LSM layer supports access controls on abstract sockets, with at
least two (AppArmor, SELinux) providing abstract socket access
controls, other LSMs may provide controls as well.

--=20
paul-moore.com
