Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBB58460
	for <linux-hardening@vger.kernel.org>; Tue,  3 Dec 2024 23:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733267931; cv=none; b=O2Dr5DL04YYl0e3CYYSUwRxqylNJ1+/KNyx6CGufI4+EZfks4PqXozVYMHoMsMF3RQpQ8bEoHUhAYBR6OHlzm5pKpvGzEdYu2/mIvLjzzdsb4mShB9c7Ojojbcob2kj0nqtT2x5jsO8OX8tvyaouqEj2rTXpWVSdwOx/neIB6U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733267931; c=relaxed/simple;
	bh=ic6/U0xqaELqdd1v+pvAh6vUGCglKQclSxwyC9Yvs78=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FO/Lt4v8wtE6/DfyxPtyci8UJkv2+xDRWiHUDxYHgvXTVThTU/UfeGhDBvkcBzZZi7uWezRcBXq7w3hiVHOJV76IQGqRDgecqeWYjC4mFj+JVJRp4gysQZd/L3eTGcK1MSemocXIaBfD4swl+Q9OpSwDDYcUMMboYMi4Ham1Tc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=KVX48KmV; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="KVX48KmV"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e398dc7864dso4224418276.3
        for <linux-hardening@vger.kernel.org>; Tue, 03 Dec 2024 15:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1733267928; x=1733872728; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PFTW7zWB6G5GI8ZW7fCb2LgR3U9wsrMvq3OV+dDm25s=;
        b=KVX48KmV/6SJGV8hTHFfff+YGRWn+4oK2Rz7ajRRCtW3P5IuO0w7sHi0DNsn0Ieir5
         kUiFyjm5c79S9sPVLOZj+ybRGgA9Mwzf7+ZI5k4HTXM9Tczk0fy2kfkzv0UmGTU18OMc
         v/XZC49G+/yTQtq8JGRgpCPee7ge5U4i3l3e5BK8m55bijkUDE5gndt71amHZzUSSBah
         MDpz41/J7TpiW+iyjjoBdZeyO2cajlC2AKnI/GjbjCkbIMpOD3lUCOkcIBIwLbabqdHi
         PUdG5dMl/Dl1Kl7wUCsvdlwuq+eHCZezk2dOkXeWUaaAf6Un4dr0Fs93nX51IZOr332O
         eZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733267928; x=1733872728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PFTW7zWB6G5GI8ZW7fCb2LgR3U9wsrMvq3OV+dDm25s=;
        b=jL9lCUmqj3e6OVJcMQc8feyUVic42wTZ/Lfvi+J/G/wIP2w+7y5FYJC5WEPdAUcZqr
         PO9oPljSwM57JvJkOcrBhAN+XVwcQwoDMpNRhfsIW4nqsao6yKVp9m5NH4VxpKV+ZBvM
         +Cjk3NzJHEUeOFxxObu/RG8/iUNe/JFrwbmG7WUtKh7mX8DYot7C2BCN4DEOhaWkRO2h
         cujO5B8RLhGzMCxt4JK8ltKqDaX36v0UUrqTbC/7H9pLX6k0fDZQWcndjGyk9Q8z4GL2
         kWPIjrvuJKWNbAQ6z0KO2A4pXj9W4zsi09cxnv0LxGQ+5boBEdgoZeMJn/S0N+k8pp71
         mWaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVC73tBb7hlRB+sMW3B7VK5y41vn/fXvZtE/ONWyhp8myZSS13heQtPSSdFTi+ssRmutjCIK1qdZt85HqgbH40=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUSafjOPRjMlnGxyzCsdDIZmEthppjEUdO89mL23EXx9h0OKXZ
	QqmbBPcUigna/uiggzUGE1B1r5MhcVkELt7Qa+639th1E25gk5uMi3X9A8wVulSDDG7yUTgqYRK
	YW+pw0iGr8DbXSGGFqMfIjWu1MvydH93h0Ssa
X-Gm-Gg: ASbGncvMdovkqvR1WG53jCGPdTtelK/bmouLVd43Bvecpp0Vwv6nmDNDL4Y9iULdEwg
	cf2O5+NBZ+Vs89iqRYZ1yUS48dS9wjA==
X-Google-Smtp-Source: AGHT+IEVrMzjj2AH4PRIkCO/0QHYQKcIZlG7DWYa92Jg7fmbQVttOUzIhDsdJ+rL6jasCznWD6AgVTx1HluchCbFiyI=
X-Received: by 2002:a05:6902:2185:b0:e39:9346:6684 with SMTP id
 3f1490d57ef6-e39d3a2571bmr4744362276.14.1733267928652; Tue, 03 Dec 2024
 15:18:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203031836.639765-1-15074444048@163.com>
In-Reply-To: <20241203031836.639765-1-15074444048@163.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 3 Dec 2024 18:18:38 -0500
Message-ID: <CAHC9VhQ4gffqTJ7-aGy+kzP3kR7TMWcxOfQkqXygmgDr2bSOeQ@mail.gmail.com>
Subject: Re: [PATCH] kernel/audit: Use __struct_size replace __member_size
To: 15074444048@163.com
Cc: audit@vger.kernel.org, eparis@redhat.com, lihaojie <lihaojie@kylinos.cn>, 
	Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 10:18=E2=80=AFPM <15074444048@163.com> wrote:
>
> From: lihaojie <lihaojie@kylinos.cn>
>
> Size of destnation less of the size to be written will
> make future warnings, the size of destnation should be
> complete
>
> Signed-off-by: lihaojie <lihaojie@kylinos.cn>
> ---
>  include/linux/fortify-string.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This isn't an audit change, this is a FORTIFY_SOURCE change and should
go to the maintainer and mailing list documented in the MAINTAINERS
file (both added to this reply).

> diff --git a/include/linux/fortify-string.h b/include/linux/fortify-strin=
g.h
> index 0d99bf11d260..0504b2c8aab7 100644
> --- a/include/linux/fortify-string.h
> +++ b/include/linux/fortify-string.h
> @@ -277,7 +277,7 @@ extern ssize_t __real_strscpy(char *, const char *, s=
ize_t) __RENAME(sized_strsc
>  __FORTIFY_INLINE ssize_t sized_strscpy(char * const POS p, const char * =
const POS q, size_t size)
>  {
>         /* Use string size rather than possible enclosing struct size. */
> -       const size_t p_size =3D __member_size(p);
> +       const size_t p_size =3D __struct_size(p);
>         const size_t q_size =3D __member_size(q);
>         size_t len;
>
> --
> 2.25.1

--=20
paul-moore.com
