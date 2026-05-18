Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472FD38F95A
	for <linux-hardening@vger.kernel.org>; Mon, 18 May 2026 18:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779130795; cv=pass; b=UJcKOURPIwh1SiQzM2zcNYP3HJ680Ju3Bg4mgCumBXLP9eFNZePe7sWs2QIIV+5RbGZeWZqDNzQxnYbaob9azetKxao9rezk3r1vVYb5nKV67XxMrjZ5gLhwrU7FQxhZc9NiOi4enh91qHcH/mlcBeHLgP4KPk/XMLFh8QgJ9BM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779130795; c=relaxed/simple;
	bh=dyypnGTPAbgYfVefP9g9uTGtAYGNrN6Dgbk9OMbK1Hs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hfN+/RGIBo/kUwmjjpqKK+xYK3X/UITU9mB5jxFsgEGgvve8xV28lqE/hqVsqB5BC5cO/Aw5KfGgQPARJQa+dK4vXlFvJ8600skoCWBoCQq85dK+0fnIukhsRX8rFvbqhT6YjFi6JQDq73Ed8pIBxe/5TN+6aXB54LLP3T2pJ4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MbXTQR2K; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MbXTQR2K"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-671588ab0cfso29a12.1
        for <linux-hardening@vger.kernel.org>; Mon, 18 May 2026 11:59:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779130793; cv=none;
        d=google.com; s=arc-20240605;
        b=EYaNNt0FEiCv835VEA9pejued9R0ATp9b1piN/lvytCpkOLFx1Iru/59MBa8kUo10d
         LJ+063D9bmpsPymTQwrwWrGnvpRb5I/5vLYsiOqibZe/CFOZ0uM+ARxFrjiISAj8onXJ
         iWyrIw1C1bs642P++6Luwa9IXCuAWH4VY6LwXeDTeBrxmcHgSjaDXzZs8TuvIOgQ5zEi
         lcoWWi5YWculuDVwrWbUu4M2OtTdcN9CvZ1uDsu5NKvnYsizGT/qISWSip2y6EFhGAtB
         oyPa0s8HvHOeezlUfc7KNnJqNFNDgrMbixyjQBypYHI0nwceMB06cioGRNdGHIZwwjU1
         fatg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dyypnGTPAbgYfVefP9g9uTGtAYGNrN6Dgbk9OMbK1Hs=;
        fh=fd1ZWMAb75AVIAvmS1e6EYYWZSCY0MY6MixXqmSyIGM=;
        b=GXMdgPg3C9p/xK/+JyFp2rPeItr3Ez0xevBlFFfsXIM7k8BC9IkSdYkObGzdWDp/8w
         j183UVPDGHpDRcIeoGU+8aBUoWKMAJ21WmKBRESHI40/+oepXi9fmdO0bkxq9jp59FIS
         Yz01mGyfOQgtQh5clZ3F+JGpZZLqPyH5xbHlytdtkLfg/bB40+vB6qsj0BFeZruPUnMn
         A6CA3xRmsUTPqNhjCMKGmy5h1dMPr9u8o6B+MXFHF6HXz98Ml0jYRrZtHqebYX+A479A
         ++PCg/IzAWGzfYv3LnlqLxhoHAHzJ9JcrnYD0CNyNixoE/KBx4aSqd4tWug5hMCOwoTV
         T1KQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779130793; x=1779735593; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dyypnGTPAbgYfVefP9g9uTGtAYGNrN6Dgbk9OMbK1Hs=;
        b=MbXTQR2Kpf3Xfl5M280xPRbvdgo+gR2vtrEEqA3ydY7IFiteCAJDeO5hlyqv8/4LvR
         P423+iH0NZUGkmxRGIiqCifqgBhPVH1SjRzky4o1bt5AEkEtlvNb3Kc7IBN/G+TQlcwi
         GwyjfhjFMqxbwfvhlzzAaz6tQaZLAvgW1u6U+BJE4/IeF90LEtphCNo/D3WY8DluK47m
         Ny9dPYbMiC067ULGy/9v7LKyEF4brkJJ/Q5Mn5vfNXng51VG91QnOdQzz/f5ffU1naHC
         6/hM39ScNm8mpMhL3L1tM5QWIca4PYydFdogGQ5foC8vi4A7owMoykGgRq+QczIFMolF
         vZTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779130793; x=1779735593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dyypnGTPAbgYfVefP9g9uTGtAYGNrN6Dgbk9OMbK1Hs=;
        b=QKufHoqhrT4HWEJ3y0Pw6q5yx6zQix5Z/dJA+JE6E6l6DzMRv10CTzgVJMCJIbGYdl
         lwveLDhMtSR+VeolisX5Sbp3y1FJaQTo5vmloAPHRKAbjYycJmKQKgZa2YZ+mY8B7zs5
         B0y6n+GQpQDGpzuhkpum1tJBV0Mx+Zizowolf8KC5Xu/KnhlkH9WhSjfU8FKSArmDZVW
         x2gQmbSL2gDMP/TX8zx6A9ZrXObxoNLS4Afbt0WJ33uck9ZtCw0qUZJNEvqFCFY9WVuQ
         Y4fOaBtD7MG6kcf9kSlqLLQfdL9A7qJ8s4NaroPlwrwij/FdvO1ayj7m8F9o8ZxL/u8M
         0WeQ==
