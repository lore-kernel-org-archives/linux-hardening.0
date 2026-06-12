Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E172EDD6C
	for <linux-hardening@vger.kernel.org>; Fri, 12 Jun 2026 04:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781236930; cv=none; b=DNaszl0y+eJ9phycbaoPdPc56yk/SL/vxF6x8XA546VgdnrAlf7amf/2LOJzCx5aFpFdVDPOrIEmCpM1915op4naf15vqheXWI0CgpDDMM32o/tElWW7/jYseYO0++9eHNLU06wwpulneATcWzab9GjQYzsBGYgjoB8zD/Uq4lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781236930; c=relaxed/simple;
	bh=JLFccZ4it4V6fK+QYSmMetOCL5T/AQu19DtNuDoAkfA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RTZrC5wofvXt00JaTznz28wJ1OB9YMJlTPn5QGuJWDHc0yl+B84Pe01DIo9tGswuopzBUn+sH5NwIjLGAeyU4+hgH2zBowSSyRRvtQY19Qag67f03g+0F9e7skBffTLev34eqotxu62+nTqNDqv1b8yM9JZnv5ejjvQD+518KXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=x/7tarjV; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="x/7tarjV"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5aa6c66e6c5so323378e87.2
        for <linux-hardening@vger.kernel.org>; Thu, 11 Jun 2026 21:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1781236927; x=1781841727; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zNQmbGQm7HtfdiZQEmc4CAfdRcGI2sG3f5yeWvbGW+M=;
        b=x/7tarjV9GfC/kWthfFTPEqDEc3kayYzQ2WZi9bABDSOMHoXbTAZRt3DFhzFwijZju
         UefnO5t/rASOFdeG42KS+znIl/1MHqpOU5bhui948nwZJTBfLvnT8CmFVTeHjYx7EOay
         d+dZGBxE41fumwNYFbOQsjLO5RRuuciiR6ShCV/apq50VQvV9aoVGUAAKahSQOoj/q9c
         mJp74nge5KkNs4XaUdUmnUqHQCNAuoZzXhSDRUBPkJAEFc60MH9/LXKJ59hTnCUvBE2S
         fi0jv4aIqvfd1qFngQ6TLVxphUGN8Pvvz1mxp8L98OUKYoyaAJ91lN6GgO7lA8CEzRM/
         6l3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781236927; x=1781841727;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zNQmbGQm7HtfdiZQEmc4CAfdRcGI2sG3f5yeWvbGW+M=;
        b=Em1d7s3exeknNv2UVSuS99wbKEInTV7EuOR0AHhQFReMDBOIbpr1/sXl3CtuXkhr+i
         /ZTGonwWTCnGf+Hm6ZoQJdAdHWyLOQt99saNsMtbVXF6CTRctRjRWoSi0Bh+7ct5B8nM
         +F9cmH9lr8a8i1VIsQRVibqW5V/OS0X99pXDqWc5/PCC4E4pR00ehfsSbNLxE3yBKhGV
         1kaax0p9Mvo0+Srn7R4iK1SrjKJ7xj/XF3Z3SMdUuElAYRtwmpxRqchaJArfB1WzqhYd
         42nuvGU0Z43H3RrhEZmsuominsp7U6WS66jDWWSvriXXPVQ/uuley8sAfUqdsSr9g7Ra
         5p+Q==
X-Forwarded-Encrypted: i=1; AFNElJ/NVzFbrj60gp6EfDDSc5p1S2p5dGAhOZ6OBjBzH7oLMwOppJcxphjgAL8PSskWLls+GRy2R/1rxlykFKdURSA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyco4jlaGewtklWDD/WWBLlYwtAyFQNP/KJKsmgs7VQRLllJ+nT
	hPH2jdDdAjyKrrsGKUOSqw/bYXSB00zonpehkeTSS0zfujf0P25ZmV/0NL64TE1CYDcNmdCwT+3
	/9kA6VLZMYA==
