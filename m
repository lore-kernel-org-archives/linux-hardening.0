Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128113812C8
	for <linux-hardening@vger.kernel.org>; Tue, 12 May 2026 13:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778592817; cv=pass; b=q5OQBdHKZroFzFoOyuxXiNLBlbSAx2jPib433OmT7ui99Kb/PmeTiiIOVuSurYNzy35Ybuq0xawzhkYec2lVYJGTQGY2GVIplsprjFSIbIj+pp4j5Mbdxt4zjHqWUB/PkSRUruDmSyv3E0S7sJN/YYVUeGvH9PVOZjuIv0z4Yyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778592817; c=relaxed/simple;
	bh=D1jJ/gf21v5jTsHW/66Kz9VjA9WYKFK/yu8KnI8oy8w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LP2ksnFd0I4MoeXyU8cF2p7MsTK8dAfRAUTOsbGy8BY7MngMFdsNTKKhyrKtFR2ZKDp5dAlmetXn37fN+Qabjgp5kaKzm8MM1/IBBpuVO08ulhWQEzdvyVfG0dkOJwTOaHy+oBzx8r1mWIiLNbDKbMZxHR6dqwkeqk9CRSmIVa4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TUlH5wNP; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TUlH5wNP"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-671f1a0d0c5so311a12.0
        for <linux-hardening@vger.kernel.org>; Tue, 12 May 2026 06:33:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778592814; cv=none;
        d=google.com; s=arc-20240605;
        b=DDCtE8ws2JbPeW9GzoUxPoX33P00uUuAyPdbFGq9ej/lzHaTewoMMCyuQy/rsjSl4b
         H9wBhGpVhSwZkBtSPyaTjEJljy3P5OWePV0FVWaPwu06bKmNw3p8FlP8B/G2AqEfDjSX
         AGEhFGVJrfAmf2bQWkVHcFfHMa2FJhWXvDOXHP+qh1xGEC6P16K5XVliSLdI/dyc1uiW
         KiV1e7yy2ynLIvfPFDE5nTu6PsDOlWjQNmc5ApQlIefoLlSSUY8/IEWoBlokBu8wSr9f
         CzfIoXBeXJeNpV9N1FkrYbvG7tJ4zHXYuY8F7o6XXmI0DqznpF73ke7dAp3oXa3oWv4E
         PN1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=D1jJ/gf21v5jTsHW/66Kz9VjA9WYKFK/yu8KnI8oy8w=;
        fh=yCnTVGZHzAQ1fwjeG+hDhXky+e446esV1g0UMS2n/S0=;
        b=BD2acsvIdZbhkhPiWOh2j3OoyqwpyTMa7V0+rvN0L0qza2/rVUw3+9seFv5dsifL30
         EIMxJ/daqe8LGn80YDAGw7KwzlEuBoavZHfclpu7A1mrmRdmUkLWFUVPhU7T49EY3U9h
         35QxFCXsO6l3mCMrjZ4iJ/qN30puGMgY2pHmkW2lLpFxuPbepxGKP+T3SKUUEyhUJfRg
         57G1xmWYvvtt/e3TlwbmFeB5XSxyoV9yByNa5cfAshOqCu2IKqqELXOARgp4hv022+cx
         quq+XZN0Vn+w5UzbGf+8h3Ht5Gknrs+JqFQioocuZ/8Eu+d4NcJLIl0YnOAqHhP+t448
         OFjg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778592814; x=1779197614; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D1jJ/gf21v5jTsHW/66Kz9VjA9WYKFK/yu8KnI8oy8w=;
        b=TUlH5wNPt1KuAvCb2XvjvGXYO0xegmgsGy9/LBtY2bMfHKropXada3cCuP6UAYt8JR
         376IMimuyXpzEJcw7UI3pdynXcSnDM0yTpNuWamxPkjgrZp0YQnfzGelWuR/jwv+g6lR
         gL1/ll9qjsPQmInkNh0N35e/CD4UViO1fKn/teaXrAjyUvwzZhs8MxM/WKBSuVel97Ne
         BmCcF4xR7/2NJ7IY1tY7cGkoh0dnnHQZ4UwLEP12e0P+yr9y9eURNQ4uuJmT9jz8bKqc
         6RMuQM3rru9x+S+Vknzu79ImoKfm2b7SOnNyO8DsDTZqJ/9I1fUkFLkI9gKALPLMqqHZ
         LClg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778592814; x=1779197614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D1jJ/gf21v5jTsHW/66Kz9VjA9WYKFK/yu8KnI8oy8w=;
        b=iFrsWejvNhsp8mGqv0jNNmik+Iov6Xm0WHHR4PyfCnXTZ78D4S744GTEzVqwUX9A8Z
         YpEEVNMELbINe7NUKtzXPjdzqyRKZ/KRyPDFSoRi1uYQBPPBI3l0x0BHxwBeCHUSLb/A
         /zv+DAodfBI87XkKMF4vmOqYpmlniN52zBlWoy6p4Hc5uddwfwxhIRa5cTM4kjLZ5sfV
         /cXNyumScjb1BJpUeuMTitUXJMCDyp3rbyWXDPeyoZsLccYtlqRULw5rXT3u1FFrnPGv
         ntS7l0comx8r+0CPnKpSIN16/vG6+OYQo28e092/1YALkVnNPHIgjcRH88kti2i8SmKb
         H5Zw==
