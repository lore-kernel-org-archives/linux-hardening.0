Received: from mail-ua2-f42.google.com (mail-ua2-f42.google.com [74.125.226.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC85351C10
	for <linux-hardening@vger.kernel.org>; Sat, 26 Sep 2026 03:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.226.234
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790395021; cv=pass; b=PSrQyz1DD5/lhhYrW9UKyWhDM/T3vWdOE6yVgUSM6663E6gKRBrKsyGA37+1XdgTkSA26BUmNyS6Epfvy5ltOQhjO+cNxR0+y6DI6vc+cSPr6Flhdtn9BCFWIZufPsw6Nqb2M79c3F424ZSqupLizbT4t6ImHS5r8WzKhq/AUno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790395021; c=relaxed/simple;
	bh=kZy9FlRDjUea/4cavqBXm9PiQeLiuh2i8j3p75iGMn0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jsICqzS28xORa3r69NRmz38yQj2p2tgHCZS3L3dii8tMo3NzzUf2wNUZtdN9VgYL4KFU0ubLWqpzXz7BmCDa7Jgotr+YypfYniXOSf5O2o/ttoVRrsiIIvJ+neWLhZTHQKsTDtOiVabaB1yY5gPTGN9NYTPVAtDWUnx4BHe2C2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rGIRSrWV; arc=pass smtp.client-ip=74.125.226.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rGIRSrWV"
Received: by mail-ua2-f42.google.com with SMTP id a1e0cc1a2514c-9863292a2e9so463520241.1
        for <linux-hardening@vger.kernel.org>; Fri, 25 Sep 2026 20:56:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790395018; cv=none;
        d=google.com; s=arc-20260327;
        b=ggv7O2BUKL/VzNPTVH0n782q7VGza6LxLnUm0xKZ0Tn2B5B9ih5Cs2w+wGPqjQD3H1
         ao7XyE4Ncgu/c5L3aE3hPco57sFIwCkIVE7IH6jorWI1b2VZlDxXnjl7Gea40RpRzts7
         DZhDhMgL9zBV2VoRe7PdPdjkne1y3FNU8mGYkRsaSBwpzu5lMmcSDi8GSGjvFUKIZ878
         AVhqJxuKrNU8kdY4HNN9/leA3dwgrjnIJkT9eDFlUEYduQiEk1AuqzCNZTZagfUzpGm8
         hp1gH+efTgwOLwjlo7YeijhJ/WxqkwwQKtMy0sHrbi0XJsf8ZtNuW8MDJI4pWTUOwTcA
         nwxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=31bXx9DDYtYaMyGphvOilRAP9jmRVAn7WJ7/Gygm+I4=;
        fh=sGGmsN08eYbuduzbU/ThDkyR/uwzRUWrPOBBeind04c=;
        b=KpmPmojkAJofR87wH95WkHjLxzY0xfGe88uhRzdg4g8PexR0ua5zs8zWMuGWgCtLKy
         dlHFzLlni5fKXeYEH4PdM9DVWBpMPvdBCFEGJUYw8amTEGT1TdeJ4P9e1e7prwLkjmUO
         l35uaUcMdj0R9UrrkHZ5P4IXqJ4bRKG6a6YaDi4+un3xUSmqowtflEb2jQqPWnL6L7qj
         55ppbom83Rg0iuX/dbHyrWIqKOEenFq+OzcQpv8OTP/TZ4lbYsTchjiZXDBU/Dx5khuj
         bDKx/gt/xjemk1JFIo2mysZeygcsfzaqv6L6kKnJkAK2j48eEsuMQuZ5AtU9YhxUVop9
         SRzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790395018; x=1790999818; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=31bXx9DDYtYaMyGphvOilRAP9jmRVAn7WJ7/Gygm+I4=;
        b=rGIRSrWVGL8wlG5UhqAbQoK+F7yZOaNmc9nLdr4Jcac2tQr22wQDB1r3Vx+7aFJ693
         HDQT7ITvxNmAGSX7dFMFDeagsz6AyUCD7LtY82rYgqL9RCOxm4vleGeWruEY+Fpi2q0H
         69Me0ZVT+136JVQBHGWzqphA2NoBrifKcJ3oao7LMtxa+QiccmHPjSh78RyjhSqvVOMl
         28QaEBZYBZhGFHnMfqGA774hIykG0b56sGRkG3A34wIdoA8Q9j8YaNChwSzCW0Y0mDvq
         J9dM7niD5sDpOEUePPotRlMRd/4Hgc6lgf4pJ+UQoZYU2XeEli4yPXkYBVkpjI6hhrYP
         PEWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790395018; x=1790999818;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=31bXx9DDYtYaMyGphvOilRAP9jmRVAn7WJ7/Gygm+I4=;
        b=uQQETqb9HkMkZcao5sRmP4hCGKx3hoYui7MyHruvF+SrhVHP0ip9ZHbbUjYmNyufom
         Za4CxRAhfB4aNvvIbBfXmVY3rqUHNThXWGVJoQNFmUkJfixV4h2+Z10lXvzK+p5EqAIl
         qzU9cQ0LIUsBLZp8vnQgs/gpor8kbJjWubpGLTHNmiP9SbJT86kf2Lsg7aYon5HFxANG
         Ae8pwy4VqIRFziQPIbgxhJLXK16jXY+0hEGjm1M8lXusIBgMjLvHIij+gV6if9aQdbqI
         5P8Hbsg/lsebtm98KKpb+wFZkAEetU3Y2Je6i9pAZG6ngC150ZLV4zNIlOJcw8y9ApAr
         gTkA==
X-Forwarded-Encrypted: i=1; AKwUvBy85YUfC6z/k9E39xG/xrFuEE2ziKmJLQI/zI79DuRXETUKXd1AYxbWM1IHMTh26EHULs4hfLycosjSIbRSAf0=@vger.kernel.org
X-Gm-Message-State: AFuF++m9CeWwbcwkBSXm0c1r0n80y2ifSFFnDNeeOcFyrDEWeKT6sPxw
	n3h8Ifb7Hogdk2Xg2JbDifOomgrdgDOwnwfECHHhprFzq1V40CbCE2BTGvUMR2U7j6yUVgm3nQX
	zzhkNE6ouku2T1IhCG1ovnB4zCQbGPrfLVZblAgo=
X-Gm-Gg: AYBFou1yrfi++FFQEe+Or/fdnsr11oApZMeU+tjQYcUpE9Ejr8HFfS/DjSTTX2VPPCm
	Jjl71NJ4hqAKJ4sdtz8qrzeNFPEwe55zUqnMLtVS8foc5umO0QufTMnyJUBPRIj1ps8G26i4SJH
	5K1nwWTpbdNIWyxq8seFKmNpVilsPd0txsIVUJgVUZHtgqfr+JkCS730RFyGCh/+az+rz3glNJx
	/0kOBOzfcyVzQJmabcq8CmZHJpDiqKCsaQUmJTC6FCthONUvjG1xf6vuTWoF6vqbIHX9piW0yjJ
	C9rrcREhezYvdLL6a7AsxJMnd06hFd8Z6SixTNtxBf8+qti0zxzFsNCQaPzMRmwG9FCEVuxpz5d
	0hhosMijprtrADuOci4u+
X-Received: by 2002:a05:6102:512b:b0:7b3:5cb7:49 with SMTP id
 ada2fe7eead31-7b35cc64b1emr468961137.31.1790395017546; Fri, 25 Sep 2026
 20:56:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923055320.2602534-1-morbo@google.com> <SN6PR02MB4157A2693AE5369CA19A84DCD48F2@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To: <SN6PR02MB4157A2693AE5369CA19A84DCD48F2@SN6PR02MB4157.namprd02.prod.outlook.com>
From: Bill Wendling <morbo@google.com>
Date: Fri, 25 Sep 2026 20:56:41 -0700
X-Gm-Features: AclHuK9ZglMRgpOjf7nJE9QEEZwUIEVC7ZTeuasL8ipLCjkjknKZffHOUZ4KyBI
Message-ID: <CAGG=3QW1HvN9Rz0k41jnDv4YMY1-LA0NhiA1B+CqzRfZThspbQ@mail.gmail.com>
Subject: Re: [PATCH] Drivers: hv: vmbus: annotate struct vmbus_gpadl with __counted_by_ptr
To: Michael Kelley <mhklinux@outlook.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Justin Stitt <justinstitt@google.com>, 
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>, 
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>, 
	"codemender-patching+linux@google.com" <codemender-patching+linux@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 6:55=E2=80=AFPM Michael Kelley <mhklinux@outlook.co=
m> wrote:
>
> From: Bill Wendling <morbo@google.com> Sent: Tuesday, September 22, 2026 =
10:53 PM
> >
> > Add the "__counted_by_ptr" attribute to the buffer field of "struct
> > vmbus_gpadl". This allows compilers (GCC and Clang) to perform
> > compile-time and runtime bounds-checking when KASAN is enabled, prevent=
ing
> > potential out-of-bounds accesses to the GPADL buffer.
>
> It turns out this "buffer" field is never dereferenced. The value is save=
d
> here only for the purpose of passing into set_memory_encrypted() as
> called by vmbus_teardown_gpadl(). The memory *is* referenced, but
> through a wraparound mapping created by vmap() from the struct page's
> underlying the buffer. The mapping is created in hv_ringbuffer_init().
>
> Given that, is this patch still appropriate?
>
Hi Michael,

Huh...so it is. The buffer is converted to 'unsigned long' (*sigh*)
and then passed into arch-specific functions, which do what you
mentioned above. Given that please feel free to ignore this patch.
Apologies for the extra emails...

-bw

> > The fields "buffer" and "size" of "struct vmbus_gpadl" are assigned
> > exactly once, during GPADL establishment inside
> > "__vmbus_establish_gpadl()" in "drivers/hv/channel.c".
> >
> > To ensure that the count field ("size") is initialized before the
> > pointer field ("buffer") is assigned, we reorder the assignments in
> > "__vmbus_establish_gpadl()" so that "gpadl->size" is written before
> > "gpadl->buffer".
> >
> > Cc: codemender-patching+linux@google.com
> > Assisted-by: LLM
> > Signed-off-by: Bill Wendling <morbo@google.com>
> > ---
> >  drivers/hv/channel.c   | 2 +-
> >  include/linux/hyperv.h | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
> > index 7e4cc6f55237..7042de2dd481 100644
> > --- a/drivers/hv/channel.c
> > +++ b/drivers/hv/channel.c
> > @@ -548,8 +548,8 @@ static int __vmbus_establish_gpadl(struct vmbus_cha=
nnel
> > *channel,
> >
> >       /* At this point, we received the gpadl created msg */
> >       gpadl->gpadl_handle =3D gpadlmsg->gpadl;
> > -     gpadl->buffer =3D kbuffer;
> >       gpadl->size =3D size;
> > +     gpadl->buffer =3D kbuffer;
> >
> >
> >  cleanup:
> > diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> > index 9e109d91aa14..408748a05440 100644
> > --- a/include/linux/hyperv.h
> > +++ b/include/linux/hyperv.h
> > @@ -780,7 +780,7 @@ struct vmbus_device {
> >  struct vmbus_gpadl {
> >       u32 gpadl_handle;
> >       u32 size;
> > -     void *buffer;
> > +     void *buffer __counted_by_ptr(size);
> >       bool decrypted;
> >  };
> >
> > --
> > 2.55.0.1082.g2b9226bbc0-goog
> >
>
