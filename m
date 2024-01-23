Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1B650276
	for <linux-hardening@vger.kernel.org>; Tue, 23 Jan 2024 22:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706049318; cv=none; b=ZYbuHcbGO3jEkVXo9ANdhL5bb4yR8BEvAdBLXs+Lin7v1aZwPOVVz0OUeArfmEgA9Awa3NjBsgfIJaojczZTBWXKw/8HzesSh+o+hox/wz1MMRGTyBTiK83lKSN5cz3f7+ozjTfwRLC5MdqY+K53EqooGqhMQd0H7qcqNdAonYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706049318; c=relaxed/simple;
	bh=4HZ7KFNLvz+3GjuhRA3NrU10jfjlQt2x42kn4P8Gfg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JYofb6IjE6rgt9a98+4f5YPmrKR5OeAA+TxJCboNQj2AF1a2Xo4fxKW3lu6ie27tzyo0DHtRn/5KJxg6JEw1QnLMFUA8Ad9ZurTQ/c9uzTT7jins6ytM9OMtDDZKA53CqSzZf84/DyyjypvXC4N4mjp7G5jxPoWDLI6FwOyT/18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UL/8q2u3; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UL/8q2u3"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3bda741ad7dso3767925b6e.1
        for <linux-hardening@vger.kernel.org>; Tue, 23 Jan 2024 14:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706049316; x=1706654116; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c6AnvGe+nDcHjURBPGcdHvtcORYZs9pMI2C+Mc0vQNM=;
        b=UL/8q2u3uhSWe6n48rBpIqEHQ5c00f2iilv+GO2hiHwp0Nq7aj3N8wQmxkTVobp1RS
         Zi2KTaUOQGUXDv3Us1l7538B3IZbmjzriFkrdT/8Z5PfADlIklTZTQbAfnN7emS3TlKM
         CrQWpBlMXelYHWItVyB3MUVmEgS+dwIG+OGg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706049316; x=1706654116;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c6AnvGe+nDcHjURBPGcdHvtcORYZs9pMI2C+Mc0vQNM=;
        b=SIqzzisBHACdoTg+3gMWLSGHWMIHiLqV8Id4fcPQH+fI4TbGnjLv4FwnZhiBiUut9O
         ySd4Tp3yeeq+1rgZ9W7Ll4gDrl93WC5yOSAOG/Pl4G31fmvWUcKmzUreyz2pFLvqVM6F
         H1WnqOgO3f2jxlsfLVn0zXnynSI6u3KJUD3PMzEt+AOCKE4VM53kpocjAUsvRgEo13FR
         ux8lgGhRnM+pg9uk64P7h3pdoU2Qo3TesIk9mLajVAa0TYEr4XhEYqois4LBk/ZmeEKU
         XIpSNc2MaG+fmSGRf7YwtZV8tfPy2D0XxfAan3fdWaG2WTefwF28mZbv5sD+lWipG/U/
         dYEw==
X-Gm-Message-State: AOJu0YxsSBfaCT0qmLEfubdAFrt3FBWOB2nDPsvinOYzHq2SETPzUhk9
	kuLGI3C38U1GF3pKkVo2o3ohT53uDRp9aIJ6M6Z/HGJ7zRhxveyV6ipg9uLD0XuNojJVRpVaA4/
	+Nw==
X-Google-Smtp-Source: AGHT+IH6Wm9LU//CqVYjGKX/7agKx4Kncxxv9iSw1pxwiuakH0Ny/I7WoORPxMG+l0RwGcmkYq8/tg==
X-Received: by 2002:a05:6808:1450:b0:3bd:b8d0:99e7 with SMTP id x16-20020a056808145000b003bdb8d099e7mr759504oiv.1.1706049315889;
        Tue, 23 Jan 2024 14:35:15 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b20-20020aa78114000000b006dbd787aa8csm5484970pfi.67.2024.01.23.14.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 14:35:15 -0800 (PST)
Date: Tue, 23 Jan 2024 14:35:14 -0800
From: Kees Cook <keescook@chromium.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>, mail@horotw.com,
	linux-hardening@vger.kernel.org, Jakub Wilk <jwilk@jwilk.net>,
	Salvatore Bonaccorso <carnil@debian.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	William Kucharski <william.kucharski@oracle.com>
Subject: Re: Limited/Broken functionality of ASLR for Libs >= 2MB
Message-ID: <202401231433.FB2D7FBD@keescook>
References: <69fa6015256613ed10aee996e181ebd4@horotw.com>
 <87il3ur1ik.fsf@gentoo.org>
 <ZaVi4ij0jgEz+isx@casper.infradead.org>
 <07c348caaf6b4c457ab4b452f53ed048@horotw.com>
 <ZaWZqnD7XmP5HMA0@casper.infradead.org>
 <CAMj1kXGMPeFE_JAKBhAkh9eqmvEJjucsXru2bjc6oa35oyK4=A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGMPeFE_JAKBhAkh9eqmvEJjucsXru2bjc6oa35oyK4=A@mail.gmail.com>

On Tue, Jan 16, 2024 at 09:09:45AM +0100, Ard Biesheuvel wrote:
> (cc Kees, LAKML)
> 
> https://lkml.kernel.org/r/69fa6015256613ed10aee996e181ebd4%40horotw.com
> 
> On Mon, 15 Jan 2024 at 21:46, Matthew Wilcox <willy@infradead.org> wrote:
> >
> ...
> > Yeah, I don't know either.  Outside my scope of expertise.
> >
> > I received a suggestion off-list that we only do the PMD alignment on
> > 64-bit, which seems quite reasonable to me.  After all, I don't care
> > about performance on 32-bit just as much as I don't care about security
> > on 32-bit.
> >
> 
> For context, the culprit is
> 
> commit 1854bc6e2420472676c5c90d3d6b15f6cd640e40
> Author: William Kucharski <william.kucharski@oracle.com>
> Date:   Sun Sep 22 08:43:15 2019 -0400
> 
>     mm/readahead: Align file mappings for non-DAX
> 
>     When we have the opportunity to use PMDs to map a file, we want to follow
>     the same rules as DAX.
> 
>     Signed-off-by: William Kucharski <william.kucharski@oracle.com>
>     Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> which affects *all* 32-bit architectures not just i686. 32-bit ARM
> user space is still being deployed widely, even on arm64 Chromebooks
> running 64-bit kernels (at least up until recently) so unfortunately,
> we're not quite at the point yet where we can just let it rot.

Is this related at all to this thread as well?
https://lore.kernel.org/lkml/20220809142457.4751229f@imladris.surriel.com/

Can we avoid this on 32-bit or at least not mislead userspace about the
available entropy visible in /proc/sys/vm/mmap_rnd*_bits ?

-Kees

-- 
Kees Cook
