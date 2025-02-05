Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A3622C328;
	Wed,  5 Feb 2025 12:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738757900; cv=none; b=ZH8KtqKNuLEnxIOruqJiUfYecr0A4wmhBawaypk7kxr01ErleY9VaODk3jEiwDgHl/d/piXna5jQE0gJQFouJRbqGR0mOW35OCV03QqGJSFeOCU+XUiZiI+ZHmAoIz4EguJ/ixUoInbvGl/YMyarI7wJCBgCg2SOz/HExb3/yD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738757900; c=relaxed/simple;
	bh=fR+cFt4BZQLkpdvtnfLohX+19rk0r0+rK9SVAbMmxYg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=carLjLVhKqdhkCcc1mmOOoQEd8Rx67TISOc9I5VoGK/V7pnb+UXl+zZFwIiIhRidrYaCjpRSvLR2YLFW231FWzivQ0FqMQgfy2tkYKP1MgRsxorCje1pf03ii8i1jl/vgf8ZP4kRF53ZUxVDR8uNqFiT88NaF5MT79NIt8PndHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SLdiLpIs; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SLdiLpIs"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5dc75f98188so10841322a12.2;
        Wed, 05 Feb 2025 04:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738757897; x=1739362697; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p06UyUghuYW91CsxE3GRq30kKC6rXBlgYtHonuFNOdI=;
        b=SLdiLpIsKWmpMUq5UFDvvyYGpyUuPnzfVfg+lXp758KhYlzhbwuxIolitpXOtdlBcA
         b8f5URJ642ErRlhJgETsvrg4LMYUnW1Q82G5YokL8RWDRyNyRWYifnxGiLuZ2Rd0Blcn
         CmYW9qDHEdx6QcMZg9+YFWun1YJSfgba/4kcC8eU147P4svxGy5SUx4g+cN3obLoQZuJ
         pyQjefyBHsgROsRwJaE66U8K/mIj49BybtNDlfySD68BKBHLNPsGOFfXJQRidkvRMdfq
         YBQ9DrvV4CwcE2TZw3YmjN42Q2S7GMo+q2vJ5c20h2yLqPhhpWHx6dL9SoiAsmGIAzRs
         72zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738757897; x=1739362697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p06UyUghuYW91CsxE3GRq30kKC6rXBlgYtHonuFNOdI=;
        b=STigjg2zcc8ZBeGInZhcJUyfNYw26xd+0iO5/FOm9PiO08Xi1/6M918uEFgrCPoVFe
         /NtBPHFx7XDevDdI4nsWNH8Nhq2h6RVq8PQ45y9Og2V9ZX7jXFQSdYCve/XTEz652L5N
         gWEPN2TH5KuWhQQJ7677iaXHXjAtvRDFDfF8m1HPPxQCnjF9I6+yl85X/YvdysILLnYk
         YNdEDmuOfU1W6H/QpDmtBnmD1WZtFv5SCDQrgFIICvEzrPgbsAxbL8WV/+OG/KsuoBfX
         H85fs/S3Aqch0YAzuKy21T5lFZScb6fRHbY8NigTLTLrJow26DPt5GES+D1mpTbLsywM
         BUSA==
X-Forwarded-Encrypted: i=1; AJvYcCUm8PgS4tKR7sRjiK45QpJBw2ikRpPX2V3SdmdDKUUt8mBqE34yQjlMuRhnrJ5//J9yKlGSw5xINqM3U4GyRhM=@vger.kernel.org, AJvYcCWE1Jm1bbnt4nEiIif8uVEbbhPey/Bj518SmVz9u9rAFElgdM2PPBxian3p8DIIU1WLkLL8MU2ZpgbvhwOJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxSCMj7qkTpkEMq38aMQrhzAsaBmwtWUfJkLJbJaCEtXx8E3toQ
	oOwc97klKUfK3ITpMPxitRtWtnrPnIugJCQl10U70CGiD3mElPs4O5eAzB5/YHkTr1ehuFk6kF5
	dXCuV3F50pLEk5C2fOb7ItGctCIY=
X-Gm-Gg: ASbGncu+eBC9QOazS7MdniPoxrR8djmBOfqvaegpKl79xzG+kTxHFtYe3K/aTt9Uwtd
	qrTUYoPQaV/jmAN8jSde/d6E4ww8xePQI3RqTxhMHrGo09wONbJEYGjctzqJInibnnPwoc1s=
