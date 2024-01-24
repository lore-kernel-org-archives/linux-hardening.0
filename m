Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC19134750
	for <linux-hardening@vger.kernel.org>; Wed, 24 Jan 2024 20:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706129514; cv=none; b=eERCSLmb2lFbibEArsfrK4LGPSg32deIo7ZhvvVmKtSzgKGq8fi2SRzc1DjliwfLTK3uy34j1CdnqPrJ4sD8Ky/5x/D4ic5hXAMYo7Q08YqLzrXwXUsboQsFHMae4QrxF0d5oKTi90n2+JBXj8pfTb3Qf7tRtBFtOK99pf0e3yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706129514; c=relaxed/simple;
	bh=8AHF91uvt8/XRr8nVpdx7OTkc9kUJK+Zdwkb7E1C+tM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H9IpMe3s2kl0uj09gl+MWxBzO1uD6/XCs+HQYbjSFvYTZu4Q8qwQJBX5BdP55tSi+VhuBf9VrDvjvcexGujqB2+KLtaBFaUEGFuUGou8hyyxR+9u8YjSJwJNeGaXxnvrnWDyDfjRB5FHFVC5NtaSx3LXvYV1mZqcfN3sr8H74Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QQSaSBKc; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QQSaSBKc"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-55c89dbef80so72a12.1
        for <linux-hardening@vger.kernel.org>; Wed, 24 Jan 2024 12:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706129511; x=1706734311; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8AHF91uvt8/XRr8nVpdx7OTkc9kUJK+Zdwkb7E1C+tM=;
        b=QQSaSBKc5YXRrwseT28VLCXtVbUV7E9Jtd5kb0ypblZapUB9tDqWdtW/mMUMI/O2Ti
         KfZs9FX4LFcnev1OX1te+yEtwvtIZttYte6zHJGP2FXcLJLiEyNiqY825ehFNXC/k+EC
         /hackWXgSmqIVPqjIMqXfvuZ8n4R6zJDGptfgjjnCj0qUgEpETladENJuZqUMhLQsIMK
         NMHCKThaIMl5Cm7T3cwHqPfUL7LjR2Wnhe9jEiZ5qDX9Q5jB6YksnZAkwzAFcjcz6YeK
         XFNvQrPkMckc5mxcR57G7tAcrdehDi+1YysgeQ4jlw7tl9pegfzFgy8/g64iSMF40EN7
         Utrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706129511; x=1706734311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8AHF91uvt8/XRr8nVpdx7OTkc9kUJK+Zdwkb7E1C+tM=;
        b=pGOjUmCDJTeLz1stK4rC709qb171QpFrWX/Jfh02zaHsde17bLY2p9om813JbrHyaa
         zvoDYRyZj8sNrPX8q3R9An2xT0VVlmzielfCIJyhM+fHT8xj+QaUzixVjGN8LSPr68vC
         yj33ETJ021IsfllcUEtoBpgECXvI6DzpLu+d4R+pLR1eXuengNkPamJuMToNpuThDr8P
         PUVvkKE8iQm5hqxWqpTQE3nW3aLZWRC5FJpJP/zBy2dup6gZ5X6X2k7Ty934cXkvZ73S
         CvHp1xeahUDYJxr74sTr9hnLnXcjx93mi0bM6C6ntgW7d6uSHqrcCg8vmJmkduIv7Hjp
         H+WQ==
X-Gm-Message-State: AOJu0YyfMdka9+4G7sZXB0gHdSFgkfhvPUfEj5NJ9ed9yVvKBXfnH2n5
	4Ua4bypvorjEJBY/fYLB4ot1iz6y2YZozaB8fDa0QXKTSHKZVFmvAmd2ZXO/62sU3uU/8abPX07
	RneotCHkJ/tYeAd/dxMudxhdWy/vUN/3szbhU
X-Google-Smtp-Source: AGHT+IFSJu3YtHxJ1C9xsiD6VboT0OpL149sYEOn3JiasNKwbqmVCWDsj+0AThh+onMYWiLSwFji1svlzJHw50Lzx7w=
X-Received: by 2002:a05:6402:b77:b0:55a:7f4e:1d62 with SMTP id
 cb23-20020a0564020b7700b0055a7f4e1d62mr47583edb.4.1706129510820; Wed, 24 Jan
 2024 12:51:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124192228.work.788-kees@kernel.org> <CAG48ez017tTwxXbxdZ4joVDv5i8FLWEjk=K_z1Vf=pf0v1=cTg@mail.gmail.com>
 <202401241206.031E2C75B@keescook> <CAHk-=wiUwRG7LuR=z5sbkFVGQh+7qVB6_1NM0Ny9SVNL1Un4Sw@mail.gmail.com>
In-Reply-To: <CAHk-=wiUwRG7LuR=z5sbkFVGQh+7qVB6_1NM0Ny9SVNL1Un4Sw@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Wed, 24 Jan 2024 21:51:13 +0100
Message-ID: <CAG48ez3v=dWVNaLwQi_f0j5X2+g5e9ubuaZoEkivsCTVK5u24Q@mail.gmail.com>
Subject: Re: [PATCH] exec: Check __FMODE_EXEC instead of in_execve for LSMs
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>, Josh Triplett <josh@joshtriplett.org>, 
	Kevin Locke <kevin@kevinlocke.name>, John Johansen <john.johansen@canonical.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Kentaro Takeda <takedakn@nttdata.co.jp>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Eric Biederman <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 9:47=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, 24 Jan 2024 at 12:15, Kees Cook <keescook@chromium.org> wrote:
> >
> > Hmpf, and frustratingly Ubuntu (and Debian) still builds with
> > CONFIG_USELIB, even though it was reported[2] to them almost 4 years ag=
o.
>
> Well, we could just remove the __FMODE_EXEC from uselib.
>
> It's kind of wrong anyway.
>
> Unlike a real execve(), where the target executable actually takes
> control and you can't actually control it (except with ptrace, of
> course), 'uselib()' really is just a wrapper around a special mmap.
>
> And you can see it in the "acc_mode" flags: uselib already requires
> MAY_READ for that reason. So you cannot uselib() a non-readable file,
> unlike execve().
>
> So I think just removing __FMODE_EXEC would just do the
> RightThing(tm), and changes nothing for any sane situation.

Sounds like a good idea. That makes this codepath behave more as if
userspace had done the same steps manually...
