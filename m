Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD30B379
	for <linux-hardening@vger.kernel.org>; Sun, 21 Jan 2024 00:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705796213; cv=none; b=fxNLqSNaduMXGhYgxxdLWsjOtG3Np8gWwim9sdyqX9y3bdx+3LpZ/LvbHW6gEhLsKcfaR95+1Xt5/M6e9R6xRgaAHYPNjwY+6mMH1j/wBhD+Oz1BW2TPPLoAYPNA1fF9JLRZ09lSlpgoJKwun1ADsd0jJLr9E0/I0qUfu4EULwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705796213; c=relaxed/simple;
	bh=/C66J7wkQwwS2IqQ96WKFgsVf+pRy97LkmCeeYhVdP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YwnKWebeCCjZiq1oHkwXqUFZaCd5ExFr8Y0spj9KZXg/AcnkkBB94ZbY/fs3mh1PJeymyC/WKdg8wYDUCMVOjsAXMdFOOXwxtUXuD0YZw/jIN6uNb6tbkgidZFEcKzJTFQ3BJL5MCrhP7a3gspkwLjLCQDVHGnf6bMNJ7mhDDvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jb6xoVCm; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jb6xoVCm"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-210ce33ea1aso1115517fac.0
        for <linux-hardening@vger.kernel.org>; Sat, 20 Jan 2024 16:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705796211; x=1706401011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VGx1uUqBJNwaB067t1zS9OZh+thLjfiev6N5olOliBQ=;
        b=jb6xoVCm4erIHuii7QR+BQMXQW1udD1XI2eGpmGrRN07v1b8g2Dans3F6BK64Hguzm
         agWG9o5d4WAs+bSZfi/Q6SQQaidl50E81tkc5ANVEDAw1sEsgqRkaAHEwRGh5ZQ0NAbL
         EjhBG8lpCf1gr06FhT8gVyDJyUCm3wAkpYBL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705796211; x=1706401011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VGx1uUqBJNwaB067t1zS9OZh+thLjfiev6N5olOliBQ=;
        b=wtCtmgnSOPFLHUQlIw0X/BnSG4kezdTJnzlMEaD13ha/aL/q9pjXTxYH6FIMHjm1oK
         EMEuIGvVZQq8dHRqsQAu2PtsT9X2BRcNWKoYyZATekx9Pq6joCSyfVXjWtQTsnwvvbdh
         ZoJcAZm7m66L66TS4kRIciAe1udClZ5oc42Nqscaa7Xsfxtp1SPwDM3othD/gNdnPu9Z
         SJi64R5SM9NdGmGoJeEzENqcXl80MNkZvJsRZTphY5sLI5W5koB+xrsCwWizYzhVZBgT
         eho1yEm9HVJVNDmCJ+XyrvSg3S6jIkCvTowlJItOyyqrTvepmVucI/5Pj/WCEW7FGE3S
         A7Ew==
X-Gm-Message-State: AOJu0Ywc1WPQ7eRyAiKwIi3SKBSA1YpX0EEs1dKAPO9/S3ZTMgDWF5Fl
	ieOYr/ZXBE89W9SG5veowinw/O1vgAEr8fjF/fOU2R24QQOa8xyGU3JvZcl126E8D3I/ahHclCW
	ABIjZM7ksRwLSB35JcchBssBW0/DEY+zZV4a2
X-Google-Smtp-Source: AGHT+IFwp+DKXCAKoixsZuns+yTYxxlyPCYBxSpYdd1fXnL6rdiY+k7qeKJU05Nn//cgId/cR/5b/LaiwJxnDuIsufc=
X-Received: by 2002:a05:6870:2e06:b0:210:8df6:3b04 with SMTP id
 oi6-20020a0568702e0600b002108df63b04mr2269701oab.102.1705796210854; Sat, 20
 Jan 2024 16:16:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212231706.2680890-1-jeffxu@chromium.org> <20231212231706.2680890-12-jeffxu@chromium.org>
 <CAHk-=wgn02cpoFEDQGgS+5BUqA2z-=Ks9+PNd-pEJy8h+NOs5g@mail.gmail.com>
 <CALmYWFu39nzHvBmRsA326GcmV9u=eM-2aCGOvLK31rrb2R9NEw@mail.gmail.com>
 <CAHk-=wh_VViVZxjiQ5jtB0q=p=JtJMj2R24UAmj-fL-RNLWxNw@mail.gmail.com>
 <CAEAAPHZpYXHNPdca+xfj77bwYaL6PY-c_oQ54r+=wtJa6_hmCA@mail.gmail.com>
 <CAHk-=wiVhHmnXviy1xqStLRozC4ziSugTk=1JOc8ORWd2_0h7g@mail.gmail.com>
 <CABi2SkUTdF6PHrudHTZZ0oWK-oU+T-5+7Eqnei4yCj2fsW2jHg@mail.gmail.com>
 <78111.1705764224@cvs.openbsd.org> <CAHk-=wgdhbLeY=pEY27m4OQuDAn9xkzSLHwE9D8m1Dw8a++n=Q@mail.gmail.com>
In-Reply-To: <CAHk-=wgdhbLeY=pEY27m4OQuDAn9xkzSLHwE9D8m1Dw8a++n=Q@mail.gmail.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Sat, 20 Jan 2024 16:16:39 -0800
Message-ID: <CABi2SkVXgyG4r-SzkXx0-MOQ2dqhy1ewwhvfXMJLw066i1zJKw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 11/11] mseal:add documentation
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Theo de Raadt <deraadt@openbsd.org>, =?UTF-8?Q?Stephen_R=C3=B6ttger?= <sroettger@google.com>, 
	Jeff Xu <jeffxu@google.com>, akpm@linux-foundation.org, keescook@chromium.org, 
	jannh@google.com, willy@infradead.org, gregkh@linuxfoundation.org, 
	jorgelo@chromium.org, groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, pedro.falcato@gmail.com, 
	dave.hansen@intel.com, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 20, 2024 at 8:40=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sat, 20 Jan 2024 at 07:23, Theo de Raadt <deraadt@openbsd.org> wrote:
> >
> > There is an one large difference remainig between mimmutable() and msea=
l(),
> > which is how other system calls behave.
> >
> > We return EPERM for failures in all the system calls that fail upon
> > immutable memory (since Oct 2022).
> >
> > You are returning EACESS.
> >
> > Before it is too late, do you want to reconsider that return value, or
> > do you have a justification for the choice?
>
> I don't think there's any real reason for the difference.
>
> Jeff - mind changing the EACESS to EPERM, and we'll have something
> that is more-or-less compatible between Linux and OpenBSD?
>
Sounds Good. I will make the necessary changes in the next version.

-Jeff

>              Linus
