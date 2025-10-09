Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955E52D0625
	for <linux-hardening@vger.kernel.org>; Thu,  9 Oct 2025 12:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760011670; cv=none; b=fNz4tb+/HjJOcUbkVRWh1URGlgVu3ofCgsMWX+xHoZUeHifIUwcNz+vhss+vbCj5obE0VNTKis+FNO6UZAbBeSqgfdEnPPDdLhKqQyeFGnAyN8liznQ9O+W3yaSbtUVWQ87JnnuXDODT1BCfxXNqY0tysqP1Cc1yNs5Vtyy9HUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760011670; c=relaxed/simple;
	bh=+p3lQzk+If+FfstGkjdjKHCQavXIY1wiQDGCM90CDQo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TDwjHZTz7wg4pZTy72ShgVpKiLpPipWf00Hg5pNe2dT1vSiymyE8cFLR7zg/b0BWPT1gXTHB5iYerYNeHMQ4DQRL/HNowXHDu9/+hJhs1C/nQ54sFj+LgnH5CRKaAG1iXxx8eOVG0g7YqgU142BtE/nhEGUm+0CQ24wV04b5r28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ASnf2qxi; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ASnf2qxi"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b67684e2904so36214a12.2
        for <linux-hardening@vger.kernel.org>; Thu, 09 Oct 2025 05:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760011668; x=1760616468; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+p3lQzk+If+FfstGkjdjKHCQavXIY1wiQDGCM90CDQo=;
        b=ASnf2qxiZprtOG/sg3kmX5P98qy3e8qUf6RIjvbEPiHly8MQx1YktSRmlaPlFQHTIx
         tkkpZ7hbEsyhTQv4vFT6oHXV4qyxdTTbG2NDmpZbVKa5uv9mqZYCJejduRI3QG3TseMX
         Qm07zbwOHUT14hrDko9mzUmSkLJEtu9a+8Rj09/YKAerhFNMby0vOmFlLVU2HuutJXP8
         ExVgEn6NURLMPamEiRNcl7A8F1OPu1yeputBi20UmDRrkVPG7JxBnNY9h6b0riPi2E65
         RgAnTSqbpjLxuT3DnmhDBRbdpoM7ktBGv/VudT50zYMNtGvT+hQj8fDAxqfjYuCjRKXt
         Q0Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760011668; x=1760616468;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+p3lQzk+If+FfstGkjdjKHCQavXIY1wiQDGCM90CDQo=;
        b=RDNTbTbI2+J0/sJqp/Hv322ppgqZ54Wkh8feMlwuF+Sze09AQzueGaU6VVyqjno+RJ
         MFvb4KqbGBzXWePIVUJtjvzx+FgCaXwvxAVKn9cf8dyRLKRhfIiR6nZJHSmArpKhVIE9
         YT9Zfy0Tyshw/T5h1n/nBHDlfaQavpuaLjLRFdK9agPUzb2zcgP+U9gMKdBWtgFf3MdB
         sV1N7N+Apo319dis827G49mkxv6fAhRG8t8r3if9toUkh8P42Ikz8KFyk7UeVL1FXq5s
         2e024hQln0PDoVmIful/UsVCsLTXFC2LUpqmdb+RZpg44GmkQMXHc+0Q1ni9MqruvGei
         bsZg==
X-Forwarded-Encrypted: i=1; AJvYcCV0OIbvh9bEWmjv2nrY3FIAKI+oDTzj4JfSoVbMSIW2ZpiueHFrG9r6aEVXfmscn4Jbdc7jOM1aK0yKpWoExi8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkXrtDVUFyMkF1zCOnVuqvKZn5/rx7eImTeTabKlb0P/JIyZAG
	TlV+yxWpO43t+qrMCM+vFutL5+SwIjGJhU9HOLl/ymGBvi978qmXioCQikn/bMwozY7cBzE4V5t
	1tGDtDG69VRiiADCh5AIz3H/F3Yqj1LtkZzP8/Yfj
X-Gm-Gg: ASbGncvctazo9ap8uGa1YbQ84ybPvp3BzM2wwtAybcPTyXx1k8uj0h2P24IKmKo/Xy5
	5vNfxyahd4JiO4ZuTyoHrecL3VLvDIHk5BtpHhC6AOAv05bqEyCFRyhpoF7XW7QkeImZUZHmiSN
	RRcuR23LyzGQM+WcLV0YJfSewRqMOelQDfsCYIEU6a9RJ82AFtua8BzLFqD/UNlQQc6aUxZAJej
	kNofieirzPd6DGD6fBev1PIA8TuOPUTlGgfZziv9sqz+yP6uWLUQkvWDn4vdJT3eW6I
