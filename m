Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0722684A50
	for <linux-hardening@vger.kernel.org>; Thu,  9 May 2024 22:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715292622; cv=none; b=ShmllQPn05j2lKTqlW91wSbK6wchANat0xhaeVKuXGj2Nyyw5Zv6XzFXqY45Pcf9GuSw4vff5Tk7Za2HexGlNjOC/R7xFs8XIFAzJmGU/SofiHCxqXExKTBFUc8wGAUhlmJMdz99mX9qGIoO4ftNqguk7Nb5dpi9hG9tstneaPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715292622; c=relaxed/simple;
	bh=59mEgVC4lkz46VEjh2qNmxWDlTxiAqyCrQSnZR5NBDU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QAILzXc/8e7858zV9SZ+jvrh/MwBxnyHVVE60HpLdfrAiIR/UuXI0gPB5rb0ae3zzYLcLvd7qs/IJNZRNBVPPKy2l9+oLpA+U7JalNUW7hhNfCDnNye5z3lRZoY2PDZNXuwtHj3fjHM6EWNLftBzz3O3yftCZnPVJaPYfacgPso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=di5Mko6G; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="di5Mko6G"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-47f13801f3aso482148137.0
        for <linux-hardening@vger.kernel.org>; Thu, 09 May 2024 15:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715292620; x=1715897420; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MKdICX+lX8CE08nIGqEYXYRJN4FhWDTtg4wUvpl3cAY=;
        b=di5Mko6GC7T7epR4LNQTDzrknh0xtFQHeQAXuVd9spUmCnpwF/AZHDFEqRR+lW2AJz
         QEQVTH0+KQXE9z4+MITUgcl21Yw5nSjABKPfQ/GOexgxGBQaDp+Nfi4X2oGcRombOJMZ
         Bkg609DfQZUQNQj2APCsc0t34flj+rl3fFdd1QvKMI/w+m4wFaB86vDkTSQgF54hRnjJ
         zgddmDMEjPGwzcRp1XOeiW2H1CcMx/llFwTsSQYBA4qkCP27EUOezHfiwL1lSnkwDfBc
         XKbZx2TIzujommW622COfx9bohLNHdhyFI4Vi5tulbnJAuASS/M2xyVFHJmRXvFi3kE5
         qAVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715292620; x=1715897420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MKdICX+lX8CE08nIGqEYXYRJN4FhWDTtg4wUvpl3cAY=;
        b=m89U3wPwZuaOdeky5URULCRxP937wOpgfI1TNusmDN6Ct4ecVwnyBZRVt2I3/MVBVi
         /TCLQlZJxWt3MEp8DyzGUqKU7BVzPYorwHaL08A+prUWT8Lg8aTB88TysimgelylEShB
         VS5F7oVzMYF3CLwLyeUee3wR2Dc/AdcvzNfW1un8LGTcIALs9tXllAzZLhvB2vObTm7b
         IB8xeW0JCfQCl+hpC0GNA1nRK2FPCEyXh3t9g9GDyFc/unA/ZwSBj5GzMR5kUzbzXkrd
         j4SVs4YAg7o5lWxgICB5O4M8SE6+WPjWawWgPHEO6SzGDM4oNgejRoVhxgMbJo/fmWmp
         OvSg==
X-Forwarded-Encrypted: i=1; AJvYcCWJWbZRNLODOXex7t9JQWTmFc/dsSqNw+kIhoF7MYhhl5kPckwN2LRkUQQ78WJQVYwfkybECdFRKpWFpuOWSQeRT+EXKdh29tgPlsxa8+1l
X-Gm-Message-State: AOJu0Yxtbxox8jYXzHjOdQm2togb4hMfna3hwfQG0TGtILgx/A8EynMD
	Q89HV5t6CtH6UqpHHnkqgMLXmMBzYROjXBleTZFJTAvB0wjTYZQZOtASR6VBAj5Jl/uPQ7fxXGb
	ywbdK50Agjzdcvj0A5Ngm6u7t5dYhrBlY5pJy
X-Google-Smtp-Source: AGHT+IG9UCFfCI7smAQh5zYoU5+Q/8AopDE+XLvDQt4XHypQBrcuB26D5dwcSEX6FTb7qgBIbqU5zgrv8BJ4OSYe5Bc=
X-Received: by 2002:a05:6102:3053:b0:47a:22cd:9716 with SMTP id
 ada2fe7eead31-48077e07a05mr1112057137.17.1715292619999; Thu, 09 May 2024
 15:10:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507-b4-sio-vfs_fallocate-v1-1-322f84b97ad5@google.com> <20240509155356.w274h4blmcykxej6@quack3>
In-Reply-To: <20240509155356.w274h4blmcykxej6@quack3>
From: Justin Stitt <justinstitt@google.com>
Date: Thu, 9 May 2024 15:10:07 -0700
Message-ID: <CAFhGd8opxHhTdZhDg_hq7XWQFxJ34nLDxTd-nBBgye9BLohnqw@mail.gmail.com>
Subject: Re: [PATCH] fs: remove accidental overflow during wraparound check
To: Jan Kara <jack@suse.cz>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 8:53=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
> > @@ -319,8 +320,12 @@ int vfs_fallocate(struct file *file, int mode, lof=
f_t offset, loff_t len)
> >       if (!S_ISREG(inode->i_mode) && !S_ISBLK(inode->i_mode))
> >               return -ENODEV;
> >
> > -     /* Check for wrap through zero too */
> > -     if (((offset + len) > inode->i_sb->s_maxbytes) || ((offset + len)=
 < 0))
> > +     /* Check for wraparound */
> > +     if (check_add_overflow(offset, len, &sum))
> > +             return -EFBIG;
> > +
> > +     /* Now, check bounds */
> > +     if (sum > inode->i_sb->s_maxbytes || sum < 0)
> >               return -EFBIG;
>
> But why do you check for sum < 0? We know from previous checks offset >=
=3D 0
> && len > 0 so unless we overflow, sum is guaranteed to be > 0.

Fair enough. I suppose with the overflow check in place we can no
longer have a sum less than zero there. If nothing else, it tells
readers of this code what the domain of (offset+len) is. I don't mind
sending a new version, though.

>
>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
