Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038443D969B
	for <linux-hardening@vger.kernel.org>; Mon,  8 Jun 2026 18:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780942810; cv=none; b=FYE48x17XU7TYMu2O+1QsUdkeoRr6olm3SGagopU64Nc2MaAZnjmILl1Nk4sXrds473Y7yyvNGd9joe2ael6jos8ciSiT1ryjjjdukT1Q2SuEl1qRHmVd4sHHtPnZCMFvzjdi8Lit60F/biAq60hBrQHNo1KM5o0c7gb4MINQLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780942810; c=relaxed/simple;
	bh=uwsZ3rg1UDET6SuAP7hOzDi5eSbDRr98eL5zTg6W9wg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BBe7SoObzf0/KTMZ7cDciEVlWIN6/+w8XTw9o+keXy9LANvSpXODGPjUQ78YPzul1jXEF6b18J0+y53DXMXd8iSQ9t77xmFAKhP0YEALKhpJi06msgH8M1fWB60XU6JX6P5fA5x4gPGbh+pjwXONBeDZSTL/2nQZx9dklDmxs0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NKk9lbdl; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NKk9lbdl"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-45efa80e0afso3591209f8f.2
        for <linux-hardening@vger.kernel.org>; Mon, 08 Jun 2026 11:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780942807; x=1781547607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IM32Hg+/N9sZmZsEYWIoImVUskuRRqFje5vCWqdJGu8=;
        b=NKk9lbdl4FYAZ1zxJ6uJy2UY8xtXN/xO0sk2iK8vyc72Ornh6t3J/hiLinD5Fq9ETx
         NcccXyWqz2wkvAw9pzZFRftcEk3d3Hy7qQdHQsYC8X6kwEZZzCQJyJKD2pKjUY2WAySJ
         Q7qRPZpLdzZGStWjSMX5NcFYNDqHnyGfLTbTcZADmh9I3J36PQbfIaHUdEUdzGlzCJaf
         lH4OAPCS9SkCoI25c3w4HVUQDYZUwlKYGFo1tUnrUujYK7MJm9glmWoGwUHjPIX2Pmf8
         Fpgjl8rG9dB+2xlFN6YVx7pZQ6PwVH+8sGtoKdMCPd84PcgU01WC66cNfURwwxdLHT9v
         G8AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780942807; x=1781547607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IM32Hg+/N9sZmZsEYWIoImVUskuRRqFje5vCWqdJGu8=;
        b=a32My+gCWoP90MfNMkJ6rOcuZp7eNJHfzYLEcQfgs3uv3QXsgagD/+9+7kKBbbuikS
         GAnNrO6/FKlzTUfcFSLHEIG1h8AFApSUydU69DrIJX2nDWO8gHZ9c+POP4IEAKc0cPzW
         kckhNvok4RQHT7mIIrk70OKTGZ0khuWMMH3cZnL8g6INBlAL4eaiX4Ah2wcNRNSEGRMV
         N6Wos7W6gruHUYif4OX5eWkP/GQTMURUDMFOR2okGteRH4dskHXDosKmnCz9oCL4KB1M
         EyslVwwQzW+C2deD+y6xVPMT9DTPYgiC9kRBhFcMY5/Bng+XNJl003XMU9Gg6KUOFO/Z
         ZXmQ==
X-Forwarded-Encrypted: i=1; AFNElJ+bkqRsCYxu8k3JLl1k8y224Cw4+MtM9mYMo8hQ4+14uL0uAz7HLnMkhD3mGKYRmOqvTMCP38ud8jNI3LE2pWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvInX7NDJSfKRMvy4qzqA6zHk+sbe247R+pMp4LYGYg6Nk+FvX
	5Hb4PLSEpbKF1JQWBWUMDW9+dvmI6/V8Ms/12cwPJMfSgcj9Tt5qte4M
