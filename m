Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE638BE9
	for <linux-hardening@vger.kernel.org>; Thu,  9 Apr 2026 16:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775752640; cv=pass; b=nXNfEyx7NeyCxUUerQPAOk6XsiQgvTUGgB6Nyl155mACoK3fByFVYzTIb2g7WI8V3gPiWMc/F+Bmmv6HrFNEm6thqDGfujVL9yN1EbhyMgI67fLZM4d9PqS/49vMP421Q4zdpiTvuH1M9WWyKrnNMKMguUqIzdVxaA4ljfE6ZlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775752640; c=relaxed/simple;
	bh=0/YeY69ktax7xAvFlmlWRIB5ZF6q0vZYsf5nGL0qfHE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SneFkdDPvW1Zc/i3pQtq7/RP65Cut/dRME+b3mlbugiPITvuNBACG2JQY2j20crcaTgWWPZ1gNNK2V8tPg1rgYSGMRfMNBZpol6M2iAbxU56RsOVA03ZmgMVk/4yicuKBIK3Vp48EDyHIr7np+95yCnrG/FPq6bBSKvitCs5CXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g2WlRB04; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2WlRB04"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b932fe2e1a7so139909866b.1
        for <linux-hardening@vger.kernel.org>; Thu, 09 Apr 2026 09:37:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775752638; cv=none;
        d=google.com; s=arc-20240605;
        b=HnYKTh3jeBeZJBQ4oYuDwVQLm3NtWpN6rY+Tourjg5vBLxeuIimNR1jUZoLFhwYxdf
         rQh7h6PDzp7LY2R/6kkANBdw9prSlBiE9Bf+TPnT7OvKOJjtlU9Lgy9VlkcIT7qqgvD9
         szIDSxIf/omQRrbccy/posYxdqWJHfCLNRI+hZ9vjkyYtEyiQBV845SnfZj6uFEAyTdv
         jAluFD0VCYyQ4FdSk7Ph3Y5Lg46NEjOEtElsk+W8YZhhBeT1o/SU0UIth9T0NBLcCKKJ
         pStLtGJHRpHDgGShaFZxkIh/cPT1JiP95d+cYkzA0ui+vJZ9aYT2AT9QlFw2wqHyeFjl
         1Z2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+UAGY8HPWBNZ5o3qgVOf3XDwl3FBEuhdTjIiA2jewZU=;
        fh=IS2HyrqgXXQlkiQg0vVFzlk+jfM/WHbUfaqbk/Ej5Ug=;
        b=LxGINvh97RDWhN59oh+hHYuqLOOUqDMvJ2yMX0KsBzR5FPjzyk1MrQoOUr2G+lzYuu
         h2wr5QtvSwzxkg5l0vqFXvSNfzbDpS2bteh5wIx9k8AiE2Ai9lJAE3JYnJud4mkb34EY
         +Q95/W6+zbozPBIJwPUKLhe5u/+3TmWsV8ggaol7Cca76PQhmRHzOBsLe+uhgcbylA1H
         N5qpHu2AwoPJU/TGYqmLl2rTrqye9Ai7E5XkTJAsJhBiRAmGQxwQ7Pj0D6PVbrtGHqjv
         COQKLEtW5ZAGymN0LNydbGzsx/SqfT5UkqC3MH6HwcuaC+SyAdkvvpT8OP60j60Z9ePM
         4YkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775752638; x=1776357438; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+UAGY8HPWBNZ5o3qgVOf3XDwl3FBEuhdTjIiA2jewZU=;
        b=g2WlRB04I9NdWkCI5EIbZgKgPbH/UuxOCaCaK72rSr6QXHsHO04AmcsSfnEs4pQTgD
         HGXbor73gWk8C6pjFpCSgs6zfWktmElumo53unQsfyYUMP0njx3OJzzpzARfX0HJ+QkU
         DbpNetQvGkTbvQ8pF572zXdtECBTHHowIprd5QMLsPEcMUmLEeNuqTRSJv9eeOMKruTd
         FbdBqnxHBlPpvOIYBlHefFP9x9OTmdMzODChGbVZcmZYR1BPIMBBCpHkYPAejUpI1SNb
         EJXukkPSfnYQj3Eqi+Vqb0Ak7bkiBZGLXEztPsSdomNtbI7C6Ff8FVvIIdJrLdTGpe+p
         tV/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775752638; x=1776357438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+UAGY8HPWBNZ5o3qgVOf3XDwl3FBEuhdTjIiA2jewZU=;
        b=kud7MGGDIHnoUl+PLNS1rLwkfT02CHIp4WveZ5ipX1mk1nApUJ5wej3W33KzyEHFBg
         1sbm8SFCrv1IJxEhcC2Piw8FU+pRlDMRQ0sO9zQ4ElFuyr4nmGmqMtiTqzk9CIXX6p5P
         pX5hGDBSdLzX8k/bCeUazkUDooFD77Tx4yFTo3iuSvn2ituS4sZNb+OOhJjaG08kIZih
         oO134VlSO+aF4XQy/HQY+PI1dNBxMypQ+QEtWP7pm9/k9X9WOJOPYDvnqxwaKjm4tQKo
         laXoM+eIKtZQ1b8kahBObBFxDEtCohbVj97HGmKrqeCJwwKIaYhoDBCKQ15FiNwGfoEG
         dJCg==
