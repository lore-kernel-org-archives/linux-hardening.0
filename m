Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0EE1F0E32
	for <linux-hardening@vger.kernel.org>; Sat, 21 Dec 2024 11:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734779200; cv=none; b=te1NokeZqvf7DC53yRJb72CTgXRmbSsJiy3FEPkHA/Fho0NtADxWjS6AyUi7H+8/vGhTdKo6Zi9YtQ+yAFCfcWP57L3wUdOYcP3XTRZIGW4EJP/Phq7PRt4qE1tm18qBLtOGK0g2KjzLhZ0HhIZtcVP2+8LIugalFVqMSfOJJLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734779200; c=relaxed/simple;
	bh=HKrvtGIaAK3Jab0O+wQO5OrK+dBoeEExyYJNxAwz//M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oqyMMOJ02oX4bEVSRdeXPYGU5o1uyM8Ur1UuA5Svt+c3AY03w8zJsL6C7X6a8OEA8xkSYqJNN5EhZ1bWbl7rjiWBXY2kAiBXgLJ/duRg85tqM4RNuw37rQ5NxLp4PwWnOWpDWShSde5BUhQ8kJBS/ZBL78rD/oF/QSD8EpCyI6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iBFoJJ84; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iBFoJJ84"
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-aa68952272bso293259366b.2
        for <linux-hardening@vger.kernel.org>; Sat, 21 Dec 2024 03:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734779197; x=1735383997; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9c9a3iVDE+5v7pmjMQqm1QHn7yy3OkjMxC3jrRl0psE=;
        b=iBFoJJ84n5IQypwq8a/T71FT6GZVYCc9/8mCJxdbLwJPQe6qv3oRACTg+TLLnb1u1W
         TjD3URVnBjlrYwM3xSQ3oOLFIz4mY+DLv/h2KSQthbm4vwTQDGQNo8CkpDKI6TsDqEX3
         G6tEplwCceNHi0VRx9NKkuM0d1TwvWcSrjbvdBiHxcsIqztdfu2uYGM0Ta43CWVQmcAI
         o3IFnSyn7h997ycaiIsxRHecnGRskJk351yaqR0tqhTfTAYj4O0ewW/eX/rKsCXZUQne
         uIF/WRDXHFUv3o7UcUREJ26aPRF85Gvxl4DAzPS5W+5/2STi/cE0WSCUsAWIVs777T+y
         HH5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734779197; x=1735383997;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9c9a3iVDE+5v7pmjMQqm1QHn7yy3OkjMxC3jrRl0psE=;
        b=ltv5miN4lodTYizLY4Zeo2BRmmnNm/UfnfXIngFrhU3XrS2V9Cg118wdUkG+MD12Yd
         1ZetDWgCMJya9WofiOGdT5hSCAkVkJlSY7rqxtgFtPr3m0B+JBanlN87VCmOHGOCO95u
         7Ju2OWdoxP+M0OgCUZquf42vo9jKmna6JmIqYqyefaRGSpISDfw/42+sSQBCyGrc+7rx
         HNQ1/GhVVTpLP0wBHR/K4Z/7qROK5cdHPr/MnUQkIvHL54TeZzGCQyaak9t86wx5V56d
         lLmzHi5EdTecQ3ZBtz1qEojAJwOyX1qy5spVwG3F7wwIOGtFN8052IFd7kjCi0XtjAIN
         2lkg==
X-Forwarded-Encrypted: i=1; AJvYcCU9cC/hTbsgSSpJ0/HofevYmLSAlP+9Oy6L/4pIpr0r8QzG/AYGdNYMx+NHd5ujX2HczDXjo+NK1wfsrx97QK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMnNlef6KGmFSbMNN/7fo3fZsTFVlsfmyWLLWL3vGU/OpdHZGu
	v52TPga4Z3MEF6B8x50svGeArIDHaL4UXTay7x9RwCCvc5LAeYsReFYEvHDFOoMAbEa6f6MpVCw
	2zg==
