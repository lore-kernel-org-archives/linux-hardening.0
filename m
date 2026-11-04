Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793818924;
	b=Vrwey+kw66SeAXk4Gv17cHNfAt6oF1322xxUNVqIsi7dXuN5QUbdbzmGkb0fezS1zZR1
	 36mVErpVTOHxI1R9Djzf94dYCZ+gsUdTwfjx+d9S35T60nBbJ7j/mV7oA6M+P1py+bEY1
	 YMnbMQJNquEIv3GAF3yQE6yydmxsIJ6qy9KFTmfoJnYb6IAlL3OYGSpGGcJBExoHyDQTw
	 FQN6OoOyEQ2MLHhzF/3RJl3j/9ZJxpj4jRczmXo/W8w636FuCPLTjFZ2D1h/Z8XGHqnoK
	 mHhJjTf5CSb4OwZfT4qwUCWil0i2ScgoIgqmPwTLpUt4GBXyCg8H/SiGXp37dfhKH6g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818924;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=oafn2hCqm7HTSzGstliyGNOlBVNP4XwTG5bffvWvqGc=;
	b=iwLgLtSNLfYGUG7amcmQ6T9aFOdvWpO2mLtg6qi6NfX1dzMZB5PyRB4m9jT45z8NnBfh
	 tjsl3qtB2C2FtB09ddTa02tw9G8OmfW1ttVsuZLjCgVcpPlILrLx+GHeuNIeFau4/yNO4
	 a+CaHg29ql17jL1rivURA9Zj5akeEeDnBR+0p9BPwqlJNg+jY03JjUQCwGzoy7MOWKHVB
	 Sjl/2Su4ahFabUoiF8TcDRA5HjgAumPsNP0LRNIOdP5m30E58QscJGg7dCCd0t+kvlXQA
	 F7g4/Vw8m0l5FeMZBY/fDJO+yHT7FqNuh7o3kITvZMdd2IU4JfudZO4zAsT3Tbz7Q6Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eqTCOfeH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773F4606A329
	for <linux-hardening@vger.kernel.org>; Wed,  4 Nov 2026 19:02:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 773F4606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eqTCOfeH
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a208d93758so11908305e9.3
        for <linux-hardening@vger.kernel.org>; Wed, 04 Nov 2026 11:02:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793818923; cv=none;
        d=google.com; s=arc-20260327;
        b=ZxHaZTFy3LxE4qfs/4RGHIH8+CC/yA/xZKdCHDJrUCmTPq7fhshZjnUz5eNat5q6zO
         kkdpEG0yqpQCb6mLHi0bueuZ7tpfS2f7iijBwgSgkSU0HwNepxXa0HKKzXGCXaiMpffH
         8LInd0HpHYWfSqXxdGQ0EUv39mgx9iBXU+iDOH60l0sWMp9ITmjGRO2Y1e+s/IApGVtk
         shONoWPw+ML4HAGSZXdPevXojyzDEzSQ8z0Z7TpecAx2xVKCMAwPP+ubwOmSOlZ/Y4c1
         /GjcjOdfyTnI9CelVGtNbA+2XqlgaXeoG3RjJJYFTRDiXRZlcFdXtTpZRdDtzDFMCJ7n
         cv1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oafn2hCqm7HTSzGstliyGNOlBVNP4XwTG5bffvWvqGc=;
        fh=sU8b71Y3DiBYzGyg1Hc32uzLdYvhg0toz62XLAqrHhU=;
        b=DdLuE8dmBAJYXeeK4ggAOPn9cXswxrimAKtVwUrwzbOYozRRWs3rgNtetdMmMdgxFh
         Hvxivx09+7apgicYVIlAdVRK6EHGY4lYy4/ycP+uBD3oHMmu5p3g8dV7BUc3tQnruE/E
         Dq/c8BbEk+I7fBaLjIwXLg6L0CkjytANXm1qQDMzPRpFMI5+AdBtFPHQkVlXuA67g7ty
         Ux1WwELMcA5jXnOBCQLoML8Cdf0kkXtCOHKCMDkqSUvRce81dfXMHrY96BsjCayrD9gE
         UactjSefw6iDNTjtJMBQ2Pf0e1cQzS8IqpuvzeZyTiDkJ/UUgZXTdIusqIgIyqVsjkxp
         YEHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793818923; x=1794423723; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oafn2hCqm7HTSzGstliyGNOlBVNP4XwTG5bffvWvqGc=;
        b=eqTCOfeHKe3l/56+nB+NKmRz+SQ2Uh2SxG3yy5zShuOF7qJgXjlby62RNT2NdNWDKV
         xWYdzvYrJqktNSr+ev7IYg2iP7D2PKmWEkcFVmfqRlzEi4hP+Fm0ir1E+cu3t598FiRu
         kpVN4/6B/47P1p/emIG7ZsA1B3PFz7A9cEjQety4hgfAtIXj+1iyhkNIaZL9KZcyvEw7
         nOHJE0X2qtEmE1qIxarLgkTZemtv6NeHjn+TYM7V5FDx/3d0FerOS19sd1mSPQ2Kc1Ch
         g/MDLT+dveL7jWzB08rgYkXhPpSj5Z4pVxAVP6zybFOfOu9M5Rx6xBA/r6h2Ax6xNPpz
         FJIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793818923; x=1794423723;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oafn2hCqm7HTSzGstliyGNOlBVNP4XwTG5bffvWvqGc=;
        b=XX02Q78EENhNr6i0h+zzc0LIU/KOyFUeFkNIrNyfa4TFDruGG+4r+ubMPtQlY+Gftq
         CITxEVEsiyDYAFZyYEuDuuUdx+cQfS8Q7gYWQBeyE0ogRLehlFbqe2geHcYgqk10zUlx
         2/GXrqL9m7mYjff5llQSWd+WNZPyA+UmJJVq2k759DIB3mfS5kI3x0rHA6uHXacUHGkZ
         jmvmYNxcrAKvMokCk9hHS1NCg/7I+rN+KDr/H9oQ09kJyFyP4O86wQVTwxxywR/Y8QZl
         pB0eEdAQfzfc9gpG5YDMvKlfM20pb43aGUREUbKMIORMwwxhcEiS7G8IZpKG75L34bsj
         dqvA==
