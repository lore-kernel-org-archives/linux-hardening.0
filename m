Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A3A382F03
	for <linux-hardening@vger.kernel.org>; Mon, 14 Sep 2026 20:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789416764; cv=none; b=YeSg3GCmMriKewIzKQbkmce77WZ/7USXw2OYtOt5YApkQ+6zDbFv8+JcgtJ2OOZuoFVjoBNr0YqEOrEFdqFvjji+0wayqI1D+R1i+Uxqt45vTvJ/5ioeQT0Uz78f4tjnar9eLmy80XIt3fLPR5vGwVp5Gu7YamWFGxsYXfr6iyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789416764; c=relaxed/simple;
	bh=g8JbSv2uB9OVHPX6mK0/xKaLA1R5JXVM4OnU1gOEgUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y1tBxYnJp9ufr8fE09lBb+7eRNeM+ST7UkL+GI54SuwLkd3QK2TpFutbal/fof668Y6/qOErd5+YvA5KBAfkzuMtDXbr9lx590zFfufLhHI7XMs4hpxI/LJHYcLZAQCAG2p1LDjOni7q11qV6O9VmvDob3DgBv1SfgCvSlHXlPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=W71/iHs7; arc=none smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="W71/iHs7"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a9c0cd47bbso3799430a12.1
        for <linux-hardening@vger.kernel.org>; Mon, 14 Sep 2026 13:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1789416760; x=1790021560; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FhpCYoKplrM1IaRlncQiHxwpj03BaeP0oenEDpXOAEg=;
        b=W71/iHs7bodCdYJzkam/39YITwq1YL/ZgkZtL81QtWtqACCfJem3R4iUdUycMl7+dw
         nq4RIxPhB/EdWmAzD3CBXbmENQby4Yd395a7jF1jE+bEec7W/ZoVnfIFAvTMNjPp+Emi
         ZhUk/lAsVV3LVtPJrAocJMfFwHmOU+8d7qBxc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789416760; x=1790021560;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FhpCYoKplrM1IaRlncQiHxwpj03BaeP0oenEDpXOAEg=;
        b=2hIQ/Jq1AKs+2ttJktQxgs2w3hSEde0zKVbM6DWXTXaEJigA+deE5L9cBF8YRf013y
         zR28ClnJl1JzA0Cs1OokF1Ustm2CAB0aGts/aZ2SQGZR/mjhfPoop6ldKWKFtDjhRUfD
         s3vKsTGeH/uLDhxTUIvQ6w4Ri/afChXdT5tXgd2gp+5CQRLUndpfxbnZVYzpxqi14Xs9
         dRWD3NKzWvZd3DD4P9p7E6+fXNHk8PtDIa8KYItFNTaJZEqa1nmBEAg0RBFmScKII0pL
         Vf8IweFXE0bnUJoY3HJ4j0LeVjfJjTEBVGBxCj8pTuDQjAzgStwy3C2NZcEVJIJZYdIy
         s0XA==
X-Forwarded-Encrypted: i=1; AKwUvBw14bn2bj6b9jNicddjmuEPAczhRDdpGf1/STuLbQ6WdaVn7v7ebmZM8GSkjvKOq7AlpBluttgEjQ8bFWxZtCY=@vger.kernel.org
X-Gm-Message-State: AFuF++nQEb/5P2v1Fgz5jI80vV9fts/la/7eKCsRNvsadEQ2hzfGzCqg
	zHvEsRLGSBUX/OOmZT9l0FBvq6fq2advCU/UZ+jR5Qwdr/G4dxzVCQ/rA7rOwlfRu8HSBo+GJWv
	PzaNyuxEirA==
X-Gm-Gg: AYBFou2K3aOwDi6zu9gjuugUHnxpizWf+4/o1uOJojTB3WFzCCx/hQQgZKHJq+3/Zhz
	GzJRhZYLqjwlqHEMrSsXuaiT/WNbXutMdFFmSbdgIt4vJcoRK5VJJo/WAjztcirp5a+zc9ZdJEw
	HUQp8PIVbhIWO7CpTaljYczrjWfzHKgvD1UChRsKIQufPcRSgK2QE0BgACmLS5mQ0w84TdHbbvR
	weSyPtdgMIg6SBoF4+W9ZODY+WH5u1fPl+EZZai4fjFgTEminIiVvW2rIm8ThFh+//xi3Dqt5dH
	vHvH3Y1+yBa9XExGTCrEgtm6ahPvqHCeIgb5+5DvloICQxtoRxbLs9bCUV/feU190V0cca0Z+qf
	/NioI5FeXRRZBKXBe5rSooeYTZnXCnMi7zptTkcUNSYAf92mAH0YqO3qHpXzU8N5VwA3KsfbdL2
	MOn1pCpB/aDhoBgHCBqsAokRmjhIVaPk3K/RgTPjOHUC36VGT0eUBPE5wM6Hzy7BdonoXEeIOus
	tI1m/D5OqehMMNKHkB0BSBdZnJQ4M7947Vexy8YvluCk48h
