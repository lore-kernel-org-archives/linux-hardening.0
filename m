Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD1540803D
	for <linux-hardening@vger.kernel.org>; Tue, 16 Jun 2026 07:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781596293; cv=none; b=okcmesnAvPbQ0YQDP7KpluZ34UHkD0f0XGYpSYKBVx7H+dLAWyR44V4ecmqMByAZLDTaTUAfkAVPrMfHtX0NxPHzUPsgZVndebljDF7+EjowJXDkvM/J455G/dvilunXZpE/oEab7ByMToTt5pB+aVUUH3rwYT3cKJrGdwgoqmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781596293; c=relaxed/simple;
	bh=RziPevZjm3z1eK2jSastK/VakUqZvqN7tlSiqdnOdKc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bSKAsb8U3pA5LRIf1CrOIKQpYANTrNufz/BKoxSAHeH5ncDSnCsTMnRq8/6CKGCDDj/SrRetFAY+MdlBG/bZ/L9/UH7rrSFmP15HKcLYa9O87awo2zajpS45EHAEIhGeXLt14B4bOaxUTYpMzVTd6YYJdndh8rWi+/7W5lRoq8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MXzYD4bW; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MXzYD4bW"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490b211ee6aso31560955e9.3
        for <linux-hardening@vger.kernel.org>; Tue, 16 Jun 2026 00:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781596290; x=1782201090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y5/NsOrzzl/d9TsugSUWPekYDst5Pv+qw6Cf0EjCiuo=;
        b=MXzYD4bWxd15RyjC/kAgi9yG89Hyy4FF4c4Zt5BpX4DP66RPI6myhVQ0F0QUPbiDpp
         pXH71rc43EPXJm9lC7Ba+519DJ5BhbrVPxu16P91wzwly/QylGJbJBFN6nPT5wxhPeBi
         VNya51vYaR46LTw6fNilXC6Zy4WR9iVsPQpeiyRVPBCiU3+AQaxvr7g89MCQsd9J6ZOx
         d+irg2Bg3/zxui2/Wu42F+NsJlVXush/E6WmT508VylWA1pyy7lUL3S87VHYeyJxHML0
         pvx8+W7OQomOGQTWO4aoQF9bsMPeAqPmPCdt+V1OQrQWa+LlkjUWpQdepE52P6qGtZRL
         rPCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781596290; x=1782201090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y5/NsOrzzl/d9TsugSUWPekYDst5Pv+qw6Cf0EjCiuo=;
        b=B4DsuULrgwF9AvVUVhS1OgIiwHgpyIARfXGBAWGO3Dxb8FLCeM1aIqK9Ebcbd5Pjmd
         Zpws2IjfniRPzTGy6/9OmtTQwqCr3S3UfS9eMnjvRZ4ibTBdUVhX4M/8GF0Vd4RaYl0U
         W1efC1mu8JMD/6nqfSESQ5960n+zrVP2M5p8jrGNvQf5L7sefgJ+0yL82B9YOK+i3fgU
         2zkr+MXLwqJzrDjQvxjVxcEdQGigx320xSgheGqU8j2AstLe05lQa3BcrqRj1KbBBHQu
         ip5KS3ON/XeG8ZuDGo+/oZBTlhKieEbtb8S+o9jRNVY8mqlekeVcQFyNoABLXi6tOEza
         0FqA==
X-Forwarded-Encrypted: i=1; AFNElJ9ssn3bLx9HWJVG4VeLHY0NfU/ZDmj0zAVFGuwaU5TYqOB37BN+aW+75nV4f54V8VPY0Ne+CoFhdQ4H/Q0QgMU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4Z6LIF7kgaRlT28hXaflTZxwtMUmLhMG6hvav7fMGpUdpaqaW
	QZ/j+lKwd1/6LLpT5ZATZXe+5qw8p7XAi8IKDK+AfGnal7NLonkm4PRs