X-Forwarded-Encrypted: i=1; AFNElJ9UhGzukijq7gxW/w+jOzGaNMlXyVn/oNNOplPW1GqeneH3ovoSvRu3HwKZMDUV0n3CgzzwVbyiRC1OcBVFw/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrxzGyz2f3F8lZZKDqplMfpcK/mAFwTDpcOY+/i8L6euoqM232
	i4uPpcoukaGThsLmYdmgTRXklqUJa8fO4Hr9EdNvGZRvygszGRZ8irfPIed2ObvT5MlNTarsGo4
	V0cM45/QGbq1nPJXgqMrLfX5UxM/knK+fu4WbgGfM
X-Gm-Gg: Acq92OFPCaT/IDCS1gsi033g2vTh1nPeXqdPTHhPNRhEVvC4Wwi3WzBZvKyrlsUZyep
	odufX0VUptWilZawaKg0JKzBG0c3H5aT5qGFYpsS2zcNRC6LXTe8lmAtyoliDFH0IsoGXTJj2gI
	Ge2HlV3fOQM+2eEB7DUouauvdxywf8DTsn3u9acrD1aurww6D+eMU9ReCmHrriqkCqJavk+J1X2
	jo3UCVWoeoq3/aktXYzXOVg5eByUFVLufpzpu4x5NdmzKXlOqvBhU91RLe2yRorBMkK1t3Exnuf
	tKdRpkuF0gwek7YB2c1nCPPeFcATo8ve5LY+HXkw6GDQC5v4
X-Received: by 2002:aa7:c7cd:0:b0:67b:8283:6240 with SMTP id
 4fb4d7f45d1cf-680dab0c7c9mr39195a12.7.1778592813829; Tue, 12 May 2026
 06:33:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG48ez2ed44M=-qsZO7gwcz5L2njdRdk54d47jEg48MhWTkaew@mail.gmail.com>
 <20260512023129.44966-1-lance.yang@linux.dev>
In-Reply-To: <20260512023129.44966-1-lance.yang@linux.dev>
From: Jann Horn <jannh@google.com>
Date: Tue, 12 May 2026 15:32:57 +0200
X-Gm-Features: AVHnY4LZwF_WYCVPXafYsLmjKwF1Trc0n8j0sGJfDYhW6dPI4yRtQ6ztFmHrTkM
Message-ID: <CAG48ez1xdO1wkqS+eAcnAV9QJ25=t1o0-Qz4qTZdg1Mo+en2QA@mail.gmail.com>
Subject: Re: [PATCH] mm: make zeropage read-only
To: Lance Yang <lance.yang@linux.dev>
Cc: rppt@kernel.org, akpm@linux-foundation.org, arnd@arndb.de, 
	linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, ardb@kernel.org, sethjenkins@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 4:31=E2=80=AFAM Lance Yang <lance.yang@linux.dev> w=
rote:
> Would it makes sense to apply a similar treatment to huge_zero_folio
> as well?
>
> with CONFIG_PERSISTENT_HUGE_ZERO_FOLIO=3Dy, it is allocated at boot and
> never freed, so it should never be written after initialization either :)

Oh, neat, I didn't realize that that feature exists.

I guess there are two aspects of making the huge zero folio RO that
could be problematic:

1. If the huge zero folio comes from the page allocator, making it
read-only might require splitting a huge PUD, which could have
performance implications.
2. I vaguely remember arm64 has rules about how PUD/PMD entries in the
linear mapping can't be split at runtime at all depending on hardware
capabilities, meaning the entire linear mapping may need to be mapped
without any huge PUD/PMD entries - IDK if thp_shrinker_init() runs
early enough to be excepted from that. See can_set_direct_map() and
force_pte_mapping() in arch/arm64/.

So making the huge zero folio RO in the linear map would probably
require adding a new config flag, connecting that to
ARCH_HAS_SET_DIRECT_MAP, and changing one or two places in arm64
memory management.