X-Forwarded-Encrypted: i=1; AKwUvBxgit/NVZ31mPUVo/0L2ubLfALqlaiaXqKZJR3X3EElOLJDrFQmD3LLX5zwAX8myAlIu+rfEzVNb/CZkxit4sI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+WWJ/HN6kObzoV3+gnU3edHe2LktTVtkw8fuICElCqu85N4wB9
	QPlhzfDm9SwtIfWiT+wxGlaA8Lnm4LVPD26lroX9Nlld4nV0euox/OA1WDwt2THYl1sxOfPWfoQ
	BkWaunclLoceIGVSjcZ/CjV8G6csJUSE=
X-Gm-Gg: AYBFou1H21lJAD/ortEupB6zbSrNyQIF8RJr5LQnLD8dE3rBYlSvfD8dQyh0JEHEnX3
	9eEL9BT74IHJi+4gYVp6HSX62OrbFeHNoAlKciwnFln7wmUy/ZFaAFgCo1eEf74UmT74zbcpLp4
	qgyvoyu9Vjy9OXZ911Fo1UW2uMjzMRX3PVI4ctmmTHdNGnqo/wP+mQNZBCzLqMuBV+LiJLiiQ5X
	/uGX4Hr52F0FVWqamRM+2vWwpsX2GF8a9T3gUZk+zDfMHvpjMh8Rdz/CUC6JwZw9Cpgq9sa0dpy
	lr2s0oOSN9/xtPxkZYwCJuvmIMEJmzKWvkzmfG7jYv8sGo3cRNC6QtRzRH02rYF76l56DxJj56Y
	09cP2Br0g0V5E5WmMGT7MhVfk5PxMO3IxqrwJgVK3zchzXNyG1vZuYYbjhiK6FtCBJCvzgv6Z
