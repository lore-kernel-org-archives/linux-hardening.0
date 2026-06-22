Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2204940D596;
	Mon, 22 Jun 2026 08:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782118650; cv=none; b=EJYS4SPC62ddK/cOutiy01K24KPT6uBbWCFlrsGBBDNiBgDFTz0au+D8kq1O2dHKOn9jCAcGjmGHzoO8QRU80XC2hMG5/Z1WtVd6d9HGI5Z1lNFmZCC60Z3OBGMOXKj8HhvmCxMvpz8tSdZzqqwFKk5XahCrVM/6w3kZ0humrEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782118650; c=relaxed/simple;
	bh=+3p4Rv3wZ6gDtsmjkRmmRXH93vJESrZv4HBL4LL670U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hb0PJAa16CxcSUvpDaydTWXYkQczRehV7ecYyRn1nm8U49pU/f+y2B9cQbHAZUsG6jHR5FyfDt9Od01nPsISvLuk1B5xdKVri0s0AViROYOe5U13iSFODzNZPvZQNN40dcb4lHTSUeoN1lmnxYznNDNSAO/301IPfYuVLYwe5co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TdR1yVmA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TdR1yVmA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AD201F000E9;
	Mon, 22 Jun 2026 08:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782118648;
	bh=wv/i0r1bxlNBcrsh4HnjmajShtpfnDagJ19dN4X4hIY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=TdR1yVmAnuLvWKNb1r6naEiUmdm1tE6T1TkkwqQ/uHPzmY7ET5woNWqZdr94VQbzR
	 mQIZhOzLoPhWZ5xjmpzXithUmUS8PmC1A6Ps1+Ygc9LGAequmzBLZkLtVnZdgD3z7W
	 U+6vvkHFhKL+YuiV9ZSJ9aM6rKugf8Wqyi3kso+Vh+OVZgMPruz+dLdPdmugF7xlcV
	 6HCN67DiZ21LkATZqdjZSsJGQu50cEuts5U85RMOpBiDdJehLSB5eqQMgJkPqEbNEP
	 HQSNd03+6LTcv4HkMQq4T5B7/b01UpB6AWUYzp7FeazQkKakxUpSH5QOrdRSBL/yyB
	 OGK4Fb2lMQIsA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org, Arnd
 Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org, Breno Leitao
 <leitao@debian.org>
Subject: Re: [PATCH next] fs: Replace strcpy(s, "../") with memcpy(s, "../", 4)
In-Reply-To: <20260619143438.495c1780@pumpkin>
References: <CnPdNyUGjsYpAP8JdysfUf4wkBkm2a923cQ1hE4-mg0sUnJIm4Uj-cAkdVHswEsuZ3d6vhmX5eil2zLmrkfl3A==@protonmail.internalid>
 <20260606202633.5018-5-david.laight.linux@gmail.com>
 <874iiyg5kj.fsf@t14s.mail-host-address-is-not-set>
 <20260619143438.495c1780@pumpkin>
Date: Mon, 22 Jun 2026 10:57:21 +0200
Message-ID: <87se6fdkb2.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

David Laight <david.laight.linux@gmail.com> writes:

> On Fri, 19 Jun 2026 12:58:20 +0200
> Andreas Hindborg <a.hindborg@kernel.org> wrote:
>
>> <david.laight.linux@gmail.com> writes:
>> 
>> > From: David Laight <david.laight.linux@gmail.com>
>> >
>> > The code has already checked there is enough room.
>> > Use memcpy() to avoid compiler warnings from possibly unbounded strcpy().
>> >
>> > Signed-off-by: David Laight <david.laight.linux@gmail.com>
>> > ---
>> > This is one of a group of patches that remove potentially unbounded
>> > strcpy() calls.
>> >
>> > They are mostly replaced by strscpy() or, when strlen() has just been
>> > called, with memcpy() (usually including the '\0').
>> >
>> > Calls with copy string literals into arrays are left unchanged.
>> > They are safe and easily detected as such.
>> >
>> > The changes were made by getting the compiler to detect the calls and
>> > then fixing the code by hand.
>> >
>> > Note that all the changes are only compile tested.
>> >
>> > Some Makefiles were changed to allow files to contain strcpy().
>> > As well as 'difficult to fix' files, this included 'show' functions
>> > as they really need to use sysfs_emit() or seq_printf().
>> >
>> > All the patches are being sent individually to avoid very long cc lists.
>> > Apologies for the terse commit messages and likely unexpected tags.
>> > (There are about 100 patches in total.)
>> >
>> >  fs/configfs/symlink.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/fs/configfs/symlink.c b/fs/configfs/symlink.c
>> > index f3f79c67add5..9f36699e5922 100644
>> > --- a/fs/configfs/symlink.c
>> > +++ b/fs/configfs/symlink.c
>> > @@ -67,7 +67,7 @@ static int configfs_get_target_path(struct config_item *item,
>> >  	pr_debug("%s: depth = %d, size = %d\n", __func__, depth, size);
>> >
>> >  	for (s = path; depth--; s += 3)
>> > -		strcpy(s,"../");
>> > +		memcpy(s, "../", 4);  
>> 
>> I don't think this transform makes sense when copying string literals.
>> The post transform code has one more foot gun than the original code.
>
> They are actually identical, the compiler converts the former to the latter.

The original one is resilient to changes in the string literal. The
transformed one has a risk of reading beyond the string if the string is
shortened without the length being updated. Or it can create a string
that is not null terminated if the string literal is made longer without
the constant changing.

> I was trying to remove all the strcpy() where the target isn't an array.
> The initial check also only allowed string literals - but I relaxed that
> a bit to reduce the number of false positives.
> Were a similar check for calls to strcpy() be committed this code would
> need changing, but you want something that ends up being a (misaligned)
> 32bit write of a constant on most architectures.  
>
> I just looked at the code again, the final '- 1' on the 'size = ...'
> line looks very odd.

It's to leave space for a null char at the end. `fill_item_path` writes
the path from the last segment to the first.

> I wonder if it would be simpler to merge all three functions into
> something with a single loop that builds the name/name part backwards
> from the end of the buffer while adding "../" on the front and then
> calling memmove() to put the two together.

The current implementation is difficult to read for sure. It would be
nice if we can make it more simple to parse.

Best regards,
Andreas Hindborg

