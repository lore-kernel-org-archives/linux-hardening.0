Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0012C2CD
	for <linux-hardening@vger.kernel.org>; Fri,  2 Feb 2024 03:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706844257; cv=none; b=FGojBo13eiLXWNX15RsZ0usy0nB0FeXs1jvqOUr2T9i+xOltAnMbnnN6Lcrkpep+9H1OnrNaa5EMsI8Cpzio95hdJ6X4hwj0voCc8jWtjPA+U2OOJA/YrAzBZ0FODtto9wuM7+63Y86+NhoWs87h9U1kNrlI+noJ9G7j4rAlArQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706844257; c=relaxed/simple;
	bh=F3RU9i0uU3xxYEdybKRzetgfuHN+SaA1c3E4tkveiMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QVRVlKs+xizsWK9kjpxsZE6GmSi08G2pjSeCXrou3+2S5X7QZtEHeTAdhR7A8FN6jvoox9+uN6L6v+jYFWF9KfW0cQVIJiMB460W285vHJ1idYaMMGKboSLWEg6KjzuIimPU2l37I58kvr4aZUCe5McSED4EfeiH0QO2iNISAS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=K4Ai01dn; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K4Ai01dn"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-21428d99395so1220182fac.1
        for <linux-hardening@vger.kernel.org>; Thu, 01 Feb 2024 19:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706844255; x=1707449055; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SC8wVnR3b9FYoU326Hexqhd8UbKzrj1qBSp3p+CBSZw=;
        b=K4Ai01dn68Hk4OzXwV8MwazFSDe0UiHI3FyAjykAT6WTAF8du5repEyczPpQQKk8rL
         szQQbmxQ/DKXAWyG8tRIhvYLZ7MfCpSuJoy83bzg0XgMK2Qv3uMtHGfjY+ORozkIiX+Q
         mYxjjHrNTMSHhpgvrHLA5VNqa1s5RXKJfpaeU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706844255; x=1707449055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SC8wVnR3b9FYoU326Hexqhd8UbKzrj1qBSp3p+CBSZw=;
        b=vzXw7Z2TdifoAskF6/jMvjIO0qIcDcfVI6Rx6JTHVoRdctIIopWHlC+LXj10fWmDsP
         JM6PuKrJB5AzF2gxd5Q9RO8PzyugtOlMi5WOz7QxRMIUUMznHeoGsaRrwzTzjlwe/ZLV
         Ag9/ULE4yVz7COdIJS3VOUjoK+X+eqFgd/B96gdDalFOIVVWm5uHm3ToW5wfqX1TEteQ
         /XyLr7Ktih9Vx4xU6aeHdczf1mMNHianWqTkOKxICKL66oXgADn5d963u9fTl02dkOc+
         yHUWe+FTvadpxdpmtL/KyDpNoTx+11+StDrHOaLRbhLe7xuiqPJGUHykpefYXoNQIlN9
         rUUQ==
X-Gm-Message-State: AOJu0YyklkMNEhDpCcRV6yrA2yyjxblJOLd+zmZ4ind4IfZ0OCH25OWU
	G+SUtQ0290V2knoAzW+paONz+Uw25f6mr9kj7Tceafy8DBSWT3chBjff/XM4O4u5r20bhIXh148
	b1zALku3gcv8k3Cs9s8Hv2GrydQJ1EieqeChE
X-Google-Smtp-Source: AGHT+IFVtEYMlNn1ZPZd/WSM3dio26Xfg8lvB4X5Uex93ZbRv/CK5G/PNTz+uV80oEs86/m1pkKQAtE0anCQk5ztgRg=
X-Received: by 2002:a05:6870:b49f:b0:219:1f9d:e0d9 with SMTP id
 y31-20020a056870b49f00b002191f9de0d9mr161830oap.29.1706844254829; Thu, 01 Feb
 2024 19:24:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131175027.3287009-1-jeffxu@chromium.org> <20240131193411.opisg5yoyxkwoyil@revolver>
 <CABi2SkXOX4SRMs0y8FYccoj+XrEiPCJk2seqT+sgO7Na7NWwLg@mail.gmail.com>
 <20240201204512.ht3e33yj77kkxi4q@revolver> <60731.1706826280@cvs.openbsd.org> <2024020137-hacking-tightwad-a485@gregkh>
In-Reply-To: <2024020137-hacking-tightwad-a485@gregkh>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 1 Feb 2024 19:24:02 -0800
Message-ID: <CABi2SkVb1goM95FT5v2K18NHbaLitLpK6fL+wE6Y47z8yvW0Nw@mail.gmail.com>
Subject: Re: [PATCH v8 0/4] Introduce mseal
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Jonathan Corbet <corbet@lwn.net>, akpm@linux-foundation.org, 
	keescook@chromium.org, jannh@google.com, sroettger@google.com, 
	willy@infradead.org, torvalds@linux-foundation.org, usama.anjum@collabora.com, 
	rdunlap@infradead.org, jeffxu@google.com, jorgelo@chromium.org, 
	groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, pedro.falcato@gmail.com, 
	dave.hansen@intel.com, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 5:06=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> On Thu, Feb 01, 2024 at 03:24:40PM -0700, Theo de Raadt wrote:
> > As an outsider, Linux development is really strange:
> >
> > Two sub-features are being pushed very hard, and the primary developer
> > doesn't have code which uses either of them.  And once it goes in, it
> > cannot be changed.
> >
> > It's very different from my world, where the absolutely minimal
> > interface was written to apply to a whole operating system plus 10,000+
> > applications, and then took months of testing before it was approved fo=
r
> > inclusion.  And if it was subtly wrong, we would be able to change it.
>
> No, it's this "feature" submission that is strange to think that we
> don't need that.  We do need, and will require, an actual working
> userspace something to use it, otherwise as you say, there's no way to
> actually know if it works properly or not and we can't change it once we
> accept it.
>
> So along those lines, Jeff, do you have a pointer to the Chrome patches,
> or glibc patches, that use this new interface that proves that it
> actually works?  Those would be great to see to at least verify it's
> been tested in a real-world situation and actually works for your use
> case.
>
The MAP_SEALABLE is raised because of other concerns not related to libc.

The patch Stephan developed was based on V1 of the patch, IIRC, which
is really ancient, and it is not based on MAP_SEALABLE, which is a
more recent development entirely from me.

I don't see unresolvable problems  with glibc though,  E.g. For the
elf case (binfmt_elf.c), there are two places I need to add
MAP_SEALABLE, then the memory  to user space is marked with sealable.
There might be cases where glibc needs to add MAP_SEALABLE it uses
mmap(FIXED) to split the memory.

If the decision of MAP_SELABLE depends on the glibc case being able to
use it, we can develop such a patch, but it will take a while, say a
few weeks to months, due to vacation, work load, etc.

Best Regards,
-Jeff

> thanks,
>
> greg k-h