X-Gm-Gg: Acq92OEl/EsbeNxXsi6sc3uabFC7pDcGTHXEl3HP4Qawr+8LiIdngAyigb+hUb8TXT/
	7qw6CC9WEc0/dISRANv0c+x/bORVxI6KTy9VcAutTy5q2KKAsaMQYBljBKVxMzKTNji+BtswHbr
	u0zEj7i6s59wplocecufl6LLckjfTgcH3obzzWv9/IO/bj1u4JdafWg5OyYB85gVPbpxp60x08T
	S4E6kGL3m+P05LH1+Eg3leJ1rfISLGhCumPoAHiL79/0MlMilKFGQo7yaa1Wcsa3uT6ZUNzhvXV
	rao5Y5EHcf+pphKSgFxkVKMaiNE3koXpCx+E7zPZaRiaKH4HoHrDVFK9DsMmPiZV5aBfXK90ns1
	7vlPhsHQLv7KCuRMFvV/qEi1Kh7fBoF+wRixAeIiOO5LzWgoAUuClm0B5HbnKJYaBWFGsKL4suB
	GQAdBB7iN6deaZ9YoVgJvbne4xvTUzlYxaFMaRi/RF88ihAk6TtGh4qrC3FYZW8JEJ09LhrWI+F
	FbkencyoLlCwQasvEa/0ksLKU3LOmegUrprOa+kewgaKR6IzbQkIkOv
X-Received: by 2002:a05:6512:234f:b0:5aa:67c8:5dcd with SMTP id 2adb3069b0e04-5ad2db1dd69mr335719e87.1.1781236926948;
        Thu, 11 Jun 2026 21:02:06 -0700 (PDT)
Received: from [192.168.1.246] (broadband-95-84-186-252.ip.moscow.rt.ru. [95.84.186.252])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad2e1715d4sm161727e87.34.2026.06.11.21.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 21:02:06 -0700 (PDT)
Message-ID: <09abf97d34d91fa2e373961babb24581a68305ac.camel@dubeyko.com>
Subject: Re: [PATCH next] fs/hfsplus/xattr: Use memcpy() and strscpy() to
 build xattr_name
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann	
 <arnd@kernel.org>, John Paul Adrian Glaubitz
 <glaubitz@physik.fu-berlin.de>,  Yangtao Li <frank.li@vivo.com>
Date: Thu, 11 Jun 2026 21:02:05 -0700
In-Reply-To: <20260611091833.02ac2b6d@pumpkin>
References: <20260608095523.2606-39-david.laight.linux@gmail.com>
		<2543b22369ec19dae397963fbdf2e7181c7419a8.camel@dubeyko.com>
	 <20260611091833.02ac2b6d@pumpkin>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-06-11 at 09:18 +0100, David Laight wrote:
