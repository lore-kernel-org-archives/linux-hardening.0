Received: from mail-lj1-f202.google.com (mail-lj1-f202.google.com [209.85.208.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F8E1F1304
	for <linux-hardening@vger.kernel.org>; Tue,  3 Dec 2024 13:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733234013; cv=none; b=J24edE1xY7tEREHAuExF5qfdJ3rllZSR19I3153GWdACvSAQHbAnqZweeOj4WVISkgEYmwYSNBzMTfdXpV8o/JMX4h8eeTSXS7K6qme65cCXETp6ic61u6eNav/kSN9Vk/C+Uda0oiO3hBAk3rVSV/nmSKpFEf2fwh+nOv2lqz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733234013; c=relaxed/simple;
	bh=TXAqVY8KWWJBZQ6CwZv+j5Cey4kS2P9bKaxvIbGTRW8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jkq9OoD5FiEJm/+iDnhZlEMesxgPufFHFQUdsp0IHMp742iDf40TH2kG/mIbfeTEZrIPhcC/ewMa9/L8wGFcN972q6i4XQkgRp8TMINaeyoLtcE5//658xlc9ljFXzYCKggJUHrGO2L0n4GlgN3H9Lc8PJ5m5IOY7aGwMmMZwlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g7N5UeFU; arc=none smtp.client-ip=209.85.208.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g7N5UeFU"
Received: by mail-lj1-f202.google.com with SMTP id 38308e7fff4ca-2ffccfce0e7so45654951fa.0
        for <linux-hardening@vger.kernel.org>; Tue, 03 Dec 2024 05:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733234010; x=1733838810; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AemqQ9vAGuX9F0C6FlnaawUPQzUVE3YTdDtlmLWXAww=;
        b=g7N5UeFUbzOPD1ufR1KVQ5J3HgjmEovkdl+kIF6TerKFa4jZmtyOr9EmsPtrKVE5xZ
         /vxk7aeya4TmJFE5/yjBRYl2zGCI9UDFD4ZEmm8i36yA0yNoFaFHI/AdT9vdVtbTTS6O
         W5Bl4V9V1IDe1w0W9HzNnzkWlnDQUx4HKg8cjtsTAg4ARFfCwDUVe+BOz6j5aklNz33Q
         qDFrXnqvCsgAxoDWz1n/3rIyrn7FqBY+ufSIYey5lO+Ix2NaeaxplZY7VYfNL4uug667
         5kXhXdbxaX8VP2SFOqb+YM+Busmwrh57dytefhe8q5yYlcWz/ifExZej0GRTxvpXv/JT
         MyEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733234010; x=1733838810;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AemqQ9vAGuX9F0C6FlnaawUPQzUVE3YTdDtlmLWXAww=;
        b=dOgUz5zP8ZfU0Asv4dJRKnY6O88BNR2Z3Nm4JfNAIzXMjIVi4x/y82jWgc8eZh0oqV
         ESu99f+n/iFDiha+YH5+vYDePczTQhWKVGEULjvZFbV3uBg/P0au+bCRCQCPGF2ReQn1
         TrKAtyzV+tz4xCa/Wwd5lC8/ggTUyikPtGUvs8nH5UeSEBM97/ymdjBcWeVQxA2mI+0E
         bsGZz6LpRfQumoBaW/Z1T7Uj1pdew9HtPFT9OKELhHfKfET9C+XwzxdRmfoJsL6KHJ82
         wd6vC4OakpcDMkYlTiuDk4mkVOD6R2mu6Yj/TxWTcn1ZbtEAgTOMiCjQ9ceTXbZgOMx7
         gw/A==
X-Forwarded-Encrypted: i=1; AJvYcCXETDGfewJFTWnWNtM5JKBAx99chkq5PBjEf4VL6mpSAmiq5ufiZ1GVSSLJQ+z6hfdS/3Gc40c/PzWX/hZIueQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH8l8zl4mH5RMogZP5gJyPAhdkrojrNcxDvgif4CyDKEGJLj4g
	XF0YjE4zEapYc/j4bejX3jkogRhZIfWNvCKvWgcq80OAXZ8BunO0ta9bE1a/32smmnOu64BJScC
	GOw==
X-Google-Smtp-Source: AGHT+IFCzJOllkW4D5c3mTj1w+OFc+7lwZc+dvcg9StCItki84tsAp5HAkY8UOhehLFLcQlMW28Y3LqEwco=
X-Received: from edbu25.prod.google.com ([2002:a50:a419:0:b0:5cf:dfe3:2bd7])
 (user=gnoack job=prod-delivery.src-stubby-dispatcher) by 2002:a05:651c:2117:b0:2ff:d801:4aed
 with SMTP id 38308e7fff4ca-30009d07e8bmr20937821fa.28.1733234010358; Tue, 03
 Dec 2024 05:53:30 -0800 (PST)
Date: Tue, 3 Dec 2024 14:53:27 +0100
In-Reply-To: <CAG48ez0vg9W=oatvEqxvTSYNUx7htY23LxPrYCiuLZhZQuaGjg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <ee3ec63269b43b34e1c90dd8c9743bf8@finder.org> <CAG48ez0vg9W=oatvEqxvTSYNUx7htY23LxPrYCiuLZhZQuaGjg@mail.gmail.com>
Message-ID: <Z08NV4Z-L0anDxGk@google.com>
Subject: Re: GPM & Emacs broken in Linux 6.7 -- ok to relax check?
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: Jann Horn <jannh@google.com>
Cc: Jared Finder <jared@finder.org>, "Hanno =?utf-8?B?QsO2Y2s=?=" <hanno@hboeck.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	linux-hardening@vger.kernel.org, regressions@lists.linux.dev, 
	kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello!

On Fri, Nov 29, 2024 at 08:50:38PM +0100, Jann Horn wrote:
> +regression list, LKML, maintainers, patch authors
>=20
> On Fri, Nov 29, 2024 at 8:38=E2=80=AFPM Jared Finder <jared@finder.org> w=
rote:
> > The change to restrict access to TIOCLINUX that was added in Linux 6.7
> > breaks Emacs rendering of the mouse pointer. This change was previous
> > discussed in
> > https://lwn.net/ml/kernel-hardening/20230402160815.74760f87.hanno@hboec=
k.de/.
>=20
> This landed as commit 8d1b43f6a6df ("tty: Restrict access to
> TIOCLINUX' copy-and-paste subcommands").
>=20
> #regzbot introduced: 8d1b43f6a6df

Thank you for reporting the bug, and thanks for forwarding, Jann!

> > An associated Emacs bug report, bug #74220, is discussed at
> > https://lists.gnu.org/archive/html/bug-gnu-emacs/2024-11/msg00275.html.
> >
> > I wanted to ask if it made sense for the restriction to not apply to th=
e
> > following three selection modes for TIOCL_SETSEL:
> >
> > TIOCL_SELPOINTER   3 /* show the pointer */
> > TIOCL_SELCLEAR   4 /* clear visibility of selection */
> > TIOCL_SELMOUSEREPORT   16 /* report beginning of selection */
> >
> > On a glance over the selection code, none of these interact with
> > vc_sel.buffer and therefore are unrelated to the exploit linked in the
> > original report. Only SELPOINTER is necessary to be available to fix
> > Emacs bug #74220. I imagine such a change would involve moving the
> > capability check from tioclinux(), case TIOCL_SETSEL to inside
> > vc_do_selection().

We did indeed miss that Emacs is using these IOCTLs directly.

To paraphrase what is happening, so that we are on the same page:

* Emacs includes the GPM header gpm.h and calls Gpm_DrawPointer(x, y, fd).
* Gpm_DrawPointer is implemented as a macro, which hardcodes all IOCTL cons=
tants
  (as it is the case in the entire GPM codebase), and it invokes ioctl(2)
  directly from the macro.

The Gpm_DrawPointer also gets called from other packages, including mc (Mid=
night
Commander), elinks and libt3widget (which supports the Tilde text editor).

https://codesearch.debian.net/search?q=3DGpm_DrawPointer&literal=3D1&perpkg=
=3D1

* Midnight Commander and the Tilde text editor display the mouse cursor fin=
e,
  also as a regular user.

* Elinks does not display the mouse cursor at all, independent of whether i=
t is
  being run as root or not.  (Which makes me suspect that it might be an
  independent bug.)

* Emacs does not display the mouse cursor when run as normal user,
  but it works as root.

I can see how the three selection modes TIOCL_SELPOINTER, TIOCL_SELCLEAR an=
d
TIOCL_SELMOUSEREPORT are related - TIOCL_SELPOINTER is the one that we need=
, but
TIOCL_SELPOINTER and TIOCL_SELCLEAR are the other two which can happen lead=
ing
up to that at the top of vc_selection()?

I also believe that what we *actually* want to guard here is the change to
vc_sel, so to propose a (somewhat simple-minded) patch, I guess we could pu=
t the
CAP_SYS_ADMIN check in vc_do_selection() right before the place where
vc_sel.start and vc_sel.end are being assigned?

Hanno, you are the original author of this patch and you have done a more
detailed analysis on the TIOCLINUX problems than me -- do you agree that th=
is
weakened check would still be sufficient to protect against the TIOCLINUX
problems?  (Or in other words, if we permitted TIOCL_SELPOINTER, TIOCL_SELC=
LEAR
and TIOCL_SELMOUSEREPORT for non-CAP_SYS_ADMIN processes, would you still s=
ee a
way to misuse that functionality?)

Thanks,
=E2=80=94G=C3=BCnther
