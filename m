Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97EE153812
	for <linux-hardening@vger.kernel.org>; Fri,  6 Dec 2024 19:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733514807; cv=none; b=giVqzO/RE7CshpRCTknTJYJ8zL0gITqk1jLdq/koBEBfDf944kBC1WXj86ogrYZ1gLLnrlh6FOVtzIw8vsPwRsEYQCYIqYwUKKwoX3GzU+ZJcBxc09Wsk9nud9hkdo+13xVlcCdHBk6mYI2qNx75jZ8PK46aD+vV55Hf6ZLmJzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733514807; c=relaxed/simple;
	bh=+UJaKlCLM1eBrOkIcwMg7qDlcZEJbIkUlLbxpr8c1ak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HvN6pntLh/AwvAR+29PjXh4KwdZHyzoOsDna3qQ9zej4rqdGMliJ2Z3BATDacG9I9zDU/JbiN9qGc21MFrUrJ+tBdx/h362+ktarX3+u2Ymo52y8j6eZFSxg/ERdutLnISopfHMlBsefL52qhsuTlojo4ap50nxhSf60k9D1WKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ear1Nysq; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ear1Nysq"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-29e2bb5f100so575578fac.2
        for <linux-hardening@vger.kernel.org>; Fri, 06 Dec 2024 11:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733514805; x=1734119605; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kD0PG/Son46c2udECUUzy+txrtNMIZH1gjXmstMo4Js=;
        b=ear1NysqeFhIo/+1m395I8RMI71d9VhQkv6CF8zo8w8adBf5/C0d3FBVgmtWy3kyMQ
         VXu2XDBBdwneahNiUG1fNPFuAcf5qej2R+F6cadpEKZ/C7qwT7uoMY1yTvCYWyr4NF3S
         YEVT71NS9y2Fx3Lr481+SPFw5FdemNkReMAvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733514805; x=1734119605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kD0PG/Son46c2udECUUzy+txrtNMIZH1gjXmstMo4Js=;
        b=AiZFZc1/ZbVQxJzNlq6oX1TXIRaxXEJrUCoCCeFBQ9AM+LcG4EB+2Pzxm6F3zZD1au
         /4g8PE/3XAPjilRdSGsElRwTh+A0K2+wQy5XInHZH/GtbRiNFDqk+1xsebepPvGbcA8O
         UJ7nha1xGwai4ZCUGU1YdSlYSkns0uc0J21CjXc2jltEMmRb+rDYuoiOYN1KI6mUdIn4
         gWkpLWdpX35wKD6QtUGXFnoA0aeHG68Z+NMDxB2DKehlIb/mKf2FVgeTsxGR0sdFQSy5
         SzW+cClI5sHJOtv+iXQUpwW5BzJX5aktZpdFcetK15r8TBYFhGZjIN6uQPrCcqzIaHC/
         W7cQ==
X-Forwarded-Encrypted: i=1; AJvYcCUV+rMkcZ1TxV/CATKju3CCcLJYhUQgyh+UMpqxDPd2UZEi0OOLGX11++Pa5P49FjDVHBrpWmSYwVixfrlG0cg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxS3vFnI/SoacNQDpPREZVLxxZICw/kNQuWvCXIzX6MCPXWfC7
	7BbuFfMYg9JkBM2kXlhqq/rgeh4uhaen6ourcqcrVZAbMYVv/ryNYVFQuu75/keGPLYSNxbtbW8
	rFZ20eP/P6WIwiUwzUHUHfWiqEHpG6PgKezbR
X-Gm-Gg: ASbGnctNQb/NBsyeOOBAfOoFYdiPsJ7eWFN6mjzjH2pzNgdUvp/71s/MwsnHUatQYzJ
	6B8cyeF0hW8BF3evO3crqSwlXSLkrFBkL/Scw9gHVRBrXJcJYo/286yITsUE=
X-Google-Smtp-Source: AGHT+IFSeXugZN7WIOwQr8YQLq8LU3bDv7Zj73/Xx2iLMaJeWot5Rr5Xvi0Wz4axw+70GUka05MUK/Yl5vgeFS0FbSQ=
X-Received: by 2002:a05:6830:6586:b0:715:7a24:32c6 with SMTP id
 46e09a7af769-71dcf6c2979mr910230a34.6.1733514804898; Fri, 06 Dec 2024
 11:53:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABi2SkUxcgKf1Z_zYNP+LOK8w=uUEKyq3fUpjJNcavhts2g0TA@mail.gmail.com>
 <20241206193309.3026213-1-jeffxu@google.com> <456abc34-9071-46f0-8c70-62377484dbf0@lucifer.local>
In-Reply-To: <456abc34-9071-46f0-8c70-62377484dbf0@lucifer.local>
From: Jeff Xu <jeffxu@chromium.org>
Date: Fri, 6 Dec 2024 11:53:13 -0800
Message-ID: <CABi2SkUeALssNiEwcUHNQ7AUWY2UvScJmw4LJWo5+fV94_42Jg@mail.gmail.com>
Subject: Re: [PATCH] mseal: remove can_do_mseal
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, vbabka@suse.cz, Liam.Howlett@oracle.com, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-mm@kvack.org, jorgelo@chromium.org, keescook@chromium.org, 
	pedro.falcato@gmail.com, rdunlap@infradead.org, Jeff Xu <jeffxu@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 11:39=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Fri, Dec 06, 2024 at 07:33:09PM +0000, jeffxu@chromium.org wrote:
> > From: Jeff Xu <jeffxu@google.com>
> >
> > Hi Andrew,
> >
> > Is that possible to squash this change on top of
> > "mseal: move can_do_mseal to mseal.c" on the mm-unstable ?
> >
> > This is the first time I m doing this, because I saw dev did this befor=
e,
> > and saying this is the prefered approach.
> >
> > I could also send v2 which is what I usually do.
> >
> > Thanks
> > -Jeff
> >
> > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
>
> Hi Jeff,
>
> Fix-patches and the like are usually for stuff that's been taken and this=
, I
> don't believe has (I might be wrong actually).
>
sure.

> But anyway, as a reviewer it's easier for me to deal with a v2 in this ca=
se, I
> am not going to give tags to the original version of this and want to mak=
e it
> explicit I am only giving them to the corrected version.
>
> So from my perspective could you do a favour and send as a v2 as it makes=
 my
> life easier anyway? :)
>
sure.

> Thanks, Lorenzo
>
> > ---
> >  mm/mseal.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/mm/mseal.c b/mm/mseal.c
> > index e167220a0bf0..08e6f328d9c7 100644
> > --- a/mm/mseal.c
> > +++ b/mm/mseal.c
> > @@ -225,9 +225,9 @@ int do_mseal(unsigned long start, size_t len_in, un=
signed long flags)
> >       unsigned long end;
> >       struct mm_struct *mm =3D current->mm;
> >
> > -     ret =3D can_do_mseal(flags);
> > -     if (ret)
> > -             return ret;
> > +     /* Verify flags not set. */
> > +     if (flags)
> > +             return -EINVAL;
> >
> >       start =3D untagged_addr(start);
> >       if (!PAGE_ALIGNED(start))
> > --
> > 2.47.0.338.g60cca15819-goog
> >
