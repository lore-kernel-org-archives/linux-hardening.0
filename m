Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465E1306746
	for <linux-hardening@vger.kernel.org>; Thu, 11 Jun 2026 03:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781149837; cv=none; b=WgbQn9pjWWKkqAhQ/F6QstxQ7cL3ITlGyDowvpnwJTO+OKAhgnlp1JfjnqZM1mGuxxrsKleEtg3ZcZhp1wxcTI5IDVFJyJciDVzpKoKFOinp9AuVapdoBjUY/JFwCTTo8XnvnpfQCR6hpTOus8MMY7hV2RU9/5aoLbNY316/Q7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781149837; c=relaxed/simple;
	bh=gz/msjdtOunMEex2BqTVGDc/ZG31euGpU4mAhP/QZRc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s4ECiziWGjydsaOp24x46JK1NFKafbOVH2H4/r0QcwmzhJp1UcN28/4r0RxVw8ile5v7R9Bs3nAZHpURnAdtMYBvo6MNk4oAQyH7S0kje5LAs+RfcTa6mUGkbG3Xpx6oJZhtMnfa80XELkrBq8mOaaUmlglrlp/RXmxkOYmm33g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=Eg91DVsc; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="Eg91DVsc"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5aa5f11deb2so8550598e87.3
        for <linux-hardening@vger.kernel.org>; Wed, 10 Jun 2026 20:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1781149834; x=1781754634; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FVrzkqwtVWnUjAk0pQWrCKuHIZWdAIMxGLk/tntdOl4=;
        b=Eg91DVscJNYnZU9JOPFYnyXIxVJc52iQBBSVwinl7VUijWvWXslkckyw5+vOoB+j79
         P3eGDZizn4/ZiPFZ5M1GgvLKJNJxeuQtDDRhEYB/U9MqpdpVmThzEEg5i23RGJdav3/u
         CIGo4INay1vUzQuTxbLObLxF8ohOQtt1hoNkmgNN/EGq0qEGJhENJ52Y5XcMc/Jn/9nr
         eqlT7t201aI0mqrDC20H1cqrBk8fVDtkBAOncqs7u2L25J7+doCigq9iwm1F7LeeykT2
         rNBOyOA/mZZQxIsOg/Oj2YonN32T5UyHjP74FCGM0VGcnrUuLaofM1splyLvLD7GYp+3
         zcJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781149834; x=1781754634;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FVrzkqwtVWnUjAk0pQWrCKuHIZWdAIMxGLk/tntdOl4=;
        b=syz74Lss9/WLAhyPtrsqTr7glmbQgFZD0XUtcJK6b1CPJTwPINUdCxixOTKxFYeuXV
         RNhKWLbyouOGXe2hCnFCWiUuZm2niqhY1G5gQD8BWclAtsftpPlSA3yTXaquMj18fVEd
         YN8mUHLTxkBkNHU/ZVdUJ6pff7sRv2kDcuBjggTUdF9hpQNizsxd1dN4SnN56LcpvSW4
         nmF6NqbFdiLCJdfWk2HEbrQWpwV7e0ijxvYvtIUVSD9mgN6P5XyCtgsIl45rAHxUhbhK
         7dVBOzDTsgkRR0JRN9rkFJ3Vs9QjgyCzC5u0xcphkPagaM3oE+TlkAW4mFgKBWURxcMp
         f2rw==
X-Forwarded-Encrypted: i=1; AFNElJ8nk4nkFuBgcnqqV6PIUJs17I8/6kvcDFY+AEIowDvc8yzav5sI4UcILhTibHKndKkiW55rV524n29TLzYdL/U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyuctbv14+eurpB08jV6pAoFkbCaHJtu1ApBhi1en2NeXeaqOC
	tchQGYmgO94+RzNgDXXdaSWSt7xOanj4KnYZToskgvmQ/MPI/hYIjqyvsE3DYR5T/4g=
X-Gm-Gg: Acq92OGozd1i9V5QCQgQov3Jdr/03zkLlyCa9XPIEiyYWSr/4PqMVnPHUIA/99Ni7EA
	tUcBAkf2wJi2Oaw3Gwz11Mm2n4spk4Dx69iKJEZBrO2Seo8EsvZOutOuOxhi0VwNt6oADfJsO5X
	y2Ve4LzCDG37Rv0s6PU4b+UMqlD4iMQxFfh63L0i9mvejI1wnfuGk2u01eTnFWm2tqo9BQ0LpV/
	Vi6Tqsss1r1nlwEBa9sxUpkk5T8KE1aCgRi/mIZh9fqyJb3ACZ+NvGpSO/s4NT/GBX10alvmRCP
	KiQ7ieVgrlSGZvgVGRwsdoL7xkkkZCTkCi7dvXSLZ2WrkPnT6NIDsddXM04NvjlMjY+qeJolT0J
	a0f7VCWGh7w+Nfm+6JxBnbB7wjSdvxAk0UaaclRhG29K5rX6sbXUkYbEN49/soZSZORJLRtxm4d
	Si3za3Epx8Ndf/2+dOaHrTvQk/exNX3b9KIjeakiWTCfUmTs1muhowwA+9hfgwnHtshowuu8IB2
	IIliTfsj40R2T83/4OvlllzReSNgTaxPyMhHTJXGUg91RVdAB3Ymr0CCpKBJ50Pswg=
X-Received: by 2002:ac2:51cd:0:b0:5aa:77b2:fec8 with SMTP id 2adb3069b0e04-5ad27fb70bfmr251340e87.27.1781149834211;
        Wed, 10 Jun 2026 20:50:34 -0700 (PDT)
