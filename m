Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2AF37F315
	for <linux-hardening@vger.kernel.org>; Thu, 15 Oct 2026 22:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792103369; cv=pass; b=jNP3qw6ovNtr53FIy5GhRtCJ6CaMNZRslsviezEOeWqQu7QByzRvr2kp84yYRnxrf67r8fkJPIdv8sWzi+A/zWRGwt3Z+dSNeEVJYmZxGUIM+uw9b1sM4lYGBzLIlemImDP7qm+6+LVFYbDA+J1LlmnZ576VGlYREQ33gKUN7LM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792103369; c=relaxed/simple;
	bh=AXRRS22uutXkOu3guPUe2GbkmsWxR1BXKHyZbsJzLy4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TWT562wexlkLOLVi/xKODlDntsalpRiKfavLz3sM4IHi86jgl0yEZBQoijd4J0SeZOjtkAedGjulrwzZJx9pjAyMsZNbprljsJr1+jKOKsr3W3jmFUcJEh/jDOA8uJYIyLpOnz0DpWSa/4HxyUo2msgImt8dSNQrd3ZE+5lErR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NRVAjXEt; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NRVAjXEt"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-535f598d126so53541cf.1
        for <linux-hardening@vger.kernel.org>; Thu, 15 Oct 2026 15:29:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792103367; cv=none;
        d=google.com; s=arc-20260327;
        b=E5TQxECcX83ZOcP9ZxfrE1MR7NI1p7jWbjYrp0KrUNo2N9MWD5zD19DKyfgcsQiVFA
         1ZUnTWchuMjN951lnkzrLCA312HG+BhUTTeXOzMNikUaCWipSUSjus2oST5x6T/nviW/
         BnXNNH1/GM7jACBBkCYB0KJnk5q3pzO/dTk31hZaR8okZ9yZJZtyhUfXdpc0TWYmTipA
         UyXghKZt2083J9+8KVjeR9ZeeFyXIaEPFCiMJFoWFL3fT73TK2+z9CJjTDY1qQU72hUW
         1/su9D/EETQCESnDM07QnCberyltUq9pZDfm6g0+syu/HsoOVP4zNlC/PWDr2FWrEBdw
         TR/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Fx0meqXkpmqmZ+T0ZUXv6LFbVHDOrz59U8bjk3O4KlE=;
        fh=G1ovsXbZaeOkRVxNl9k7FjDBmspaahpSQYRKMYsV1bA=;
        b=tBUHKIet5VpgqrTNN8syUz4o6IhWYr4LXxVrZYliKoS+k1uy84HrkuU6gvsG0JSv+8
         QOi9iK8+wFJPC0VDiUuRn3FODbWiGnmp4xh9RP5G7Blcb46emH1LsYRs6AzTAfX9NZ4a
         EBdTWZ14CdMhL90Ymf6d2O9jMKDAckB+jDYvdI4Bf8cYPrTsJpFyiegJimP4g9v3dEzI
         Nr8jolEdbUcXDDZ9UP1xUP7f1z9VhzWhAqaP6PXT3gEk5GLYN+CmYJaOQE+1rV8n/ogo
         Oiv+l5Q9aWpDKIuIJyF7r1Xf0QzYqcQMLxWEvjQnnbsZMdVuzZ8XKeS6f+B1Hs9UpAjm
         Efjg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792103367; x=1792708167; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Fx0meqXkpmqmZ+T0ZUXv6LFbVHDOrz59U8bjk3O4KlE=;
        b=NRVAjXEt20dCgTC1AdDpGbOXmNtHTqK3ykULgg9QQmKY3yCKHMT8KPw2ao7Ln27DBR
         Usl+Y3wt2Y7k8Z8uCzEoetaxmOLL0n+g8rrjsfVsJKFzRVYCxZIDLHRTnMkNJtSydYxt
         fCESTcbCsNXnZ92hd1VUi5dPtA1i8Fz0vcM9tsGzkJ/HKu/4gr7IElT9ybmcdhSFirj8
         s6Tx+j3LWwMODjwNeKBx2JLnVi3H7JT2FacHoYXd5/jwj8tQyrm5tYxTvrNrs1jFekNI
         hpHBcfHiXfMf5jqLLoT8gAmtkjsXSHJFXTQWtLz9Mut6QpoYOieEhcyn9fBoN6juG3oL
         zNZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792103367; x=1792708167;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fx0meqXkpmqmZ+T0ZUXv6LFbVHDOrz59U8bjk3O4KlE=;
        b=EkyGvZD1KFlzRpIYhFxijQYfXfAjNwzYbiEmhnoQRjW19qR8jL6nOtyTavA8A/DNzO
         nFca+h0mkGjJqzx57YWpgwcdXspDDycgDNmyk9aL6vFG0EA3do/rASWJGdCtgkej1fy4
         dMQeQMeG4EbWpn3mrPua4KXi7BPAPQycOpao3iez7DGke2FrRm1bNDmc3sdbUoV2S+2b
         7oCd1AFn/GMAh35U7te02qgmkmPUM3BW1+4yVZKAMsexPU6duc4nVzOxmCnPJ/GKx5hu
         1D72QATB80JPV9XEYu4fP9WuHCgmcpxlNG+A9Cme1x26u4be7iG+vT4ko0YlbhEZM43q
         NN/A==
