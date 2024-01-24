Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2287134740
	for <linux-hardening@vger.kernel.org>; Wed, 24 Jan 2024 20:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706129296; cv=none; b=FG7YXxsIWHB1OfUNAD9XSm605ga5EIhuOyKnzA7jUk/EDngsxA5KfgueLbe7hhdz139REGcQbCwSYa9tccrt+XqQ7WTwQJy5zK64QNpMHqLqieYLQK5ARgSFb/G0BuFPJR7ql3P6AUSRRSiBqzgv159mQ2nnUAkW9yhjYthdMCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706129296; c=relaxed/simple;
	bh=7cPnVJTTwAqS5m/D9fwBaWJXEtqGZq8IcE/AOficsKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sIIbGEVaA7Vs4XJAuLt4MH5i5lt/2ahnP0CQxwAFXRXZDKDAp1OdwlHvSj5MHWfUaq4tbxaAy7jqzYzmxADEwMyhvf1tZbBjUsXQ9rei33Ek0I6LlL6O/lGzO27Xq16Vl6CbgtCfe6lHxQISWpme2pSO2Z2+KsvoWaI4spFTXaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JCf5YSNv; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JCf5YSNv"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-55a5e7fa471so5388024a12.1
        for <linux-hardening@vger.kernel.org>; Wed, 24 Jan 2024 12:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706129293; x=1706734093; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Rk3ry+wMmO/dN2zz3UHRD0lGEi4syprX1/TUT7irM/o=;
        b=JCf5YSNv1AEp68/Ka12er32EYzrHNguUv/zyrA8tULnBiIA+/7Bm5imRwSGEPHJe9u
         8R3gxPxQcloqGfIo/jgZIqjH/621XGstAc4mDpsJDcfx0ku3sybiMhkRnd0/pRI9p0N3
         4hlX6qEFwjW5w63BCmZuPl6b9ZZBig/bUozOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706129293; x=1706734093;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rk3ry+wMmO/dN2zz3UHRD0lGEi4syprX1/TUT7irM/o=;
        b=J1wV1kL7BWaPFcM+7YEreJ7u4ZDwnWH5HV50VlULO89t80UvxLLD/V2XJDewGKea/u
         l8/CVfKaUzjMM3Oyi7D/+ZsN4w7fBTZIh9506GX8enrPLNKQ+FAL7UgRtJUBmfQqoZz9
         sx16aXeaNBc//buZNVoKm9ogHK+9aNHYO4nwis1Lt/M0g7lMmBKdHMYWPLXKheX3a5jv
         vCV++B7k5noxr+Tk7NWw3axb/bbDdohtQu5IGebk1lMUJ96sIpdWjYQ4152Rw9KjdOmW
         sJTCA1i0bQOtjBfSCK372cJ432b0QY63ndvpm7mu3FkH2dCHX1jNJecCyGtRk+M+yd9+
         ZX6Q==
X-Gm-Message-State: AOJu0Yw92u522gvW2kvAXFQ4WGvpHBdiZHT/LgrOnKyGWIMzq65e+X+h
	5p8dpQME3cvESD3AwFH54gZswCW4lIn/s+MV958JwSU7ysXhv5qQHue07DyHAGhmQioVCT8OP7t
	GTeZX3g==
X-Google-Smtp-Source: AGHT+IFyQ89w02dluLIWbYu78MsPX4mbYnV9LioK9hGynqk9Ta0Coc7z7BwTrvD0E6lPUxFikmXPaA==
X-Received: by 2002:a05:6402:22dc:b0:559:d75f:4907 with SMTP id dm28-20020a05640222dc00b00559d75f4907mr4976edb.84.1706129292874;
        Wed, 24 Jan 2024 12:48:12 -0800 (PST)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id e9-20020a056402104900b0055c15c5919csm4599685edu.86.2024.01.24.12.48.12
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 12:48:12 -0800 (PST)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40e76109cdeso65644885e9.0
        for <linux-hardening@vger.kernel.org>; Wed, 24 Jan 2024 12:48:12 -0800 (PST)
X-Received: by 2002:a05:600c:4ec9:b0:40e:a3aa:a463 with SMTP id
 g9-20020a05600c4ec900b0040ea3aaa463mr1545745wmq.20.1706129271244; Wed, 24 Jan
 2024 12:47:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124192228.work.788-kees@kernel.org> <CAG48ez017tTwxXbxdZ4joVDv5i8FLWEjk=K_z1Vf=pf0v1=cTg@mail.gmail.com>
 <202401241206.031E2C75B@keescook>
In-Reply-To: <202401241206.031E2C75B@keescook>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 24 Jan 2024 12:47:34 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiUwRG7LuR=z5sbkFVGQh+7qVB6_1NM0Ny9SVNL1Un4Sw@mail.gmail.com>
Message-ID: <CAHk-=wiUwRG7LuR=z5sbkFVGQh+7qVB6_1NM0Ny9SVNL1Un4Sw@mail.gmail.com>
Subject: Re: [PATCH] exec: Check __FMODE_EXEC instead of in_execve for LSMs
To: Kees Cook <keescook@chromium.org>
Cc: Jann Horn <jannh@google.com>, Josh Triplett <josh@joshtriplett.org>, 
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

On Wed, 24 Jan 2024 at 12:15, Kees Cook <keescook@chromium.org> wrote:
>
> Hmpf, and frustratingly Ubuntu (and Debian) still builds with
> CONFIG_USELIB, even though it was reported[2] to them almost 4 years ago.

Well, we could just remove the __FMODE_EXEC from uselib.

It's kind of wrong anyway.

Unlike a real execve(), where the target executable actually takes
control and you can't actually control it (except with ptrace, of
course), 'uselib()' really is just a wrapper around a special mmap.

And you can see it in the "acc_mode" flags: uselib already requires
MAY_READ for that reason. So you cannot uselib() a non-readable file,
unlike execve().

So I think just removing __FMODE_EXEC would just do the
RightThing(tm), and changes nothing for any sane situation.

In fact, I don't think __FMODE_EXEC really ever did anything for the
uselib() case, so removing it *really* shouldn't matter, and only fix
the new AppArmor / Tomoyo use.

Of course, as you say, not having CONFIG_USELIB enabled at all is the
_truly_ sane thing, but the only thing that used the FMODE_EXEC bit
were landlock and some special-case nfs stuff.

And at least the nfs stuff was about "don't require read permissions
for exec", which was already wrong for the uselib() case as per above.

So I think the simple oneliner is literally just

  --- a/fs/exec.c
  +++ b/fs/exec.c
  @@ -128,7 +128,7 @@ SYSCALL_DEFINE1(uselib, const char __user *, library)
        struct filename *tmp = getname(library);
        int error = PTR_ERR(tmp);
        static const struct open_flags uselib_flags = {
  -             .open_flag = O_LARGEFILE | O_RDONLY | __FMODE_EXEC,
  +             .open_flag = O_LARGEFILE | O_RDONLY,
                .acc_mode = MAY_READ | MAY_EXEC,
                .intent = LOOKUP_OPEN,
                .lookup_flags = LOOKUP_FOLLOW,

but I obviously have nothing that uses uselib(). I don't see how it
really *could* break anything, though, exactly because of that

                .acc_mode = MAY_READ | MAY_EXEC,

that means that the *regular* permission checks already require the
file to be readable. Never mind any LSM checks that might be confused.

           Linus
