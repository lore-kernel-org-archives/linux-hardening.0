Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B76428A2CE;
	Thu, 13 Feb 2025 19:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739475250; cv=none; b=DcYgHhshj2liqpc6KwvfPQn/sUPwAVmaz4+uJ5jy6wpBuFqY7EhTIKd5MJghZQ3cd5dYrzF/SQCKGNn/8umRozwcwCpV4ngouLiRgQSt1nVCN9l77sdTZI5vO7QmhBVfTobQWxE2AhrBcG+dyouEoRhAuD9P0AnhpTuSxiQ/6pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739475250; c=relaxed/simple;
	bh=uxvsjaNh82I1/Ai/fST6DXeHd9m7K/+qT5V12SmKNto=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=I7gL2jOOUlXMGW8eYaHGyrYQlT4ZlJ3NixXPfaVuQjhLwt4Mi4/2FFiBOYQrSnViHzIe0aP19uWPhLydOa8oBFNyHJPGDndSxR8wwt1XpQFpfKTOuz6UBVQO19YRbWoFPDzzdPFrZyY/fK7lopAV2LG2JpahCGZpJv8b7Ov8U38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=habiQrF5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="habiQrF5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A09A9C4CED1;
	Thu, 13 Feb 2025 19:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739475249;
	bh=uxvsjaNh82I1/Ai/fST6DXeHd9m7K/+qT5V12SmKNto=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=habiQrF52mK4Y+HokO0aZIYhVrmehI3PnkD7DXVK+BH104wyltvtNsLqAQbsv+GuX
	 pBc8FSHmfH1ASrLHv4YgiSJH7vszpoEYe+jvILWUFMgNBd43DxQt19t36YCXCYCFmc
	 VFnmHc0ygvHs94FD6NRMlukpe1dcVFQFc0rbF1RhHee+x4hZJWRcg1nouRL704l44n
	 4mE2LPZAbSBvanFTpP3ZhUKZ49u0zDR/cxCkLf+nTwldPBpW8IjWvcWL6TxfL7kCDB
	 SEQD7I401n7ANI8/jz10ufHNX6gbPETFzw3A/cQZ4ZKjudj1deJ6nVL0SfdywK+WnG
	 XylqhC58Ip4Zw==
Date: Thu, 13 Feb 2025 11:34:07 -0800
From: Kees Cook <kees@kernel.org>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
CC: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, jeffxu@chromium.org,
 akpm@linux-foundation.org, jannh@google.com, torvalds@linux-foundation.org,
 vbabka@suse.cz, adhemerval.zanella@linaro.org, oleg@redhat.com,
 avagin@gmail.com, benjamin@sipsolutions.net, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-mm@kvack.org, jorgelo@chromium.org,
 sroettger@google.com, hch@lst.de, ojeda@kernel.org,
 thomas.weissschuh@linutronix.de, adobriyan@gmail.com,
 johannes@sipsolutions.net, pedro.falcato@gmail.com, hca@linux.ibm.com,
 willy@infradead.org, anna-maria@linutronix.de, mark.rutland@arm.com,
 linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de,
 rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com,
 f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com,
 mingo@kernel.org, ardb@kernel.org, mhocko@suse.com, 42.hyeyoo@gmail.com,
 peterz@infradead.org, ardb@google.com, enh@google.com, rientjes@google.com,
 groeck@chromium.org, mpe@ellerman.id.au, aleksandr.mikhalitsyn@canonical.com,
 mike.rapoport@gmail.com
Subject: Re: [RFC PATCH v5 0/7] mseal system mappings
User-Agent: K-9 Mail for Android
In-Reply-To: <fyqlqgtbscwh4fiwmjtkb74k4ratlelwh2vzfyaeatbc3tcicb@5uvfy4hq5xde>
References: <20250212032155.1276806-1-jeffxu@google.com> <b114f48a-a485-4ebd-9278-6c62a1f33d9c@lucifer.local> <202502121401.B6EF2D4517@keescook> <fyqlqgtbscwh4fiwmjtkb74k4ratlelwh2vzfyaeatbc3tcicb@5uvfy4hq5xde>
Message-ID: <CD0870ED-6857-45EF-9C28-F27475964D71@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On February 13, 2025 10:35:21 AM PST, "Liam R=2E Howlett" <Liam=2EHowlett@=
oracle=2Ecom> wrote:
>* Kees Cook <kees@kernel=2Eorg> [250212 17:05]:
>> On Wed, Feb 12, 2025 at 11:24:35AM +0000, Lorenzo Stoakes wrote:
>> > On Wed, Feb 12, 2025 at 03:21:48AM +0000, jeffxu@chromium=2Eorg wrote=
:
>> > > From: Jeff Xu <jeffxu@chromium=2Eorg>
>> > >
>> > > The commit message in the first patch contains the full description=
 of
>> > > this series=2E
>> >=20
>> > Sorry to nit, but it'd be useful to reproduce in the cover letter too=
! But
>> > this obviously isn't urgent, just be nice when we un-RFC=2E
>>=20
>> I advised Jeff against this because I've found it can sometimes cause
>> "thread splitting" in that some people reply to the cover letter, and
>> some people reply to the first patch, etc=2E I've tended to try to keep
>> cover letters very general, with the bulk of the prose in the first
>> patch=2E
>
>Interesting idea, but I think thread splitting is less of a concern than
>diluting the meaning of a patch by including a lengthy change log with a
>fraction of the text being about the code that follows=2E
>
>I think this is the reason for a cover letter in the first place; not
>just version control=2E  After all, we could tack the version information
>into the first patch too and avoid it being in the final commit message=
=2E

Okay, so to be clear: you'd prefer to put the rationales and other stuff i=
n the cover, and put more specific details in the first patch? I've not lik=
ed this because cover letters aren't (except for akpm's trees) included any=
where in git, which makes archeology much harder=2E

-Kees

--=20
Kees Cook
