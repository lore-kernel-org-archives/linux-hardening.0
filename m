Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com [74.125.227.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAA2499F0F
	for <linux-hardening@vger.kernel.org>; Thu, 17 Sep 2026 21:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789680586; cv=pass; b=t1RSWDjIKVv4ZROCqMzCBeUAtDf8FAvrUp7AugwQCksOfDf+uNS9qRIG7Fk3h9jWCG6dTaCTCZK4hE04asIK1XUcv/V8GNtaj7OGXF74aRtmQo40MJKzNKw+dDTS8JfK7Q3vV7H6/hHjnmzPRTFKjI82tU49SiTWNiVKQpJpOR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789680586; c=relaxed/simple;
	bh=qgLoDi6Xh7D7JxGbAM+LdTIwZ8wB4ozC9PqydMFa25M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SFbALpQYYJ+mHbGf5ocGY29V1gLdDYM6yTHldOAb4WbAxy5Fmocv8sPzDJnGEgoUuHNYs6ALBQ6pm3y9O09k3geWXda/Y3ZZtjS0TxQ/v8tJhYBYH7ke1DfvB3Kfmtvlg8eUHoB6cwXtb6wHya3kYbMlzXgMmVp08gfJ2hmK9zU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v31K2xAs; arc=pass smtp.client-ip=74.125.227.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v31K2xAs"
Received: by mail-vs2-f12.google.com with SMTP id 71dfb90a1353d-5c67e5059f9so13934e0c.2
        for <linux-hardening@vger.kernel.org>; Thu, 17 Sep 2026 14:29:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789680584; cv=none;
        d=google.com; s=arc-20260327;
        b=d3JtYlnfRXOh43CeP9UBE+2+CsBiLIqzRCucQzSdxYOVHIwgc9MWuWi33vqi3cx6ZD
         VEcouVUBhceyn2aKJqarvEKMy10dEiA2JBRP7Csb6BzHAF9SBvNLWwHxkyRuQEgjDdPI
         dMoJ0Z19A8q2FjCHaxZMTGMj/cuPc4Xzw7Mk58JT9XWC/NzpqASo7VQjH1nUM47kLOK7
         cScJyaUp3vhI673F3UXws4kFS9d/gVyArFUZLMl/zXW7E7YS6AI+rM8QF/BK+mCcCPrV
         K5XuB4tLA70JJLjuj4lUl+B0WurW+a4AqsRelBErgWum6EFVRjYmx5FxK/gaKbTHQrbS
         k3+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qgLoDi6Xh7D7JxGbAM+LdTIwZ8wB4ozC9PqydMFa25M=;
        fh=2qf3u0NRCkFysarKlwKEWZTmEtKriv2Xj2dwgDTw0gE=;
        b=AjoUDTX464eVAO7bR7cCZHrHJsqhgxpP09+LV7uiBas40qfGaJ04LIb45SzpuN9q7l
         l5/z2hIWJPuDZCbEFJGCEiTA9pbXbfc83mjaCMGkZqO8HN+kvv46AiYYHxtdLziu0MM3
         WSSzxb+yQNQX/taCK9R4VS0vnWZRGg85r9kzlIYWvoBWTjW9s8c43DAIpGj2cT3HGILp
         6OsgvBoP+Jz59BQNOnlMAWp/l6tckvBiLo+WMcpmGj0H2wZAsebF1nndenKcvGxZGz6A
         0LzkLSLy5gRsWiMla2OpjaS2mBGv/MrGAaDNpFLGOuEkCpKLh/JGvLzlG5XQ+cy6BLWy
         0zDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789680584; x=1790285384; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qgLoDi6Xh7D7JxGbAM+LdTIwZ8wB4ozC9PqydMFa25M=;
        b=v31K2xAs4kc1vZHOyTkWByZOM8TMy+phP7RpVpUuEOX9a8GRdHmduPj94d3Nh1yhyw
         WUutoWbMfwDMqCL/k8FXhit1X0/ybEB4o9T7W3SATErlhIc6Y3yGfaYiULrPucGvrqZQ
         uE5BD1s6zkUxXsISYHIkJKFjGg9nb2v5GcNQ5j/JTdAzrVKOo6xu+PYku/PSKmP8clRW
         qZ5eRtin4lNoelGVoA8kjcoMIl1YOwtKwU44sY1gW0OZobeVPGbdD4IAGGKhQqlVEz2b
         sIrnscC+Ord8a7/IlsVdgpgNh83jL3rfOHQvEcSVgL0tdvcoMliiLsnN1VIm/KusAWk8
         pqPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789680584; x=1790285384;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qgLoDi6Xh7D7JxGbAM+LdTIwZ8wB4ozC9PqydMFa25M=;
        b=rz5XQEe0cDtOxug6gR3uLdlpS3bPz5BNoLEstuKGUxT4l2FMIFvd8Sk8dYTFqEOSwQ
         6cDLbbOwRVRLEdgAPP9kWwmTdKVec6r1biwF1hOKjMW2pc3cVrdWA81njT+/vkvEJb+I
         7ZGz9tuw1g16+4Tdf+1RWe+vNmgb+FMGfe5aQm09hRSwi44TLj6R0rjtmRywPApBCoCU
         q+wb7N7bvnNnkfBj9J8t/nkOvtnZaspzH9QtZxUpgVnwkjwB4MuPn2xoPHaOC00mnvc3
         3MowrzJRqdtfB3KdWKOuWVBJlVaJYsIY5kS7/4riEL1FtDp6/0TUfC6cFxiknX7/jaTX
         g3Dw==
X-Forwarded-Encrypted: i=1; AKwUvBwQeAkfNrWNBXp68xHarRIySHppHgmL/SotX0Pqu98Mc2dSnFi/NggjbcTuAHzREDMDZ8XY4XBo3XCzgxg3lfI=@vger.kernel.org
X-Gm-Message-State: AFuF++nNrRlJ7q/3O9T9sWfwTOduABmmBlSocaF1bj+E1ujR/r1t8JkS
	WurLG7TylrbDnP8U8ALVvm4B+jhFhqT7EaOfgygMrytk7iXCw9ei3zCl6vjXtUDAUR2SOq1RbDd
	k6/lCi76ULXyFGuGnUOgX+CEBN3BEC1Ft04XqhCSQ5f+Tm2/bl6oAkskb9Q==
X-Gm-Gg: AYBFou3A2M7RmyFFL2nhx5AlNx5iTERTVUK9OCXPI2z2iZ6l3VfFUcWlXlMbpAJ3ggq
	fFFSpO40QEzv+WWrz474xXCUwZkd4FrlOJStV2hdkbd3KINir/PzBGgIZXMuXbtyxumfiHhOMuh
	cVhRaFjg31D20uWNnZ4gI+yeE8z6yV87DGro++d8TNoMOrtCLOfchtk9EAHAj5w/3cEC4P7h4U9
	7bpMWOUSe4SZDfGFR2D7j1JT0+jRyDwa9yH2K37iR+klc6uDg3R4JvebpifzpDjgQxN6W/Osygv
	X+hYJkuV9m1RaSKia7eWhDSn4Ey4QDjvdHGFlBe35il4vkE2sCUbvHuToyl+c5unEL+oEOt93Go
	gGjhKYeavVT9YSKSQi31z
X-Received: by 2002:a05:6122:328a:b0:5c8:4bd6:fe with SMTP id
 71dfb90a1353d-5c9b58e4d13mr267621e0c.8.1789680583441; Thu, 17 Sep 2026
 14:29:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916222125.1259631-1-morbo@google.com> <20260917011359.1585961-1-morbo@google.com>
 <9DA6BE5B-E65F-4E8B-8B56-A861042100E4@kernel.org>
In-Reply-To: <9DA6BE5B-E65F-4E8B-8B56-A861042100E4@kernel.org>
From: Bill Wendling <morbo@google.com>
Date: Thu, 17 Sep 2026 14:29:26 -0700
X-Gm-Features: AcwNN1VNx8kwm1pwS70fvvLDvkNMIiJFA0qoHj8KSyyD3K9Zmt_H0FI-tXmjMpE
Message-ID: <CAGG=3QV0yamwdhWX=vB4LaworiOJ0iUaDCJ3E24Wh8NHgHXpuw@mail.gmail.com>
Subject: Re: [PATCH v3] seq_buf: add seq_buf_strlen(), seq_buf_init_append(), seq_buf_puts_trunc()
To: Kees Cook <kees@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 7:24=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
> On September 16, 2026 6:13:59 PM PDT, Bill Wendling <morbo@google.com> wr=
ote:
> >Converting some strlcat() call sites seq_buf need behavior seq_buf
> >doesn't currently provide, either directly or without introducing subtle
> >bugs:
>
> Ah, our implementations have crossed paths in flight. :)
>
> > - seq_buf_strlen(): seq_buf_used() reports the full buffer size when
>
> We agree, we need this one. :)
>
>
> > - seq_buf_init_append(): seq_buf_init() always clears the buffer it's
>
> Oh, nice, yeah this is cool. I'd like a different name that mentions "str=
"? Maybe _from_str?
>
> > - seq_buf_puts_trunc(): seq_buf_puts() (like seq_buf_printf() and
>
> I prefer my solution that just truncates and sets overflow. Nothing i fou=
nd needed the non-trunc behavior.
>
> I'll send a v2 of the other series with seq_buf_init_from_str?
>
Hi Kees,

I didn't know you were working on this as well.

Andrew, please ignore this patch. I apologize for the spam.

-bw

> -Kees
>
> --
> Kees Cook
