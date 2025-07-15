Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF27E2641CA;
	Tue, 15 Jul 2025 06:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752562462; cv=none; b=odIryro9wXRgDhn6Z/TeshLY+oq5X80naN2VxBFa9aIrrjfPhO/A5m6QCftkeqcN/nZx2aS9oZUntLsq/GOMgLVEsU7n1csM/9okl435e8J3tRoA0VN7iVsNCRQP+9QaiOeNqkDezCagOQlSLsRCz2v48Ii5qdOkYd9+UKJ5RZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752562462; c=relaxed/simple;
	bh=iYEmdgVDVilx6r+/rcv1fMSKywLiSD07WpOBMo7klTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CqTzQKmkeer/2xRaBXv7WrPTlVfSydYrRasB+k6AM0EeY+sriXXwwC5jAE6ExukH2ZtVnEHROBgjjljtlAvLvc4FdwbZZ5+UZKao9sf28j49gGcjJeQfRk7xMFwmso3gRXjPZSQWdPDPrdix3MYPmmPd0LEL0XO3MNwsXV2YHSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ksJUQpat; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ksJUQpat"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ae0df6f5758so885632066b.0;
        Mon, 14 Jul 2025 23:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752562459; x=1753167259; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iYEmdgVDVilx6r+/rcv1fMSKywLiSD07WpOBMo7klTI=;
        b=ksJUQpatLiZLddCM/IWqiV+LL9DayUgBzmLEpYSQc9sKLijmc8qbqPOW+0Vi7fNGAA
         0FWPr8XHzK6aILDNwrengOuybDJTcQz62ukgj/pEbRr9L57ESLM+zVe/gZ41wsbKFqkF
         ohKOzMVoimiCrvrWyM2NBYg/gFILmZA6p3v/3Wa1pbTEKqMOQSdKpw5aTLJYjcobfW5K
         JexQcLzpmGE1213/RokXx4FTn7+3FhOk7DWNIMNpA/zK9yQjfnHQBTFn33uzZiQkTkIu
         mVlxr43/EOsyQ/EC6eVTg9O7HY1gZD9pUi4KCDV6UeTaayZLU012vblTcoYyKVhNdFNp
         CUBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752562459; x=1753167259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iYEmdgVDVilx6r+/rcv1fMSKywLiSD07WpOBMo7klTI=;
        b=hBqWGc96LkJ2GDnTHvJa74GvTnj2krbC5nO5tyLMSZJb8e1dzRzZFzBkhawQlp0OrO
         weFINKe1+ESlStun/36yrIyi5+VExkeLbbhJneeufOtCifcNy5XsuFRurK0Y5JHheaig
         O7TtrlrC/hEUwHCxbHbsncrY4e2FC8P53RkU3P4keHp/iMmxF7FV6a22Cqr7nIPKc5xG
         slRTn7d6KKlasxTN+XhPJAfwCWvOElOk2vq/mFdDqOTT70mOwi3LPnrLqQS0y4pxLGdD
         mFF7gdAY1GGvhG1decsrPH+OsjUDAh0mb3t4hIM7scDQLhHWDrDVcKh1lpG4QKiHkdGs
         xoCw==
X-Forwarded-Encrypted: i=1; AJvYcCU5EhsOnlQ+mJw33OMqbgmPkLUh8DMzNd2K4rwvIoPi3nU6MmDymqOX1Rt8eAQB9K2A8HO5MT9LJjMiAUN2RJE=@vger.kernel.org, AJvYcCXxh+JG0XnU/nc5tnPmZJO42w4C4h2u5D5iwPrRuXkE/O8LYcnP51fuE9+UBsDZDqebT5UVi18TsAEQnwGw@vger.kernel.org
X-Gm-Message-State: AOJu0YyASYfxigBlfdEwwjQUlYDeZ89M2qyNR/NaoznuplGV6ldglb7B
	1oeDgsx5HqDJs/aCTgWG4mMd4+MO5rLhB8ksO0n123bY+jvE1QvBsTo0iHlZ858sFcq43rKhdfn
	nUaHCBVVjiy/S8dY5iO/YaXFtjg0FfpDs1slS
X-Gm-Gg: ASbGncvrp/oVWFZN4OavF7M7Bx2etB/4NLJY3sIFs2TvFcpkmPX11CzKgrraOxUMT0d
	4lYpwzS/xSGKRv1gW5KMUUHFcM3tnLRYMC6F5A+42zf4iJXk1fca4OrGEavrQmnPkanVo9t0oiz
	I3L4GpHDeMWzCpBK7erinSjBovp0JFlgSiqNYDcEDeK+ImAlsB9/FmSeMwHRT41jC8WLBaYerO0
	Cj0/IweFQ==
X-Google-Smtp-Source: AGHT+IFJNsrAp6WEHoK7N7c5PJHNjZVBWw0ui3X/s6/QnO3LNd3x+XuuZkeOxuEzGFZSpdsLG4upyjIk7ANJtjI+ZyY=
X-Received: by 2002:a17:906:3993:b0:ae0:cadc:e745 with SMTP id
 a640c23a62f3a-ae6fc366544mr1511285766b.40.1752562458735; Mon, 14 Jul 2025
 23:54:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711085514.1294428-1-andriy.shevchenko@linux.intel.com>
 <202507142224.28276C2D8@keescook> <CAHp75VeWvezuhKx-Q4hHV6=TqbHx=jEmR1wuqEzdJY+xUv7OAw@mail.gmail.com>
In-Reply-To: <CAHp75VeWvezuhKx-Q4hHV6=TqbHx=jEmR1wuqEzdJY+xUv7OAw@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 15 Jul 2025 09:53:42 +0300
X-Gm-Features: Ac12FXzowBIGuN-txmDbWlJbhW-lrd4GPryfiuTawVxufSB4YHMugojOopnhvwY
Message-ID: <CAHp75VezE_xG58zYkWJ3ohAX8HOMCDpz=8uJx+da2hKXLHgh+g@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] string: Group str_has_prefix() and strstarts()
To: Kees Cook <kees@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 9:52=E2=80=AFAM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Tue, Jul 15, 2025 at 8:24=E2=80=AFAM Kees Cook <kees@kernel.org> wrote=
:
> >
> > On Fri, Jul 11, 2025 at 11:55:14AM +0300, Andy Shevchenko wrote:
> > > The two str_has_prefix() and strstarts() are about the same
> > > with a slight difference on what they return. Group them in
> > > the header.
> >
> > It seems more like strstarts should just be a macro around
> > str_has_prefix() !=3D 0?

Actually this won't work for len =3D=3D 0, would it?

> This change is only about grouping, but if you think it worth
> modifying, I am not going to object. Just that I am about to have my
> vacation and I leave this as is for now. Up to you how to proceed.


--=20
With Best Regards,
Andy Shevchenko
