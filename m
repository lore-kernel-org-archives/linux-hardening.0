Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CCE2874E3
	for <linux-hardening@vger.kernel.org>; Fri, 12 Jun 2026 07:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781248271; cv=none; b=VJ0REf5Fiuu15gCBMzLY/Bk8MxNgfAA4fE+aPHl9ark10uJ0pPTJNXOLDClISSZZ3i3mADIqWN8cPsZiIxP5IkehibUGqZBCHm5jGSSJPputqvGZfWbSJ7dg48ZtUvTil+TtU5FB1uMMKPPDLGypCfPL++mW4XWfj31RrnqBlE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781248271; c=relaxed/simple;
	bh=kJwMKiOTWIkbsmnRbV0MMfpa6h6Sxg30U8KDY0xEkMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WGBWk46FYPQ97NDDrbmOpt5FY8k4gWywIzC/HSJ/QXMt68zRBD0JfBegYJR4LUz72/Be+732tnDWnvslfHGY9OKTts/tEKqmuQ8UK59xJgspi1K2ROgERsE/QbHmWKlnirouOduawuy8n75ItjdT2h1Uk9kfAhIvh3cR4kzq21w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a2qJVz5E; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a2qJVz5E"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-490bb83a3f6so4369275e9.0
        for <linux-hardening@vger.kernel.org>; Fri, 12 Jun 2026 00:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781248265; x=1781853065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MxxuXAanpuVJwY07nvR8f7H3W6xJwG0r4IOOF65r+BQ=;
        b=a2qJVz5Enc47ZeEMk51DXQyeRcEiaxaA5bB1OPdqiodDaCe60v4oCixyzEimWZZGzB
         hLqLikXEmi2j51EGd7p9YpsPExor34PdOZQipqlTfkfJFmKfbbPR4w5dI69jEmPdYQTb
         3R9RxoudtEmsmK701oF7HUPdqKxCRs73G/DdkMogem+QGX/EFKmWs0uGriCf4bb17IVy
         mGIJqcWE4muuBZ3UbXYdbfj5NcYV2E/7NaelRvAcTqrpFFeZtWwwhhXBZizvQD23pS8/
         cXMOlZft9KLAponiilj1tbtSYz5nnMMDueZTQQH35+sb+QM4TxNpBx6TP0lvK5btLRxK
         LXLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781248265; x=1781853065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MxxuXAanpuVJwY07nvR8f7H3W6xJwG0r4IOOF65r+BQ=;
        b=Jk9btvO1yqdLLD79ScOurCg8Nz/fXXNeOYh9vwTeBax7tY5Tlfq1KW5JEINia++YaT
         mBWpiL+eJH1/3xPHeV+rTlJ3fUefYB+nnP79XnpucZOX5rPIWS86ZtENqet2WsxWfuch
         iV/yUJwU6Rv4SSY9jGefTuQUfP43k3trQv0IJVALJdhGk0fJHE/gmgsP7uR/m9jmOkWJ
         CN94lPKF3Cp+Kdn30jYGigQ6RL3GCj54me1SEFkhAp85dfxYCpm5DgS7tibT0WPW5C66
         jlrmXzn4mWjrVYsz3NXqulfPMLXM6upBGJkUycp94T7CcTYYvZyJUzyUR75b5R9Ye0TC
         citA==
X-Forwarded-Encrypted: i=1; AFNElJ/2OQObF0CYj5XYjZAd5s39j4MGNfzJNZA2m7WpDciRV1cPv5fiXJJJXeCNEYJK+z+8YyF29+iXyMMHxWKdyK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYUfb9mHfqhyPmUdbJ/izDcq734MfMqAa2Km/+H6bw3N2AvWOY
	I+zMcHd/ga3gXvvwBNKyJoxqdd14XGgfb0jfaKtP2HTb0sujDCU8TYCnHsJtaVU1
X-Gm-Gg: Acq92OF6FKJpwlRwJLfwdUYllw7FilgELbcAuDX0jfCcXz36yArX7SkyB3umx0G/E7m
	xlkufx80cAel7voa6b0IzL1ABB5OkTx7EYU/nAJpSwKUKIavH4j7RuOcyMlzeO4mWFVYGxEB7DG
	on5fQ2qNBDyPT1jv1TaR59u11ZmQVmekk2CHGXENYlo7H8vt5lRiTID2pWYygkc8Jaaj6bMakgm
	9g0r1lSxu3+f5YDOkbSmO25ya2sP62b+gX450PjqI/g6zr281MabNNWMh3TnNxjMnayn8xd9dmj
	skYEMiZm2gO8OSx7eNAwAbjM45F8iK367A7WUmJJGkqKDUIiNacRPH64GqgVZwmEkk/XDA/2Vo8
	8srpQGkxXJY0dDZwm/lfSm0ParMVM0YA0DDVm7aFOANgaftWNF1LXj2nh85u/mXUAaanjc7LFXX
	lIq8C6P0IxvgCwOcvFUCSXFpHYf7PVPwvyf5SaNwqRFVK9sr2gcO32W8tr/a7h
