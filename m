Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2110835839E
	for <linux-hardening@vger.kernel.org>; Thu, 11 Jun 2026 08:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781165918; cv=none; b=L72VBlomdctU/jM9yfFOl2RqNAOUWGa3PyMevonumpaxoDpuq6nkOnsdxoZSb335Bt17fw3GeUQIpkzJPewUQc5DUL5MlImfUXwPa/p9fCtyBsT+1qm+Ah9Y0y3ObdXqTVaJ2CEReClHgOvEhvLhVqH9ml4ddOQ5OAXwvEwjnB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781165918; c=relaxed/simple;
	bh=6+ksKy5zPk4CILJZnwTvpNz73zdQB5qY3mEJNmKTBpk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VBYBr0iWDQksy5UrvvS9UPGpRpDx4Ujsn0mtRezo0/MB2vlh461BQkNUKZEGmUOEyVJwR65qaoVhOh6tzbrrXLNZFQ85hzcPpO/2J/XfcrC9OVPhNpWhJpxGFVVF4vlLcLJrkhXRNiOXCz6BqFLQNBpdWJvyOw0sOcamkUOWwZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mz2KnAAi; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mz2KnAAi"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so35794105e9.1
        for <linux-hardening@vger.kernel.org>; Thu, 11 Jun 2026 01:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781165915; x=1781770715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gsqcA8bl0x+k9KH1B+UP0lOaoLno/FKA+FsmWqRpnNQ=;
        b=Mz2KnAAikjbyAVmnpWJGSctjWHZXXOLOqnlMBjmlRG2HHNQ2VYPv8S/UO2YOovTck6
         2fK3yc3HyPEiqCp7aCSLqneLJJNFuAqV+KT8mlzpGe+AvonD7dZJcE9Frm4ETGxSoZfp
         rEoGbxqn0UKOJTPpGioX2nvir+2X7MaQiCcM1AfGpb3brs3nhr0NeykkOrC4ct58//Lt
         lA0Ada1qm6wNancovnQ0N3L+KIsA/blAkCQB/Vr0teAl9ASvN64+UkKnbY4ys777AafR
         qnots8pWtAki/iyQWMDfd6bsSEf+7HBtXzitvty1SvQaAlysrd90zEppFVOBSiXzspno
         Lz6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781165915; x=1781770715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gsqcA8bl0x+k9KH1B+UP0lOaoLno/FKA+FsmWqRpnNQ=;
        b=HX4OaH+hw7rD5sY+t0p3y4h8LPTdN7bVSuheG63cp68rnYTeaDMs6v7pelSVvD2/Va
         w9i6ZMJ56FLhfGWpGhbOOFjS6JoVg9KS2PJQVMOAk3INcwJhRXvKfG6bdAxOubHWNrrq
         OjUb5ge9jNv99X3jalVY6QaSot58AHjDxCy2V2Srd0AAv7fAWr/tLY1KpH4MCMM/74hW
         dANyN3N4IkVOHeBi8MtEeedGv9U7fDmGjuRB0sZ/sPvq2Qrhv70/d73Iq2ksfYyOrxid
         Ztmd9V6qlxFpegiJoExj6YiMSqzYlX+oa1R7zZD4GSdlbwD2jzJXXNrAnF2VEWs6mE9E
         f5vA==
X-Forwarded-Encrypted: i=1; AFNElJ+RqFVK0IfaYYX2NutQW9puEaipioT6R0OgaUGpqBIcT3el4kQb8I0YVRELPTX3FsawC2Z/i5g+fDtOi8vYkbk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbFSpjqDSkxDccbCml2F9Q5Mf94OMDJLoIslOz4oTynXl0i7mr
	dpi1ZG3Bp37BtRRyKaVhlgL1NrN82EaAQj1gLcWJ6VMn0zV75eqdPssY
