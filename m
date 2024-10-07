Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C261D7E52
	for <linux-hardening@vger.kernel.org>; Mon,  7 Oct 2024 15:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728313208; cv=none; b=bhX793WA2WBg+4RV4GpJeM5ZGfnj7eTwC3vzvZxD2YPd5kmFUI6efhJX38YpOlgFI3inbA16UUh6RB5LoLA0topO9t+TjCBio5y+eEMRDXSFfOGgZGmnOVppksyRYvJuuZ5CAriwq1mCiaVTVDrjRCjtFY1Uch6QJDXwGtUKZEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728313208; c=relaxed/simple;
	bh=Kmt9cHJm8WwS3XspxjzVmwcEHGHmVBkZJdu4NDC3smo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t5Iuze9Qdy7rV9BnqrG9y+su3xNAUlAcvw4kADN9LqMRp6jyUQ+XmnmXMK5RRdHzMwH9zaP8x3p76myVTBCyb+D3+OYc7v5+jGULmBsG+eTWzLd68nc7G30DeVG9dmbthpMStgaJ70B5Yok3VjyZ2lKvCmeKLHm5oTyEr8IeymQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AbQ3gka7; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AbQ3gka7"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5e5b7d54ff8so104533eaf.0
        for <linux-hardening@vger.kernel.org>; Mon, 07 Oct 2024 08:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728313205; x=1728918005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T0KwE80YUYePgxalt01KSjIBVcvG8O10aqSXbDz0ito=;
        b=AbQ3gka7A0McnDohcQXIxVybxx+mssk805CSxaQG/2kIvzyQ5qeAvfgVIVqdZR/2BT
         iYad8oSVhVrR8dO1v4CgjtHOcfPl8ejyJg82T0xm00wk/K9/b4wQPpAR+99AjIxlLxQj
         f7uFM2YLZzeUqCKYEQ7kxeuYcORG2iNqafPDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728313205; x=1728918005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T0KwE80YUYePgxalt01KSjIBVcvG8O10aqSXbDz0ito=;
        b=D9CO/whrUy0r44MedEqhbETwvAfOBdEwcq3QWGAL3QGkUR14G89g684SK8npH1VEGK
         ZieW8PxkmKRhir8lpPxz3dfhXd3J+g9hxGjjbTQkkLZta7NJgGZ16k0uAszUtDTTAQPI
         bNSty9ysoXDymgbVjzPYaEzIRBHzm1BrXP2HpWSiD1HWfY+ikHBbxhmnM0Vnt10bgJe9
         /dujkWLQtJms1dsXORD+83KteJQggYQyIn8Xl9Om3eDQDkfOOrHlJFvHxe7LdAE7s1O9
         ZGzSzT3lP+xg+zMkGAbg13UoBLpvGUcxflaqj1EOMBkvN/pICGmAG3wiYd48H/6MopAq
         HuNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZlAn3PMAJGs4ybJiVAHb3Hp4M0Em+inrlY39F3BpVJRDTKPfI62bWDbxMDhuk6G7uhEoxGA6otyeaZMZzzRc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2c4n0E0S92Xl5JIhkL9kuOQhRD5Luv3wBnXsB6OyeTz4BFlvx
	TiA3VhrVfHSXiTYHRtNeibYiwA9mVnSgouyzf6NerDB5agjuoNoUcS1qrew/8Th7WS9Zc+fIayW
	xdDju0FbbZYod/M/knvoIebgp02ZWB1+iGpca
X-Google-Smtp-Source: AGHT+IEgxSO+or+LT/iiFA/sF2fonUe9w7Iegy6X1aayhSdUynY7mkN/5hXV/JGVKok0IKxa3fAcXXlLQMR9UOr4eLM=
X-Received: by 2002:a05:6870:1641:b0:27b:9f8b:277b with SMTP id
 586e51a60fabf-287c22d93a8mr1797632fac.14.1728313205390; Mon, 07 Oct 2024
 08:00:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004163155.3493183-1-jeffxu@google.com> <20241004163155.3493183-2-jeffxu@google.com>
 <20241005202025.GB24353@redhat.com>
In-Reply-To: <20241005202025.GB24353@redhat.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Mon, 7 Oct 2024 08:00:00 -0700
Message-ID: <CABi2SkWNy16VmXrnPtmE7njb8UzLF=z9J+Ym9titbT8Gw6g0=Q@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/1] exec: seal system mappings
To: Oleg Nesterov <oleg@redhat.com>
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com, 
	torvalds@linux-foundation.org, adhemerval.zanella@linaro.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-mm@kvack.org, jorgelo@chromium.org, sroettger@google.com, 
	ojeda@kernel.org, adobriyan@gmail.com, anna-maria@linutronix.de, 
	mark.rutland@arm.com, linus.walleij@linaro.org, mike.kravetz@oracle.com, 
	Jason@zx2c4.com, deller@gmx.de, rdunlap@infradead.org, davem@davemloft.net, 
	hch@lst.de, peterx@redhat.com, hca@linux.ibm.com, f.fainelli@gmail.com, 
	gerg@kernel.org, dave.hansen@linux.intel.com, mingo@kernel.org, 
	ardb@kernel.org, nathan_lynch@mentor.com, dsafonov@virtuozzo.com, 
	Liam.Howlett@oracle.com, mhocko@suse.com, 42.hyeyoo@gmail.com, 
	peterz@infradead.org, ardb@google.com, enh@google.com, rientjes@google.com, 
	groeck@chromium.org, lorenzo.stoakes@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 5, 2024 at 1:21=E2=80=AFPM Oleg Nesterov <oleg@redhat.com> wrot=
e:
>
> Sorry for the noise, forgot to mention...
>
> On 10/04, jeffxu@chromium.org wrote:
> >
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -1535,6 +1535,15 @@
> >                       Permit 'security.evm' to be updated regardless of
> >                       current integrity status.
> >
> > +     exec.seal_system_mappings =3D [KNL]
> > +                     Format: { never | always }
> > +                     Seal system mappings: vdso, vvar, sigpage, uprobe=
s,
> > +                     vsyscall.
> > +                     This overwrites KCONFIG CONFIG_SEAL_SYSTEM_MAPPIN=
GS_*
> > +                     - 'never':  never seal system mappings.
> > +                     - 'always': always seal system mappings.
> > +                     If not specified or invalid, default is the KCONF=
IG value.
>
> perhaps the documentation should also mention that this new parameter has
> no effect if CONFIG_64BIT=3Dn.
Good point, I will add that.

Thanks

>
> Oleg.
>