X-Received: by 2002:a05:600c:1511:b0:490:ce99:d2ee with SMTP id 5b1f17b1804b1-490ec4df7b5mr8347315e9.15.1781248265147;
        Fri, 12 Jun 2026 00:11:05 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490ea83d8dasm56012075e9.11.2026.06.12.00.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 00:11:04 -0700 (PDT)
Date: Fri, 12 Jun 2026 08:11:03 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann
  <arnd@kernel.org>, John Paul Adrian Glaubitz
 <glaubitz@physik.fu-berlin.de>, Yangtao Li <frank.li@vivo.com>
Subject: Re: [PATCH next] fs/hfsplus/xattr: Use memcpy() and strscpy() to
 build xattr_name
Message-ID: <20260612081103.1676ffd8@pumpkin>
In-Reply-To: <09abf97d34d91fa2e373961babb24581a68305ac.camel@dubeyko.com>
References: <20260608095523.2606-39-david.laight.linux@gmail.com>
	<2543b22369ec19dae397963fbdf2e7181c7419a8.camel@dubeyko.com>
	<20260611091833.02ac2b6d@pumpkin>
	<09abf97d34d91fa2e373961babb24581a68305ac.camel@dubeyko.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 11 Jun 2026 21:02:05 -0700
Viacheslav Dubeyko <slava@dubeyko.com> wrote:

