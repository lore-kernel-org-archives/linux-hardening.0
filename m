Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FB93DBD70
	for <linux-hardening@vger.kernel.org>; Thu, 12 Mar 2026 19:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773342802; cv=pass; b=i4MCmWg2McDilDIu7DYGuIcxqZO8dfOLWvEyJE53uZ+cw4Xq2MYcAtzjStiBRhbLPen8IHx9L4RnrzBPuAFQiYhnFJErF7UHkSYycBPh20EwyB522lkTyAFtf3dPqOaua+w09CfJAUVYdBDqbCUenFC1k+a3L2PM0XQxmj7/WIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773342802; c=relaxed/simple;
	bh=lyP69GJRrwv0QQAsgL3D9V6L4yQtdwZuuIRAYsKpWOc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F2O1xr4xNfLs0UEp3DS3Vgy+xVuntoyP/+5IkVBBocMzNaajvV6F+cFAxzwrSvZwpp2ys1slVUp7EY20EoIr0nU4jtfwQ+XFFbDSEnheBsT1kDf8dwse6/Dg+kr2lW9dttYteoXtbiBgo9RgtxxmXSWz8Vige4QiHrMOUQuhicc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d6bYkSXH; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6bYkSXH"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b942a41c5fcso182258166b.0
        for <linux-hardening@vger.kernel.org>; Thu, 12 Mar 2026 12:13:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773342799; cv=none;
        d=google.com; s=arc-20240605;
        b=TJvJLpFIbSA8UNzj+xuayokUlQkVWFWH5EBh2lx0ErLpcmmE4cuxEsGrywRBYjZbGP
         jq7pOn4VTLfrJmzXWb2TB5krZl5hgSMMrrXP0Y6pTS1A5SaCPyBbs0Kym3IkbkkaccJc
         p5mr7xka87tAGUipTAbyMQN2RCQ3nWH+OZoKhpBbymCA+ROqmY5tj4Qv8uAsPnHhUL5L
         9+5VwuBjlDIhRbINSK4t0Jjr92VnVsFJ/jaxBhEkd5CEJjuC3DfjkZogDSTfiDoueXxC
         s9GY/vshl+wF2jruhWYujHjpVTdi4XKTUKX49q/QE0LlBn2NXDd6/B3STQn6uEFEI8Ff
         jqKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/H7v3o957EUpQyPVZbAPuTTS6j4qz4Nq2G75uGjkcAE=;
        fh=UcydOhQuhxybcuAnVTI8pWFg/W4ntPlVJ8BL4bdBtwI=;
        b=Sd1rcUmmGXc+ddY3mqd2SNkzfKd7gozcNHo9n7tAciwCgIvXRIP5IUtKHyrqcuvh0r
         xtFZTmZtaCUqV1C15PiUUcxzFvgd3dPObUw1iVx83XtFXJBGWs40xidjn2GPoP1pPvNO
         56FPhdt7n0PvIG8A38umTNEt1S4mPEqCyIHrfy6mR/z9hVZ9x68fuQtSxOV+CZHPdZTo
         SOF/wfSH0CEpGA1yOcuKdQtqjB54NxtVomTbCM2rGejpt7iBTKkP2uHQUaZhmPZYuczP
         4OgYE5OHHJ5UQcspTiKcSD2wB/4OAsLqCt4+FhyIURGF4hS8hj4IsbGSQjHHIUV6c/oV
         z6Ag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773342799; x=1773947599; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/H7v3o957EUpQyPVZbAPuTTS6j4qz4Nq2G75uGjkcAE=;
        b=d6bYkSXHq8M3X52oNh1lqwpom0c1KEaGfwJIm3bfz1GJlOCAY531/uqr6rvle/1+mx
         Y5Ua2BGmwMYjLyUB5/1nJj3rLRiG1Q+Wn28M4bel62ksUw+lSZQSyhu+AwkMZvQhoxFO
         98t72tq4R2/jJLJlDoeRKg0TseYF+AqG+1DSugnx7COVNizGWUu0YvwJ4lRfTiUo4sA+
         2gy/vilAdlTETBy4prHVwWDY4OV/8KDHd+Z8Ka6LfTAfvouladMLP3LvBx+iThz8Jst/
         WKnBZrXW/KgsRI6LAE23tpwZEv1IDFtqZwa3iV68ZYhhCejCcLSZbwQRogcomPUxWfWP
         Kc8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773342799; x=1773947599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/H7v3o957EUpQyPVZbAPuTTS6j4qz4Nq2G75uGjkcAE=;
        b=Ajpbze/U2daXUcmpXTA6QkGFpMKr87G5AZlB/2Z9UWMcC73vpL/XMY3nVTpd0ILlA3
         CXNVzXaflVEjlAqjNkZxrCQvJB5wh7cmil9kqs5SUKjNDqrqgi1+386Tg6Xg40g5BpAp
         byQT2rao5IS0yqO/LyZfvnxO2YaTPQ5xDCp01onPeZC97XTMaZwOWUd5rUWWdEOlrfQh
         aKP4fJy55hYyv8kzuiLdZGlAl64VvFFlcZfdysd9UIMIww/eR5u7c/pl/5oAPr7UyvoM
         MGqjUiIY0B6F/8ErfcOHXonaUHPMx+Jblq0wxJx658G/zbBxl92HWGDSyrbc9cJiCIvK
         ocaA==
