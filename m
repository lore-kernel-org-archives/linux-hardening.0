Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16DF1EDA20
	for <linux-hardening@vger.kernel.org>; Wed, 12 Mar 2025 23:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741823617; cv=none; b=f95lG6gBtQgSv0MxDbS7SlJhg1hasN+WUwmsNmR2qSg/LXC1yrB31tTi9EWPzaLUraJ/p7AnhECHivI/qxUzQwxdMKPlskxATYeZ29TAwDtCaF7svAuP7z6bwrf0XGPSt5I/WabmXH/3a+eMW5XowzMipaKz1TI40PlIWJnxwks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741823617; c=relaxed/simple;
	bh=AeGft02PCfpVr0FAIZGX6Xlm9LKJIDZ9am3sD5SGW/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JPAxgp9afyXt/J/RZL1uIwg6wOxcGeMN/E7tAjrF/BG2p9k0BbXaj0OUzu5UHKbNOlGCQ+WlvFMdw+jrQiXWzokfCfmVGk1Dzl208/3gtFYLlFdRm0gnwDMhtuqOtctEdjfMQP8Fxjr8oJIF0qvjU0jMtFp4ccSYWK+4Jug2bBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PFk0EfgC; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PFk0EfgC"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-601a15186f0so60900eaf.2
        for <linux-hardening@vger.kernel.org>; Wed, 12 Mar 2025 16:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741823615; x=1742428415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8H6u01PvxgJprnkIiXjJQ4sDMD89dhh8rkhvlxkSKIk=;
        b=PFk0EfgCfcgTGmQiHNt80npqdJMZ8eCdoQhyKeMatewoigAbHyC9cqdPtdFZpMV1mk
         nlzki1esIUEgmRlJ7MFmUeiiGCxbkummMPyXIAbg0gU3mv/d+03Z2tGObrNoT6/DVVf1
         YAut3E4fAVA8jg1WMymwmH8GcPPEcfxQzj2Kw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741823615; x=1742428415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8H6u01PvxgJprnkIiXjJQ4sDMD89dhh8rkhvlxkSKIk=;
        b=A50oVqu0ANl7w9TAlpSg1sdrCFmPS4ckunyNU9mcHMVqgpnU3qlHLy09uKqb/b77Od
         2rv5OwZhOBSFNb4LHPlrY48KBLcWFdjLZJZDhdQecIi9mVBuiee47wI7nzvK6MhIlGP0
         HYR0aAPY/sn3w+ZsVEiWOvK4wNynyypNE/r7OoGcGTCJijte6We7NzoNKvZ5h0oRDpN5
         zjgdgEk0+nH4td1HX+rw7WQFEeifY2oMjgPG1oReKnEQPzK8AZYGFPmf9H431xRILM3x
         4C0TPvN+6YnkDpr7AA4y8CKyvldLKepQ44XTrQIOnQ/Paeh/TjKDA6LvOjRPJG8kTM6A
         gVNw==
X-Forwarded-Encrypted: i=1; AJvYcCVkpAE+uz4Ojc3IDH+xgsG+eDaWLtIRToikAKff/GxUhRMF8jxa7qPKwwWbzhqxblttP6cl0N/8S8hnLWIXxMk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx7KgpYfiojP22HTjJth+ixs0BKOtjoxValDDUbxf7/bDDzfnb
	9ALDZI1Kpe+1/q/SsiYC1blj26LHsw7IW2Lczbbx7PbgGdX1YGB836354IEJ2H9FlOF0VI+KNrZ
	vjbnhJdt/4cc7AKUI2LGjxiifNTqAtmtXvfm3
X-Gm-Gg: ASbGncsBvsDMUmLrf6fBxv1B93jEK6vVUV/ZIO/6iF1DSTZ1ui5ixIzSzoIz7lUsxia
	cGteN6NPcRk8KD3p8jJsChD12GhxnT9QbJiKR13vI7CeiQLydpkZAbE0x/LkQkzbigjEBFG9S1w
	Lwy2HFAgRwJ7A2MRuJUwyp8TKq
X-Google-Smtp-Source: AGHT+IHjNAYQ0ub88nN1552iMB2eL8X1RV4+1cI8aJCntlA0geWWYJiWNKkJ8nP6eRkdBx32XB4wFpN6HoYn7iau44M=
X-Received: by 2002:a05:6820:458f:b0:5fc:92ed:639a with SMTP id
 006d021491bc7-6005a21992bmr2215701eaf.2.1741823614821; Wed, 12 Mar 2025
 16:53:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311123326.2686682-1-hca@linux.ibm.com> <20250311123326.2686682-3-hca@linux.ibm.com>
 <CABi2SkXWD4Pg7Y7TG9fMV9eat_1fOGwHjvEUKHXREN+pRe18NA@mail.gmail.com>
 <CABi2SkXzqJ10NW3j1y-FtmrheDkqzL5QgMcN9UN6UvhbXFHCuQ@mail.gmail.com> <20250312153946.10610B02-hca@linux.ibm.com>
In-Reply-To: <20250312153946.10610B02-hca@linux.ibm.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Wed, 12 Mar 2025 16:53:23 -0700
X-Gm-Features: AQ5f1JqCIcxEvjlYrZ3A0vTQkfvlQ3azH4ngw0Oh5F45vZFYCocj3YPdsQosWIk
Message-ID: <CABi2SkVk-LNWioxONFDppLJNnd8kj+UH9PXG3BU-5GKcUJDavA@mail.gmail.com>
Subject: Re: [PATCH mm-unstable 2/2] mseal sysmap: enable s390
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Kees Cook <kees@kernel.org>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 8:39=E2=80=AFAM Heiko Carstens <hca@linux.ibm.com> =
wrote:
>
> On Tue, Mar 11, 2025 at 03:12:55PM -0700, Jeff Xu wrote:
> > One more thing: do you want to update mseal.rst to add s390 as
> > supported architecture?
> >
> > Currently in the mseal.rst:
> >  "The following architectures currently support this feature: x86-64 an=
d arm64."
>
> Thanks, I missed that, however I'm wondering if it would make sense to ad=
d
> mseal to the generic feature list instead (no, I am not volunteering to d=
o
> that :) ).
>
> See Documentation/features/... and scripts/get_feat.pl
Thanks for this suggestion. I will add that file.

-Jeff