X-Google-Smtp-Source: AGHT+IGK2999Kxnf1WRLkrVBgJlG2sfTe8NQQmLvAYHDshQ3OJDYVTnqzxr7Hq0u+SA2CL8Dip3ynt4DcSFfDVGoOE8=
X-Received: by 2002:a17:903:2350:b0:27e:ef96:c153 with SMTP id
 d9443c01a7336-29027379a5cmr98765325ad.19.1760011667351; Thu, 09 Oct 2025
 05:07:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250315025852.it.568-kees@kernel.org> <20250315031550.473587-2-kees@kernel.org>
 <aOR15Xb6DfolYM0z@casper.infradead.org> <202510071001.11497F6708@keescook>
 <e019c59a-ba8b-ec04-dc5b-923cf9dd9d9c@gentwo.org> <CANpmjNMsSGY+QEn=GV8S2sXuuQsioikPR+OhGa3+6EoTqYPkHQ@mail.gmail.com>
 <202510072114.52B93ED736@keescook> <b17ab23a-b0fb-4fab-afa9-41dfce65675a@oracle.com>
In-Reply-To: <b17ab23a-b0fb-4fab-afa9-41dfce65675a@oracle.com>
From: Marco Elver <elver@google.com>
Date: Thu, 9 Oct 2025 14:07:09 +0200
X-Gm-Features: AS18NWBVVE-SSQe4ScCSB1Ze0NxTS0A8p2TAsqA4RTj9KK9B9ZbDa15oefynRbc
Message-ID: <CANpmjNN3UH9vL6x4P29MjSg5L7p3aBScGv5tY9ex7N-xYmqrPw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] slab: Introduce kmalloc_obj() and family
To: Vegard Nossum <vegard.nossum@oracle.com>
Cc: Kees Cook <kees@kernel.org>, "Christoph Lameter (Ampere)" <cl@gentwo.org>, Matthew Wilcox <willy@infradead.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Pekka Enberg <penberg@kernel.org>, 
	David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, "Gustavo A . R . Silva" <gustavoars@kernel.org>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, Jann Horn <jannh@google.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, linux-mm@kvack.org, 
	Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Jakub Kicinski <kuba@kernel.org>, Yafang Shao <laoar.shao@gmail.com>, 
	Tony Ambardar <tony.ambardar@gmail.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	Jan Hendrik Farr <kernel@jfarr.cc>, Alexander Potapenko <glider@google.com>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org, 
	llvm@lists.linux.dev, Matteo Rizzo <matteorizzo@google.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 8 Oct 2025 at 09:49, Vegard Nossum <vegard.nossum@oracle.com> wrote:
>
>
> On 08/10/2025 06:20, Kees Cook wrote:
> > On Tue, Oct 07, 2025 at 08:18:28PM +0200, Marco Elver wrote:
> >> On Tue, 7 Oct 2025 at 19:47, Christoph Lameter (Ampere) <cl@gentwo.org> wrote:
> >>> On Tue, 7 Oct 2025, Kees Cook wrote:
> >>> iOS did go the path of creating basically one slab cache for each
> >>> "type" of kmalloc for security reasons.
> >>>
> >>> See https://security.apple.com/blog/towards-the-next-generation-of-xnu-memory-safety/
> >
> >> We can get something similar to that with:
> >> https://lore.kernel.org/all/20250825154505.1558444-1-elver@google.com/
> >> Pending compiler support which is going to become available in a few
> >> months (probably).
> >> That version used the existing RANDOM_KMALLOC_CACHES choice of 16 slab
> >> caches, but there's no fundamental limitation to go higher.
> >
> > Right -- having compiler support for dealing with types at compile time
> > means we can create the slab caches statically (instead of any particular
> > fixed number, even the 16 from RANDOM_KMALLOC_CACHES).
>
> Maybe I'm missing the point here, but I think we can already do per-
> callsite static caches without specific new compiler support:

What we want is not per-callsite but per-type caches, possibly with
some smarter cache organization based on the properties of that type
(does type contain/is pointer), where the latter is required if we
cannot have as many caches as there are types. Per-callsite caches
could be stronger than per-type caches (with the exception where a
single callsite can allocate multiple types), but neither per-callsite
and full per-type caches are likely feasible due to performance
reasons. So we need some scheme that allows bounding the number of
caches, and letting the compiler help us out with type introspection
is probably the most reasonable approach.