X-Forwarded-Encrypted: i=1; AFNElJ/mKXcGSRsp+GwY/uoCin5FMtVwcprtLAsqvM5wASDIa85n4JYknElM9krvBBI4jwgRwwre2Cu6QJI5huWr1Rw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhqB48wDWdwDkPiBUIdVtJX4sXOCgEizvonxxRLNeROtdAUo1E
	4n/qkipqvN1FFI8tvgL5K676AMYz2TUErpx/dJjl+UZXD+qNccFNdsWfn4fVPhY9Ke5mwl73upC
	3zzug59ODn5geFtLSoyJIgfWKqUwgXCuHubvcZQwL
X-Gm-Gg: Acq92OFrkBHPKPheJ3BbPvhwaE+5fDqJEl9XlhmyQp/+xSHUnwLzIuGKf3EH+W0XFNp
	nhuvCK6SHoVQFMc8rUm5OOKvwh/KZbtsGK0brmEC7XgArxhLGUjh876AnDzpVdNI5HiBw6G49nj
	vOp6fJOgRvKh2kZb4LazyERpvLKPLmobvFAm5OkMZO2BNkMfcIjtygSwxvx3GmmtVZjIM8gmiVI
	2/2Ti9YKr2vCABqlanAvKNeMygBbEP40xeleRYSIIjA778VuXCLlZGZ72TEWiJ1NbogNnIo5Xrv
	ohi6KEyxBqWf36lJkIOwLXoWsZe2LO6sNdEhMi2HAuacPok=
X-Received: by 2002:a05:6402:a587:20b0:668:c2b6:9fa2 with SMTP id
 4fb4d7f45d1cf-684986efb13mr83277a12.7.1779130792215; Mon, 18 May 2026
 11:59:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260516182126.530498-1-pfalcato@suse.de> <20260518-starten-messdaten-3b8aa670ec85@brauner>
In-Reply-To: <20260518-starten-messdaten-3b8aa670ec85@brauner>
From: Jann Horn <jannh@google.com>
Date: Mon, 18 May 2026 20:59:13 +0200
X-Gm-Features: AVHnY4LvxvBtU7IvbOZw7RgET8Oa9vmPu-ETaJy_kmEvSdqRrpv4JPgUqfOI0wg
Message-ID: <CAG48ez0jbSUgT3ZxPKZP7Eu=K7ce2cX7k2NzHCHNMOxQjOGT9w@mail.gmail.com>
Subject: Re: [RFC PATCH] fs/splice: allow for a way to block splice() with
 read-only files
To: Christian Brauner <brauner@kernel.org>
Cc: Pedro Falcato <pfalcato@suse.de>, Jens Axboe <axboe@kernel.dk>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>, 
	Mateusz Guzik <mjguzik@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 2:30=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
> On Sat, May 16, 2026 at 07:21:26PM +0100, Pedro Falcato wrote:
> > Since the advent of vulns like Dirty Pipe, Dirty Frag, Copy Fail
> > and Fragnasia, splicing a read-only file is fundamentally unsafe.
> >
> > As such, as a mitigation, add a way for users to block splice() for
> > files they cannot write to. This eliminates this whole class of exploit=
s
> > that use splice()+confusion in pipe/net/etc code to gain write-access t=
o
> > files they can only read.
> >
> > Users can simply toggle fs.splice_needs_write=3D1 and suddenly splice()=
 will
> > refuse perfectly legal splices() from files it can only read, but not w=
rite.
[...]
> At that point you can also just ENOSYS splice() and vmsplice() via
> seccomp and force a fallback on non-splice codepaths that userspace has
> to have anyway as splice() isn't supported unconditionally.
>
> It feels like a knee-jerk reaction to an exploit class originating in
> buggy modules that we have little control over and we would extend an
> API to users that is really difficult to use.
>
> What might make more sense is to add a splice specific security_*() hook
> into the code so that an LSM can deny usage of splice in whatever way it
> wants to - bpf lsm or in-tree lsm.

I feel like a sysctl for "disable all the splice-like interfaces and
zerocopy TX" would be reasonable to have? Either by blocking such
operations, or better, silently downgrading all such operations to
normal copies.

FWIW, vmsplice() and splice() are also weird in how much memory they
can implicitly pin - if you call vmsplice() on a single byte in a 2M
THP page, I believe you'll implicitly pin 2M of memory...

By the way, another bug a few years ago of a similar shape was this
one - also a bug in networking code that can lead to accidental writes
into spliced pages:
https://project-zero.issues.chromium.org/issues/42451650 ("ktls writes
into spliced readonly pages")
with fix: https://git.kernel.org/linus/c5a595000e26