X-Forwarded-Encrypted: i=1; AJvYcCWNwHYiKBePVkhXK+zSXoBG1+VtTBAGKa6EWiUFO+TxOrERMvfcAptG7JpA8wuyHtGgfg7yof9TdgFY7Ps/LS4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYjK8HngrXozLt70G4lVMHIJVBUOZ5qsDS7msJ+OTDDFOLXPrW
	8vATzGl2yR2VLTVV7UILcuv3NnNKnrHjg/TGSwxbyezY/D5b013sWkbKVRUo9ExHtgBLzimCVQG
	WYFvjHne/5B3AHolI/maTPLRCzPZbwkc=
X-Gm-Gg: ATEYQzxdmNCcYDA4WLZMQOUTQJNjNZw3K3OWT46pkJsW8WLvafxWMcak2lDmzkXal5w
	aE0+YhdPTK+yL2FxTgWbq9iaBQm4/dD/d0dbeO8KvtE+Olg2zGV9tkMUtGZD7l+dyRR10Rpq7zt
	BwjW9wz4EKZPHtSvkpvYR7t8JVKrwgak6n0b2plu7ry4UJ5g5E6HNspw4kGlCIj2sNNc/MebQiN
	n6g3P61NbbD4RIm0bTaBvBdwGsQkE4SwBXlZOt7pBG1AK6G8PeVUL5c1+yNCZv8quF2yJusZqoJ
	By5cIiXGr/ZxYBZ61ZKqffDtuf0x1fK2Z+t0jNty3uBaRMZGtDNr9hDd/b3fqG+Q7igeCWknl8s
	g26qtNw==
X-Received: by 2002:a17:906:99c5:b0:b93:59db:ac6b with SMTP id
 a640c23a62f3a-b976507b071mr30331966b.5.1773342799180; Thu, 12 Mar 2026
 12:13:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311232545.18492-1-rosenp@gmail.com> <SJ1PR11MB6083C3A677F5C906222794A6FC47A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <CAKxU2N8zSkzJMp85hgRN453x8bcPDvN_3tXmp-sNfueZOAuHfw@mail.gmail.com> <SJ1PR11MB6083385736D708F551CEC85DFC44A@SJ1PR11MB6083.namprd11.prod.outlook.com>
In-Reply-To: <SJ1PR11MB6083385736D708F551CEC85DFC44A@SJ1PR11MB6083.namprd11.prod.outlook.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Thu, 12 Mar 2026 12:13:08 -0700
X-Gm-Features: AaiRm52jVl2YcO6DIkn2mjvZFsDX5fGOT6th8Eqq-_k1mgUQhSIQevWqa0VCUVI
Message-ID: <CAKxU2N9X18LOw77eM8fqryqrc8yERSbnUNZVzDtY+RoZv6Snfw@mail.gmail.com>
Subject: Re: [PATCH] EDAC: sb_edac: use kzalloc_flex
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, 
	Borislav Petkov <bp@alien8.de>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:\\b__counted_by(_le|_be)?\\b" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 10:09=E2=80=AFAM Luck, Tony <tony.luck@intel.com> w=
rote:
>
> > > +       sbridge_dev->n_devs =3D table->n_devs_per_imc;
> > >
> > > Do you need this? I thought that kzalloc_flex() filled in the __count=
ed_by field of the structure for you.
> > kzalloc_flex is just a macro over kzalloc(struct_size()). It does not
> > do automatic __counted_by, which makes no sense.
>
> It is a fancy macro. But may be complier version dependent whether the co=
unt is filled in.
>
> See include/linux/slab.h where kzalloc_flex() uses __alloc_flex() which l=
ooks like this:
>
>
> #define __alloc_flex(KMALLOC, GFP, TYPE, FAM, COUNT)                    \
> ({                                                                      \
>         const size_t __count =3D (COUNT);                                =
 \
>         const size_t __obj_size =3D struct_size_t(TYPE, FAM, __count);   =
 \
>         TYPE *__obj_ptr =3D KMALLOC(__obj_size, GFP);                    =
 \
>         if (__obj_ptr)                                                  \
>                 __set_flex_counter(__obj_ptr->FAM, __count);            \
>         __obj_ptr;                                                      \
> })
>
>
> See the __set_flex_counter() ... looks like it is trying to set the count=
ed_by field.
/**
 * __set_flex_counter() - Set the counter associated with the given flexibl=
e
 *                        array member that has been annoated by __counted_=
by().
 * @FAM: Instance of flexible array member within a given struct.
 * @COUNT: Value to store to the __counted_by annotated @FAM_PTR's counter.
 *
 * This is a no-op if no annotation exists. Count needs to be checked with
 * overflows_flex_counter_type() before using this function.
 */
>
> -Tony
>
>
