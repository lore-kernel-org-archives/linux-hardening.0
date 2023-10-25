Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10493F50A
	for <linux-hardening@vger.kernel.org>; Wed, 25 Oct 2023 17:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IraOVuCc"
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5A713D
	for <linux-hardening@vger.kernel.org>; Wed, 25 Oct 2023 10:10:46 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-53f98cbcd76so267a12.1
        for <linux-hardening@vger.kernel.org>; Wed, 25 Oct 2023 10:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698253845; x=1698858645; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WbCzlcs1e/xyWA1Lmpsd2IcmsRjzxcTLP4u0CYsVcpQ=;
        b=IraOVuCcZ3m+2FDerIIswdr50P7rnMr9ozk3osfccyHttCygrmLFNu3kNW4TTZ5iRE
         XzGDQmvFhwZ5/HA4HjsKkH8+lXfir1ok4KiQ8LM9ZTuO8h5MgKit1DkO3ao4IE8cA787
         q/pOMRWYXuYYBS5g8spDridU+HmulpZ3+/anS/+KGZtqC8yVWzSSshzS/Ky0ALqPZ6kC
         kDvi694rDQGHvTCQrbZ2Z4mu2pAL1qsWJfGdDUCXjEcsCbYAZixJw+b4LyaMvM+M2fbd
         YyQl5lqY8KDG3NiKmbyYqlI35TbX7IW23r2jklXMHTcgkMJc1Db1i07NVWGwpnG+FNKI
         jnGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698253845; x=1698858645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WbCzlcs1e/xyWA1Lmpsd2IcmsRjzxcTLP4u0CYsVcpQ=;
        b=Nhgm5Gg6U39ePQtYGtrzKpWXuryP5IKvJry4kKrOjSXmxl03kY18piIl/TmQI4IViQ
         W3Rm510vNaDG/p1jUdow24BkVfrAT7h1I1eDrFL8E+g2PsRwoiq4sILQRhu90Muu3l11
         iwIHyl+jV8cnkOblYC33ldQQ1ZhC6yyl19toPrdfMOX0BAYg8peOgGo6UIzux/NrfT4u
         3QTbDSeipFZdDjpCDPdnRs3qkZrWmWG4AGYv/VDQW4M4h0fNaFthvM6Qi3iYfgSZK7xk
         QBQSLvOE7EQYh3rHHcvKl7yrD76a96Ae9DTp419KiwEwoZUzEzMfPp6LI6W21dSP6y7U
         MM9Q==
X-Gm-Message-State: AOJu0YwJzZVbNFeguWmFl4Tpb5L62kM7M62CLeQxlhbVeWDVKxsBTFC7
	FeRl64rxoPxLOYhtxBc6+3O+92UgD1D+qGOmfbkgb7n9056ZxtM7THy1ng==
X-Google-Smtp-Source: AGHT+IEuT5m2F+vLsyPqrvngPEJcOV2q2E/KK4G3bQy+ECWMBZP/HzYEGV6AqI1S0zF15bbRjRPWy0jFMJv1H1qaOCI=
X-Received: by 2002:a50:9ec5:0:b0:540:9444:222c with SMTP id
 a63-20020a509ec5000000b005409444222cmr125835edf.6.1698253845177; Wed, 25 Oct
 2023 10:10:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Y59qBh9rRDgsIHaj@mailbox.org> <20231024134608.GC320399@mail.hallyn.com>
In-Reply-To: <20231024134608.GC320399@mail.hallyn.com>
From: Jann Horn <jannh@google.com>
Date: Wed, 25 Oct 2023 19:10:07 +0200
Message-ID: <CAG48ez2DF4unFq7wXqHVdUg+o_VYee012v0hUiGTbfnTpsPi0w@mail.gmail.com>
Subject: Re: Isolating abstract sockets
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Stefan Bavendiek <stefan.bavendiek@mailbox.org>, kernel-hardening@lists.openwall.com, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 3:46=E2=80=AFPM Serge E. Hallyn <serge@hallyn.com> =
wrote:
> Disabling them altogether would break lots of things depending on them,
> like X :)  (@/tmp/.X11-unix/X0).

FWIW, X can connect over both filesystem-based unix domain sockets and
abstract unix domain sockets. When a normal X client tries to connect
to the server, it'll try a bunch of stuff, including an abstract unix
socket address, a filesystem-based unix socket address, and TCP:

$ DISPLAY=3D:12345 strace -f -e trace=3Dconnect xev >/dev/null
connect(3, {sa_family=3DAF_UNIX, sun_path=3D@"/tmp/.X11-unix/X12345"}, 24)
=3D -1 ECONNREFUSED (Connection refused)
connect(3, {sa_family=3DAF_UNIX, sun_path=3D"/tmp/.X11-unix/X12345"}, 110)
=3D -1 ENOENT (No such file or directory)
[...]
connect(3, {sa_family=3DAF_INET, sin_port=3Dhtons(18345),
sin_addr=3Dinet_addr("127.0.0.1")}, 16) =3D 0
connect(3, {sa_family=3DAF_INET6, sin6_port=3Dhtons(18345),
inet_pton(AF_INET6, "::1", &sin6_addr), sin6_flowinfo=3Dhtonl(0),
sin6_scope_id=3D0}, 28) =3D 0
connect(3, {sa_family=3DAF_INET6, sin6_port=3Dhtons(18345),
inet_pton(AF_INET6, "::1", &sin6_addr), sin6_flowinfo=3Dhtonl(0),
sin6_scope_id=3D0}, 28) =3D -1 ECONNREFUSED (Connection refused)
connect(3, {sa_family=3DAF_INET, sin_port=3Dhtons(18345),
sin_addr=3Dinet_addr("127.0.0.1")}, 16) =3D -1 ECONNREFUSED (Connection
refused)

And the X server normally listens on both an abstract and a
filesystem-based unix socket address (see "netstat --unix -lnp").

So rejecting abstract unix socket connections shouldn't prevent an X
client from connecting to the X server, I think.
