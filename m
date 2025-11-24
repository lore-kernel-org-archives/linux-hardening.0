Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E48B32E6BE
	for <linux-hardening@vger.kernel.org>; Mon, 24 Nov 2025 21:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764020614; cv=none; b=EIfaLG++dEfPetU0zQlPBYe30tNzsezEz3KdAKIAj8UqvYOuZdwyp+FtjN6w83/fOPkJ2KF10cOMNW4eulATgJpvIQb3UHKmPjuTeX3VNyWN6Z1KdNUXi6vwkY6Xt6bsQgR8FyAELIxKYsa6jmbEMzAqNX5c8HHcjX33WIz8aYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764020614; c=relaxed/simple;
	bh=21B8UNo59KNJ8qFUDnUl8PBh72Y8QaDRJNTNf4wTI1c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=caBdtddQlqQegKVFetG/3rg0Ku65Izfp4ZZSFG9RwaOOcItJlAPYRI/CjHbf2mUCgBtuC2zKv9lMVbMtNsjupQ6qoBmIomEMXP2tXABamgTbRFlOsVsfQ3HD8yNm8yBr64+UphYyoEOfADer27ZpxZoUpxruvRDyiWs6tf344nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=L6nZ+RUt; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="L6nZ+RUt"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-64162c04f90so7949723a12.0
        for <linux-hardening@vger.kernel.org>; Mon, 24 Nov 2025 13:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1764020610; x=1764625410; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NoAYUzaUy2oENd7JkoqDPVCvDLLlV10MU8wdc2FsfGw=;
        b=L6nZ+RUtkNuCmriKuoXn8PFrIcq6kzZxVq5shqWFtz19r8Xvzx8zCN/z3gMDf/eHvX
         EZQgCd2RYRYJ4SC8bgjtMnJ3yHP1SOWEJmZaKRdnzjfBbFeUXpx9dnSQImBt1t3IQiGJ
         iyXhormy063ACCQyzPb+OMsdhjU2Oo9m/HDf0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764020610; x=1764625410;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NoAYUzaUy2oENd7JkoqDPVCvDLLlV10MU8wdc2FsfGw=;
        b=Zrxhqj2YXAxc/hol1sXqxy+IaWh4sA9N0ebKXLYdZ8LBlrkG3/cpNtyGhfkHqcZRel
         +okm7WAcQNaEMbPz1OBSCKZQFENlFQhN1TmwGstcCyLGgdgbnpYzejdzhbVtWgTioPZi
         hCE0Q1HTjglcjWV1Lg+fPhT3rjYuy7nXsXD7Rscr2odsZwr5wfR4w7fTw0kcleM7VFkn
         qtCnvOC+TqiRZVM4yDgvRZobLrnOIafQ89Pt0rb5N4vezuGOO5s/xu7MHNAwv4AKFzbe
         fz8pbgNZDaQaEZkqxJyQKkfDbrUoEpSTI/csEl1WjDZ4fNnm3cIo2J1RPtLRIcHQvTyK
         Bk5w==
X-Forwarded-Encrypted: i=1; AJvYcCX5toOhJEy4OcH1NaP8pAewvPVreCMrWMPIVls7zWXJpkouJeJU5FgtcuVkLhdH6U60vf4szgMce5BGluIUzyc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwr4g0Q6gL9ThTa2gcRUG6o5eR+Sfq++DSj01de2e/x235hShR
	FTh7jOpuyqXRnns1LTlJMkRxvPnMTeXehtOfSH3ZK/QYuX8z7HFm3Fj/xM3iixfLxNz4S1KS4gT
	GsmHbuWQ=
X-Gm-Gg: ASbGncvRBwlo+lhN2nvIekB+/z2DM+PLoZ4dLZLBOlbIczgp3aspdogiC5VXuG5MU8i
	Ho0p+eemaness4rDyRo7SHR8eu5mwOlvYCEPHQ0Oqk7plXbXLNPzfAnMmsuAazgte4QwPYQzDGY
	ZCDz7EwYKIUCMh5dHJyLj34MYIqQZni3tCFonB5jnt9OgZvekFrhhdM01dDZWbp9apFqxMOMcC6
	T6OspE9aJEznq0at240SweUrZfsirZlnHXAMI/bMlC7VD6vnoSK7ayPCnFm4jCD2sHDW5i5/8uR
	qUFRPcXDmw+YT0YujyXv3KN1NYl61T65SeJec1H+OyWhq9ynqENMd3t3TIKZ1bk3hdhZeZnCgj4
	atQ5m05MQBydwGqp4cD/+rtKiVvLwCNEV88EmXbtJLhydwPmtZkzjE3wCUAmumgn5bYhowA7CDY
	tGCrxiEC4Cv5syUwWMt+mRNl4h4z7kOlyTDQH7TWLUKHCFiIlsUTZGFpL2GVRSoEb252G2ueE=
