Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2151B4236
	for <linux-hardening@vger.kernel.org>; Mon,  7 Jul 2025 20:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751921383; cv=none; b=P6nHg6+KyvQEFCGPqIHJ/Wfqz6dpAYylGLF11gAcsAiBd1NL1+2oLQ3uDA7B5+6q29s6jisbcQkcH0O0egfy1snVAiyJmyMSId6P3JPe+as0nA41qh7yxSamVuHVO8+yTg8aQ79qjIx92ozbu2Iu5ED7STihzvSXp5IFXNF9dmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751921383; c=relaxed/simple;
	bh=UlDKEZ5sWoRHG7cBcIetwmT6gX+Tex47BHzvQ0TG7UQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CwwYC4y28I2vw4cd4MjwSUTNP9Gd4bScVcxznZUd9tuzXvs+lGazWP+8keJAJS/ytpuLqP7OxF7y4ShYjRU2ZsXKr5A+MO84D+ZgSe6hW+psU5H2eKpt5VjtUuaT5LzBdoFR7tdSVN7GF1a9lqw8f6V0+dwofJQMvHGx5OrbGnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OznHFgvz; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OznHFgvz"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ae401ebcbc4so591901666b.1
        for <linux-hardening@vger.kernel.org>; Mon, 07 Jul 2025 13:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1751921379; x=1752526179; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=02PgiN7PJFVFaSl1V+OWG4TgqqQ82M8yAYvu32Fbss8=;
        b=OznHFgvzIGNoin3XJUee1aRQWChgFR90oiWthvm4p3rNoLLd5hHta2PjrN0l3bC2/I
         lalfnpvsjqQvcwZNnEq1BfkpXln1CF762bWR3y4iue/rheNsJT0OZ1XgdTcX0l3l7VbR
         veXrKDHaD0lnsEfUDslZ8+qgXZiJCqzCstln8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751921379; x=1752526179;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=02PgiN7PJFVFaSl1V+OWG4TgqqQ82M8yAYvu32Fbss8=;
        b=t5Zm/ToJFXFqavwGCYzw7oaT6UWdyQH8D9H3w6boym0UgGWMkCdjtipGupt6LIpjh1
         0FCKkL/MD84vGNhJH95IJHo8DqTtnN0vsiDjwN1wSXdJHHBmDQhWBDWp2016Sb6JACQ3
         2UPK11MeUegqJ3UvjL31JFlUGORbLTGyldy9MnK96qOgB7N6qyI/5QtiULSRI67QWHNm
         gX3ZcYbEkG0p6zWDrVtZuc0nxg3E8GI4e2m0zRga/ZO6C7XyOEJeuxEDDnZrT6DjO9hr
         IuQu2+AcYDNjRFFutJY8rW+lYmIiM+yxKkdgqjhDaypslSFs3S5L+ehuv/RnSRUpGT+f
         Nh8g==
X-Forwarded-Encrypted: i=1; AJvYcCWcgID8UATuHr93FUuDi0aL8Ctt9Hx7rSmpPDINGiIU237JJjPtRzf+qEF5rLebluEdoyZBdx4YSgZAPiIRLk4=@vger.kernel.org
X-Gm-Message-State: AOJu0YysZ3AviJcKJuVFb7lL+vbLpZ8AG9nvjkBlR5O0O8MlRiux+mil
	DZnH49XcjqM2rQkZhP6Ij7RTn3oiJ3VpE2dHFqX63naH7VUUi5z5ila2DwCjfOekgnRN57UOwZT
	IEQYvrNE=
X-Gm-Gg: ASbGncvmyKM5bEBM6xQaM7vvRWTfbGswqiANdrdLE9ihNk0/diWgXkuHNbSdGo2Uk48
	TT2I6cLa/YuFM9J5hg4I/yoHZyOSwT6s1R5p9FBfjMAGKaggvE0A0b7Xw+Tn6zwwYRITI1dci5v
	IfpER9yoI2meikuMF2VOdL7xDT9/ZlwHNhOj1Gu7MJi4su3AWa4Y8orbx3T8EEniqWQuEyUtu20
	Qt/1aVPKQTkHpTt/lXDmhTCK22R8U+m7vWIrgSce7l8CVS+iTVjOLSFG73JGJkQBVbMdDeeBYRJ
	Lwh+TpRU6/o1vjk8848sSQ8uIro1PZAbJxW3uFiAIbETx2OU/6sOza2Yw9ZeU4vhlNObE+5mPwA
	dDOXol6/5kYxwn0phmFkoNyTM6NipgjWxLTC9
