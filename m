Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E941A1D14F8
	for <linux-hardening@vger.kernel.org>; Sun,  1 Dec 2024 16:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733072105; cv=none; b=W2ILT9UXcWYkIQfFlAN95X9pDGF2u3QIefYCjeRKyLOB3xS8SsguICheOMlrUVKONEnyUD3Pr0mRrm387tVLlgxH0jpx1mmlM60bwI96kMKrI4JKBEsKRn2YC8eX/CKY85LX1gdGdoMXh2l1N7ab0Va/I+Zge6MxcsSdkYsA8h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733072105; c=relaxed/simple;
	bh=Wu7aLMR8bgAYmwBV8FIHf7YQhTXWw6T7z4NKroXjPYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Onbpi/ME2QsCuzzpnZjBtAMiANspFnlTb1g0g/D0lz9DO6NMTtZNErLkpYbia99Ktr/74UGYevNMH7gsLckAyyP5bgNxjY7vnHKNRKyH1a7jl5xzr0B1pBXl4JEkQFpGtCU22z1RsLf9eyypvLyJNHzR5HcnV5u68QjsZCeup+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UWgX+UmK; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UWgX+UmK"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d0bf77af4dso2319901a12.3
        for <linux-hardening@vger.kernel.org>; Sun, 01 Dec 2024 08:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1733072101; x=1733676901; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q5z2s0WfIwLJLVHUR6snQ9W2d5ktmXbetex9wVs407g=;
        b=UWgX+UmK7LRq2nzfgf8gr/9CZ8HOdaG+5xpojOoWeoMM2IoisRw2+ud7d8tyoGTIdu
         vAMuYwkmfxizWOFTqUSsyhLyMb4mMu48iT/UnBPKi5y08UIjbksto0rPlnvcF6WOSwoB
         G0dEFkX1alr4fVTRq+ZNCmomMaodvBfS2Yzyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733072101; x=1733676901;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q5z2s0WfIwLJLVHUR6snQ9W2d5ktmXbetex9wVs407g=;
        b=FsYLOOL7Yf62pEN3fMxg3bXonOCCkkgovONkDePRABTTQi1LkMTOtiO+EpSwST6ic6
         mCWSRXKid1Bj4oYTj8M6lIAIkxcYRXs9vtHob9ma0UqTaAdjay3tUvQBUwmeIJEDQV9d
         oaXkinu4xilXP+i5SoZMHhshBXV4lLhMxbzKu6lKhZRM3XFyiGGcI0rZlLLA1H0hq2QH
         xoZmrZZETPZO8hmILNzJfr/xMpNagT01hODGO8Wve/aAMemZE3QkVjbCLv+9+8A/b9Mx
         w+FNbok/CKoeNvJcDO21xofq8d+28ihiqucuSn9MDSpVKX7O/XbF+6x3ql9SIx9Tjrvr
         wQtA==
X-Forwarded-Encrypted: i=1; AJvYcCVt3O72aHOLHD6G5yy085YmL6PH4nYaBQMGX+m4pqbLgO97s5YNypyYWXb65GHTQ86IjMGD4jPnRfeawxv3foA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTu3026rKoXZZnzUIpqPFN0ucBDjTWmSwtIjQRDfZOj+3kUKHn
	AnLIfVnG8RIXL3MhKx87J00s4V2pJ3yeIxWUFlv/6SblIpGCO0muCHLgMGyf9qqqDoiFKUYyLy1
	ZC7o=
X-Gm-Gg: ASbGncu0GQ9a0TYIDPYkAYM2yYjaHyZPYDfe82HCV5/BcWAvtWY5G6p+USGIju5O3n+
	P6T1BN2VgtIvh6yPmiOHNW4BW60W0Zn5ukHS0PKwRWRF7MtI72IDh68bZV7YHzo4X8ZPY5KlzAy
	kZTQBSDdmNLEqKG6MS0q/9mPrRjTnxdQCGSo3FVceV371n4XGE6sJ3k5ysaSN9hE/up+5aK7sZR
	6jh/izh6Ftt/atj8qkta3+0UNgojTKuJX3DRbHSEC81zjPDXXp1Ca28XVlF7HzB+M2aNZhTUTjm
	2eN3dJ7scoHrmvfFTUa9TQns
X-Google-Smtp-Source: AGHT+IHOBPZaLaZNdFxHpd7ITf0CgzjqkC+m3+lWT/vKBE6QL3Dnu6QeB/sG53MLRScAWlJ33QubXg==
X-Received: by 2002:a05:6402:5243:b0:5d0:ea4e:9ad2 with SMTP id 4fb4d7f45d1cf-5d0ea4e9c07mr1535298a12.17.1733072101023;
        Sun, 01 Dec 2024 08:55:01 -0800 (PST)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d0c757c8d4sm2122463a12.46.2024.12.01.08.54.58
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Dec 2024 08:54:59 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa503cced42so514251166b.3
        for <linux-hardening@vger.kernel.org>; Sun, 01 Dec 2024 08:54:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXYcO3FbWTWtx/Ynxt4F2XnFxE0qe46g9Qn1cGdzgGb0FEkcrH53EaKUl3awlGgSW3qEgItnOLKLv49VIY7l3w=@vger.kernel.org
X-Received: by 2002:a17:906:3d29:b0:aa5:1699:e25a with SMTP id
 a640c23a62f3a-aa580ee98eamr1451183366b.10.1733072098046; Sun, 01 Dec 2024
 08:54:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241130045437.work.390-kees@kernel.org> <20241130-ohnegleichen-unweigerlich-ce3b8af0fa45@brauner>
 <CAHk-=wi=uOYxfCp+fDT0qoQnvTEb91T25thpZQYw1vkifNVvMQ@mail.gmail.com> <20241201-konglomerat-genial-c1344842c88b@brauner>
In-Reply-To: <20241201-konglomerat-genial-c1344842c88b@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 1 Dec 2024 08:54:41 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgcbq=2N8m5X8vJuUNgM9gpVjqpQzrnCsu19MP8SV5TYA@mail.gmail.com>
Message-ID: <CAHk-=wgcbq=2N8m5X8vJuUNgM9gpVjqpQzrnCsu19MP8SV5TYA@mail.gmail.com>
Subject: Re: [PATCH] exec: fix up /proc/pid/comm in the execveat(AT_EMPTY_PATH)
 case
To: Christian Brauner <brauner@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>, 
	Tycho Andersen <tandersen@netflix.com>, Aleksa Sarai <cyphar@cyphar.com>, 
	Eric Biederman <ebiederm@xmission.com>, Jan Kara <jack@suse.cz>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 1 Dec 2024 at 06:17, Christian Brauner <brauner@kernel.org> wrote:
>
> /*
>  * Hold rcu lock to keep the name from being freed behind our back.
>  * Use cquire semantics to make sure the terminating NUL from
>  * __d_alloc() is seen.
>  *
>  * Note, we're deliberately sloppy here. We don't need to care about
>  * detecting a concurrent rename and just want a sensible name.
>  */

Sure. Note that even "sensible" isn't truly guaranteed in theory,
since a concurrent rename could be doing a "memcpy()" into the
dentry->d_name.name area at the same time on another CPU.

But "theoretically hard guarantees" isn't what this code cares about.

The only really hard rule is that the end result in comm[] needs to be
NUL-terminated at all times (and hey, even *that* is arguably a "don't
print garbage" rule rather than something truly fatal), and everything
else is "do the best you can".

Could we take the dentry lock to be really careful? Sure. We simply
don't care enough, and while other parts of execve() are much more
expensive, let's not.

              Linus