Received: from [192.168.1.246] (broadband-95-84-186-252.ip.moscow.rt.ru. [95.84.186.252])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b8fc8d9sm5921278e87.28.2026.06.10.20.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 20:50:33 -0700 (PDT)
Message-ID: <2543b22369ec19dae397963fbdf2e7181c7419a8.camel@dubeyko.com>
Subject: Re: [PATCH next] fs/hfsplus/xattr: Use memcpy() and strscpy() to
 build xattr_name
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: david.laight.linux@gmail.com, Kees Cook <kees@kernel.org>, 
	linux-hardening@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@kernel.org>, John Paul Adrian Glaubitz
	 <glaubitz@physik.fu-berlin.de>, Yangtao Li <frank.li@vivo.com>
Date: Wed, 10 Jun 2026 20:50:33 -0700
In-Reply-To: <20260608095523.2606-39-david.laight.linux@gmail.com>
References: <20260608095523.2606-39-david.laight.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-06-08 at 10:55 +0100, david.laight.linux@gmail.com wrote:
> From: David Laight <david.laight.linux@gmail.com>
>=20
> xattr_name is kmalloc()ed at the (assumed) maximal size and then the
> prefix
> and name concatenated together.
> Use memcpy() for the prefix - its length is passed and strscpy() for
> the
> name to ensure it really doesnt overflow.
>=20
> Prior to bf29e886b242c the buffers were smaller and on-stack.
> (But I cant see the copy in the old code.)
> I am also not sure why the buffer isnt created "just long enough".
>=20
> Signed-off-by: David Laight <david.laight.linux@gmail.com>
> ---
> This is one of a group of patches that remove potentially unbounded
> strcpy() calls.
>=20
> They are mostly replaced by strscpy() or, when strlen() has just been
> called, with memcpy() (usually including the '\0').
>=20
> Calls with copy string literals into arrays are left unchanged.
> They are safe and easily detected as such.
>=20
> The changes were made by getting the compiler to detect the calls and
> then fixing the code by hand.
>=20
> Note that all the changes are only compile tested.
>=20
> Some Makefiles were changed to allow files to contain strcpy().
> As well as 'difficult to fix' files, this included 'show' functions
> as they really need to use sysfs_emit() or seq_printf().
>=20
> All the patches are being sent individually to avoid very long cc
> lists.
> Apologies for the terse commit messages and likely unexpected tags.
> (There are about 100 patches in total.)
>=20
> =C2=A0fs/hfsplus/xattr.c | 12 ++++++------
> =C2=A01 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
> index 452a1f9becb2..0b3dd48c28c9 100644
> --- a/fs/hfsplus/xattr.c
> +++ b/fs/hfsplus/xattr.c
> @@ -550,8 +550,8 @@ int hfsplus_setxattr(struct inode *inode, const
> char *name,
> =C2=A0	xattr_name =3D kmalloc(xattr_name_len, GFP_KERNEL);
> =C2=A0	if (!xattr_name)
> =C2=A0		return -ENOMEM;
> -	strcpy(xattr_name, prefix);
> -	strcpy(xattr_name + prefixlen, name);
> +	memcpy(xattr_name, prefix, prefixlen);

What's the point to mix memcpy and str*() family of methods? What's
wrong with str*() method here? Otherwise, if it is wrong to use str*()
family of methods, then why is it correct to use for second operation?

> +	strscpy(xattr_name + prefixlen, name, xattr_name_len -
> prefixlen);

Why strscpy() is better than strncpy()? What is the main argument here?

> =C2=A0	res =3D __hfsplus_setxattr(inode, xattr_name, value, size,
> flags);
> =C2=A0	kfree(xattr_name);
> =C2=A0
> @@ -698,6 +698,7 @@ ssize_t hfsplus_getxattr(struct inode *inode,
> const char *name,
> =C2=A0			 void *value, size_t size,
> =C2=A0			 const char *prefix, size_t prefixlen)
> =C2=A0{
> +	size_t xattr_name_len =3D NLS_MAX_CHARSET_SIZE *
> HFSPLUS_ATTR_MAX_STRLEN + 1;

Frankly speaking, it looks like a constant that should be declared in
hfs_common.h. Even if we would like to declare it here, then it should
be const size_t, from my point of view.

> =C2=A0	int res;
> =C2=A0	char *xattr_name;
> =C2=A0
> @@ -705,13 +706,12 @@ ssize_t hfsplus_getxattr(struct inode *inode,
> const char *name,
> =C2=A0		inode->i_ino, name ? name : NULL,
> =C2=A0		prefix ? prefix : NULL);
> =C2=A0
> -	xattr_name =3D kmalloc(NLS_MAX_CHARSET_SIZE *
> HFSPLUS_ATTR_MAX_STRLEN + 1,
> -			=C2=A0=C2=A0=C2=A0=C2=A0 GFP_KERNEL);
> +	xattr_name =3D kmalloc(xattr_name_len, GFP_KERNEL);

Finally, I think kzalloc() should be much better for both cases.

Thanks,
Slava.

> =C2=A0	if (!xattr_name)
> =C2=A0		return -ENOMEM;
> =C2=A0
> -	strcpy(xattr_name, prefix);
> -	strcpy(xattr_name + prefixlen, name);
> +	memcpy(xattr_name, prefix, prefixlen);
> +	strscpy(xattr_name + prefixlen, name, xattr_name_len -
> prefixlen);
> =C2=A0
> =C2=A0	res =3D __hfsplus_getxattr(inode, xattr_name, value, size);
> =C2=A0	kfree(xattr_name);