X-Received: by 2002:a05:6402:249f:b0:6a9:983b:79bd with SMTP id 4fb4d7f45d1cf-6a9f639b8d6mr2443669a12.39.1789416760209;
        Mon, 14 Sep 2026 13:12:40 -0700 (PDT)
Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com. [74.125.228.76])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a9bc808adfsm4605580a12.4.2026.09.14.13.12.40
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2026 13:12:40 -0700 (PDT)
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a605c198fdso4694883a12.2
        for <linux-hardening@vger.kernel.org>; Mon, 14 Sep 2026 13:12:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwgoJFZqqt1l8NJtm3PNRT4cYqcL/O4HWhTe9Q1h3dPM96UlymifxjGM+NEahJdFN2/YWU4InOuSt41NWtGjiA=@vger.kernel.org
X-Received: by 2002:a17:907:6d1f:b0:c25:5faf:b207 with SMTP id
 a640c23a62f3a-c29b84c9a48mr280688866b.3.1789416413732; Mon, 14 Sep 2026
 13:06:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914-build-speedup-v2-0-39817ec5db23@kernel.org>
 <20260914-build-speedup-v2-15-39817ec5db23@kernel.org> <aqhLhVMkNzf_4oJw@jpoimboe>
In-Reply-To: <aqhLhVMkNzf_4oJw@jpoimboe>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 14 Sep 2026 13:06:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiB9MX7vBDQ+WHTUVfSYubLhR-PbABewscqTsxRhg-LbQ@mail.gmail.com>
X-Gm-Features: AcwNN1XwkDuRyfqGBvPSv1hGEYJIl2TPFZFoOf2g9mdtKKeoU1aAJmlE5veL8PE
Message-ID: <CAHk-=wiB9MX7vBDQ+WHTUVfSYubLhR-PbABewscqTsxRhg-LbQ@mail.gmail.com>
Subject: Re: [PATCH v2 15/21] objtool: cache relocations, do less work
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Alexey Gladkov <legion@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Arnd Bergmann <arnd@arndb.de>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Peter Zijlstra <peterz@infradead.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	=?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 14 Sept 2026 at 12:44, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
>
> BTW, I found another initialization bug: klp-post-link.c uses
> elf_create_section() to create a reloc section, so it missing the
> initialization of rsec->hashed in elf_create_rela_section().  But that's
> moot if we just get rid of the hashing.

Talking about "getting rid of the hashing": the instruction hashing is
obviously a big deal judging by the hash size expansion in that other
patch.

Do we actually look up all instructions by hash in the first place?
From a quick glance, it looks like almost every user of "find_insn()"
is looking for just certain *kinds* of instructions: calls, branches,
returns, endbr.  And branch targets.

Maybe stack updates? I didn't check.

Yet we seem to hash them all - even if they are just some random
ALU-only instruction that is in the middle of a function and never a
target of anything and has no impact on any code flow.

So the question becomes: do we actually need to hash those
instructions at all? Are they ever actually looked up?

I don't know this codebase at all, so maybe that's just a really
stupid question. Feel free to look at me condescendinly, shake your
head and say "Poor Linus has lost the plot".

[ And yes, I see that whole "next_insn_same_sec()" thing, which
obviously *does* look up all the instructions when you iterate over
that function, but it strikes me that using a hash table for that is a
bit strange when the natural way to do it would be with juyst a
"struct instruction *next" field instead.. ]

So if hashing was such a big deal that it showed up clearly on
profiles, maybe the answer isn't just a "make the hash table larger".
If a "next" field were to not only make the hash table much smaller,
but also mean that next_insn_same_{func,sec}() would become a "follow
one pointer", mayeb hashing would become rather cheaper?

Stupid? Or maybe "not completely stupid, but too painful to change"?

         Linus
