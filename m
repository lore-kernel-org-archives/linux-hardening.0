Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794507725;
	b=Qzv1qQ9KcPgFr+ILRyFo/ogbGgSNo+SId2p4POgp7+dy70WUm+cbG9BLLLudIjIeDmmq
	 KVApZ729PAWXaKwXTZAgrg+mq/POu+2Flj2vxs7QRFk51zYMtQ2zzhD8/5s42rX4b9/yo
	 7Y2t2WSKChsCXTABMZRWNNAriNOuu1TDu8dZKD//XFEUtshAHa74bKZ8iVsX7dQfDg4wU
	 /ItPzkqYSEEX2ENJ6G1nH8BiUlEYkVkUKaunv6Ybx0fXDWEfTC7xaWO3OhKZ5C2LDMBjr
	 yvRHihXUJlmVCdS6P3UaJEaBG9I7MshKdECPlnYhseKaoKkw9uyh+XLunX+Gje6h5VQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794507725;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=/9R53hS2lq3Ijq537Vl1ow/wvMt9akHjDmPhIy8wjS8=;
	b=0g1kBlPnmFaDrC4ss5ktQIsVxhH5ViMWD1CWEJ+BBayn/q2QqgzJ/uQBrYd0/lckP/Re
	 jE8ztRL3FsrEftjINdccgwy0DjVxP7xevI/z2fBHjEK09GMcqB3WBRQmxlcF5hfSYiM/p
	 vKtLusKPVQG0kh3/C1a4LRxDeSEnRjdCypNM6z4PIiJcaPahjyy9i99pDmMCJQEsKJFuR
	 5t/XfAclgVcMFtRSUemE6fI3kgjXtpzMaRUuDZtbBqF9GyMZZ67vkiSwEh5akQwIEkXLk
	 pKY2xo2aai+CamZy/bgxMcqG8D8cDjaf0BDaO3TEsB1ovfHBdx8Q88dkyqpBiDZfxYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=e+Fu5t0w;
	arc=none smtp.remote-ip=209.85.160.71
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4C1606A327
	for <linux-hardening@vger.kernel.org>; Thu, 12 Nov 2026 18:22:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E4C1606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=e+Fu5t0w
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-45e83fd0663so66669fac.1
        for <linux-hardening@vger.kernel.org>; Thu, 12 Nov 2026 10:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794507723; x=1795112523; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/9R53hS2lq3Ijq537Vl1ow/wvMt9akHjDmPhIy8wjS8=;
        b=e+Fu5t0wQU/zqG3zMaP0dIhN10Fv0XsJiWYtR+kmFemhiVnwSgWH69gnd+sVSms2dr
         +zV0RzMuP8v9E9n6uz1OZXptheMpHQWozcGws+r58DJc1lc9wckLdaxzEshISrJkR7ZG
         2tuZR4PDgGp7P++qpuNyedALlzvC0XlQle605w92KYNfuOJ4oq3a6n8qTnbtqtLd+0/1
         /SXXon+J7ZYXflap70qN5CCLqlDGlamI1d6jkt72PkE+GeFVW2+q1wjjjp8DCqnHLx5c
         KuNQ/OgdfDMbP3a3dZy9Q7ggQ6rW7PV9EH1QKALzeOjnEDaTKmHfcGEpb24UhsSjPSgD
         EsVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794507723; x=1795112523;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/9R53hS2lq3Ijq537Vl1ow/wvMt9akHjDmPhIy8wjS8=;
        b=sYUrqw+N74YqakzED9OqEBqxBkb5nF7jELTvhfQq7DGGGppGS/cmabawtgqzWskRuE
         WnyQ7z6L0DpX2ErOsi0KakB3KbQeYwEtUpFbs+NZD62En5LQVqPvvopSdPH/iRbmG5Ad
         L0yftXYWoITyc2Xt26BuHRzfQVnr6oMzGzersklaCGsYYp/GFO2n2y53lCyZnpSHEV+R
         NDbaRi3XmjSlgUgLcjCr3jJzhCWjuDnO6nkpIaA2uVK0jerK7LGGMUG1pFQRhldPEmPj
         CiQHtbsl1+FDttCq0aFajHmnoaTrJfpTdly0fgcdwFHm76gV1dqyspg5jUCo+wqVf016
         9Tww==