X-Google-Smtp-Source: AGHT+IEToD+6DqkOSrJAGdf3lwcpFc2nJisfO7vLafkdBubYriBDAdyrh0akWL0n3H+qY6NTTVgq7uQb4Ik=
X-Received: from ejcvw10.prod.google.com ([2002:a17:907:a70a:b0:aa6:9dde:9b22])
 (user=gnoack job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:2dab:b0:aa6:aa8e:c89c
 with SMTP id a640c23a62f3a-aac335626acmr489665766b.39.1734779197235; Sat, 21
 Dec 2024 03:06:37 -0800 (PST)
Date: Sat, 21 Dec 2024 12:06:35 +0100
In-Reply-To: <Z2BKetPygDM36X-X@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2024121418-blazer-valiant-c51a@gregkh> <20241216150722.4079213-2-gnoack@google.com>
 <2024121653-unblessed-mummified-c630@gregkh> <Z2BKetPygDM36X-X@google.com>
Message-ID: <Z2ahOy7XaflrfCMw@google.com>
Subject: Re: [PATCH] tty: Permit some TIOCL_SETSEL modes without CAP_SYS_ADMIN
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jann Horn <jannh@google.com>, "Hanno =?utf-8?B?QsO2Y2s=?=" <hanno@hboeck.de>, Jiri Slaby <jirislaby@kernel.org>, 
	linux-hardening@vger.kernel.org, regressions@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello Greg, Hanno and everyone else!

On Mon, Dec 16, 2024 at 04:42:50PM +0100, G=C3=BCnther Noack wrote:
> On Mon, Dec 16, 2024 at 04:17:15PM +0100, Greg Kroah-Hartman wrote:
> > On Mon, Dec 16, 2024 at 03:07:23PM +0000, G=C3=BCnther Noack wrote:
> > > With this, processes without CAP_SYS_ADMIN are able to use TIOCLINUX =
with
> > > subcode TIOCL_SETSEL, in the selection modes TIOCL_SETPOINTER,
> > > TIOCL_SELCLEAR and TIOCL_SELMOUSEREPORT.
> > >=20
> > > TIOCL_SETSEL was previously changed to require CAP_SYS_ADMIN, as this=
 IOCTL
> > > let callers change the selection buffer and could be used to simulate
> > > keypresses.  These three TIOCL_SETSEL selection modes, however, are s=
afe to
> > > use, as they do not modify the selection buffer.
> > >=20
> > > This fixes a mouse support regression that affected Emacs (invisible =
mouse
> > > cursor).
> > >=20
> > > Link: https://lore.kernel.org/r/ee3ec63269b43b34e1c90dd8c9743bf8@find=
er.org
> > > Fixes: 8d1b43f6a6df ("tty: Restrict access to TIOCLINUX' copy-and-pas=
te subcommands")
> > > Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
> > > ---
> > >  drivers/tty/vt/selection.c | 14 ++++++++++++++
> > >  drivers/tty/vt/vt.c        |  3 +--
> > >  2 files changed, 15 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/drivers/tty/vt/selection.c b/drivers/tty/vt/selection.c
> > > index 564341f1a74f..0bd6544e30a6 100644
> > > --- a/drivers/tty/vt/selection.c
> > > +++ b/drivers/tty/vt/selection.c
> > > @@ -192,6 +192,20 @@ int set_selection_user(const struct tiocl_select=
ion __user *sel,
> > >  	if (copy_from_user(&v, sel, sizeof(*sel)))
> > >  		return -EFAULT;
> > > =20
> > > +	/*
> > > +	 * TIOCL_SELCLEAR, TIOCL_SELPOINTER and TIOCL_SELMOUSEREPORT are OK=
 to
> > > +	 * use without CAP_SYS_ADMIN as they do not modify the selection.
> > > +	 */
> > > +	switch (v.sel_mode) {
> > > +	case TIOCL_SELCLEAR:
> > > +	case TIOCL_SELPOINTER:
> > > +	case TIOCL_SELMOUSEREPORT:
> > > +		break;
> > > +	default:
> > > +		if (!capable(CAP_SYS_ADMIN))
> > > +			return -EPERM;
> > > +	}
> >=20
> > Shouldn't you check this _before_ doing the copy_from_user() to emulate
> > the previous logic properly?
>=20
> You are right, I believe this can technically return a different error co=
de.
>=20
> There is a data dependency between the two though - the capability check =
should
> only happen for certain values of v.sel_mode, and v is only populated by
> copy_from_user().
>=20
> As far as I can tell, this only makes a difference in scenarios where bot=
h
> copy_from_user() and the capability check would fail.
>=20
> Do you think we have to emulate it down to this level of detail?

Another observation which makes it clearer that copy_from_user() failing he=
re
should really not happen in practice:

The 'argp' pointer that gets passed to ioctl(2) here is a pointer to a regi=
on in
memory whose first byte is a TIOCLINUX subcommand, and at the time we do th=
e
copy_from_user(), this subcommand byte has already been successfully copied=
 over
from user space.  The region that we are now copying with copy_from_user() =
here
is directly after this byte, and should under normal circumstances work as =
well
-- I believe that callers would have to construct a specifically crafted io=
ctl()
so that the first copy-from-userspace works and the second one fails (refer=
ring
to a byte just before a page boundary, or something like that...?)

I'll send a V2 of this patch with the comment removed, the 'Cc: stable' add=
ed,
but where the CAP_SYS_ADMIN check is still done after copy_from_user(), wit=
h the
reasoning that:

 1. A previous get_user() from an adjacent memory region already worked
    (making this a very unlikely failure)
 2. I do not see a good alternative to reorder the code here, because we ne=
ed
    the data from copy_from_user() in order to know whether the CAP_SYS_ADM=
IN
    check even needs to be performed.

Hanno: If you are OK with this patch, I'd still appreciate a more formal
"Reviewed-By" or "Tested-By" from you. :)

Thanks, and Happy Holidays!
=E2=80=94G=C3=BCnther
