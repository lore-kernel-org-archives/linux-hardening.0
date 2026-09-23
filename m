Received: from mail-vs2-f30.google.com (mail-vs2-f30.google.com [74.125.227.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6BE45C710
	for <linux-hardening@vger.kernel.org>; Wed, 23 Sep 2026 08:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790151244; cv=pass; b=VQHDJN9CyNlScLzaOW+X+92aT5oG8eiR8eYFanYS7xBm2oGfrbgtNz49tpZkwdhuTgxqWYuQnXwuibdN6teyDXL+lRcGqyZe9h5s6WYIbkIM+IXVBto8WfBb/gPeKeDJdAWgo/rzw0uCCmTAbYEJYl6Q3sAnEcLuNVh5dPslR1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790151244; c=relaxed/simple;
	bh=g8p2y5h9Zq0bo26ThNpQVMYPb69DIVXvUL91DVTUVlw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qTV/lc8dmJHnDHsJDl6Cw85vJXCY05erKP0OAxBsgD4reVLFbVqZJdgQHIa6YbTaah2LDSsiKPEEHKRIew6ZJET+r+NRQgmMGp1KWw5q0ggUeUxTPXP8W0X67De7MoiKVC7mAJajrcJBWI9IcYs2M4Uibw/acHdXU2hmXn0XzxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V9MJxztE; arc=pass smtp.client-ip=74.125.227.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V9MJxztE"
Received: by mail-vs2-f30.google.com with SMTP id 71dfb90a1353d-5c7e8a17839so166295e0c.1
        for <linux-hardening@vger.kernel.org>; Wed, 23 Sep 2026 01:14:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790151242; cv=none;
        d=google.com; s=arc-20260327;
        b=IrPJB0DZvfIOxXfrhwfN0Qqxi2uoGRcLKFy6oCSur9Y3UCorW04f3TOEpCsB8nbErA
         jGG/CtiW8UPJf4hPWhMaFtJtv3H2C35JRTy20X+++TQYeVQgtUsUF3UgpmuIbzhMsPAO
         xM1lesI/nTEQw5dhDZ8SBsiaptYlNcVQjyOSnph7GjvkRxtRqbSS/mkBErkbh6f5/AdM
         JxGmNtu89RZKu7r0CtQDcwFzJ3yBRnByFldVt5anOqTc6xip9vcyN3aQDE5RKe8as+Qo
         tQ/lXhL8YvMiytFtWorgG0ZA4ylaDuTboAZktiNbyTX3sDHtfHoq/Y0EVN6wZH1+fKXU
         0HWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=g8p2y5h9Zq0bo26ThNpQVMYPb69DIVXvUL91DVTUVlw=;
        fh=Skn6QHdMY0NaN6ylOrFpA5AGkBbfie50J0a1muGlUDo=;
        b=DyILhhwtcWNsDoQpKofGaGLQWfN4U+0NE0tgwzFGs9YPezBrzxDClWf6v2LKqg6tnT
         fJKMh0x1Jk2VwQjcofeHEtzKJiQtp6KbVRsPa6rhbnZNPGlRG6tc5+iW+n9BDCcFdQaa
         9EpxHcammNA298eek8vyFGdpGIlUhdmlEHwlAU50Ze0xqP4SdERjHjepcJbUUUII3Mzw
         CtmrB2jFYgXncyNY/p4SeYbL5j20vCzCoGf4K0/JO2OMAx7FuKd5ChN8LSNhYRwRUCrp
         KQb15jUiHYiuFIld2FL87g88XMPdoWW9lxeHDXXItxRQgAegKYWVtzQ96lqVTfOeOEZk
         CM5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790151242; x=1790756042; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=g8p2y5h9Zq0bo26ThNpQVMYPb69DIVXvUL91DVTUVlw=;
        b=V9MJxztEId42bn3P3TBdujbZbAy8XMO9hwrA0pNJ6XZ3eTzvJyJIl70dmHyVSW76Wr
         HsVBynydAeli4NNTUjQmW99pkGJ/gSR9vWucz+g3NwxFIjnonUDdsuOXVJNNBuGhpbPp
         /mEBTioFk9wKmCke9FNC8ILzp1hTLmofy15j9ZgDLaR7MEM5C/+an8mL6q4g2Q4p7vTd
         yslnPjJORMRxyhoLyBzbLiFoi6HNi2Bzci3YpT4a0fr9g9Vd4+uuK2H1QMU/0TA/a8rm
         Z0IQz91zAUiK9x3lm0rdv3XIYdeRQDiyYaqClc/1dNGLhee7AGE1yrbrayKn7xdhRmDo
         Z/LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790151242; x=1790756042;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g8p2y5h9Zq0bo26ThNpQVMYPb69DIVXvUL91DVTUVlw=;
        b=Uoi1RECGF4fzxAxk8WpkTS2Tlu9XvypmJ0LLXtP7i5K6lEFHlacmNUuUpdbQ6AfTny
         KRTlAcdEwFwFwbOo0XDK4Az+EKhGiUkNCbWofxHigdtY5ih2NEg7VcqGuVgbDnXuvxHX
         RVeFS2M+kFjJC1evvPz9Gog8dXpZldQ62i3XVJZRbjVj4WP68NisYvZMwxo1ElTZdaVj
         mU+VYJTyTrrTme+BdvQ6SH6I4trUfrv5sDDtpYzSpPpNcbbgSGqnW2mpkXpTTyFUZusa
         AS5HjPSMyDJbQEtWapyVBuRJg55WJMG47A1n3E3iX3pqRiYgBkxTn2IlYyYkVdSVzZ3p
         5PUw==
X-Forwarded-Encrypted: i=1; AKwUvBzPNpAGhuVqj6SAP6oz/I+RhMPubeDU5VARk/k38st3B2Q4avxRAfa4kOkHoHEqOzS+9IH7XX8pB8IvJklwU3w=@vger.kernel.org
X-Gm-Message-State: AFuF++lagfPA4STyQyE6+6rSAzr6jsdWyOpC6v70SfEI/DzIXHeHPfcg
	mcyUFu08V4z4bC8iLTEE7byNV5pejm9KFziJpZ+iHjuT/opDPJgNkY3OzhfgvXzRbOoDfl3MLPg
	TPK5yeNpHH5++2NaLJ8HDbjlFk6UsUqCPVCquq1Y=
X-Gm-Gg: AYBFou1fIqQEHlcI9TPgFhAcrRiyu5V4+sEBXsb0Mtu8lrsRhqdggj3uVb1tE0pYN6G
	8MY2jxXIjEfUn0lY0cpYguS0qO8YhyiBXG5GCpjkEeJMIsnl80yuSjfVw9HT3+HJSejfrwitT2P
	XQsbG8aQxoHwiJCYZ9+Ypt5kzaW0e0mFT/akU+y72NzUaPQ5fpzjdaRG7oMAARFk03aXIb4vMrn
	zT0ThLJnhd9jnwwaYTCqs5znfvR1kjXIGwePu7uhc7zre/s5i0jQAsCIa5RMnootjmqYsr0jxtc
	YrxnJ6OAD5QVTAkosYotm+w92MqdHVEhfQu8KFV1+xKwfDMQ+Vc9psfNZQvL45x4dpqD/fXQ5xo
	nkrbWDSytfi12UxBVxG8J
X-Received: by 2002:a05:6102:4414:b0:7a1:f2b4:dae0 with SMTP id
 ada2fe7eead31-7ac0d12c7b6mr1858808137.13.1790151240916; Wed, 23 Sep 2026
 01:14:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923041630.2553973-1-morbo@google.com> <202609230023.C2053303C8@keescook>
In-Reply-To: <202609230023.C2053303C8@keescook>
From: Bill Wendling <morbo@google.com>
Date: Wed, 23 Sep 2026 01:13:44 -0700
X-Gm-Features: AclHuK9CRP64XWkh5O-lp0iZIS46BhsaKQBJZ_3Cwu7viyTTfI9mH9peB9qjiC4
Message-ID: <CAGG=3QXNoR_EpkUiTi4Rh5c7HNZCsVVTFneOT+TzuPiv9Yy=bA@mail.gmail.com>
Subject: Re: [PATCH] iio: gts-helper: add __counted_by_ptr to struct iio_gts
To: Kees Cook <kees@kernel.org>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	codemender-patching+linux@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 12:26=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
> On Wed, Sep 23, 2026 at 04:16:30AM +0000, Bill Wendling wrote:
> > The compiler attribute __counted_by_ptr can be used by KASAN and UBSAN
> > to detect out-of-bounds accesses to pointer fields in structs where a
> > corresponding element count field is available.
> >
> > In "struct iio_gts", there are multiple pointer fields associated with
> > an element count. This patch annotates these pointer fields with
> > "__counted_by_ptr" to improve runtime safety:
> >
> > - 'hwgain_table': counted by 'num_hwgain'
> > - 'itime_table': counted by 'num_itime'
> > - 'per_time_avail_scale_tables': counted by 'num_itime'
> > - 'avail_all_scales_table': counted by 'num_avail_all_scales'
> > - 'avail_time_tables': counted by 'num_avail_time_tables'
> >
> > To ensure that the count is set correctly before any pointer is
> > accessed or assigned, we update "iio_init_iio_gts()" to set the counts
> > prior to assigning the pointers.
>
> "Accessed" yes, "assigned" no. :) Let's not churn on assignment ordering
> unless there is some problem I'm not seeing. The only time this should
> ever matter is if there is multithread visibility on the object already,
> but that would require both counter and pointer be set, so that'd be a
> general locking issue, but ordering during initialization doesn't
> matter.
>
In a separate patch, Sashiko flagged the assignments being "out of
order". It's not an error, but I did submit a "v2" that reordered the
assignments (that Sashiko is still complaining about, but I think it's
a pre-existing issue). I can weed out the needless reordering changes
from the patches, however, I like the idea of people thinking about
the ordering of such assignments.

It's a small thing I know, but I need something to hold on to. :-D

-bw
