Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F75299920
	for <linux-hardening@vger.kernel.org>; Mon, 23 Jun 2025 15:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750691753; cv=none; b=S/qGHoNJxJFtSNrkR6luTTGD+xf+PHBn8TsDbliLVJTe8YLd/1pZ9N1FtY97/JKp5GtvWzx2LqHHkEfRumVl4Esb4kGkU0UczinZBJZwSsZCGS4vPL4VM+p5XcLHfsTJrIUfQ8WhRxxGeF9Az2PgjQd5qDxnsH6QuJNxX91KSOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750691753; c=relaxed/simple;
	bh=bqmkafwxydyORUt50Ur58Kwuhlign7ZQjhD916NZCSY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MijsEUsNnKp7R+PfKrr3THbIwE0oUZxxMP9pv9HdO/7ThFeQ55PtqTIYM4OjqXR4raGACC3cYHp6p49Qc9iBkIGPdmGeWUoUPm0qCodkZbbkQXS1zVjrqBGkVFpnORXglQDIjDtzi92aLQfOjLwQ9cObP05HTjfUCqjz5ZBYxcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=EKYe+ogk; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="EKYe+ogk"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e81ec95d944so3475828276.1
        for <linux-hardening@vger.kernel.org>; Mon, 23 Jun 2025 08:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1750691751; x=1751296551; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/cEM3zQRxkyeF8QlajSb8sKwoIOz06mgwPF6H5WCdJ0=;
        b=EKYe+ogkX/OG1HhZRLqatx3ccfj/tYIE4kgYG87jUjQcRjccTjocq1jB1lMNhHPGRq
         HVvhKW2AzCeUA37+5GN9cy7gNkL304wcUDb4vveYgRHcavzhBj0zzTNsPzVgzkN9w/Qr
         9rP7KeS5zvw3CcE/F3eFpK2ztzdW9dtH1C5wQqIBGxvtEY16BLCU7Hd4xNH1G4sF/UDP
         Nd4/trrkWCsA1EDmITaNhWWuu7U9kcyNbL0Fa1157ez8R0mLwRXlQo3mxf650uauZowL
         X2mE0QhSiFnr2geIFqOLp1ReIMqydYNmSEM01NEihxVhk4uHmjOEzwe2dFYzOT8gT/KD
         Ex2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750691751; x=1751296551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/cEM3zQRxkyeF8QlajSb8sKwoIOz06mgwPF6H5WCdJ0=;
        b=q0USQ/BvUMNaeVFGgNjLgCzeFakqA0zEmyRQmOenimWPbd2L04m+Q+FfzhylgZR9dg
         Z5y3xulAzV1EzVaeb7Gsq/VqzeaSCrGQzwHzZqKakbf34E2UpZOPycnTCEaPE+EeHYG2
         VFPVlLmIEIzX7/ho0iyN1+0+G9EtaflT9UkQzY2hOIXiWxVEToPWPQn6wiZr0y5Hv9BT
         9JSYOJ93C4UoVQeKt3eSLMUgGD8ConNjrHOsStBzupH4uHnjzE9nqqF/D8Wgd2k55V1g
         2N+cmq3Z3FxV2B68d9YsL/1qiycZWODRDJwEdrEUkPOXgglY2gGgtYwfX1IUpk7NFnU0
         AisA==
X-Forwarded-Encrypted: i=1; AJvYcCVHr8CZ0eEZgSXHcrZXR9xrBbIZC2NSXfL50hhcWl6+YkyqzW2xD4zvexZLSfl9QU5rbuZRFMV1Olh3ZL2RayU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeD78EJu2L+t34wgbAeWLUoC+1F/ssQxv3NgTTHeetm5PmKtYx
	a0aX4cx9qX66pu+0nWLGF1hReEuH5YXOQ4YexU8FoD7eZT/FzjI7nNdv0mEPmpIQeM0LcqtTIwW
	fFLFh1WR1mXe4z0Q5CLHydXPcndYmubKh5x1+aPCJ