X-Gm-Gg: Acq92OFbT2zJk2SQx9PbI7q4MDztlfn2gKbiIROg/n5ZkM4M1Phv6TWGh6gOMkbj7Yi
	Ff15PAD9xTwtCogsw+hJO3TlItbQDzO7wg2JmqEWEGEM548LNmw+9yYCtgvJ7e41T8aHZu/hHCM
	1Q8ZPWk4s66Vf2kXZxB4cJ7IJ4szV2JCXtt5kZENRnRDskBtVdhKyJN5XqS7Jh9QgwyQEMPdYNK
	DUpBg17avEd4EHzHstDXhn9fiatxD8ZppjrdCAeer0fyktqnHV2svXgoSAqIott6dvlmV94y/rt
	JHEje1KLC2+sg94cX0kcIwWa3E7z3kuD9vdoRgytSlHYe06ClZuB61oOmWuPYmtc3x1mJWXhvsp
	cNrgyybOueOzUMMhhSEilu0iY+icqMe43bKkyHuh4gNNXIC67c5m6fLC8MIq7ZOfOqzuYfBNYIn
	cLQblyRCT6wTpcx7ueJY9bAbu/dCHisHi2QUZaHFL07MI35qicLMYByi+3O1u3NnvR80pzGNI=
X-Received: by 2002:a05:600c:4452:b0:490:e18f:d112 with SMTP id 5b1f17b1804b1-490e56043e2mr20472375e9.21.1781165915470;
        Thu, 11 Jun 2026 01:18:35 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490e52b3970sm29913375e9.8.2026.06.11.01.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 01:18:34 -0700 (PDT)
Date: Thu, 11 Jun 2026 09:18:33 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann
 <arnd@kernel.org>, John Paul Adrian Glaubitz 
 <glaubitz@physik.fu-berlin.de>, Yangtao Li <frank.li@vivo.com>
Subject: Re: [PATCH next] fs/hfsplus/xattr: Use memcpy() and strscpy() to
 build xattr_name
Message-ID: <20260611091833.02ac2b6d@pumpkin>
In-Reply-To: <2543b22369ec19dae397963fbdf2e7181c7419a8.camel@dubeyko.com>
References: <20260608095523.2606-39-david.laight.linux@gmail.com>
	<2543b22369ec19dae397963fbdf2e7181c7419a8.camel@dubeyko.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 10 Jun 2026 20:50:33 -0700
Viacheslav Dubeyko <slava@dubeyko.com> wrote:

> On Mon, 2026-06-08 at 10:55 +0100, david.laight.linux@gmail.com wrote:
> > From: David Laight <david.laight.linux@gmail.com>
> >=20
> > xattr_name is kmalloc()ed at the (assumed) maximal size and then the
> > prefix
> > and name concatenated together.
> > Use memcpy() for the prefix - its length is passed and strscpy() for
> > the
> > name to ensure it really doesnt overflow.
> >=20
> > Prior to bf29e886b242c the buffers were smaller and on-stack.
> > (But I cant see the copy in the old code.)
> > I am also not sure why the buffer isnt created "just long enough".
> >=20
> > Signed-off-by: David Laight <david.laight.linux@gmail.com>
> > ---
> > This is one of a group of patches that remove potentially unbounded
> > strcpy() calls.
> >=20
> > They are mostly replaced by strscpy() or, when strlen() has just been
> > called, with memcpy() (usually including the '\0').
> >=20
> > Calls with copy string literals into arrays are left unchanged.
> > They are safe and easily detected as such.
> >=20
> > The changes were made by getting the compiler to detect the calls and
> > then fixing the code by hand.
> >=20
> > Note that all the changes are only compile tested.
> >=20
> > Some Makefiles were changed to allow files to contain strcpy().
> > As well as 'difficult to fix' files, this included 'show' functions
> > as they really need to use sysfs_emit() or seq_printf().
> >=20
> > All the patches are being sent individually to avoid very long cc
> > lists.
> > Apologies for the terse commit messages and likely unexpected tags.
> > (There are about 100 patches in total.)
> >=20
> > =C2=A0fs/hfsplus/xattr.c | 12 ++++++------
> > =C2=A01 file changed, 6 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
> > index 452a1f9becb2..0b3dd48c28c9 100644
> > --- a/fs/hfsplus/xattr.c
> > +++ b/fs/hfsplus/xattr.c
> > @@ -550,8 +550,8 @@ int hfsplus_setxattr(struct inode *inode, const
> > char *name,
> > =C2=A0	xattr_name =3D kmalloc(xattr_name_len, GFP_KERNEL);
> > =C2=A0	if (!xattr_name)
> > =C2=A0		return -ENOMEM;
> > -	strcpy(xattr_name, prefix);
> > -	strcpy(xattr_name + prefixlen, name);
> > +	memcpy(xattr_name, prefix, prefixlen); =20
>=20
> What's the point to mix memcpy and str*() family of methods? What's
> wrong with str*() method here? Otherwise, if it is wrong to use str*()
> family of methods, then why is it correct to use for second operation?

They all just copy memory...
memcpy() copies a number of bytes,
strcpy() copies up to (and including) a zero byte.
strscpy() copies up to a zero byte, but no more than the specified length
	and always zero terminates the written data.

memcpy() is always going to be faster because it doesn't need to
look at the data being copied.

>=20
> > +	strscpy(xattr_name + prefixlen, name, xattr_name_len -
> > prefixlen); =20
>=20
> Why strscpy() is better than strncpy()? What is the main argument here?

strncpy() is completely broken (but not as badly as strncat).

And, replying to the next email.
You really don't want to use kasprintf(), especially just to concatenate
two strings.

>=20
> > =C2=A0	res =3D __hfsplus_setxattr(inode, xattr_name, value, size,
> > flags);
> > =C2=A0	kfree(xattr_name);
> > =C2=A0
> > @@ -698,6 +698,7 @@ ssize_t hfsplus_getxattr(struct inode *inode,
> > const char *name,
> > =C2=A0			 void *value, size_t size,
> > =C2=A0			 const char *prefix, size_t prefixlen)
> > =C2=A0{
> > +	size_t xattr_name_len =3D NLS_MAX_CHARSET_SIZE *
> > HFSPLUS_ATTR_MAX_STRLEN + 1; =20
>=20
> Frankly speaking, it looks like a constant that should be declared in
> hfs_common.h. Even if we would like to declare it here, then it should
> be const size_t, from my point of view.

There is little point marking variables as 'const'.

>=20
> > =C2=A0	int res;
> > =C2=A0	char *xattr_name;
> > =C2=A0
> > @@ -705,13 +706,12 @@ ssize_t hfsplus_getxattr(struct inode *inode,
> > const char *name,
> > =C2=A0		inode->i_ino, name ? name : NULL,
> > =C2=A0		prefix ? prefix : NULL);
> > =C2=A0
> > -	xattr_name =3D kmalloc(NLS_MAX_CHARSET_SIZE *
> > HFSPLUS_ATTR_MAX_STRLEN + 1,
> > -			=C2=A0=C2=A0=C2=A0=C2=A0 GFP_KERNEL);
> > +	xattr_name =3D kmalloc(xattr_name_len, GFP_KERNEL); =20
>=20
> Finally, I think kzalloc() should be much better for both cases.

No point taking the cost of zeroing large amounts of memory you
aren't going to access.

	David

>=20
> Thanks,
> Slava.
>=20
> > =C2=A0	if (!xattr_name)
> > =C2=A0		return -ENOMEM;
> > =C2=A0
> > -	strcpy(xattr_name, prefix);
> > -	strcpy(xattr_name + prefixlen, name);
> > +	memcpy(xattr_name, prefix, prefixlen);
> > +	strscpy(xattr_name + prefixlen, name, xattr_name_len -
> > prefixlen);
> > =C2=A0
> > =C2=A0	res =3D __hfsplus_getxattr(inode, xattr_name, value, size);
> > =C2=A0	kfree(xattr_name); =20