X-Google-Smtp-Source: AGHT+IFeX+/obu7ox8PSNyj4uND9bjMg4Y3XV6IaQYWfLu9eUVM1KsKrD3Fv1nq/hLAssLVakajUofJswFM1RoTahQo=
X-Received: by 2002:a05:6402:5d0:b0:5d3:cf08:d64d with SMTP id
 4fb4d7f45d1cf-5dcdb779fb9mr3123510a12.32.1738757896835; Wed, 05 Feb 2025
 04:18:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67a1e1f4.050a0220.163cdc.0063.GAE@google.com> <CAGudoHHCXHA=7e8M=6jMVqbh8=keRBBF8yHvDm9PnyeN6Bb7Xw@mail.gmail.com>
 <202502040717.FCEFDB7E0@keescook> <CAGudoHFszbdKkPibU_ynbj_PSyHewxTxWT_-hR3=8GHa46ebaQ@mail.gmail.com>
 <CAGudoHHWsuVse-Ek3zOuOh-mBxaWRXYVr9W_Uef46K0_mxB0ZA@mail.gmail.com>
 <20250204203059.GA909029@mit.edu> <CAGudoHFvLiCnCkAQN82qhdqmy0P2=Ywtnwqkc3KOc3s3hUQX8g@mail.gmail.com>
 <CAGudoHEv+Diti3r0x9VmF5ixgRVKk4trYnX_skVJNkQoTMaDHg@mail.gmail.com> <20250205052651.GD909029@mit.edu>
In-Reply-To: <20250205052651.GD909029@mit.edu>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 5 Feb 2025 13:18:04 +0100
X-Gm-Features: AWEUYZkBF2cxzU94WR2mFC2eLUAkx0XtWDm1ZPapWQsMexh_fxOzU14uHyYbuR8
Message-ID: <CAGudoHEkekF447FRTZL0GQsDwGi=VNr1vkwiDuOuME3YEpP0Lw@mail.gmail.com>
Subject: Re: [syzbot] [hardening?] [mm?] BUG: bad usercopy in vfs_readlink
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Kees Cook <kees@kernel.org>, 
	syzbot <syzbot+48a99e426f29859818c0@syzkaller.appspotmail.com>, 
	akpm@linux-foundation.org, brauner@kernel.org, gustavoars@kernel.org, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 5, 2025 at 6:26=E2=80=AFAM Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Tue, Feb 04, 2025 at 10:25:29PM +0100, Mateusz Guzik wrote:
> > >
> > > My question is if that's legitimate, I'm guessing not. If not, then
> > > ext4 should complain about it.
> > >
> > > On stock kernel this happens to work because strlen finds the "right"=
 size.
> > >
> >
> > So it occurred to me to check what fsck thinks about it.
> >
> > I ran it twice in a row, it *removed* the problematic symlink.
>
> Can you show me what's in the problematic symlink?  And does the
> syzbot reproducer trigger a problem before adding your symlink
> caching?
>
> What would be really great if you couldcreate small focused test case
> that shows what's going on --- ideally something like a 100k file
> system, ala the file systems in the tests directory of the e2fsprogs
> sources....
>

Everything is in the first e-mail I sent you, albeit a little spread out.

Corrupted image:
https://storage.googleapis.com/syzbot-assets/7c2919610764/mount_0.gz

The bogus link is under file0/file1 and readlinks to
/tmp/syz-imagegen43743633/file0/file0.

ext4 sets  i_size to 131109, while strlen on the thing is 37

The problem happens to not reproduce with this testcase because of the
nul terminator in the corrupted symlink. Because of it the kernel
prior to my change only attempts to copy the 37 bytes.

Suppose the corrupted image got massaged to *NOT* have a nul
terminator in that symlink. Then the kernel-side ext4 code without my
change would still only nul terminate

So this:
                        nd_terminate_link(ei->i_data, inode->i_size,
                                sizeof(ei->i_data) - 1);

Clamps it to whichever is lower -- inode->i_size or sizeof(ei->i_data) - 1.

The call added by my patch uses inode->i_size unconditionally and
trips over, so one could argue this is a bug on my end:

                        inode_set_cached_link(inode, (char *)ei->i_data,
                                              inode->i_size);

It definitely fixes itself if one strlen()s and that would respect the
termination, I'm going to send a patch to that extent later.

However, that aside, there is definitely something going wrong with
the symlink to begin with (size vs actual size disparity) and the fs
should most likely reject it in the first place. So for this
particular case I argue my bug only manifested itself because of the
prior bug of ext4 accepting this link.
--=20
Mateusz Guzik <mjguzik gmail.com>
