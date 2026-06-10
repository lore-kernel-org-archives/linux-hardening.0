Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCBC1D435F
	for <linux-hardening@vger.kernel.org>; Wed, 10 Jun 2026 01:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781053495; cv=none; b=UAWLHh4rR1YXi9xnFZyDpPJcnhPyTkQZ7nEYfQn/U6Ak2/Oh3tIgQW4QNih765bp17r7pfxChG0Fw9nZb6KCkuZW+MYPtBPgm1fEhP9tFOtiQY8w8atwz8r/qgake2pWv8uI9S/w0+nM1GzCBqJvWaYpreStg+6MIDHAOomMmt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781053495; c=relaxed/simple;
	bh=BgouVNDaMkUocleo1nUzgz4x0HgWmDSLRPJA2tZ6RAA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KEZg6fX3JbhCRoCB++J4ttBJeS0J6OuPNBLrFHKd9p8IBJh3viR6vno8XwEJxZdWgSI7EXI8PuxFU8vqis2DrggJK9KF83JT3ahg85mAwNzUyUC6eDCyzZ0l9BqoyrupSJQ9raXnl8nqFN9jwlV6CihuMjT7YBgIqip1a/xf1Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=OpBsK6sl; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="OpBsK6sl"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5aa68d7d757so6588463e87.0
        for <linux-hardening@vger.kernel.org>; Tue, 09 Jun 2026 18:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1781053491; x=1781658291; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3+IHp2l2rrkkQsrMXx/C+M6l/022rECrJz/KtdXmcpQ=;
        b=OpBsK6sllyNkGqKRBfe4snDCkwvgWNNmmjknzfUGHs9KaUxPVjF9hckXGIf0OhYP9A
         UaSy3d6UiqtuaskdwxT5WK2Wz4gSCUfTCUiludAJyBD6pIlylyHXM5mFDyV04CFfWJF3
         WX3Xns8gpbWl+XDEDklQXRN6bvaiZink8eXTCEgQxAo4S5wOyiLI6SbfMcmXQZP70ssy
         g4Q/2yOkjx68lPa4peMvIM4I/wa9k/oOE/+uQRZ+xoJgB7qxkU669r6luy2O0LJodNzy
         xpqZ94e1bUIAILuG+QCrcujFPQbxyDyyP+Cmekm3gL1L+zXBz6Dzue+hFIFmRv6qSHEg
         zwSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781053491; x=1781658291;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3+IHp2l2rrkkQsrMXx/C+M6l/022rECrJz/KtdXmcpQ=;
        b=PJWO/5cbHdenlhUyQww3isJUopyD7uBY4GcOvUFpXEnJAVIBj/9Rt3cMpy3ySpG5hA
         kZNh4xbMR8VX+V2NnTiyV3hajBwpAr3zAlyAF4m3m8bJzrIzj1yRnBOSo7z4B3JkCRS9
         7UHdgrSlFca0zB0yjligFscyHTy85mTWkYi0fGj+ImDU+nD/JCiicgMb5lkuPiXigUTR
         vQrgFVO/3QXu5vNM6/UeXU88Ti1bd11Z+nSM7yoFrOEXf+updqFfq82PnxF4zFzMzbqc
         gepOgBboXhyp+81/KdsV10RRBVh6/1G4lPaSizy5yds2Rbpyvc1aJcV4gWDXJeP847iI
         nehw==
X-Forwarded-Encrypted: i=1; AFNElJ+XYb27qec8KYk/5zU+B4jie/sJ/HymTCWZQFSfxHtQ+bNUCWM4eC7CfLFhfZEl8VudRqJUHXnkhZgE8cIzuZc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbxrl6BzkNSVhCktF4LZns7p8WUl50MbxWZk3g2PsTK4SOXTwV
	vvlXQeGbp1R31DVmqb0PGvsOti3yRhmg5U2eXPLU5kkDNMXd8MyczkhpUhuay/92H8M=
X-Gm-Gg: Acq92OE3kJpoEg5f2FkYqy5bg2EeVkd03BYXTAEhZ1lgWrxUdZ7K2MQmPT4ikOAUCrc
	uBDMYvF000JPTi78QkwwRo5Jnbwaqw46M/IheEy9mCNAtIt929cwEcF+gSy2MoOfBXetELcTjUK
	9oFUz1eKXSYbVUuyKOW8++l49I+RcpK4BogQCvOljPydT47wJolp8fLG2HTfwIht8cFwve/n/be
	9sI/TyftPglzJ/1D1bAjSEwesTmv/Pa3mqgEHzPyndCglfADR2GIUD1RaENqx4U/uYMgCFg7BaL
	ZvUtDiQUMeeWwtzIxoO3eaSvYTjOwB9EZyGn2uW2a05hQG/4HN5Q5qqtkHpKPzgE/MAhz54j7bC
	lNovDcEiIKJ+uEu3cek0fsJbftH9u7aiNbhd7umvZ40x/ervIz+sO/rZVlLx5lCA/z5H0CgM0g/
	eG+zvF1CvhiL3ZQre8jq7V8c//q+Nm62fxNNLGp2JRwNx42aDGwHCGFe4ZGUuhbLEUB82F0XG1f
	p6Asxz0G8lsfa9sRr+LbcqJ4HAa6pLHDtL4n2ImnB4OJJ8KS4v/+8t4WqYxBVCg6tnAMQIU+82d
	6w==
X-Received: by 2002:a05:6512:108c:b0:5aa:6f5d:ee0b with SMTP id 2adb3069b0e04-5aa87b8b34cmr6193269e87.2.1781053490709;
        Tue, 09 Jun 2026 18:04:50 -0700 (PDT)
Received: from [192.168.1.246] (broadband-95-84-186-252.ip.moscow.rt.ru. [95.84.186.252])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b97ac3fsm5007983e87.42.2026.06.09.18.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 18:04:49 -0700 (PDT)
Message-ID: <45e421ab38cfdbddbc0d34970a2db94902ad634b.camel@dubeyko.com>
Subject: Re: [PATCH next] fs/hfsplus/xattr: Use memcpy() and strscpy() to
 build xattr_name
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: david.laight.linux@gmail.com, Kees Cook <kees@kernel.org>, 
	linux-hardening@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@kernel.org>, John Paul Adrian Glaubitz
	 <glaubitz@physik.fu-berlin.de>, Yangtao Li <frank.li@vivo.com>
Date: Tue, 09 Jun 2026 18:04:46 -0700
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

What do you mean by "the buffer isn't created just long enough"? And
what is your vision of correct implementation of the logic?

Thanks,
Slava.

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
> +	strscpy(xattr_name + prefixlen, name, xattr_name_len -
> prefixlen);
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
