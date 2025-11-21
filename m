Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4670013A3F7
	for <linux-hardening@vger.kernel.org>; Fri, 21 Nov 2025 21:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763761682; cv=none; b=fojGg6WeD+ltGZrGqnTngfOtjLYMsmtvmejyPET9e9rU/P/mBNCoY3Pf3BsZpLXSf7Ed6S+ykqD/AGAnqtXc8ZmWxkk3r2rRExWtoYpcpvWCWalWI/IwSeAMUvwWTwAOKg64FP6ZMri7P/1P+1pUUppmt2bRKifWA0rHaD8xwzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763761682; c=relaxed/simple;
	bh=+1chXuvjm9GlVaYLgfPyjC18yPzYgGx7MYfJjLnWvt4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ge5eoTaVSQgIfublvs/MR1aPs4+qqdqqaHz5+L556yQWCem2F/GJJ4NddxWYLBlvOvfRBFiadKU9QU01l9bBqHbWB90UK7oiLv9lYZqYmTb5ZEUbYeNnUrGM19zoA/GFzu4o/N7thx1t162sPRW7fMte437EyQE6WAsYv+MFLX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aU2cZxZP; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aU2cZxZP"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-bd2decde440so169143a12.0
        for <linux-hardening@vger.kernel.org>; Fri, 21 Nov 2025 13:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763761680; x=1764366480; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ekM322G+PEin7yvRndAbrKvUWb4I0YPQ5GMMtTk3+Eo=;
        b=aU2cZxZP4E+cBVSikk5qdQxHM7M4IKM4ycJyJEUCqNTMvKkRu/BZ29isA15/G/oqOF
         ITudijlInCp9HabjfJoE+b6noRtRdfrv3rndQphWKrIeKBGqmv2VPZ/MGOIcjmxW40mm
         CLDKZNbTLIFSqi2JGu6LlF9dQ1ZXInF9PeSOj4XHFAv6Ps1UAqx4Ew1LDF8f5fMcsd+4
         IvsTyF7oYgFpJ7dJquoLiNUFXFKh8/ynVXGBFaUTu15t/y/eQJEkv5f5pSu3OVWILB3z
         24NFV+guOrUHd08xBUizVsLQ2BszGCE9ZJ7JbsaGjotSVKSNelWKfPBX+2BgEa2jhaxs
         AUuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763761680; x=1764366480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ekM322G+PEin7yvRndAbrKvUWb4I0YPQ5GMMtTk3+Eo=;
        b=Hflw0Vt/BVyTV6mw4rdcuWFOZhk5Obll3bI+OwjAwU78K2FTt25g67085N51Zh6Qgd
         4XWG7RaZccj4lDwP+JXCmE8TcCBiL6XdTmkQvA6moNf0wGmXows+G7sxsUlaBiuNdGy2
         hYZHYbium/I93sdd9z5wfFGxyWS/rybS+Gu4Q5Sa+QkquDduvqSJiT0McQxA9sWRGPy8
         9kvIclrbZdUKBVQY50GBu98KT8HHYe3bQAT0bM8/Qc9xcPMNw+DaO8Gh+akBezWiTC77
         V0fHueWeBEpx7geOc5P9crgnkkf3xFCvNi0sPsHBTMBY6ixfjSicMFNE5ECAqIimHxIS
         D4PQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYs+HzO41QMA/dee4Q4TpOw+k34j8f5NXpLtZ1WPThdS8NZA4SvGnFivD2Pq03gsSEK5E1pgyF7J/T6bocHhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuVy5LYeckKpMGmewgXUYfT3Xc0U5KPEe/XTVUUB8YkGawhotX
	4+xX9xgg0H/pYBZf3OqangtcCpsoY4r4qeEO7j/U8aqDFlsSrNwf5K5MBAh3v1KfA4bFdMuiHAe
	mvqE8+Y4VxXeIizjU4rYRgosGcKcipKw6T/+hmbY=
X-Gm-Gg: ASbGncu4Iwyi2iwb/KUL8fdcLG0EyEzOoN63RUJ19PHNsKE02gXV6oCR8TBKS+egmv8
	a6c3bG4muilyJ2Y/U+JFtSaunRLlEUFXp43hUNiXC4eOfzS2lJhgOzw8Mc159tfx+Zqb06FgJGu
	q+Lja//1Ka9+EFzEiIfhEMAyT5fnKA4gBwNpjVVCy57QYD8ht2l/iWNiSAZNZsikv04AudvLIEx
	8lUSY7yXpK4VtCzfVJqU9TGobxiALiHsE0EVSyRZejidXe6mHwKyzUzbLTqc1CJ/U993htGEAaS
	tqsx0zWse2cIzn6+32K1SoWLVhAVrxWfrSvVApEkOpA33pT+rfm64u/2jEDrYu3HL/PqtcnlJ/d
	DE2ZDTnSQaQQbjA==
X-Google-Smtp-Source: AGHT+IG2D+cdh1NB4073zeVTaOivGEAbr3ZKYdLcyI3VJrGEJvRL6ka722J5H/M0mBobMWPmISQlxk8KY20YkPOqf9o=
X-Received: by 2002:a05:7301:4084:b0:2a4:3592:cf8b with SMTP id
 5a478bee46e88-2a724bbea18mr1100277eec.2.1763761679587; Fri, 21 Nov 2025
 13:47:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121193957.1655580-2-morbo@google.com> <20251121195504.1661783-1-morbo@google.com>
In-Reply-To: <20251121195504.1661783-1-morbo@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 21 Nov 2025 22:47:45 +0100
X-Gm-Features: AWmQ_blZSawsk7jSjU9s-ayzPlxR-h3EgYVHr_sbGcneoHOjgFGGhmStKYwRrFg
Message-ID: <CANiq72=kqJApbOJ0hmC_mAYe6DO8YqXSFaLJOsbPhkXfxmvJHQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] Compiler Attributes: Add __counted_by_ptr macro
To: Bill Wendling <morbo@google.com>
Cc: linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>, 
	Qing Zhao <qing.zhao@oracle.com>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Justin Stitt <justinstitt@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Marc Herbert <Marc.Herbert@linux.intel.com>, 
	Uros Bizjak <ubizjak@gmail.com>, Tejun Heo <tj@kernel.org>, Jeff Xu <jeffxu@chromium.org>, 
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	John Stultz <jstultz@google.com>, Christian Brauner <brauner@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Brian Gerst <brgerst@gmail.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, linux-hardening@vger.kernel.org, 
	llvm@lists.linux.dev, Jan Hendrik Farr <kernel@jfarr.cc>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2025 at 8:55=E2=80=AFPM Bill Wendling <morbo@google.com> wr=
ote:
>
> +/*
> + * Optional: only supported since clang >=3D 21
> + *
> + * clang: https://github.com/llvm/llvm-project/pull/137250
> + */
> +#ifdef CONFIG_CC_HAS_COUNTED_BY_FOR_POINTER
> +#define __counted_by_ptr(member)       __attribute__((__counted_by__(mem=
ber)))
> +#else
> +#define __counted_by_ptr(member)
> +#endif

I guess there is a reason for this name, but it sounds to me a bit
like the thing between parenthesis is a pointer, i.e. that perhaps it
is the pointee that one that counts.

Hmm... what about `__ptr_counted_by`?

In addition, could we please provide a bit of context in the
documentation? i.e. links to the attribute docs in both Clang and GCC.

And perhaps explaining why this cannot use `__has_attribute`, i.e.
what the commit log mentions.

Thanks!

Cheers,
Miguel