X-Received: by 2002:a05:600c:8b85:b0:49f:e8bf:8f9b with SMTP id
 5b1f17b1804b1-4ac14fbdcf7mr351103275e9.4.1793818922672; Wed, 04 Nov 2026
 11:02:02 -0800 (PST)
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104090239.311074-1-nikitash.mariiaw@gmail.com> <ausVkYs1-3rJ5Fj0@devuan>
In-Reply-To: <ausVkYs1-3rJ5Fj0@devuan>
From: Mariia Nikitash <nikitash.mariiaw@gmail.com>
Date: Wed, 4 Nov 2026 11:01:49 -0800
X-Gm-Features: AclHuK9UdU3dwq1JUXXL7zxhwPl3JamlIpuYEG9TvgYAG08j28_4tj64jKv1xfo
Message-ID: <CAPDEY+XgvNEfMNLH9YgJLZGF_bfDFC9kTe58ssxyq=joYYzQtA@mail.gmail.com>
Subject: Re: [PATCH] media: siano: Replace strlcat() with snprintf() in sms_ir_init()
To: Alejandro Colomar <alx+linux-hardening@kernel.org>
Cc: mchehab@kernel.org, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	kees@kernel.org, justinstitt@google.com, morbo@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2026 at 3:25=E2=80=AFAM Alejandro Colomar
<alx+linux-hardening@kernel.org> wrote:
>
> Hi Mariia,

Hi Alejandro,

>
> > Date: 2026-11-04 01:02:39-0800
> > From: Mariia Nikitash <nikitash.mariiaw@gmail.com>
> >
> > In preparation for removing the deprecated strlcat() API[1],
> > replace the strscpy() and strlcat() calls with a single snprintf()
> > call to construct the IR device path.
> >
> > Both the source and destination buffers have the same capacity,
>
> The line above seems irrelevant, and potentially confusing.
> The size of the input is not important, because since we're appending
> stuff after it, truncation may actually happen.

Agreed. I've removed the statement about buffer capacities from the
commit message in v2. No code changes.


>
> > and the return values are unused. This preserves the resulting
> > string, including truncation behavior.
> >
> > Link: https://github.com/KSPP/linux/issues/370 [1]
> > Signed-off-by: Mariia Nikitash <nikitash.mariiaw@gmail.com>
>
> Except for the small comment above,
>
> Reviewed-by: Alejandro Colomar <alx@kernel.org>
>

Thanks for the review!

>
> Cheers,
> Alex
>

Best,
Mariia


> > ---
> >  drivers/media/common/siano/smsir.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/media/common/siano/smsir.c b/drivers/media/common/=
siano/smsir.c
> > index 283770d583d5..636ff228108b 100644
> > --- a/drivers/media/common/siano/smsir.c
> > +++ b/drivers/media/common/siano/smsir.c
> > @@ -55,8 +55,8 @@ int sms_ir_init(struct smscore_device_t *coredev)
> >       snprintf(coredev->ir.name, sizeof(coredev->ir.name),
> >                "SMS IR (%s)", sms_get_board(board_id)->name);
> >
> > -     strscpy(coredev->ir.phys, coredev->devpath, sizeof(coredev->ir.ph=
ys));
> > -     strlcat(coredev->ir.phys, "/ir0", sizeof(coredev->ir.phys));
> > +     snprintf(coredev->ir.phys, sizeof(coredev->ir.phys),
> > +              "%s/ir0", coredev->devpath);
> >
> >       dev->device_name =3D coredev->ir.name;
> >       dev->input_phys =3D coredev->ir.phys;
> > --
> > 2.43.0
> >
> >
>
> --
> <https://www.alejandro-colomar.es>
