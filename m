Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8DC11732
	for <linux-hardening@vger.kernel.org>; Tue, 24 Oct 2023 14:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Oobz4oxA"
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355EAC4
	for <linux-hardening@vger.kernel.org>; Tue, 24 Oct 2023 07:29:29 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-d9fe0a598d8so1860974276.2
        for <linux-hardening@vger.kernel.org>; Tue, 24 Oct 2023 07:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1698157768; x=1698762568; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9St+NC+XD1HvjvLwwsYc0DGwnb1k0QyELVidz1a0GZc=;
        b=Oobz4oxAvRhRescv5O0JMEUPyFW0bXScZyUhmfrxtOBLfHqiRxt0CANOJb5u0ONIp8
         p3F1qZuWiMNXu5EoKGB3iwSPPYo6Z+SF4pIYm863E7TIu3cj3Gaf2WnyM4H7EcHU4lky
         ou0Tr4xMHcP6cBlkKZvfHJht1hOt7U+0n64CMyv1Hu1YYFqtRro39d0JpKg/F90ZnVHa
         YUsCBYiLmu9em7j2pPqytHiDhyOET6+syQFk5SvJFOhhEEgamZ/wHgh8U3yTSHj6mlpR
         0NAe6TMw4xFube1SBJhLzYMqR8be8UQsxUgnauYAlB8GooyXzuBu+I78XdpCZlbBndEh
         XDFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698157768; x=1698762568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9St+NC+XD1HvjvLwwsYc0DGwnb1k0QyELVidz1a0GZc=;
        b=P7yWe6vVqtcAX1UFhdXkVx68fTAgsVsd8M3cww/kN4U40NtP5bULUSTni2rd+zOaXV
         nbP/8WssAxWelPHdqI7BOuzlaStVIFcW/iaQHyAY1JQytLaZgpEvm3vOGWniWT6B8H1J
         D+Plx6qv5guQVfbq8RvpOOMEw85qrt6qa7tUf4MV6EEDhYgUzdY9gbIij1GCkXrPaPOe
         ShoUyvTc4IndK843zlmU7XjdoiUYu30vAaMx6zbJNQEqF5K0VQN7WtfzNpyuNSehpSbC
         zq1m09dXLYwniYlQHLKxfuQysKTdmrtbRG2iI+nqfJXIXdr9h1w511PHkYGIRVqCBieO
         hW0Q==
X-Gm-Message-State: AOJu0YxhYctSPEzEIhMkNtfLlh6vPf2C5bNIxrYaZlP5WMcc2Ci6HcJ9
	vmjqgeRqa9GZExQqbRfrD4SrcnXaQvp7e7pcyxQO
X-Google-Smtp-Source: AGHT+IFtA3/HQ2zpytfREiV5TTig4qKINm6MGhnXPuhthXB33oQqf+csIi0haSBqSrBP/+YD5LoK7hvXQEdKBYlqKfY=
X-Received: by 2002:a25:d38d:0:b0:d9c:2a9c:3f4f with SMTP id
 e135-20020a25d38d000000b00d9c2a9c3f4fmr13007814ybf.62.1698157768313; Tue, 24
 Oct 2023 07:29:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Y59qBh9rRDgsIHaj@mailbox.org> <20231024134608.GC320399@mail.hallyn.com>
 <CAHC9VhRCJfBRu8172=5jF_gFhv2znQXTnGs_c_ae1G3rk_Dc-g@mail.gmail.com> <20231024141807.GB321218@mail.hallyn.com>
In-Reply-To: <20231024141807.GB321218@mail.hallyn.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 24 Oct 2023 10:29:17 -0400
Message-ID: <CAHC9VhQaotVPGzWFFzRCgw9mDDc2tu6kmGHioMBghj-ybbYx1Q@mail.gmail.com>
Subject: Re: Isolating abstract sockets
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Stefan Bavendiek <stefan.bavendiek@mailbox.org>, kernel-hardening@lists.openwall.com, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 10:18=E2=80=AFAM Serge E. Hallyn <serge@hallyn.com>=
 wrote:
> On Tue, Oct 24, 2023 at 10:14:29AM -0400, Paul Moore wrote:
> > On Tue, Oct 24, 2023 at 9:46=E2=80=AFAM Serge E. Hallyn <serge@hallyn.c=
om> wrote:
> > > On Sun, Dec 18, 2022 at 08:29:10PM +0100, Stefan Bavendiek wrote:
> > > > When building userspace application sandboxes, one issue that does =
not seem trivial to solve is the isolation of abstract sockets.
> > >
> > > Veeery late reply.  Have you had any productive discussions about thi=
s in
> > > other threads or venues?
> > >
> > > > While most IPC mechanism can be isolated by mechanisms like mount n=
amespaces, abstract sockets are part of the network namespace.
> > > > It is possible to isolate abstract sockets by using a new network n=
amespace, however, unprivileged processes can only create a new empty netwo=
rk namespace, which removes network access as well and makes this useless f=
or network clients.
> > > >
> > > > Same linux sandbox projects try to solve this by bridging the exist=
ing network interfaces into the new namespace or use something like slirp4n=
etns to archive this, but this does not look like an ideal solution to this=
 problem, especially since sandboxing should reduce the kernel attack surfa=
ce without introducing more complexity.
> > > >
> > > > Aside from containers using namespaces, sandbox implementations bas=
ed on seccomp and landlock would also run into the same problem, since land=
lock only provides file system isolation and seccomp cannot filter the path=
 argument and therefore it can only be used to block new unix domain socket=
 connections completely.
> > > >
> > > > Currently there does not seem to be any way to disable network name=
spaces in the kernel without also disabling unix domain sockets.
> > > >
> > > > The question is how to solve the issue of abstract socket isolation=
 in a clean and efficient way, possibly even without namespaces.
> > > > What would be the ideal way to implement a mechanism to disable abs=
tract sockets either globally or even better, in the context of a process.
> > > > And would such a patch have a realistic chance to make it into the =
kernel?
> > >
> > > Disabling them altogether would break lots of things depending on the=
m,
> > > like X :)  (@/tmp/.X11-unix/X0).  The other path is to reconsider net=
work
> > > namespaces.  There are several directions this could lead.  For one, =
as
> > > Dinesh Subhraveti often points out, the current "network" namespace i=
s
> > > really a network device namespace.  If we instead namespace at the
> > > bind/connect/etc calls, we end up with much different abilities.
> >
> > The LSM layer supports access controls on abstract sockets, with at
> > least two (AppArmor, SELinux) providing abstract socket access
> > controls, other LSMs may provide controls as well.
>
> Good point.  And for Stefan that may suffice, so thanks for mentioning
> that.  But The LSM layer is mandatory access control for use by the
> admins.  That doesn't help an unprivileged user.

Individual LSMs may implement mandatory access control models, but
that is not an inherent requirement imposed by the LSM layer.  While
the Landlock LSM does not (yet?) support access controls for abstract
sockets, it is a discretionary access control mechanism.

I'm not currently aware of a discretionary access control LSM that
supports abstract socket access control, but such a LSM should be
possible if someone wanted to implement one.

--=20
paul-moore.com