> On Wed, 10 Jun 2026 20:50:33 -0700
> Viacheslav Dubeyko <slava@dubeyko.com> wrote:
>=20
> > On Mon, 2026-06-08 at 10:55 +0100,
> > david.laight.linux@gmail.com=C2=A0wrote:
> > > From: David Laight <david.laight.linux@gmail.com>
> > >=20
> > > xattr_name is kmalloc()ed at the (assumed) maximal size and then
> > > the
> > > prefix
> > > and name concatenated together.
> > > Use memcpy() for the prefix - its length is passed and strscpy()
> > > for
> > > the
> > > name to ensure it really doesnt overflow.
> > >=20
> > > Prior to bf29e886b242c the buffers were smaller and on-stack.
> > > (But I cant see the copy in the old code.)
> > > I am also not sure why the buffer isnt created "just long
> > > enough".
> > >=20
> > > Signed-off-by: David Laight <david.laight.linux@gmail.com>
> > > ---
> > > This is one of a group of patches that remove potentially
> > > unbounded
> > > strcpy() calls.
> > >=20
> > > They are mostly replaced by strscpy() or, when strlen() has just
> > > been
> > > called, with memcpy() (usually including the '\0').
> > >=20
> > > Calls with copy string literals into arrays are left unchanged.
> > > They are safe and easily detected as such.
> > >=20
> > > The changes were made by getting the compiler to detect the calls
> > > and
> > > then fixing the code by hand.
> > >=20
> > > Note that all the changes are only compile tested.
> > >=20
> > > Some Makefiles were changed to allow files to contain strcpy().
> > > As well as 'difficult to fix' files, this included 'show'
> > > functions
> > > as they really need to use sysfs_emit() or seq_printf().
> > >=20
> > > All the patches are being sent individually to avoid very long cc
> > > lists.
> > > Apologies for the terse commit messages and likely unexpected
> > > tags.
> > > (There are about 100 patches in total.)
> > >=20
> > > =C2=A0fs/hfsplus/xattr.c | 12 ++++++------
> > > =C2=A01 file changed, 6 insertions(+), 6 deletions(-)
> > >=20
> > > diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
> > > index 452a1f9becb2..0b3dd48c28c9 100644
> > > --- a/fs/hfsplus/xattr.c
> > > +++ b/fs/hfsplus/xattr.c
> > > @@ -550,8 +550,8 @@ int hfsplus_setxattr(struct inode *inode,
> > > const
> > > char *name,
> > > =C2=A0	xattr_name =3D kmalloc(xattr_name_len, GFP_KERNEL);
> > > =C2=A0	if (!xattr_name)
> > > =C2=A0		return -ENOMEM;
> > > -	strcpy(xattr_name, prefix);
> > > -	strcpy(xattr_name + prefixlen, name);
> > > +	memcpy(xattr_name, prefix, prefixlen);=C2=A0=20
> >=20
> > What's the point to mix memcpy and str*() family of methods? What's
> > wrong with str*() method here? Otherwise, if it is wrong to use
> > str*()
> > family of methods, then why is it correct to use for second
> > operation?
>=20
> They all just copy memory...
> memcpy() copies a number of bytes,
> strcpy() copies up to (and including) a zero byte.
> strscpy() copies up to a zero byte, but no more than the specified
> length
> 	and always zero terminates the written data.
>=20
> memcpy() is always going to be faster because it doesn't need to
> look at the data being copied.

You need to take into account that it is Unicode based symbols. I
dislike to use memcpy() because prefixlen is only number of symbols but
not size in bytes.

Frankly speaking, I dislike your approach in this patch. It is not safe
enough.

>=20
> >=20
> > > +	strscpy(xattr_name + prefixlen, name, xattr_name_len -
> > > prefixlen);=C2=A0=20
> >=20
> > Why strscpy() is better than strncpy()? What is the main argument
> > here?
>=20
> strncpy() is completely broken (but not as badly as strncat).
>=20
> And, replying to the next email.
> You really don't want to use kasprintf(), especially just to
> concatenate
> two strings.
>=20
> >=20
> > > =C2=A0	res =3D __hfsplus_setxattr(inode, xattr_name, value, size,
> > > flags);
> > > =C2=A0	kfree(xattr_name);
> > > =C2=A0
> > > @@ -698,6 +698,7 @@ ssize_t hfsplus_getxattr(struct inode *inode,
> > > const char *name,
> > > =C2=A0			 void *value, size_t size,
> > > =C2=A0			 const char *prefix, size_t prefixlen)
> > > =C2=A0{
> > > +	size_t xattr_name_len =3D NLS_MAX_CHARSET_SIZE *
> > > HFSPLUS_ATTR_MAX_STRLEN + 1;=C2=A0=20
> >=20
> > Frankly speaking, it looks like a constant that should be declared
> > in
> > hfs_common.h. Even if we would like to declare it here, then it
> > should
> > be const size_t, from my point of view.
>=20
> There is little point marking variables as 'const'.

This is why I am talking about declaration in hfs_common.h.

>=20
> >=20
> > > =C2=A0	int res;
> > > =C2=A0	char *xattr_name;
> > > =C2=A0
> > > @@ -705,13 +706,12 @@ ssize_t hfsplus_getxattr(struct inode
> > > *inode,
> > > const char *name,
> > > =C2=A0		inode->i_ino, name ? name : NULL,
> > > =C2=A0		prefix ? prefix : NULL);
> > > =C2=A0
> > > -	xattr_name =3D kmalloc(NLS_MAX_CHARSET_SIZE *
> > > HFSPLUS_ATTR_MAX_STRLEN + 1,
> > > -			=C2=A0=C2=A0=C2=A0=C2=A0 GFP_KERNEL);
> > > +	xattr_name =3D kmalloc(xattr_name_len, GFP_KERNEL);=C2=A0=20
> >=20
> > Finally, I think kzalloc() should be much better for both cases.
>=20
> No point taking the cost of zeroing large amounts of memory you
> aren't going to access.

What do you mean by huge? It's only 127 symbol in maximum. It's pretty
nothing.

Thanks,
Slava.
