Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BEA3921CD
	for <linux-hardening@vger.kernel.org>; Wed, 25 Feb 2026 10:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772014285; cv=none; b=UE3dEpBC0k4jRPx0NXfaceiynxFgkU42evi/TAn4jwaPmZmJGEfsICVa75oynm89qcANGGSHPARbX6uH0DTfL+DkIkjAKYpmvjokkyF7fRqColrc1/nuqfRddsXDdn2DyaxbHcC8xvoPVoQbEpC0dKwsQ20LKq4kPyaNb5EUtUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772014285; c=relaxed/simple;
	bh=tDMxpmvWd64wiFW5JbTOxxEAgZ1+dPmVrDH1cmiS8Vs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d4KRpI9cFViENOAFbKPHnx1JQ6ygucTbfvCIWFgomNzeVrRgJSs7og/TDopd7bwNxDFWmgkYWV6j32T6jNfTFjHpZRETDj7Y5XGa6j8M2IXBF7tUQYAPjuAkCV4Wv2bRLr77FvyPA7HzJr51wGu1zQ+AMfoNOsleRYnn5X6oOic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jbo4rFgK; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jbo4rFgK"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4398913af88so1211924f8f.2
        for <linux-hardening@vger.kernel.org>; Wed, 25 Feb 2026 02:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772014281; x=1772619081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1G1yT2ul3Ys8XiUmvDO5GBct2G1otswN0+Cj5PpvnD8=;
        b=Jbo4rFgKT+myuYJlBAECpNRoJYoRpy3vpgxyjCC5SqMMuJVvQ9uhSbrPgzFF/i9Sff
         Iziwl97ybXk396gzAkAJFytHh1Dlh9jmWWAbKK81xGivi+EsrZPFycvV0J/OeN1GsOx2
         4uZmQEV9DjggiE7AGmb4XqBd8qRyg3HzdbFCvSYPDdNb7P4AHivpmg1FUnYW8ZnMoKkR
         eChttgfyBmq9kVJ5Q7Jauv0UZlW7dmeIo2SAJvjSFeJTr7Y6JJqKkh//pFyXYxFgxKJ5
         IqpzgzMcT9xWUXsLcO0IveXL4QFooOBpiBLJGhcb60CFi7YdR3eqw9Ohe0+FTHE1K5r+
         ZvBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772014281; x=1772619081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1G1yT2ul3Ys8XiUmvDO5GBct2G1otswN0+Cj5PpvnD8=;
        b=K06KhmAkThw4Fvu/mciPrm75oi3O0OB4jLC6qtRMPPiPw/j8gVimR5hja2ayQObGtq
         bg+/XaTvBoG/zSC+D0DUms3Jb17dTItEGk+CFob2Htt7ET31twRj6LAMCzrkawNdnGFv
         7aehy156BGWijGknElRvaevyd+JkxTbkUpXtsDZYridhzFLCPlDVpRZHjKbqRD8JohVT
         JDKq0grNdpZ9DMiibMMaWR0LwHzbKYCQ5NrVr9I+/6pPXblb90UcSVydwN/SZSzFnUmE
         BwV1lPvl/bAtOUI7smeAoMFZgkifg+B2l4gsHDlidnHcQQfnJR+gEgtArW95YBcqYPDW
         L0IA==
X-Forwarded-Encrypted: i=1; AJvYcCWA0igk+UuoBBivlnQYQ0u//bJB5VHN3aYJrG/KTveOmdu33QW8fiDFO3ulKY6p6Sk1zlvNhGr/nEWB67zpaXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDP7PaoA5jIPmJNCenUBJEeWbl2C1vXJ17Y2FCabwJd1WfEm1b
	Qyi6++YM/D/RYCZpj2dI4Kgiw4oJvhaoq9ksk4HT9EDamqZqMDTPSq4X
X-Gm-Gg: ATEYQzy1TnPX6pOGT7qLXwyqZ2fpD+NDXJKEWmJUyDlSlFqVvPLghnlYwznUVlwv+Dw
	RRVMT+OeD3sb9ldLsYqzmCgC/AG4wTtpXQN4O65tDl1/mKiEfOdh0ieJgepOiehwoBvkzLfhwE7
	NYb47EBVM97o82rBWyYh1EFkMiGLopOyQ2+/HxDi34wNXPxqPLMFExPhuqLs3aMIEcLL2R1wCWp
	DC77NIyZtYi2B4eDJ5p/2Gvvok3KQh9CNu8zlFmz176XgJFKwFVLmJq23X6BX1PbjaDK9jaBNHD
	jgPfGFcdoRI96I7EiATtIvAhkH9O1LXyEiAH917QXGhRNe3IIf3UUyY1PdSm3VEdvw46a5+VLF9
	6hKp3as5vrAY/xCybfoX6QHUTRup6+9uu4nLeh3E2TEofzUfS+5HZ7mPJxYc1UnB2499BW0oM/S
	qSnnkrRottiIP5O/HiFcIOG/F1MjxNTuNMRjkG2hSXNn3oWRooVw50gFTTrY6BuXDZ
