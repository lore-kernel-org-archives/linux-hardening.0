Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F522190070
	for <linux-hardening@vger.kernel.org>; Tue, 30 Jul 2024 23:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722381534; cv=none; b=mDlUZAN0Koj4SqKruUg6BFooS/oMAcptzSvJ4Aytvb1S5x+uEwHHUtYeC9CxfBuje6TdmolGy52WuxN50u1QFEqjeBW+R4aEh8VLTAh7dSQs+JIrbgQ/W/kMhwTDnIqS6rKQ+O/KoN6qCB5b9OKvqeK3Dq1+F5CDiPHA9xnswEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722381534; c=relaxed/simple;
	bh=L0PFJlPNg2nSFAwbo1MUufU0ZJpnKOJlq9Zz7UzENlo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N4vipWR8BDcLYHr/CBZo0kxOIE/ZkAJ5XsQMPWdXD2ceapmjDLZkRAiCtCpL6AT8YFr1dDVLBh4601y09h32TT26otd5hTX538kUiWA3FJZf3kM+TEgXeQ9jwH4vfg+HwOHwYc2NU3BMBukfiuBj/9Bh9j8txKDvNfb+wBdcPQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LUyH/i+4; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LUyH/i+4"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5a309d1a788so6996511a12.3
        for <linux-hardening@vger.kernel.org>; Tue, 30 Jul 2024 16:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722381531; x=1722986331; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w4KvUDxCv3JZzkJ14qFXFaCRicGT3v3Xu0J6Fixv6r8=;
        b=LUyH/i+4jDT5bE4URJyTFujqpAZxmWvwf/xO57JopMjanlblkfWQTssjMnjHklDkEp
         seDlFF3A/f+EpadRHhLdClF69n5TG/Inkr6x0JNLV5WwPytpKP9NtH5rv7NeJd9L/ROZ
         9h81OFdMh05qQpkjOJ8e4/jGCCebIZEsEDWtk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722381531; x=1722986331;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w4KvUDxCv3JZzkJ14qFXFaCRicGT3v3Xu0J6Fixv6r8=;
        b=xF+H6JCjTp5xN31hNfjcEOzotXLyJEriIsdwP9FhHMEFPghCfzj+I9wUaQ5pjXL3LZ
         8RyRAAO/7CSj4ygNRbAUw1sEJOqMulVat2+UWjA2JtGGqHcEEhWXcVJ4EaBhcSGfzkF3
         aHLGCSFIhU7UB2EhoFmvpu4JLc2WM4IQEgeAPOmj/DCuQWJlxv6Ra7PS1FB6IEQ69ET9
         5PPTcyamFATjvQHUvSGJdfn7m8YhSUcylZubYac6FhHkOg4V1meOq0jhZc7xixgl8LFB
         pjakxM91KoHGcQ6PDwHlbGBvGrRqpR4FjkFtCedV4nD05y/jk3jnN6hrMD5xHOr8T7R1
         OgNg==
X-Forwarded-Encrypted: i=1; AJvYcCXPLXXGYzdKFVTiW9GtRiK8ja4g3ysODO680JJhVjwqkjrFhBhibiLLxUPu/lzJBO5D9n+vb+BevTtlKm2xByUv/pGtNBxuGi+uAXv6lYdi
X-Gm-Message-State: AOJu0YyENSStPVHWN7jUeLJiv52eyTc2446FdnmObXsIRD5VoPYHQ3yJ
	bIFfUs9xLtE24+mvTHPWoerhF8FRg3xaB+px3MXiiJ+ehe4bfzhpTP8yl5eOSQyKHzXgRMRJM/X
	4w+smgA==
X-Google-Smtp-Source: AGHT+IFlP7p6sv0W5RZvP/kgbe9V/PcSIUzTn4IaxwPVmCIs9nv7sd4yVrYcf5VonESIC2u436Vvig==
X-Received: by 2002:a17:907:1c19:b0:a7a:b643:654b with SMTP id a640c23a62f3a-a7d40160ea5mr901095766b.50.1722381530589;
        Tue, 30 Jul 2024 16:18:50 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad416basm698573866b.104.2024.07.30.16.18.49
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 16:18:49 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5a309d1a788so6996487a12.3
        for <linux-hardening@vger.kernel.org>; Tue, 30 Jul 2024 16:18:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW7eU9Xq4X6keWoV/N97fSgjuTk4JHhCKFvkCcNvlYHjHK4492HnX/tz25fDtVOv53eXYPFrGteKBus9c1iKzFuhzRjARQor+H1M8qVKA2z
X-Received: by 2002:a05:6402:430d:b0:5a3:3cfd:26f7 with SMTP id
 4fb4d7f45d1cf-5b022a95ad0mr9903249a12.32.1722381529467; Tue, 30 Jul 2024
 16:18:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730132528.1143520-1-adrian.ratiu@collabora.com> <CALmYWFumfPxoEE-jJEadnep=38edT7KZaY7KO9HLod=tdsOG=w@mail.gmail.com>
In-Reply-To: <CALmYWFumfPxoEE-jJEadnep=38edT7KZaY7KO9HLod=tdsOG=w@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 30 Jul 2024 16:18:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiAzuaVxhHUg2De3yWG5fgcZpCFKJptDXYdcgF-uRru4w@mail.gmail.com>
Message-ID: <CAHk-=wiAzuaVxhHUg2De3yWG5fgcZpCFKJptDXYdcgF-uRru4w@mail.gmail.com>
Subject: Re: [PATCH v4] proc: add config & param to block forcing mem writes
To: Jeff Xu <jeffxu@google.com>
Cc: Adrian Ratiu <adrian.ratiu@collabora.com>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, kernel@collabora.com, gbiv@google.com, 
	inglorion@google.com, ajordanr@google.com, 
	Doug Anderson <dianders@chromium.org>, Jann Horn <jannh@google.com>, Kees Cook <kees@kernel.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Jul 2024 at 16:09, Jeff Xu <jeffxu@google.com> wrote:
>
> > +               task = get_proc_task(file_inode(file));
> > +               if (task) {
> > +                       ptrace_active = task->ptrace && task->mm == mm && task->parent == current;
>
> Do we need to call "read_lock(&tasklist_lock);" ?
> see comments in ptrace_check_attach() of  kernel/ptrace.c

Well, technically I guess the tasklist_lock should be taken.

Practically speaking, maybe just using READ_ONCE() for these fields
would really be sufficient.

Yes, it could "race" with the task exiting or just detaching, but the
logic would basically be "at one point we were tracing it", and since
this fundamentally a "one-point" situation (with the actual _accesses_
happening later anyway), logically that should be sufficient.

I mean - none of this is about "permissions" per se. We actually did
the proper *permission* check at open() time regardless of all this
code. This is more of a further tightening of the rules (ie it has
gone from "are we allowed to ptrace" to "are we actually actively
ptracing".

I suspect that the main difference between the two situations is
probably (a) one extra step required and (b) whatever extra system
call security things people might have which may disable an actual
ptrace() or whatever..

              Linus
