Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA061494B2
	for <linux-hardening@vger.kernel.org>; Mon, 16 Dec 2024 15:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734363775; cv=none; b=bHF4bWCeTJdP69fDQbC5z/l081LfI34bMbDL115kl30eoaYX9rrZ1eSEDcI+UgdUeLe0j7uMyiN6bDeKi6PMEgrIOiDyjjcwNgyhlOMNi7NDm6F0TSTlkzxsyrPW/aAbzTmlvK8XA5KDNrN7q1pIEI/ipy8rN8B/ADrBdsjykNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734363775; c=relaxed/simple;
	bh=eMMn65xwm4dD/xAdLn9gKjV0SsQ8nbUdBJWkRou7Isc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Eml81ZbXhfU29NB4Keg12G+NHuefiYjxGEmJPzUu4FBnvDdHC/kUtsFneipb26SZwQ7DtgJ6BhoMOy0t5P2Bzm/j5x/8bSNB6KXo5XvNDGvrOmq/UxI58pouWWZuZQ/lZ2ayVgoFm56cehNBc+vBtSmKGHfrNztra92kVolbsz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XqGiX+Gz; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XqGiX+Gz"
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-aa66bc3b46dso329734366b.3
        for <linux-hardening@vger.kernel.org>; Mon, 16 Dec 2024 07:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734363772; x=1734968572; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XHBbj5S9UT6s3cvDeZW+WmfAzA4JgRXAeW+4cg5L7G8=;
        b=XqGiX+Gz8biOSzTDhASdY+TaCvcVEmwA7QZ4kpJvnqBPY93soLIMksQzs3uTZwmRZo
         2vxAvEdhYvcih/MoTIwoIceL+l4lEj/q6w5VYQv0cpgUS0YsE/hslGNHinyViMqji9Ze
         l71KdhROWx5k6JQ4ZmE7pxld04y355C1bgw3Yd5lhHX+04kdIty3JUhzSKhgKt+IQW81
         Dj71FQUlwyTYj65KxLPtPXkxFw+BznC/mabY8n3KS/bbJbAzqMPuOyfXJ5pmQGypQd+P
         YN4niDxoiCHPCI792m4bnAqB2BQxufPYjVjUDUEo30uHKEryUuphn/fBtRtr2CqnDMY3
         8WuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734363772; x=1734968572;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XHBbj5S9UT6s3cvDeZW+WmfAzA4JgRXAeW+4cg5L7G8=;
        b=vUqyWsQm5xOElil08Mr9Yj/XHeN7HE+vWdxQ13+tTNEEUVtIjsZlu5H+g9caP1L3I+
         psDCVmxmKgY4esLK0nh0AN23dZxYb5JYq27k8N7G6TmQTp4n0S1a4WCtmZNMHz1xFBb3
         PAK2A1AZrj9nbwHK5IJRPW7z4AXofavm+XTa1+XkmhxIvXGLGR4QCzHWWyV95g8igwfe
         E+v2UAtcbmZ8hMf++Wab4XqGbC2l0EsTzWCHfipoVGt6QxvfA+tjo7dOOxL3yoUiaY/G
         9Ki0DRhjkGKkeYwHmig+hagU7YYslIMs6GeHwKaPagW5H3ay4dZWnXIg3ywAziQPOl8u
         0Ykw==
X-Forwarded-Encrypted: i=1; AJvYcCV1Ozfs08otvDbyOYI4qRDY0pAH93ZcgH1l7RAc+i8FElaaotIYo2PpnyZjOY2Au9ctIjzzw5Cn324Aio4XJJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6vr10DcGmKYgowtXQcuh1oAiEoaHpEtpJDEEvpUtYodlntV2N
	phS8zkcav3sLkxzQ7S+/8PnUIOtTgWyyx48ZW+36eXRUw6MlyWChZ4RP1LZMXY+LWhBPV6yFWol
	hvg==
