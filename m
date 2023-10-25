Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CD41C6B0
	for <linux-hardening@vger.kernel.org>; Wed, 25 Oct 2023 17:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KRnYSNM2"
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB6E184
	for <linux-hardening@vger.kernel.org>; Wed, 25 Oct 2023 10:41:43 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-53f647c84d4so1000a12.0
        for <linux-hardening@vger.kernel.org>; Wed, 25 Oct 2023 10:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698255702; x=1698860502; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NAZ9nGAhH3o0erIde1hPIJrXvGELXGLaUsVfM+RSmeg=;
        b=KRnYSNM2+dMwmpWjn3jm1bA11qwyJJpeE1MCjMWRefM7I0Snt+r4ovpri7VBzki/Sq
         5L7YIFraTshoYASQgtGVUyj3YrQhNCEnOVcqOssOVeWO+ox8s0Auf3Z6POjZzj94c84o
         tpiE8gfGsbNNydzUaOAexvPkrEV3oA8AetQV3GQNbPufYfE0QiT21w8KQYrF5skBn/Ca
         QnFG8jeADdINajhMKuX9lU6xtv4qixBHhzSZxBrHF15CQ13pd5N648Cadk7auiFNp0oF
         6EP1F44/iYOX7NLCCJII8CmvM/2DWnPxzT+UbqcVkraFHHYHYOFxn0AmQwmuM5wyQycy
         ajTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698255702; x=1698860502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NAZ9nGAhH3o0erIde1hPIJrXvGELXGLaUsVfM+RSmeg=;
        b=vkEdOLFaA1Ompnf7deDOAL5J1LNSW+nHpy2U3yJMIDKWltnJUnmFKjzq1tubcb3BFO
         BWkjqs/1X4+KNjb4dxEUqRkjNwxJ0LPLKDhAIwGcISnmPh0XS2B+r3nKy/X1myeH0yq3
         gUOr0UG4ubUfm1VixWbl5NOOP2Z1eN62v+AcjcEqD26EsfbNwapgUWkWMjpBdppmGSBZ
         rHh8e4y3hKKca5O7wIsqlKGFjs/MRr3j1LIeWLwLHXYhINAf8+493hUG+jumdUHWuwNX
         WF42/jgS4pc/Avbtq6DWKcgevtPUiEh6UohLDmzT7WtkhRmtuqEGQCnsLtR+6xhn3Wy6
         ctXQ==
X-Gm-Message-State: AOJu0Yw/1/xBbYbo+Pr7Z062V0UM6obgnyLc3mJG6Ai3JQpY5jdwJlEl
	a1Zxu+A2qexTPeqmOJgiAcwk70i/e6zSiei047Oqa6jhO2wN1pyzxIs=
X-Google-Smtp-Source: AGHT+IGETRjieiv11ugdTejLjjbzIjSP8buXEjIFCRQqEAqn2HYOKjHiEJwZgva9XIL3KL1gydFf/zhtey/xR2xX3Xk=
X-Received: by 2002:a50:d706:0:b0:53e:7ad7:6d47 with SMTP id
 t6-20020a50d706000000b0053e7ad76d47mr122973edi.5.1698255701707; Wed, 25 Oct
 2023 10:41:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Y59qBh9rRDgsIHaj@mailbox.org> <20231024134608.GC320399@mail.hallyn.com>
 <CAG48ez2DF4unFq7wXqHVdUg+o_VYee012v0hUiGTbfnTpsPi0w@mail.gmail.com> <20231025172235.GA345747@mail.hallyn.com>
In-Reply-To: <20231025172235.GA345747@mail.hallyn.com>
From: Jann Horn <jannh@google.com>
Date: Wed, 25 Oct 2023 19:41:03 +0200
Message-ID: <CAG48ez06yt4NO3QnUOLBBmrjesR2eF6GUWnffuckWEemxtUYcg@mail.gmail.com>
Subject: Re: Isolating abstract sockets
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Stefan Bavendiek <stefan.bavendiek@mailbox.org>, kernel-hardening@lists.openwall.com, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2023 at 7:22=E2=80=AFPM Serge E. Hallyn <serge@hallyn.com> =
wrote:
>
> On Wed, Oct 25, 2023 at 07:10:07PM +0200, Jann Horn wrote:
> > On Tue, Oct 24, 2023 at 3:46=E2=80=AFPM Serge E. Hallyn <serge@hallyn.c=
om> wrote:
> > > Disabling them altogether would break lots of things depending on the=
m,
> > > like X :)  (@/tmp/.X11-unix/X0).
> >
> > FWIW, X can connect over both filesystem-based unix domain sockets and
> > abstract unix domain sockets. When a normal X client tries to connect
> > to the server, it'll try a bunch of stuff, including an abstract unix
> > socket address, a filesystem-based unix socket address, and TCP:
> >
> > $ DISPLAY=3D:12345 strace -f -e trace=3Dconnect xev >/dev/null
> > connect(3, {sa_family=3DAF_UNIX, sun_path=3D@"/tmp/.X11-unix/X12345"}, =
24)
> > =3D -1 ECONNREFUSED (Connection refused)
> > connect(3, {sa_family=3DAF_UNIX, sun_path=3D"/tmp/.X11-unix/X12345"}, 1=
10)
> > =3D -1 ENOENT (No such file or directory)
> > [...]
> > connect(3, {sa_family=3DAF_INET, sin_port=3Dhtons(18345),
> > sin_addr=3Dinet_addr("127.0.0.1")}, 16) =3D 0
> > connect(3, {sa_family=3DAF_INET6, sin6_port=3Dhtons(18345),
> > inet_pton(AF_INET6, "::1", &sin6_addr), sin6_flowinfo=3Dhtonl(0),
> > sin6_scope_id=3D0}, 28) =3D 0
> > connect(3, {sa_family=3DAF_INET6, sin6_port=3Dhtons(18345),
> > inet_pton(AF_INET6, "::1", &sin6_addr), sin6_flowinfo=3Dhtonl(0),
> > sin6_scope_id=3D0}, 28) =3D -1 ECONNREFUSED (Connection refused)
> > connect(3, {sa_family=3DAF_INET, sin_port=3Dhtons(18345),
> > sin_addr=3Dinet_addr("127.0.0.1")}, 16) =3D -1 ECONNREFUSED (Connection
> > refused)
> >
> > And the X server normally listens on both an abstract and a
> > filesystem-based unix socket address (see "netstat --unix -lnp").
> >
> > So rejecting abstract unix socket connections shouldn't prevent an X
> > client from connecting to the X server, I think.
>
> Well it was just an example :)  Dbus is another.  But maybe all
> the users of abstract unix sockets will fall back gracefully to
> something else.  That'd be nice.

For what it's worth, when I try to connect to the session or system
bus on my system (like "strace -f -e trace=3Dconnect dbus-send
--session/--system /foo foo"), the connections seem to go directly to
a filesystem socket...

> For X, abstract really doesn't even make sense to me.  Has it always
> supported that?

No idea.
