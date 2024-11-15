Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4BF188CCA;
	Fri, 15 Nov 2024 19:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731700038; cv=none; b=SFVdICO+GKOJErl5c8nBSyHzp3HvfqcEmLbRr+hjo+s8LH13hzrkt9UrgeBeUzfVv8lKTXAOYnwxqDNRNLS/ezWL5cFwa68tcki1jr9XxLAYS5wvB4IOJfv1ZMbrj9h5iaGJbkLwwi9TobXo2FjZsrlVjnSSwG7gJfOUPuxUUs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731700038; c=relaxed/simple;
	bh=QyGNluIUTOwP4YSbRg+yS+Gxb3KvEi5akpCu4YFksdA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QPbIMwLN7ykAh43pLqKy5OtN64bTqk1rKP9zL62h4is+J3MHdhDm7cI9jJU6rmDeZuMy2d5rqTy58z1WXVtwTq+rgc0xXR5tTcHZoUe5uwxRmn8V3x/Bjo96hoTAueapkRuhVzmTnU6xlw0AlFmGzgB097SXDreIprrDi3RZMIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IjWuC1vo; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IjWuC1vo"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a9e8522445dso398683966b.1;
        Fri, 15 Nov 2024 11:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731700036; x=1732304836; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UT4z7vl48bcTH4YTj4a2K5SLXTtuIgfSnTwzWbYWdZQ=;
        b=IjWuC1votpGqgRgh0qZri4lfJqIfhEvCTMhB0QKZN+vZyUH95WVDq1tEdZPIqFYyjU
         wZqydT18pegfpW9naIpwHs9jiIamKLmFu1tJQnWQpZVsbltEHPkehRO3eo9+Cyoy1dn5
         kZJOKW2j7Vay259guXFPqkrAaY4jAk9OT/xybD5hzpGcxtl9kK6HKilosdMJWDIty08y
         Kfet4rxaxQ6K3fIHi7G0XMbSL3eQjaRY1AjfVaBF6uiI+FGsSGPdbzNypdNmoWvjBDgx
         0+/VdewgBlHOEsx8V7b6Ljzb5cr4TU0gSCDgroEsNgjPX1B/+9YyAWvIoFp9BfxZ7tDM
         0Bag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731700036; x=1732304836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UT4z7vl48bcTH4YTj4a2K5SLXTtuIgfSnTwzWbYWdZQ=;
        b=rd30lUBa+f8l8HVxRQFYlyM5Jl/5lNoeDrvjaAPO+cl7cjwOLmDLiWH7NL3SxxtQlU
         E6ijr49raYuC6BiznsfvonAcs4BZKy4/OEihPcadJVuOHEhaSwA3+jXEZM+0JSA5ayt3
         nI85slpY6GCzC+Krdk5icvCo26e4Q8dPdoLVIIGV5Z/nBP86u71NlPlEpd7P8TMomUWt
         AvNORDrmi1cXa78kpgIUOkiTD8MuAffg20CX+Zy8b1fOz1nqFnLEnpAKDW+PoELA/sT+
         J7fGL10qoDHaHS1mLAtWMBUPh58zyKsUxdDjrJVDaLNCIgtlIDHhJcqSvvDvkFx38ORZ
         VkGA==
X-Forwarded-Encrypted: i=1; AJvYcCUJnn3SOGgPOigwNphGhFa7WqlTPiNz1u8d4AYmAziR6QKESQ8f3kS2MavhsvDTp954xqNDk5f2I41cs4U8@vger.kernel.org, AJvYcCWxc1p1seTrOGo06nQbMYQXdp0GDJ4/XxBOfR1DS5NL6k7sZ0is1ywy01CMwr4l1LTGD06we6hn7jgyl9OBe8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfSYubETsChYvF7fzqgmyS7VM/FuZfcLEnKFL5b5ebfBplKi6L
	nW9Rp3jj2omHuSHTBCsJYbTReS0B0hNnLbQpEc2ovsF23+iGII7tk2nwGboQckB/4coRqGPbFOY
	rZXn0wYVylEO3wGB2o1wJXL8MVO4=
X-Google-Smtp-Source: AGHT+IFAfImbLnvNyuZA00yGA5EBJ/zkL6tbilDt+jxgONMAQiVnR6JixTg8xfB8OYw4cYf2HglpNzBT9l32DM3TOzI=
X-Received: by 2002:a17:907:3f05:b0:a99:7bc0:bca9 with SMTP id
 a640c23a62f3a-aa4833f6285mr344249566b.3.1731700035545; Fri, 15 Nov 2024
 11:47:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241115144616.7453-1-prosunofficial@gmail.com> <CAHp75Vfp++XMr8VGjjFRBpJi+uAk8PRVPxMLmQciedBzS8gedQ@mail.gmail.com>
In-Reply-To: <CAHp75Vfp++XMr8VGjjFRBpJi+uAk8PRVPxMLmQciedBzS8gedQ@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 15 Nov 2024 21:46:39 +0200
Message-ID: <CAHp75VdD1KYh9KJWHwhxkXy-+jfh_o=Rn05AtL4QBb0HC-oz6g@mail.gmail.com>
Subject: Re: [PATCH linux-next] lib/string_choices: Add str_locked_unlocked()/str_unlocked_locked()
 helper
To: R Sundar <prosunofficial@gmail.com>
Cc: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2024 at 9:44=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Fri, Nov 15, 2024 at 4:47=E2=80=AFPM R Sundar <prosunofficial@gmail.co=
m> wrote:

...

> > --- a/include/linux/string_choices.h
> > +++ b/include/linux/string_choices.h
> > @@ -82,4 +82,10 @@ static inline const char *str_plural(size_t num)
> >         return num =3D=3D 1 ? "" : "s";
> >  }
> >
> > +static inline const char *str_locked_unlocked(bool v)
> > +{
> > +       return v ? "locked" : "unlocked";
> > +}
> > +#define str_unlocked_locked(v)         str_locked_unlocked(!(v))
>
> The rest is sorted (okay, read_write() seems to be misplaced, fix that
> in a separate change if you wish), please keep it that way (I believe
> it should go before on_off).

Oh, I looked in v6.11 code, in v6.12 there are a couple of more
misplacements. Can you fix them all, please?

--=20
With Best Regards,
Andy Shevchenko