X-Gm-Gg: Acq92OGc9S/zJlbe9JO5JD8poYmLy1nkrgnsx24B3vAQ2hTdUk24T2iexzWaQygEY2j
	n2fyDrOqrpjlfJ/YjTI3YOgjrN2d1ayJPq4xE0RUFkl/hdvpx//piJSbs0k0jyUBzEjVNl9yEOw
	rrwp1GQExfzuRoimWpXw38I5qHp7daKoPWreuYSXCGN83gVpRSAHlFqYWiqDNZ3CwAhjqZYb9aP
	hL47T3MyqzkyhenwESgr4YMUPY8Py4rftAD+NUwQNVOOZGvyeQpcWokLyF7HljDSg/PofPzzzvu
	IR0XFTiRsUESG/dy2PwYMaraZMLoMb+PvF5/eDH+zFv5p0hHcRK/6jPbArIDGeb2Rmej3EE76zE
	if9DkY5QXoJ73QFmkj8iBTbmM2vDmoh/7Ib4H6A37Fz9ZdVEGBhnIbDvQOVfecmt8pJ3PRxoi0N
	rbCSTd9csQtgOzOYd/dB6V+toEBsrRPDULVcbbEpQVf37jcj6npP58XSxYJ92V5WJSZkHlQYmhG
	CPTgKhlMQ==
X-Received: by 2002:adf:fd04:0:b0:43b:3b80:6776 with SMTP id ffacd0b85a97d-46030751decmr20596399f8f.30.1780942807204;
        Mon, 08 Jun 2026 11:20:07 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcde3sm56294211f8f.1.2026.06.08.11.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 11:20:06 -0700 (PDT)
Date: Mon, 8 Jun 2026 19:20:04 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Rob Herring <robh@kernel.org>
Cc: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann
 <arnd@kernel.org>, Saravana Kannan <saravanak@kernel.org>
Subject: Re: [PATCH next] drivers/of/overlay: Use memcpy() to copy known
 length strings
Message-ID: <20260608192004.796f2c47@pumpkin>
In-Reply-To: <CAL_Jsq+W9HBmHFwzAROj-1LHK45WRFh2ry5-++K2YZiZj2n=ig@mail.gmail.com>
References: <20260608095523.2606-32-david.laight.linux@gmail.com>
	<CAL_Jsq+W9HBmHFwzAROj-1LHK45WRFh2ry5-++K2YZiZj2n=ig@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 8 Jun 2026 12:35:06 -0500
Rob Herring <robh@kernel.org> wrote:

> On Mon, Jun 8, 2026 at 4:55=E2=80=AFAM <david.laight.linux@gmail.com> wro=
te:
> >
> > From: David Laight <david.laight.linux@gmail.com>
> >
> > The lengths have been used for the kzalloc(), use the same ones for the=
 copy. =20
>=20
> This doesn't answer why we are doing this. Only the below which gets
> removed on commit provides the reasoning.

I will resend with an extra line (or two) of description above the ---.

(I was using -m 'text' to add the commit message and using same text for
equivalent changes to multiple files - seem to have got caught out!)

-- David

>=20
> >
> > Signed-off-by: David Laight <david.laight.linux@gmail.com>
> > ---
> > This is one of a group of patches that remove potentially unbounded
> > strcpy() calls.
> >
> > They are mostly replaced by strscpy() or, when strlen() has just been
> > called, with memcpy() (usually including the '\0').
> >
> > Calls with copy string literals into arrays are left unchanged.
> > They are safe and easily detected as such.
> >
> > The changes were made by getting the compiler to detect the calls and
> > then fixing the code by hand.
> >
> > Note that all the changes are only compile tested.
> >
> > Some Makefiles were changed to allow files to contain strcpy().
> > As well as 'difficult to fix' files, this included 'show' functions
> > as they really need to use sysfs_emit() or seq_printf().
> >
> > All the patches are being sent individually to avoid very long cc lists.
> > Apologies for the terse commit messages and likely unexpected tags.
> > (There are about 100 patches in total.)
> >
> >  drivers/of/overlay.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
> > index c1c5686fc7b1..656867009514 100644
> > --- a/drivers/of/overlay.c
> > +++ b/drivers/of/overlay.c
> > @@ -258,8 +258,8 @@ static struct property *dup_and_fixup_symbol_prop(
> >         if (!new_prop->name || !new_prop->value)
> >                 goto err_free_new_prop;
> >
> > -       strcpy(new_prop->value, target_path);
> > -       strcpy(new_prop->value + target_path_len, path_tail);
> > +       memcpy(new_prop->value, target_path, target_path_len);
> > +       memcpy(new_prop->value + target_path_len, path_tail, path_tail_=
len);
> >
> >         of_property_set_flag(new_prop, OF_DYNAMIC);
> >
> > --
> > 2.39.5
> > =20

