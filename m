Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513D8357D10
	for <linux-hardening@vger.kernel.org>; Mon, 14 Sep 2026 16:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789401733; cv=none; b=thUmHfAI2Qo/8OdAzVTfNO/Wq0tqdZrHlZ9fY2TQjtcfY7adkzlfvuaFEOW9RbOYuTMeZJ0YnrCXp+UHxFxQVqSbaG+QdxkRyPhUuN00/ur/iwN53kTDTsosxVfI8cEOX6xMVEIC6AbjoAZ2CsMuvyvTKFLESv3S6HZjLQEYp/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789401733; c=relaxed/simple;
	bh=xMRNGFwT5MG/tN2Z4rVlgZAaGoxD3wGYA7E+SDFQua8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h+B+NTunxxNJQwCJJdythNP1wdbBoX6Tbk6Uugv3Y0snyoytRZDLFjjlTcl0+9zQ0HvxDR1WH4LdQJx1loriokWDtNRZAkgpHeu3iRKnLXZmLDDuzRpjNxjsNr5vZYBdayi1HCWF42AUNSRGIO+h9zXWCFi83e8nBsZoEiYg52M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bc1iKYHs; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bc1iKYHs"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c29703cb470so409646766b.0
        for <linux-hardening@vger.kernel.org>; Mon, 14 Sep 2026 09:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1789401729; x=1790006529; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lW3GLwaZtw2SQDM2dpduYrEemaWK0EaPlBH9/B8yf6k=;
        b=bc1iKYHsuIPLmvG7KfrX9XGCp6mr0DBT9OzoYM8+7q+2+OLbEpB+vxp9JaeRLALBkm
         9ZlW/W10UiOOR0YavqdRreec9J8YwcHbfvvtB8KD8GwDOZJSU4QC1+n9Moa5ZadEzd0U
         nNjyGktmuj9PdUpXgzCLFmSfFhi2HEHTXxBiE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789401729; x=1790006529;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lW3GLwaZtw2SQDM2dpduYrEemaWK0EaPlBH9/B8yf6k=;
        b=eBbSI5US86JtMxcejUjR5Tplt/vjcPta20syXvhQLWkElcHvMqz4lxh5p02+iqnJN0
         lcyHQPDi9T2iGsso5SRTUohWoOEM/5OIcaejmSV5P0p4CSCGJ46covN7bmR7WV2igEWz
         xWFXfm3ZnN5cFmJTguCk/ObkY1hhVd7edV5lXcgb3/ymGt6ofEhrDN5qAS3vFc/xTcSy
         +1UaZ0ADLD4tiKCvSmrzJ8BURNDjvcJx5nBnuYmYdKOM7nMByIdY4Ju4Cq6HjKLr8CmW
         oEYt6LDk4tsxWHvXVIoXkCIicN1G2eD7VM6gUWSHniPk0nVndJkZPzcmvxe2uXiegAYh
         b5ow==
X-Forwarded-Encrypted: i=1; AKwUvByBLgPFWVyX+uDoNZLd48Ghr5N4uQl/PH5kQO00e0rdB22y7UbZ2TlUZoAfZptKCJo5FgfhdbythRcbl8t8704=@vger.kernel.org
X-Gm-Message-State: AFuF++ngPUNZ59F+r03t/ZJMjhOdiyvxygCbHGgN834Pi2hGFNlvPfMX
	lDDtfyWZAMEAjyMOebJE5qahaERAAbQJ8KhXtIXJanmW1Bed2XcNmvqiZHZ6Jrsf98mXZajo7+T
	Jn34w7hMFdg==
X-Gm-Gg: AYBFou3PqAwRO9JxOdFhBhwilDz5v11FAt7DgkoDC+tpwmYQeig/dXGdi5EfyF71LC0
	uispMWud2efgbYN5+xKMQHGnb5wa3guBQjBfzyoqOP3jmc0ciU4NnglAbFSliKqJqTipIwVSbCZ
	WANI/olyId1iNevjS/k8m70Ydt21RiaxwL9S84PEYixXwo0awBj33gueo0w0IhCwf7GEJM443nm
	/ZG372qHjQ32RptlPf3uzQclN0ZVfKpgQ1A+HRgXfruTNWVzTmP2N9x2GjYX3SMQUgG3uJJqTDE
	jUsAWVhPSaeOhXTOjo9tvi1qw/yX3dSeBO7+huljRm97hGQcIVDlBAIDFSKFJEPRGcjgFAflJVB
	KXwhG7KWEUUmu2BLalB+g1kqFWeeEIByr2QFoO5lMX/IQ5PlhjSWolzb7KWrOY/TZiWPTcyD1/A
	Aa44dqPlu3PXxlm9awOEoMWyHqYWA7JyF6s/nhPz17A0wsbtdsMfnqJbUUrh8ExoC74Q33UQsWO
	+FCN+4aL3pw0XpIvreZYhnmUHL+kvByjcxTuhJT80ZVsUjJ6Q==
X-Received: by 2002:a17:907:d38b:b0:c29:4a1f:76be with SMTP id a640c23a62f3a-c29b875ce3bmr350494466b.20.1789401729489;
        Mon, 14 Sep 2026 09:02:09 -0700 (PDT)
Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com. [74.125.228.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2965c4e8a1sm462951066b.6.2026.09.14.09.02.08
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2026 09:02:08 -0700 (PDT)
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f9f0b20so461085466b.3
        for <linux-hardening@vger.kernel.org>; Mon, 14 Sep 2026 09:02:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByM4pUZGLStezna351eCArooU0wK5hqMtO5NdluN8nyvhDwyPcT/t5NSgwAciZTEKkAWsn+Gsg+dt2sGrg3HV4=@vger.kernel.org
X-Received: by 2002:a17:907:3f9f:b0:c29:444c:8f28 with SMTP id
 a640c23a62f3a-c29b84c2597mr415053566b.5.1789401247404; Mon, 14 Sep 2026
 08:54:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914-build-speedup-v2-0-39817ec5db23@kernel.org> <202609140833.88C0E16E50@keescook>
In-Reply-To: <202609140833.88C0E16E50@keescook>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 14 Sep 2026 08:53:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=whB0X28MNAg71it=1SfFyV7rB+PK3qajpRyWoxXHW81fw@mail.gmail.com>
X-Gm-Features: AcwNN1VyLYI7E7T_24gtwZZHDPdmXi1EUi9s9xthPRH35xQepEwWHVnUZ8r6fdo
Message-ID: <CAHk-=whB0X28MNAg71it=1SfFyV7rB+PK3qajpRyWoxXHW81fw@mail.gmail.com>
Subject: Re: [PATCH v2 00/21] kbuild: significantly speed up kernel builds
To: Kees Cook <kees@kernel.org>
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Alexey Gladkov <legion@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Arnd Bergmann <arnd@arndb.de>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	=?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 14 Sept 2026 at 08:41, Kees Cook <kees@kernel.org> wrote:
>
> One area I think might solved via an LLM is the 3-pass kallsyms stuff.
> If we could get a deterministic kallsyms build in 1 pass, that would be
> very nice. A lot of people have tried, but it has eluded upstreaming.

Even the three-pass one hasn't apparently always been entirely
deterministic. We've had random reports over the years of it failing
in some circumstances.

Maybe we've fixed it all, or maybe the failures just go imperceptibly
rare. Regardless, it has definitely been fragile.

               Linus