X-Received: by 2002:a05:6000:40c9:b0:436:3707:2bf0 with SMTP id ffacd0b85a97d-4398faefc72mr2663789f8f.35.1772014280726;
        Wed, 25 Feb 2026 02:11:20 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d4c977sm35315573f8f.32.2026.02.25.02.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 02:11:20 -0800 (PST)
Date: Wed, 25 Feb 2026 10:11:19 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Fuad Tabba <tabba@google.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Kees Cook
 <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, will@kernel.org
Subject: Re: [PATCH] lib/string: Fix UBSAN misaligned access in
 sized_strscpy
Message-ID: <20260225101119.0481a005@pumpkin>
In-Reply-To: <CA+EHjTyWtdwQe3_pyrrC0jfhX30jHwYVNQkgNE7UoeJG0O=NLA@mail.gmail.com>
References: <20260224170427.2296592-1-tabba@google.com>
	<aZ3eKyVXPd-Fvcst@smile.fi.intel.com>
	<CA+EHjTxgX8RpVxdf1rrri8m_=oG-0_KpYzhEKaZXXOr2UXWegQ@mail.gmail.com>
	<20260224230637.38f93836@pumpkin>
	<CA+EHjTyWtdwQe3_pyrrC0jfhX30jHwYVNQkgNE7UoeJG0O=NLA@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Feb 2026 08:33:01 +0000
Fuad Tabba <tabba@google.com> wrote:

> Hi David,
> 
> On Tue, 24 Feb 2026 at 23:06, David Laight <david.laight.linux@gmail.com> wrote:
> >
> > On Tue, 24 Feb 2026 17:54:07 +0000
> > Fuad Tabba <tabba@google.com> wrote:
> >  
> > > Hi Andy,
> > >
> > > On Tue, 24 Feb 2026 at 17:21, Andy Shevchenko
> > > <andriy.shevchenko@intel.com> wrote:  
> > > >
> > > > On Tue, Feb 24, 2026 at 05:04:27PM +0000, Fuad Tabba wrote:  
> > > > > sized_strscpy() performs word-at-a-time writes to the destination
> > > > > buffer. If the destination buffer is not aligned to unsigned long,
> > > > > direct assignment causes UBSAN misaligned-access errors.
> > > > >
> > > > > Use put_unaligned() to safely write the words to the destination.  
> > > >
> > > > Have you measured the performance impact?  
> > >
> > > Not directly. I verified the disassembly for both x86_64 and aarch64.
> > > On x86_64, both the raw pointer cast and put_unaligned() compile down
> > > to mov %rdi,(%rsi). On aarch64, both compile to str x0, [x1].  
> >
> > What happens on cpu that trap misaligned accesses (eg sparc64)?
> > put_unaligned() exists because it can be horrid.  
> 
> To be honest, I hadn't considered this until now. But looking at it, I
> believe that the existing guards in sized_strscpy() already protect
> architectures like sparc from the unaligned paths you are concerned
> about. Looking at the code and configs, these do not select
> CONFIG_DCACHE_WORD_ACCESS nor CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS.
> Because of this, they fall into the #else block early in
> sized_strscpy():
> 
> #ifndef CONFIG_DCACHE_WORD_ACCESS
> #ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
>         ...
> #else
>         /* If src or dest is unaligned, don't do word-at-a-time. */
>         if (((long) dest | (long) src) & (sizeof(long) - 1))
>                 max = 0;
> #endif
> #endif
> 
> If either dest or src is unaligned, max is set to 0. This bypasses the
> loop with put_unaligned(). I checked by compiling this for sparc: if
> aligned, the compiler sees that, and optimizes it into an 8-byte store
> (stx %i0, [%i1]), identical to the raw pointer cast.

That very much depends on the exactly how get/put_unaligned are implemented
(and the behaviour of the compiler).
ISTR something about not using 'casts to packed types' for the them,
which might cause the compiler to generate other code.
(Brain can't quite remember...)

	David

> 
> So this patch shouldn't introduce memcpy fallback penalties on sparc,
> but it still fixes the UB on architectures like x86 and arm64.
> 
> Cheers,
> /fuad
> 
> >         David
> >  
> > >  
> > > > Have you read the comment near to
> > > >
> > > >         if (IS_ENABLED(CONFIG_KMSAN))  
> > >
> > > Not until now to be honest. However, are you asking whether
> > > put_unaligned() breaks KMSAN? I don't think it does, max is set to 0
> > > when KMSAN is enabled, this entire while loop is bypassed.
> > >
> > > Thanks,
> > > /fuad
> > >  
> > > > ?
> > > >
> > > > --
> > > > With Best Regards,
> > > > Andy Shevchenko
> > > >
> > > >  
> > >  
> >  
> 

