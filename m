Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08AA3905E0
	for <linux-hardening@vger.kernel.org>; Thu, 18 Jun 2026 13:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781788993; cv=none; b=cvmfxfa0Hk2SGH2Yxp/Kob+k2Qtkd+bD69ivfNah3tw6TW5HFyC7l4wRFi7VQ8kEljvUOA/hyQfKxxdTc+uQSWwHlpeYbs5BaNxkELOC5bcBtLVN9l7lmxK4MKiLCHqFC63TP4IGcwuImdyqoVk+6IrjakrLCzS8zRafoIORcrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781788993; c=relaxed/simple;
	bh=kzNB+bRm0uooJBN5KrY3HjTN4jZj1AGxBSYK7+XKHSc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o7COX0Dz0okR/JYJdg1qqZVsEEz+4ZW8P7h5Q2LE0n6bPci1S9n23NUJNRnrADkDeptBslI7qJ1TrdK29UMjhscWSI/RL/PS//ORZ1ZBBhvLj+yVFy2eBs6YauFMO3Z12nwY9oukjI8JVMxcS2hWfmfSoaxZJaMShD/MwBMVzPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVaQzpYi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EVaQzpYi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4FB51F00ADB
	for <linux-hardening@vger.kernel.org>; Thu, 18 Jun 2026 13:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781788992;
	bh=+Hao5re1+cPlNlzNJBZ4sf1w820eCIPHa6P9dbVUFmE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=EVaQzpYiRqYK5hksirc5nS24Y0fzb4urTSaV/jtRdTqQooIUUArTy1+HgkpKtFwim
	 1+4WlmhNJEAkxfk/lfl5HQjq/Y957Ghxvj8izXGw/06pRWDQPP+ruSGUZgnocnwips
	 nbOIxMtH4SiWbCBweUzm8EhaTU1i0hc0tbBr2uihXX5GFXhUhRfgxP9GVbhs5rMYWN
	 UNGGSkpKbvRFL+6yTa8AVdYBjxBLZUvVNeRIn9og2bs/QNiJX0VZzDE8FhqrkAKrLo
	 Qg38vSG6ryiNQ1C1rfo8rjZkYxReWCmpGf8+iB5xzZqjutTJZyoifdtv8K9wn/4odD
	 sAtImPZz7u1lg==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5ad522bddceso477511e87.0
        for <linux-hardening@vger.kernel.org>; Thu, 18 Jun 2026 06:23:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+53qQGZNklEggirz2A+CUnzY1jS9nMeq5hu0lA7UyXUM3hlgbaS44rnyqzwjxtEOhh1v1+XcrT2zVUsutSBrU=@vger.kernel.org
X-Gm-Message-State: AOJu0YywXzfux/jQfYEHJIw76DKlxEvPG+qVldRbcdbhgk+UBa1zvWEX
	wxywbR5Ba8TQJ7LYIS4Nm2fcDwBZQOmyuzpZFhnQAq22w6DTySCecJ5a562ZVyaxVoPSyMP3I6P
	LJBkgpuTI7x5VVV0+1TZLiwfrB5JctdY=
X-Received: by 2002:a05:6512:6487:b0:5aa:6289:e0b5 with SMTP id
 2adb3069b0e04-5ad50ec7bfbmr700610e87.35.1781788991504; Thu, 18 Jun 2026
 06:23:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526-kpkeys-v8-0-eaaacdacc67c@arm.com> <20260526-kpkeys-v8-1-eaaacdacc67c@arm.com>
 <70f4dcdf-c45f-47d3-91df-a7897bd86ff4@kernel.org>
In-Reply-To: <70f4dcdf-c45f-47d3-91df-a7897bd86ff4@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 18 Jun 2026 15:22:58 +0200
X-Gmail-Original-Message-ID: <CAD++jL=km9hqTuTMFUhyx_QPuMEwWqmnUVQtPtMXnp8paHH1_A@mail.gmail.com>
X-Gm-Features: AVVi8CdVd_MSXkJ8x_FXRhl-ZhQK3-a6vu0Q8TQoQCS7OolDkuqw-biJhYguwBU
Message-ID: <CAD++jL=km9hqTuTMFUhyx_QPuMEwWqmnUVQtPtMXnp8paHH1_A@mail.gmail.com>
Subject: Re: [PATCH RFC v8 01/24] mm: Introduce kpkeys
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Kevin Brodsky <kevin.brodsky@arm.com>, linux-hardening@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@chromium.org>, 
	Joey Gouly <joey.gouly@arm.com>, Kees Cook <kees@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Mark Brown <broonie@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Maxwell Bland <mbland@motorola.com>, "Mike Rapoport (IBM)" <rppt@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Pierre Langlois <pierre.langlois@arm.com>, 
	Quentin Perret <qperret@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Vlastimil Babka <vbabka@kernel.org>, Will Deacon <will@kernel.org>, 
	Yang Shi <yang@os.amperecomputing.com>, Yeoreum Yun <yeoreum.yun@arm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, x86@kernel.org, 
	Lorenzo Stoakes <ljs@kernel.org>, Thomas Gleixner <tglx@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 5:19=E2=80=AFPM David Hildenbrand (Arm)
<david@kernel.org> wrote:

> Looking at this, and wondering about "why do we get registers involved in=
 this
> API" I would probably have an interface like:
>
>         arch_kpkeys_enter_context()
>         arch_kpkeys_leave_context()
>
> Whereby you return a "struct kpkeys_state" or sth like that.

This is close to what I was looking for as well.

enter/leave makes the code look more like generic entry.

Passing some kind of state cookie around is inevitable in
this design and IIUC Kevin argued that it would be inefficient
(another level of abstraction) as opposed to just hammering
in the context we want, where we want it.

But I think the compiler will optimize that out by constant
propagation if the backing architecture implementation is
simple.

Yours,
Linus Walleij
