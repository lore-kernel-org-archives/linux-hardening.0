Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670831B78FD
	for <linux-hardening@vger.kernel.org>; Fri, 30 Aug 2024 15:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725032330; cv=none; b=bAetQE1wiKAxfjjX5rtB4y7lpQi/wWd5ckVEeUAVWs+P4gttKEm98Punv8+QItL59zoCEIUKC87u/gML8mvI+bl7bi3UkR7wXmDx1MuZNnALL0vxhhdwVHLshyocymHncCtGZ7n1+baTcqLRuGrsMP2E4uRBoFETd9CK+IhiDiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725032330; c=relaxed/simple;
	bh=SUwxwdTKpoD+McoYuZdYTN3po1Up3ZeUUvAKwl9UHF0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mRfQ54yqOoyzKvacHeII2+H8tIG01Njvkd1sRDltfEGFZ9+3ERpsUIbwmXFGDpbMFw9JOdo4sHD6vEPSI/w35aO7TRviTu8w8z0ZF2MtpEViKfFQcmLScabTocs3Ldj5bZxc1IhZmiYttkdY3mHFFb4lcFk7m41J+YpC0lgZThE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CiSoI/uv; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CiSoI/uv"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-26456710cfdso131412fac.0
        for <linux-hardening@vger.kernel.org>; Fri, 30 Aug 2024 08:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725032328; x=1725637128; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i+4o4v4tcr8rbwr78IwtuGgqIqaHJtCiQhKM2B3jmuI=;
        b=CiSoI/uvufHcpelcebQGFY88JntjVmGPOTGbl+8LK6Q0W45x8kvDpXOrHyQuEs29PS
         7xX5jgTJZCWoG05AUkkdFmArCwnd6DASqM+DaMQfqD1H+kQH5um7HDRvK5n2gpFRfZ8D
         1Wc9Y6iMSyBP7pffgktQhbz47irtl3sUlkVgc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725032328; x=1725637128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i+4o4v4tcr8rbwr78IwtuGgqIqaHJtCiQhKM2B3jmuI=;
        b=YcleFraCCrLpMFt8oKbqqQfQuNSg9pTPb05W2MRWB1yD6vsW7h2kvuJ7DMJdx/wP/r
         qS6fe5rK87iDHFkJMiQpVd5D1ud78uzBngxM7FsvF5xq+goKNU+RCFePOw7OnkT3Kk2A
         dPsCX6SpVyOAVmHkxoSHAXdVaQ6qT7X2Mt5YZiX6x3adNHoW2irVJW9Z/7Y2Eojpq/Bh
         QML4ZoIsoQKYq20FVg/7FkgIs5MHaMvH213NO/3aZBbSsr1SVXVytC4PuvRV1z6WpRkb
         ZCzPESLXH1tL4k4qdA+utc+lFVkZVZOEEE8U/Ht4jMFKXLHiQK0Dda3K+PN2HxnJIabE
         iu6w==
X-Forwarded-Encrypted: i=1; AJvYcCWC6Rrh1C+yrn3JQvPl4UwbaJT40IOu/VzvfiOdiyrJEXPl4VWAEWaasy4F+0ZWCD45jLyCQzegjDBA0xLYmdc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyba2a/HkbboTQtDgmwM4nnBYn0yjlnpETU7gehdM/loMPC1MAk
	26w0djsAMot7sShwhIUGRz0v2iV6fqVj373YItaePLXrd7FZQyunvIpuvmk23lthc2B0CmkL4tW
	6mlngxxZRGGvLCjBGAihErp/YDdZMFNNfnIxh
X-Google-Smtp-Source: AGHT+IEJiQTBdvk8h4QsAYlys8jQM2wMdP6B97VqSR8AYorWSjmSCBIEgEV5VPy0sNLSBaQCDqVav2FFWC5OzTvuD20=
X-Received: by 2002:a05:6870:218c:b0:277:6b90:1915 with SMTP id
 586e51a60fabf-277b0e4fcc6mr1280261fac.9.1725032328307; Fri, 30 Aug 2024
 08:38:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829214352.963001-1-jeffxu@chromium.org> <ixoelxclkikscysvlmfbvciyig7pqjbuwwhhgawk6fy4iookya@kmsjo3oetgw5>
In-Reply-To: <ixoelxclkikscysvlmfbvciyig7pqjbuwwhhgawk6fy4iookya@kmsjo3oetgw5>
From: Jeff Xu <jeffxu@chromium.org>
Date: Fri, 30 Aug 2024 08:38:36 -0700
Message-ID: <CABi2SkWxAVzbZ8A4YOTcOhOOZwj6j_7K2khMs1yFDht1_GuLvg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Increase mseal test coverage
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: akpm@linux-foundation.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, willy@infradead.org, lorenzo.stoakes@oracle.com, 
	broonie@kernel.org, vbabka@suse.cz, Liam.Howlett@oracle.com, 
	rientjes@google.com, keescook@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pedro

On Fri, Aug 30, 2024 at 5:31=E2=80=AFAM Pedro Falcato <pedro.falcato@gmail.=
com> wrote:
>
> On Thu, Aug 29, 2024 at 09:43:48PM GMT, jeffxu@chromium.org wrote:
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > This series increase the test coverage of mseal_test by:
> >
> > Add check for vma_size, prot, and error code for existing tests.
> > Add more testcases for madvise, munmap, mmap and mremap to cover
> > sealing in different scenarios.
> >
> > The increase test coverage hopefully help to prevent future regression.
> > It doesn't change any existing mm api's semantics, i.e. it will pass on
> > linux main and 6.10 branch.
>
> I do want to be clear that we shouldn't confuse "test coverage" with bein=
g unequivocally good
> if it has the possibility to paint ourselves into an API corner where det=
ails that should be left
> unspecified are instead set in stone (e.g do we want to test how mprotect=
 behaves if it finds an msealed
> vma midway? no, apart from the property that really matters in this case =
(that sealed vmas remain untouched)).
>
I do not disagree with this. Let's look through code and comment on
the case directly if there is such a case.

Thanks.
-Jeff

> >
> > Note: in order to pass this test in mm-unstable, mm-unstable must have
> > Liam's fix on mmap [1]
> >
> > [1] https://lore.kernel.org/linux-kselftest/vyllxuh5xbqmaoyl2mselebij5o=
x7cseekjcvl5gmzoxxwd2he@hxi4mpjanxzt/#t
> >
> > History:
> > V2:
> > - remove the mmap fix (Liam R. Howlett will fix it separately)
> > - Add cover letter (Lorenzo Stoakes)
> > - split the testcase for ease of review (Mark Brown)
> >
> > V1:
> > - https://lore.kernel.org/linux-kselftest/20240828225522.684774-1-jeffx=
u@chromium.org/
> >
> > Jeff Xu (4):
> >   selftests/mm: mseal_test, add vma size check
> >   selftests/mm: mseal_test add sealed madvise type
> >   selftests/mm: mseal_test add more tests for mmap
> >   selftests/mm: mseal_test add more tests for mremap
> >
>
> nit: Please follow a more standard commit naming scheme like
>         selftests/mm: <change description>
> or
>         selftests/mseal: <change description>
>
> --
> Pedro