X-Gm-Gg: Acq92OE0Toa6CQ+Smjp0EY8gtPlbOvatb9S4gyRiYI7q18TsFj7GwfaIA5Tj7TvmAXT
	h0oEaODqz7ZLspJdaABiJD0Yi7cIUnCdQQ0u9rlUR7pFULZCI6pPmeEN11iYy8IsUZzRC5le3EJ
	Z1EZgOav0nqZbC3KcqwoWXF25LHBTsss7kwmI4JFJGGTu/nseXVpQ6usB55Wc9L7JIzXYnV/cfj
	f57AvJlvQr0Lr+43KnjlWpSrNbqtVeLIRvYkRbSNAeh8NeGXm4RyLcGfzzeSl++XCUFzFi6dtTG
	AR0nYkvLtVC2/OG0F9zOOE7ROVysr9B7+AloHADApYERPbMZythozUA7t6m17XKXCrQ7CVDh8Em
	Ft9MJFxQcnjzC4iWE1LzsQafyGPlUg5DOnyZUCB75l/JHeLBbI9505/s+PlWkmODckfvnbu6HSA
	JB/hPl3UZNwpFp4dQNGswTilNAhW0igJTZThezGCT9//ghK4s9lQlD80ZVFsAN
X-Received: by 2002:a05:600c:c04b:20b0:490:e1a6:25d with SMTP id 5b1f17b1804b1-4922ff9b097mr30479925e9.26.1781596289395;
        Tue, 16 Jun 2026 00:51:29 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49230a8eb30sm33223295e9.10.2026.06.16.00.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 00:51:29 -0700 (PDT)
Date: Tue, 16 Jun 2026 08:51:27 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Kees Cook <kees@kernel.org>,
 linux-hardening@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>, John Paul
 Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Yangtao Li
 <frank.li@vivo.com>
Subject: Re: [PATCH next] fs/hfsplus/xattr: Use memcpy() and strscpy() to
 build xattr_name
Message-ID: <20260616085127.3b11d855@pumpkin>
In-Reply-To: <ba59fcb77c31c1848d4a7f52e87829711b747567.camel@dubeyko.com>
References: <20260608095523.2606-39-david.laight.linux@gmail.com>
	<2543b22369ec19dae397963fbdf2e7181c7419a8.camel@dubeyko.com>
	<20260611041845.GC6060@frogsfrogsfrogs>
	<ba59fcb77c31c1848d4a7f52e87829711b747567.camel@dubeyko.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 15 Jun 2026 23:33:09 -0700
Viacheslav Dubeyko <slava@dubeyko.com> wrote:

> On Wed, 2026-06-10 at 21:18 -0700, Darrick J. Wong wrote:
> > On Wed, Jun 10, 2026 at 08:50:33PM -0700, Viacheslav Dubeyko wrote: =20
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
> > > > +	memcpy(xattr_name, prefix, prefixlen); =20
> > >=20
> > > What's the point to mix memcpy and str*() family of methods? What's
> > > wrong with str*() method here? Otherwise, if it is wrong to use
> > > str*()
> > > family of methods, then why is it correct to use for second
> > > operation?
> > >  =20
> > > > +	strscpy(xattr_name + prefixlen, name, xattr_name_len -
> > > > prefixlen); =20
> > >=20
> > > Why strscpy() is better than strncpy()? What is the main argument
> > > here?
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
> > > > HFSPLUS_ATTR_MAX_STRLEN + 1; =20
> > >=20
> > > Frankly speaking, it looks like a constant that should be declared
> > > in
> > > hfs_common.h. Even if we would like to declare it here, then it
> > > should
> > > be const size_t, from my point of view.
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
> > > > +	xattr_name =3D kmalloc(xattr_name_len, GFP_KERNEL); =20
> > >=20
> > > Finally, I think kzalloc() should be much better for both cases. =20
> >=20
> > kasprintf()? =20
> > >  =20
>=20
> It sounds much better than suggested fix.

If performance matters here it will be a lot slower.
The snprintf() code itself is slow and kasprintf() has to do it twice.
(As well as looking at the strings twice.)

It also only allocates a buffer that is big enough for a single
terminating '\0' - and (at least some versions) of this code zero
the rest of the buffer (possibly to avoid a bug).

One option would be something like kstrdup() that concatenates two
strings.

	David

>=20
> Thanks,
> Slava.