X-Google-Smtp-Source: AGHT+IEvwXRrJ0+fa0U2GbRoAPbJ3JzjYjdBqCukKbZUpFxMjfFCZNl882cgyP5mMr8ZRoTCv2E7CFLm3os=
X-Received: from edrl20.prod.google.com ([2002:aa7:c3d4:0:b0:5d1:58a5:ef17])
 (user=gnoack job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:2398:b0:5d6:688d:b683
 with SMTP id 4fb4d7f45d1cf-5d6688db9aamr10240026a12.9.1734363772620; Mon, 16
 Dec 2024 07:42:52 -0800 (PST)
Date: Mon, 16 Dec 2024 16:42:50 +0100
In-Reply-To: <2024121653-unblessed-mummified-c630@gregkh>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2024121418-blazer-valiant-c51a@gregkh> <20241216150722.4079213-2-gnoack@google.com>
 <2024121653-unblessed-mummified-c630@gregkh>
Message-ID: <Z2BKetPygDM36X-X@google.com>
Subject: Re: [PATCH] tty: Permit some TIOCL_SETSEL modes without CAP_SYS_ADMIN
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jann Horn <jannh@google.com>, "Hanno =?utf-8?B?QsO2Y2s=?=" <hanno@hboeck.de>, Jiri Slaby <jirislaby@kernel.org>, 
	linux-hardening@vger.kernel.org, regressions@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello!

On Mon, Dec 16, 2024 at 04:17:15PM +0100, Greg Kroah-Hartman wrote:
> On Mon, Dec 16, 2024 at 03:07:23PM +0000, G=C3=BCnther Noack wrote:
> > With this, processes without CAP_SYS_ADMIN are able to use TIOCLINUX wi=
th
> > subcode TIOCL_SETSEL, in the selection modes TIOCL_SETPOINTER,
> > TIOCL_SELCLEAR and TIOCL_SELMOUSEREPORT.
> >=20
> > TIOCL_SETSEL was previously changed to require CAP_SYS_ADMIN, as this I=
OCTL
> > let callers change the selection buffer and could be used to simulate
> > keypresses.  These three TIOCL_SETSEL selection modes, however, are saf=
e to
> > use, as they do not modify the selection buffer.
> >=20
> > This fixes a mouse support regression that affected Emacs (invisible mo=
use
> > cursor).
> >=20
> > Link: https://lore.kernel.org/r/ee3ec63269b43b34e1c90dd8c9743bf8@finder=
.org
> > Fixes: 8d1b43f6a6df ("tty: Restrict access to TIOCLINUX' copy-and-paste=
 subcommands")
> > Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
> > ---
> >  drivers/tty/vt/selection.c | 14 ++++++++++++++
> >  drivers/tty/vt/vt.c        |  3 +--
> >  2 files changed, 15 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/tty/vt/selection.c b/drivers/tty/vt/selection.c
> > index 564341f1a74f..0bd6544e30a6 100644
> > --- a/drivers/tty/vt/selection.c
> > +++ b/drivers/tty/vt/selection.c
> > @@ -192,6 +192,20 @@ int set_selection_user(const struct tiocl_selectio=
n __user *sel,
> >  	if (copy_from_user(&v, sel, sizeof(*sel)))
> >  		return -EFAULT;
> > =20
> > +	/*
> > +	 * TIOCL_SELCLEAR, TIOCL_SELPOINTER and TIOCL_SELMOUSEREPORT are OK t=
o
> > +	 * use without CAP_SYS_ADMIN as they do not modify the selection.
> > +	 */
> > +	switch (v.sel_mode) {
> > +	case TIOCL_SELCLEAR:
> > +	case TIOCL_SELPOINTER:
> > +	case TIOCL_SELMOUSEREPORT:
> > +		break;
> > +	default:
> > +		if (!capable(CAP_SYS_ADMIN))
> > +			return -EPERM;
> > +	}
>=20
> Shouldn't you check this _before_ doing the copy_from_user() to emulate
> the previous logic properly?

You are right, I believe this can technically return a different error code=
.

There is a data dependency between the two though - the capability check sh=
ould
only happen for certain values of v.sel_mode, and v is only populated by
copy_from_user().

As far as I can tell, this only makes a difference in scenarios where both
copy_from_user() and the capability check would fail.

Do you think we have to emulate it down to this level of detail?


As background, we have only introduced the CAP_SYS_ADMIN check recently in
8d1b43f6a6df ("tty: Restrict access to TIOCLINUX' copy-and-paste subcommand=
s")
The patch landed in Linux 6.7 and was discussed in
https://lore.kernel.org/all/20230828164117.3608812-1-gnoack@google.com/.

I suspect that existing callers of the TIOCL_SETSEL IOCTL are probably all
written at a time before the capability check existed.  ((a) These IOCTLs a=
re
used for the console mouse support, and (b) these "modes" for the TIOCL_SET=
SEL
subcode for the TIOCLINUX IOCTL are not documented in the man page either.)

>=20
> > +
> >  	return set_selection_kernel(&v, tty);
> >  }
> > =20
> > diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> > index 96842ce817af..ed65b3b80fbd 100644
> > --- a/drivers/tty/vt/vt.c
> > +++ b/drivers/tty/vt/vt.c
> > @@ -3345,8 +3345,7 @@ int tioclinux(struct tty_struct *tty, unsigned lo=
ng arg)
> > =20
> >  	switch (type) {
> >  	case TIOCL_SETSEL:
> > -		if (!capable(CAP_SYS_ADMIN))
> > -			return -EPERM;
> > +		/* CAP_SYS_ADMIN check happens in set_selection_user(). */
>=20
> No need to mention this here, it's obvious in the function itself.

OK, thanks.  I will remove it in the next version.

=E2=80=94G=C3=BCnther