X-Google-Smtp-Source: AGHT+IGcXZQBxeqz7AHcaf2jUq7xTY56FlGtImJEEaf/B+J+WPDbOtiqaxcQZVElbFF6bzm0rOgGAA==
X-Received: by 2002:a17:907:1703:b0:ae3:d026:36cd with SMTP id a640c23a62f3a-ae6b021beebmr48581266b.42.1751921379192;
        Mon, 07 Jul 2025 13:49:39 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f66e7d4asm753129366b.23.2025.07.07.13.49.37
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jul 2025 13:49:38 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-60c4521ae2cso6398300a12.0
        for <linux-hardening@vger.kernel.org>; Mon, 07 Jul 2025 13:49:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWO6d+ywjbheDoOkCilaSjVT/5Ne+dP5zORNp6yRlUuHKw8nxrILffxN/HbjJVSe8WkF8nNpzRAxSXX3Tkfu44=@vger.kernel.org
X-Received: by 2002:a05:6402:35cc:b0:60c:3cca:6503 with SMTP id
 4fb4d7f45d1cf-610472e9b9dmr1045719a12.32.1751921377273; Mon, 07 Jul 2025
 13:49:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1751862634.git.alx@kernel.org> <033bf00f1fcf808245ae150346019aa7b997ea11.1751862634.git.alx@kernel.org>
 <CAHk-=wh9Pqz07ne9iSt1_v0c14rkOGvF9AbEkaq1KnFhQD1SSA@mail.gmail.com> <ugf4pu7qrojegz7arkcpa4cyde6hoyh73h66oc4f6ncc7jg23t@bklkbbotyzvp>
In-Reply-To: <ugf4pu7qrojegz7arkcpa4cyde6hoyh73h66oc4f6ncc7jg23t@bklkbbotyzvp>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 7 Jul 2025 13:49:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=whQ_0qFvg3cugt84+iKXi_eebNGY4so+PSnyyVNGVde1A@mail.gmail.com>
X-Gm-Features: Ac12FXyBZiGga4SfFrcaUHuYJV_R_nCmMtiL9Yd7402tdLFKvKKk4keGfQkJ8kk
Message-ID: <CAHk-=whQ_0qFvg3cugt84+iKXi_eebNGY4so+PSnyyVNGVde1A@mail.gmail.com>
Subject: Re: [RFC v3 3/7] mm: Use seprintf() instead of less ergonomic APIs
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, Christopher Bazley <chris.bazley.wg14@gmail.com>, 
	shadow <~hallyn/shadow@lists.sr.ht>, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, kasan-dev@googlegroups.com, 
	Dmitry Vyukov <dvyukov@google.com>, Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, 
	Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
	Andrew Clayton <andrew@digital-domain.net>, Sven Schnelle <svens@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
	"Huang, Ying" <ying.huang@intel.com>, Lee Schermerhorn <lee.schermerhorn@hp.com>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	Chao Yu <chao.yu@oppo.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 7 Jul 2025 at 13:29, Alejandro Colomar <alx@kernel.org> wrote:
>
> I am in the C Committee, and have proposed this API for standardization.
> I have a feeling that the committee might be open to it.

Honestly, how about fixing the serious problems with the language instead?

Get rid of the broken "strict aliasing" garbage.

Get rid of the random "undefined behavior" stuff that is literally
designed to let compilers intentionally mis-compile code.

Because as things are, "I am on the C committee" isn't a
recommendation. It's a "we have decades of bad decisions to show our
credentials".

In the kernel, I have made it very very clear that we do not use
standard C, because standard C is broken.

I stand by my "let's not add random letters to existing functions that
are already too confusing".

              Linus