X-Forwarded-Encrypted: i=1; AL+hErHa7HVISetbUVnmWuTcJkHRJ4E3+uVdfDZsR/D07HFSMhkALjFHMjXJqNP/VhvMv6HRqlzTTi6o69g6TBs4YM0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Z8I3rd7AnoXNmwplT1qKMpLcaRuuCStO/gfGUX2giwv6j1dux
	KHVpQeBAKlOrtPPcvrzigY0ZFp9nQslG2veUu73U6GXJvvogzcP8IqlPKsH5O/oAUQS/ukICAfr
	2OmL2QVLy+m26QJ5p4/Edk1bojg==
X-Received: from iohf17-n2.prod.google.com ([2002:a05:6602:a5d1:20b0:9c7:6dd9:edb5])
 (user=justinstitt job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6871:6687:b0:4a7:d759:9b8a with SMTP id 586e51a60fabf-4afdf7a6881mr466138fac.53.1794507722962;
 Thu, 12 Nov 2026 10:22:02 -0800 (PST)
Date: Thu, 12 Nov 2026 10:22:02 -0800
In-Reply-To: <CAHk-=whAF3brA9Wrcf3KDhNn_653zhUsoqe1MSneYJWtS5505Q@mail.gmail.com>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20260914223212.i.829-kees@kernel.org> <20260914223219.901347-2-kees@kernel.org>
 <20261112004039.GA523044@killaraus.ideasonboard.com> <avWNCC3_Ff0knO6J@devuan>
 <CAHk-=wgYBrhvo2NAG_Ja-0ovPf=xO20Gcopv9Yrr1u=QVxECZw@mail.gmail.com>
 <202611120905.DF88D9849@keescook> <CAHk-=whAF3brA9Wrcf3KDhNn_653zhUsoqe1MSneYJWtS5505Q@mail.gmail.com>
Message-ID: <avYBdaCYclTyX9pX@google.com>
Subject: Re: [PATCH 2/2] devres: Provide kmalloc_obj*-style API for devm_kmalloc
From: Justin Stitt <justinstitt@google.com>
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: Kees Cook <kees@kernel.org>, Alejandro Colomar <alx+linux-hardening@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, driver-core@lists.linux.dev, 
	linux-hardening@vger.kernel.org, Lorenzo Stoakes <ljs@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <brendan.jackman@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	David Hildenbrand <david@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, Mike Rapoport <rppt@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="us-ascii"

Hi,

On Thu, Nov 12, 2026 at 09:23:18AM -0800, Linus Torvalds wrote:
> On Thu, 12 Nov 2026 at 09:09, Kees Cook <kees@kernel.org> wrote:
> >
> > One thing Justin was poking at was adding a "strict" mode to typedef
> 
> Honestly, the sparse setup is superior. It does that 'strict' thing
> (except it calls it 'nocast') _and_ it has 'bitwise' that is a nocast
> that also disallows non-bit type checks (which is *very* useful for
> things like "this is a big-endian value: you can only do bitwise
> checks against other big-endian values).


Cool. I wasn't super familiar with how sparse handled `nocast` and
`bitwise` but your insights led me to look into it deeper. I'll take
these learnings over to clang when I get around to implementing strict
types :)

> 
> So the compiler addition may be worth it, but  even the "poking at" is
> weaker than what sparse already does.

Right but I suppose the benefit is that compiler-enforced things are
caught vastly more often than sparse-enforced things. Plus, like I said
above, maybe I can aim to reach relative feature parity with sparse's
own analysis on this type of stuff.

FYI, there's some prior design with `strong` typedefs [1] in the form of
a wg14 proposal. I've also been keeping a close eye on that stuff as it
develops because it's essentially strict/distinct types with a different
name.

[1]: https://www.open-std.org/jtc1/sc22/wg14/www/docs/n3320.htm

Justin