X-Google-Smtp-Source: AGHT+IHflurm8cuX+fcY0tLYUHMBmdbeFWYsCBDL//5KAT/xOvmR8XNXiBaUH6avCnddsQLBDq/hyw==
X-Received: by 2002:a05:6402:2816:b0:640:9db5:ba2f with SMTP id 4fb4d7f45d1cf-64555cf7197mr12482442a12.30.1764020610061;
        Mon, 24 Nov 2025 13:43:30 -0800 (PST)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64536460ea9sm14694960a12.35.2025.11.24.13.43.28
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Nov 2025 13:43:29 -0800 (PST)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b7697e8b01aso384550066b.2
        for <linux-hardening@vger.kernel.org>; Mon, 24 Nov 2025 13:43:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXcqrbVSKviwBRXTElfVysxTOkRpHDFdcgLRpdzABcV15fkD1OWS1Tslvf2gIbHc2Mjj1jc5TS+165baax7YTc=@vger.kernel.org
X-Received: by 2002:a17:907:dab:b0:b73:4fbb:37a2 with SMTP id
 a640c23a62f3a-b7671514106mr1495344566b.5.1764020128744; Mon, 24 Nov 2025
 13:35:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251122014258.do.018-kees@kernel.org> <20251122014304.3417954-2-kees@kernel.org>
 <CAHk-=wiNnECns4B3qxRsCykkHwzovT+3wG738fUhq5E+3Lxxbg@mail.gmail.com> <202511241119.C547DEF80@keescook>
In-Reply-To: <202511241119.C547DEF80@keescook>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 24 Nov 2025 13:35:12 -0800
X-Gmail-Original-Message-ID: <CAHk-=wikqnc16e7yUTJuqnc5f4rL+y_-JpRzCLRu9WPnt3nmiQ@mail.gmail.com>
X-Gm-Features: AWmQ_blKFpIgLGtxfT-s5R89X15xCb9TiduKsCJf35qbsynIOkmHF3dcQigtmSE
Message-ID: <CAHk-=wikqnc16e7yUTJuqnc5f4rL+y_-JpRzCLRu9WPnt3nmiQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] slab: Introduce kmalloc_obj() and family
To: Kees Cook <kees@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, 
	David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, "Gustavo A . R . Silva" <gustavoars@kernel.org>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, Jann Horn <jannh@google.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Marco Elver <elver@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, linux-mm@kvack.org, 
	Randy Dunlap <rdunlap@infradead.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Vegard Nossum <vegard.nossum@oracle.com>, 
	Harry Yoo <harry.yoo@oracle.com>, Nathan Chancellor <nathan@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Jakub Kicinski <kuba@kernel.org>, Yafang Shao <laoar.shao@gmail.com>, 
	Tony Ambardar <tony.ambardar@gmail.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	Jan Hendrik Farr <kernel@jfarr.cc>, Alexander Potapenko <glider@google.com>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Nov 2025 at 12:39, Kees Cook <kees@kernel.org> wrote:
>
> I'm not sure what you mean by "limit to pre-defined size". There's no
> such design in those helpers, except from the perspective of "detect
> and refuse to truncate overflows into too-small storage". Is that what
> you meant?

I meant that odd combination of checking both for minimal size and
then assigning to it, but upon re-reading it, I realize that the
"check for minimal size" was actually checking the size of the result
variable.

Those macros are illegible. And 99% of all users DO NOT WANT ANY OF
THAT COMPLEXITY.

Yes, the wrapper macros then pass in NULL, which then - using yet more
complexity - turns into a dummy thing.

Basically, if *I* find those macros unreadable - and I'm actually
fairly good at parsing those things - then they are way too
complicated.

And they aren't even complicated for a good reason. My alternate ones
did *more*, and did it with less code and less confusion.

And you added the complication to make the users less legible.

So no. We're not doing *any* of that. You make it simple and targeted
to the *common* case, of you don't do this at all. Because that
over-designed mess that actually turned some users *less* readable,
but one line shorter, was bad.

                    Linus