X-Gm-Gg: ASbGnctm9Ex34US8UjFVx8MSx/kqCotKcpnF47/KcGkwgTn3rrHdb1o6TpqZwjr3FZa
	1k+r42nV5iyI7OhqNYWPv6yP6iWObNawNFCtBCOrUeXBT1z0SMF2yG1lSI3IA2S4z9Xe/p6Iz5P
	KT+GTnFRJ5syuqecPCmNtkTctuJ9jRrp//qbwz/8EfvZc=
X-Google-Smtp-Source: AGHT+IFZQzn3+JMIyejKC2+W29AQd1WwouaHlQDxuqJsYDQVdOYz9u2SoStqSDrpqsqEky4EPBlD56TODEPQ9GFR58M=
X-Received: by 2002:a05:690c:9683:b0:6f9:4c00:53ae with SMTP id
 00721157ae682-712ca356122mr174541157b3.8.1750691751048; Mon, 23 Jun 2025
 08:15:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250622-toicsti-bug-v1-0-f374373b04b2@gmail.com>
 <20250622-toicsti-bug-v1-2-f374373b04b2@gmail.com> <CAEjxPJ6v12nLFx-x4-=esuPMp7L8UBvTzoj1kkTPcD2mDKKW8w@mail.gmail.com>
In-Reply-To: <CAEjxPJ6v12nLFx-x4-=esuPMp7L8UBvTzoj1kkTPcD2mDKKW8w@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 23 Jun 2025 11:15:39 -0400
X-Gm-Features: Ac12FXw75VZJClzZmRv1umOqFnfnvmDMNU_jKRuRdLW4QXd6DpSXCOL2kXN21Os
Message-ID: <CAHC9VhS8gPQwgesV_0VbUuqxGrADm5uDofM3m=wZuAEgkWi5Hw@mail.gmail.com>
Subject: Re: [PATCH 2/2] selinux: add capability checks for TIOCSTI ioctl
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: xandfury@gmail.com, Shuah Khan <shuah@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev, 
	selinux@vger.kernel.org, kees@kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 8:39=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Sun, Jun 22, 2025 at 9:41=E2=80=AFPM Abhinav Saxena via B4 Relay
> <devnull+xandfury.gmail.com@kernel.org> wrote:
> >
> > From: Abhinav Saxena <xandfury@gmail.com>
> >
> > The TIOCSTI ioctl currently only checks the current process's
> > credentials, creating a TOCTOU vulnerability where an unprivileged
> > process can open a TTY fd and pass it to a privileged process via
> > SCM_RIGHTS.
> >
> > Fix by requiring BOTH the file opener (file->f_cred) AND the current
> > process to have CAP_SYS_ADMIN. This prevents privilege escalation
> > while ensuring legitimate use cases continue to work.
> >
> > Link: https://github.com/KSPP/linux/issues/156
> >
> > Signed-off-by: Abhinav Saxena <xandfury@gmail.com>
> > ---
> >  security/selinux/hooks.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 595ceb314aeb..a628551873ab 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -3847,6 +3847,12 @@ static int selinux_file_ioctl(struct file *file,=
 unsigned int cmd,
> >                                             CAP_OPT_NONE, true);
> >                 break;
> >
> > +       case TIOCSTI:
> > +               if (!file_ns_capable(file, &init_user_ns, CAP_SYS_ADMIN=
) ||
> > +                   !capable(CAP_SYS_ADMIN))
> > +                       error =3D -EPERM;
> > +               break;
> > +
>
> So, aside from what I said previously, this also will break any
> existing policies currently controlling TIOCSTI
> via the selinux ioctl checking in the default case, so at the very
> least, this would need to be gated by a new
> SELinux policy capability for compatibility purposes. But I'm still
> unconvinced that this is the right approach.

I want to add my voice to the other comments that adding these
capability checks to the SELinux code and not the main TIOCSTI kernel
code is not an approach we want to support.  Beyond that, as others
have already pointed out, I think some additional inspection and
testing is needed to ensure that the additional capability checks do
not break existing, valid use cases.

--=20
paul-moore.com
