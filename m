Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E171E520
	for <linux-hardening@vger.kernel.org>; Mon,  7 Oct 2024 15:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728313303; cv=none; b=qKenjVUWdNPL0UYe4GWGCWNHrnbWWSfKwxCQEjFyHgBaloz8ubo6IRVIAwNbHRE+U3ZdChSzv24wXPAWuz16k3vRTmGk6jgztW5GZyeTSTO3fyEiNnD+GFyFSiFWhf0ecg6Y0Udcm0NQqj4ssx8pWEcu58kg+RIqY16yyhy62Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728313303; c=relaxed/simple;
	bh=Of3fTbfTUadI91Km6QSnlfHzLgvPLsVxjWD+yFvOV4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sc53graPrVVxDUVswoYyPf+v4UyzRc/1bDYi8hF+1yBXCOuMh4MRf/+KIA3RHAOqTBP2qzUV+FyQkfe1sdZQGUgA/NnDynBDx4+wMrKgCnuhNn6D1EGM8tz31sqlpdBpx/EsJNQ+KpKmDNylzh5Of+rzqhU7C4Iw6dW8fR/px+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EbmcZEOL; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EbmcZEOL"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3e04ea9d715so370267b6e.1
        for <linux-hardening@vger.kernel.org>; Mon, 07 Oct 2024 08:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728313300; x=1728918100; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5jAAFMBYKppMdRXJchSLw0rc6C6JnyAPVbXk9thx1g8=;
        b=EbmcZEOLkHkClCAbOYu8+03DhEprBSh0oBirzogOJ0A79plhggIYNMNGQDU1es/WmM
         QjTbSj4NLpG62tnDOS+XnDqAzMe+S/6Fcqrl3Skgr6uZ6lx28qXNICQTDr2uc9xO8CBv
         VuYXc6fqgONntYqwSuiqzXhrEwu7VbEbowREI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728313300; x=1728918100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5jAAFMBYKppMdRXJchSLw0rc6C6JnyAPVbXk9thx1g8=;
        b=Ewp7a0eohv/xWQI7Q5H4AGSDMZsZxVu4a3+4xcVd/ETO5EAJv6bBzIXQXeH46wrhQF
         b+Z58YmxegehAEvEvQQFYIUnF6/Yz1GsLe7PR7jEWPCgG93rwir+urxSpP80p0NEjX1L
         VeQBepHVYX2iB+JqLmn22iWbSiZEcod/RG1I+m+2+YIeqyyWbUYcv+jQaO8NV6bbeEvs
         BVNFRbo+uOIsagdaSt8YtSqo11G09thG8ihWehCMDG92Tv1V1Mxw8Mw03Z/lU8ckqtgR
         FGuRtaSPWzfDimlBJkvDu9DqF70JaU9rlG4anUceIXHiFcOD6iTGhoBIg5JIkBiyzSvg
         E4aA==
X-Forwarded-Encrypted: i=1; AJvYcCXAGfM0+9manYKmtryxeD+EVOTaX/eQvI35vioy/juNrg/+1LVz4YrgsS1/6X/8O9SDfx41ENKFqWhkomeeFJs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3mKOJ756ynhP3SyCeTV6TPI8Yri3LhsZ5OdC6zn/Ma25f7p4u
	R8SSzzjqsKWqcEf/lcdkcNL9dVcKGpoFsptvVtj/cx40AyQ06Yl1ec4egtDAbPluB37yJs/TELq
	rKspubq+B2RGHnSAmX1BEloDUPZh5l2X6qjEF
X-Google-Smtp-Source: AGHT+IFFTDkuljTZSSM+i7nA189OSRbRxsZF42ePZcfZwT24kjDKYTZ7AaE+3X0QfQ9LOodahDeCiX/tICNJikALAHw=
X-Received: by 2002:a05:6870:d201:b0:27b:9f8b:7e49 with SMTP id
 586e51a60fabf-287c22913fdmr2397442fac.11.1728313300572; Mon, 07 Oct 2024
 08:01:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001002628.2239032-1-jeffxu@chromium.org> <20241001002628.2239032-2-jeffxu@chromium.org>
 <4544a4b3-d5b6-4f6b-b3d5-6c309eb8fa9d@infradead.org> <CABi2SkUhcEY7KxuRX3edOHJZbo2kZOZfa0sWrcG2_T0rnvHCWQ@mail.gmail.com>
 <51463.1728069102@cvs.openbsd.org>
In-Reply-To: <51463.1728069102@cvs.openbsd.org>
From: Jeff Xu <jeffxu@chromium.org>
Date: Mon, 7 Oct 2024 08:00:00 -0700
Message-ID: <CABi2SkXW9atWJLCDQboKwLoXCX7w9sgs7H3Wm4U2soG4cFLosw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mseal: update mseal.rst
To: Theo de Raadt <deraadt@openbsd.org>
Cc: Randy Dunlap <rdunlap@infradead.org>, akpm@linux-foundation.org, keescook@chromium.org, 
	corbet@lwn.net, jorgelo@chromium.org, groeck@chromium.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, jannh@google.com, sroettger@google.com, 
	pedro.falcato@gmail.com, linux-hardening@vger.kernel.org, willy@infradead.org, 
	gregkh@linuxfoundation.org, torvalds@linux-foundation.org, 
	usama.anjum@collabora.com, surenb@google.com, merimus@google.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, enh@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Theo

On Fri, Oct 4, 2024 at 12:11=E2=80=AFPM Theo de Raadt <deraadt@openbsd.org>=
 wrote:
>
> Jeff Xu <jeffxu@chromium.org> wrote:
>
> > > > +   replacement with a new mapping with new set of attributes, or c=
an
> > > > +   overwrite the existing mapping with another mapping.
> > > > +
> > > > +   mprotect and pkey_mprotect are blocked because they changes the
> > > > +   protection bits (RWX) of the mapping.
> > > > +
> > > > +   Some destructive madvise behaviors (MADV_DONTNEED, MADV_FREE,> =
+   MADV_DONTNEED_LOCKED, MADV_FREE, MADV_DONTFORK, MADV_WIPEONFORK)
> > > > +   for anonymous memory, when users don't have write permission to=
 the
> > > > +   memory. Those behaviors can alter region contents by discarding=
 pages,
> > >
> > > above is not a sentence but I don't know how to fix it.
> > >
> > Would below work ?
> >
> > Certain destructive madvise behaviors, specifically MADV_DONTNEED,
> > MADV_FREE, MADV_DONTNEED_LOCKED, MADV_FREE, MADV_DONTFORK,
> > MADV_WIPEONFORK, can pose risks when applied to anonymous memory by
> > threads without write permissions. These behaviors have the potential
> > to modify region contents by discarding pages, effectively performing
> > a memset(0) operation on the anonymous memory.
>
>
> In OpenBSD, mimmutable blocks all those madvise() operations.
>
>
> I don't understand the sentence supplied above.  Is it saying that
> mseal() solves that problem, or that mseal() does not solve that
> problem.
>
Yes. The mseal solved the problem, I will modify the sentence to clarify th=
at.
thanks

> I would hope it solves that problem.  But the sentence explains the
> problem without taking a position on what to do.
>