> On Thu, 2026-06-11 at 09:18 +0100, David Laight wrote:
> > On Wed, 10 Jun 2026 20:50:33 -0700
> > Viacheslav Dubeyko <slava@dubeyko.com> wrote:
> >  =20
> > > On Mon, 2026-06-08 at 10:55 +0100,
> > > david.laight.linux@gmail.com=C2=A0wrote: =20
> > > > From: David Laight <david.laight.linux@gmail.com>
> > > >=20
> > > > xattr_name is kmalloc()ed at the (assumed) maximal size and then
> > > > the
> > > > prefix
> > > > and name concatenated together.
> > > > Use memcpy() for the prefix - its length is passed and strscpy()
> > > > for
> > > > the
> > > > name to ensure it really doesnt overflow.
> > > >=20
> > > > Prior to bf29e886b242c the buffers were smaller and on-stack.
> > > > (But I cant see the copy in the old code.)
> > > > I am also not sure why the buffer isnt created "just long
> > > > enough".
> > > >=20
> > > > Signed-off-by: David Laight <david.laight.linux@gmail.com>
> > > > ---
> > > > This is one of a group of patches that remove potentially
> > > > unbounded
> > > > strcpy() calls.
> > > >=20
> > > > They are mostly replaced by strscpy() or, when strlen() has just
> > > > been
> > > > called, with memcpy() (usually including the '\0').
> > > >=20
> > > > Calls with copy string literals into arrays are left unchanged.
> > > > They are safe and easily detected as such.
> > > >=20
> > > > The changes were made by getting the compiler to detect the calls
> > > > and
> > > > then fixing the code by hand.
> > > >=20
> > > > Note that all the changes are only compile tested.
> > > >=20
> > > > Some Makefiles were changed to allow files to contain strcpy().
> > > > As well as 'difficult to fix' files, this included 'show'
> > > > functions
> > > > as they really need to use sysfs_emit() or seq_printf().
> > > >=20
> > > > All the patches are being sent individually to avoid very long cc
> > > > lists.
> > > > Apologies for the terse commit messages and likely unexpected
> > > > tags.
> > > > (There are about 100 patches in total.)
> > > >=20
> > > > =C2=A0fs/hfsplus/xattr.c | 12 ++++++------
> > > > =C2=A01 file changed, 6 insertions(+), 6 deletions(-)
> > > >=20
> > > > diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
> > > > index 452a1f9becb2..0b3dd48c28c9 100644
> > > > --- a/fs/hfsplus/xattr.c
> > > > +++ b/fs/hfsplus/xattr.c
> > > > @@ -550,8 +550,8 @@ int hfsplus_setxattr(struct inode *inode,
> > > > const
> > > > char *name,
> > > > =C2=A0	xattr_name =3D kmalloc(xattr_name_len, GFP_KERNEL);
> > > > =C2=A0	if (!xattr_name)
> > > > =C2=A0		return -ENOMEM;
> > > > -	strcpy(xattr_name, prefix);
> > > > -	strcpy(xattr_name + prefixlen, name);
> > > > +	memcpy(xattr_name, prefix, prefixlen);=C2=A0  =20
> > >=20
> > > What's the point to mix memcpy and str*() family of methods? What's
> > > wrong with str*() method here? Otherwise, if it is wrong to use
> > > str*()
> > > family of methods, then why is it correct to use for second
> > > operation? =20
> >=20
> > They all just copy memory...
> > memcpy() copies a number of bytes,
> > strcpy() copies up to (and including) a zero byte.
> > strscpy() copies up to a zero byte, but no more than the specified
> > length
> > 	and always zero terminates the written data.
> >=20
> > memcpy() is always going to be faster because it doesn't need to
> > look at the data being copied. =20
>=20
> You need to take into account that it is Unicode based symbols. I
> dislike to use memcpy() because prefixlen is only number of symbols but
> not size in bytes.
>=20
> Frankly speaking, I dislike your approach in this patch. It is not safe
> enough.

The code relies on prefixlen being the number of bytes.
It is the size used for the kmalloc().
The current strcpy() (for the prefix) relies on the caller passing
in the correct size that matches the length.

Although the strings are Unicode it doesn't really matter here at all.
They are UTF-8 encoded which means they can be processed as normal
'\0' terminated C strings.
The only difficulty is that the length of the C string can be much
longer than the number of Unicode characters.
Provided you make the use the lengths of the '\0' terminated strings
everything is fine - which is what the change does.

The existing code just hopes that no one manages to pass in a string
that is too long for the buffer.
Maybe it shouldn't happen - but any test is way earlier in the function
call stack.
If there is a bug somewhere you've got a heap overrun.

You really do need to ensure that the copies use exactly the same
lengths that were used for the kmalloc().

There is also the possibility that the strings can get changed by
another thread (maybe you can prove it doesn't happen here, but it
really is better to be safe) so you really need to only calculate
the length once, strlen() shouldn't be followed by strcpy().
For absolute safety you need to use memcpy() and then write in the
terminating '\0'.

	David

>=20
> >  =20
> > >  =20
> > > > +	strscpy(xattr_name + prefixlen, name, xattr_name_len -
> > > > prefixlen);=C2=A0  =20
> > >=20
> > > Why strscpy() is better than strncpy()? What is the main argument
> > > here? =20
> >=20
> > strncpy() is completely broken (but not as badly as strncat).
> >=20
> > And, replying to the next email.
> > You really don't want to use kasprintf(), especially just to
> > concatenate
> > two strings.
> >  =20
> > >  =20
> > > > =C2=A0	res =3D __hfsplus_setxattr(inode, xattr_name, value, size,
> > > > flags);
> > > > =C2=A0	kfree(xattr_name);
> > > > =C2=A0
> > > > @@ -698,6 +698,7 @@ ssize_t hfsplus_getxattr(struct inode *inode,
> > > > const char *name,
> > > > =C2=A0			 void *value, size_t size,
> > > > =C2=A0			 const char *prefix, size_t prefixlen)
> > > > =C2=A0{
> > > > +	size_t xattr_name_len =3D NLS_MAX_CHARSET_SIZE *
> > > > HFSPLUS_ATTR_MAX_STRLEN + 1;=C2=A0  =20
> > >=20
> > > Frankly speaking, it looks like a constant that should be declared
> > > in
> > > hfs_common.h. Even if we would like to declare it here, then it
> > > should
> > > be const size_t, from my point of view. =20
> >=20
> > There is little point marking variables as 'const'. =20
>=20
> This is why I am talking about declaration in hfs_common.h.
>=20
> >  =20
> > >  =20
> > > > =C2=A0	int res;
> > > > =C2=A0	char *xattr_name;
> > > > =C2=A0
> > > > @@ -705,13 +706,12 @@ ssize_t hfsplus_getxattr(struct inode
> > > > *inode,
> > > > const char *name,
> > > > =C2=A0		inode->i_ino, name ? name : NULL,
> > > > =C2=A0		prefix ? prefix : NULL);
> > > > =C2=A0
> > > > -	xattr_name =3D kmalloc(NLS_MAX_CHARSET_SIZE *
> > > > HFSPLUS_ATTR_MAX_STRLEN + 1,
> > > > -			=C2=A0=C2=A0=C2=A0=C2=A0 GFP_KERNEL);
> > > > +	xattr_name =3D kmalloc(xattr_name_len, GFP_KERNEL);=C2=A0  =20
> > >=20
> > > Finally, I think kzalloc() should be much better for both cases. =20
> >=20
> > No point taking the cost of zeroing large amounts of memory you
> > aren't going to access. =20
>=20
> What do you mean by huge? It's only 127 symbol in maximum. It's pretty
> nothing.
>=20
> Thanks,
> Slava.

