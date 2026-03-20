Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA9C27A461
	for <linux-hardening@vger.kernel.org>; Fri, 20 Mar 2026 13:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774013943; cv=none; b=UNru8j+6HwSAndlRSYZsqRAcbS5e3IrklKi8sb8/jnEn5klewQMNBfEmIoPvxWREFGQKC9UgCDWzbjdoBSJtlkyQutx2n0gJGFyAGoW79pgs6+R5f32yjvjxAWp/BukZXI9AtnFErSTpPznLBkTwzxikzIeAw6tAaZRMUl7A1eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774013943; c=relaxed/simple;
	bh=sZj6DnCZyjt8HONClCcyxov7+5CPr/w7swwMeT/AqK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XHKPhQnTpLBKkWL1iMltgGajXdGzNCkhpy1zkLzMBSjuOI4DgQ9VIMJY6+j9v4fvh1rVwjuvjRvnpfWh4+QtEN9Zd4i/gqC+HIcqPW8rS3mn3Dt94wyJD8+wEJtmsUYNnqHf+M8+K6I+1lUWG4h3HaFT17JRb/ByXfaOoDqHIB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pWw8Tlzq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pWw8Tlzq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89F41C2BCB1
	for <linux-hardening@vger.kernel.org>; Fri, 20 Mar 2026 13:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774013943;
	bh=sZj6DnCZyjt8HONClCcyxov7+5CPr/w7swwMeT/AqK4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pWw8TlzqDFoHwph3KDyCSQ9RWZggThxWkYDWtzDwwA0OIl26SBNnmwGWKyvUXmk/t
	 bDLDIfQVoweCT0QWhN0hi/0CePrQWqmS/okWujQXl9z7ibN9U45Lzqz1VW/yCKJsuL
	 MzwLiURiT9v/+P645X5uU+LGcWCbwl40Dnbck1lk2C9v9I+xfiROV6akOGoDyOYm9m
	 ybisSgzmIc3gqLHWG3qszlgjPkLjzPZYq7n0Mjx38D/dDYimOxAAVffyGCutrjAJnp
	 tW5/FuvQhXUMUm8MLBImdZgQ+0tofCMU3qAMmnuJwf2h7w14LjTpiyWg1t0PIHk4FI
	 eMEo4Cg1OE8oQ==
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-79a62a2bb8cso21356807b3.3
        for <linux-hardening@vger.kernel.org>; Fri, 20 Mar 2026 06:39:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU7hsB2c1cyV97ZY5Wy299auu1/80sJBJaeyetgeYFnjXN/VHrIB4qk223Kzv3az2zHshyNQwvTzytAvaIpBJo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9bTE/u4sHL+lO5T9zC17DlHv2yY8F0z9pMmkVrNbb4T8qQvmA
	UpjuAy7NeKKEHqDnCItWq3rCmnzt3kB9a1UPS3KBtMEWERaEInaGppl+7SgjWRLg0NJV11/Pl+G
	PYxMxvkwpKM2BAWeXoQDTAPUIVgQjdMg=
X-Received: by 2002:a05:690c:22c4:b0:798:e281:a4f3 with SMTP id
 00721157ae682-79a90ba02a2mr31740737b3.40.1774013942875; Fri, 20 Mar 2026
 06:39:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320005338.30355-1-rosenp@gmail.com>
In-Reply-To: <20260320005338.30355-1-rosenp@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 20 Mar 2026 14:38:50 +0100
X-Gmail-Original-Message-ID: <CAD++jLkpvSb+cQXoXV-9+2b8eQRYYJpKQzuf+6xAqarQsOL0_Q@mail.gmail.com>
X-Gm-Features: AaiRm51rZsRwW4njnIt6SHlMGSJepFEH4f2OsTyDiAdp7pcBmT6TD4IrYRReTow
Message-ID: <CAD++jLkpvSb+cQXoXV-9+2b8eQRYYJpKQzuf+6xAqarQsOL0_Q@mail.gmail.com>
Subject: Re: [PATCH] gpio: dwapb: reduce allocation to single kzalloc
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-gpio@vger.kernel.org, Hoan Tran <hoan@os.amperecomputing.com>, 
	Bartosz Golaszewski <brgl@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2026 at 1:53=E2=80=AFAM Rosen Penev <rosenp@gmail.com> wrot=
e:

> Instead of kzalloc + kcalloc, Combine the two using a flexible array
> member.
>
> Allows using __counted_by for extra runtime analysis. Move counting
> variable to right after allocation as required by __counted_by.
>
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