X-Forwarded-Encrypted: i=1; AKwUvBzFabS1/I7df8/qNUE1Nkpfi8PxmGCBnuyq9GoFxndYOrSZBc6lAQSshwoV/LA9lLVNaRRDmCfuoddkD0QwXdg=@vger.kernel.org
X-Gm-Message-State: AFq9FYK+8+9Fcguw9xMyR6AlaUquWyqJQ4bxKVHJbCM+DTTN+YZtc447
	Qet1zCsKK4Wjmpx/R6R1Tb2GToOJy1WjeBOW9E7TvhGEeWlq+a1w9VZfCY6iFg5O/P5A8cTi/79
	F67MteEOoH7sT67hP0AR4DEQDheWvi8aViS/XIhJB
X-Gm-Gg: AYBFou0H6zt9+wQHKh2pJjOaxFdf5m0mHREhTG5N4sDdOC6d9kyqhiuvfPzFmz6TsuO
	zXz75V1vpjQKO/EQAu0PTys37h30Kwx4Mj3CVKUPBFV9ALuogB0cZJ7bsuSAAPKY+hj0jya3FQC
	saQR1OcvbA0xVuXqEV4Q8r7hJm7qtWRHV6Tvb71v9vC8mrb1cySx6rmOiz3RqKUhtC2DXM6pQ5h
	l9bhixUdcsD0zK0f9ENUE9erhG2CP4lQIHMtXLA877WVMgBgRIVP2OzQ0hLOokpbx/+npmFKBG4
	6p4EYDrYv1L/g9UATKWrIZEHz3YAm7GUYztmLk8gd4qhSDgNNABizsNg82XQ1T2RJUJH1giS6nX
	A80labbYfjA==
X-Received: by 2002:a05:622a:1a89:b0:535:30a:76c7 with SMTP id
 d75a77b69052e-536297d3336mr5010261cf.3.1792103366183; Thu, 15 Oct 2026
 15:29:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261014225811.i.852-kees@kernel.org> <20261014225818.3457479-2-kees@kernel.org>
 <2026101517-profane-opponent-4523@gregkh> <CANiq72m_iyquf4Lc8AWvbsBp++ASz4+C_MQ5iYQW-fHd_MNDxA@mail.gmail.com>
 <C46E97AC-3722-4264-B541-04EBC3091E00@kernel.org> <2026101532-fantastic-deafness-e04c@gregkh>
 <CANiq72=wS5NJyeKKaYiHKWhDq2Wjk728qkCUNq4xVoHrPEPCRw@mail.gmail.com> <2026101515-oversleep-related-e4dd@gregkh>
In-Reply-To: <2026101515-oversleep-related-e4dd@gregkh>
From: Ian Rogers <irogers@google.com>
Date: Thu, 15 Oct 2026 15:29:13 -0700
X-Gm-Features: AclHuK_bhqpBXC-6cMMrPjeFLsPs6nuRXrMV9IFwDJ4QNHEyGqQj-Q86H0SV0Zk
Message-ID: <CAP-5=fX72cGXtOVYFK0Fr-XMWtr5nfmdr0y3dwVeUcuAueW3Xg@mail.gmail.com>
Subject: Re: [PATCH 2/2] seq_file: Require explicit initialization of struct seq_operations
To: Greg KH <greg@kroah.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Kees Cook <kees@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-fsdevel@vger.kernel.org, 
	llvm@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 1:50=E2=80=AFAM Greg KH <greg@kroah.com> wrote:
>
> On Thu, Oct 15, 2026 at 09:47:34AM +0200, Miguel Ojeda wrote:
> > On Thu, Oct 15, 2026 at 9:11=E2=80=AFAM Greg KH <greg@kroah.com> wrote:
> > >
> > > __must_init might be smaller?
> >
> > That sounds fine too. I like that it says that something *has* to be
> > done (like the original name did). Hmm... On the other hand, I guess
> > "must" could sound like one has to initialize the field "somehow",
> > i.e. writing:
> >
> >   struct S s =3D {};
> >
> > definitely initializes it, yet the compiler would warn. Would
> > "explicit" hint a bit more at the fact that one has to actually
> > "write" the field, even if it may have been initialized anyway?
>
> "explicit" is a description, "must" is an action that tells the reader
> what they have to do, so maybe "must" is better?
>
> Anyway, I don't care, naming is hard, either is fine with me, I'll let
> the authors of the patch here pick what they want :)

Fwiw, I like __must_init for being both short and intention revealing.
I'll hold off sending my v2 for kobject::release to avoid renaming the
attribute.

Thanks,
Ian