X-Forwarded-Encrypted: i=1; AJvYcCVyo6j0E5bOyhMf+N3YUrKWk+R95xe2TcJt1bs94DWkStRAhtfahEmOUmfT7OaYmiTev2Fi8+n136l1ytnh2Tg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+bH7TZw22LoFV8zjhXemEZW+Ry4pYaDTQN64lH+ZnNhu9QiS0
	L9KR+57ArDdrxi3WWXLAHyb+9t9AqIfReTz9AYk2Vu06rJsrpXbta3aJies+s4QIvzpi+6BNLnN
	sM9L2Aoz5uQN51Og/mrXmS48aBVdCumg=
X-Gm-Gg: AeBDieu2ulaojUwfm2cIbi7ysFQ/vOXQN/K80vzZbzGV6ZNZZ8XuAyHnBiYFYcFyvkS
	mfOVBRMM5DZQXbyeCMcteaySWqXwDhWSc3erp6zOjC3hPeq1PG/rpsPqu5b4eNqTVqWLeGQqjLg
	JtOhc50lwCB94GUJN/upNcNVzKKc+QqqkYT+NUAPtOh7Mmmg+j3To18u02BkAsQoaGIBMnWiy0d
	T8pleRCxDf64puA8SMygkI9jf51FjZc2uEPZgD70QKVRkft8HwiYN6cdyCHyvC7jRobA91ywp9x
	BJk80DPS0u9V0WJvaM1cNzushcuzvUQvRigiqJtHV3KdR4A2RkPltnkZeE1frRbI11Db6kP4npP
	HEyKp8g==
X-Received: by 2002:a17:907:a2c5:b0:b98:427e:218d with SMTP id
 a640c23a62f3a-b9c67957b5dmr1371549366b.25.1775752637713; Thu, 09 Apr 2026
 09:37:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327030310.8502-1-rosenp@gmail.com> <adfTdfty7q0nygeo@zenone.zhora.eu>
In-Reply-To: <adfTdfty7q0nygeo@zenone.zhora.eu>
From: Rosen Penev <rosenp@gmail.com>
Date: Thu, 9 Apr 2026 09:37:05 -0700
X-Gm-Features: AQROBzAopIFp8uM7IAtQmj1wGMGJ-yWga8r_OUIuPCkKpKHali845xMLuNe82Bk
Message-ID: <CAKxU2N9tkjDeE6Zz6diMEMT4uNzYg4D36gow0BTbaC=AyAeT3A@mail.gmail.com>
Subject: Re: [PATCH] i2c: atr: use kzalloc_flex
To: Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 9, 2026 at 9:29=E2=80=AFAM Andi Shyti <andi.shyti@kernel.org> w=
rote:
>
> Hi Rosen,
>
> along with Luca's comments, I will ask you for one more change:
>
> ...
>
> >       /* Protects aliases and use_mask */
> >       spinlock_t lock;
> > -     u16 *aliases;
> >       unsigned long *use_mask;
> > +     u16 aliases[] __counted_by(size);
>
> ...
>
> > -     alias_pool =3D kzalloc_obj(*alias_pool);
> > +     alias_pool =3D kzalloc_flex(*alias_pool, aliases, num_aliases);
> >       if (!alias_pool)
> >               return ERR_PTR(-ENOMEM);
> >
> >       alias_pool->size =3D num_aliases;
>
> this line is not needed anymore because kzalloc_flex will resolve
> to alias_pool size and will set it tu num_aliases.
I believe that only works with GCC15 and above.
>
> We can remove it.
>
> Thanks,
> Andi
>
> > -     alias_pool->aliases =3D kcalloc(num_aliases, sizeof(*alias_pool->=
aliases), GFP_KERNEL);
> > -     if (!alias_pool->aliases) {
> > -             ret =3D -ENOMEM;
> > -             goto err_free_alias_pool;
> > -     }
> > -
