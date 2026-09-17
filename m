Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com [74.125.230.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546CE4973B9
	for <linux-hardening@vger.kernel.org>; Thu, 17 Sep 2026 17:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789665754; cv=none; b=WGURMq7JcLJRNe9Q7M8EMoDTA07wW6Qx0tEsyb/p8uuOvYpGHOa3qZ3hdfxaR/Yy2kAcEmgwHXoC0zPouTtb6t0b9qNnKbuCBooVveHcw8AhPm02gQ2Dgz7ua2SzDK809fCyx1IPaRUQBlzSlBnxz54mNbLXKdy63pV3owfzXq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789665754; c=relaxed/simple;
	bh=biPMv+ofFeAlNkpuoiheHfcM5OSqeT3TWtGH022bAOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lGCzoYKt7deYmOYJnkRuLSYOLxWQN7GoS91nt3QkPdQdZtClGmNxRH8HMcLL+fLwcZqgBxKFabS09yxJ4muakslC1SAgd119XbsglYLMIr1//jrZPyIFIpUHIOvkGEarCrYjaBdZe1GgfYLtIXt/jWTAfbdHU2EIEXdy7Py3w84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hRg1eQI1; arc=none smtp.client-ip=74.125.230.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hRg1eQI1"
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a49c068e85so8461881fa.2
        for <linux-hardening@vger.kernel.org>; Thu, 17 Sep 2026 10:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1789665750; x=1790270550; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iCKe0geuwZYO+S2TeH6s+a22CWM7gde8UuWVtmH3l0g=;
        b=hRg1eQI1uvbt/9Ked6g4JC8c3nZvCAR/K8MZpce3fWqp8u0TrvnF34ztDAiy8khCDb
         n2yAI1ITYFWO5eKn7ol+Bsn4ud9MRHlGErloMxli4bMNUZToV2qDfQdE67m2JgPkiDma
         Z+qXVK9sFu3qOI/Kx9YDwjwIFuvOP9gjDoYUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789665750; x=1790270550;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iCKe0geuwZYO+S2TeH6s+a22CWM7gde8UuWVtmH3l0g=;
        b=1KQz79OynBjBbV7IjlZSWo5IvI9oJxgsFQWjeXPTiZimBY61ld11vrzJ3ttol2dIgq
         k3MxKP9EeZUteI6+M86KkHvd7ilEpBV4EpNqhic3V11G1To5QBPEwbCe+mOS0WOgDAJQ
         61ucMz0uY9MBO2MWBp7XCry/AkiUznNVpTlqIBnsnWdQeWc5B5GQMnYckav4yjJiv8M0
         pqJzLvx4le/Sd6B0ZAKy3CxnVGfTLMoEbNniNjjOtzdkocIMGPSNQsjydr3utXIMWT1i
         RZQbz/6ZJjPI0Z0wVZBEAyb7HtVWG9svso1yzklPjlMSNYNhfWre4vzOna/YOpoTqTqw
         5FOA==
X-Forwarded-Encrypted: i=1; AKwUvBz6CeynRWOrKJwXd3e7tg0a8ZW/exgwRbi2azMasdiBL1TIDcM5cgZCvi/Wr+hovdkfVmuYpB1OAm2eA6cMc7M=@vger.kernel.org
X-Gm-Message-State: AFuF++l3k3tEPABVoBrWFxlwPI1hLlUrBX2wlzOgVYQ8t+7kkEtn4oH/
	+By57dzgxFWbd4lFtcZaoPOJJlmQ0ica11AYydUP1fV7qsXkFZjbwoCKj0a7/OBqpJy0yQ8DS6t
	CIIqw7+TNQQ==
X-Gm-Gg: AYBFou015whfyePN3SG2cc82PUmslnyYSpYRknMmpSRCQkQl0HbMoH6rnGdv0fiKr7H
	hxHJVksrqi9FCLzBriwbjqYkDJdeQTDALiHKwnygY/v23RizgaYoEB2B8R2adz+kOP61jTt0a0j
	7Q3H8fucvxNR/PNsVHvGUNJd7ILdD0lFz6iDR5POBAb7ld5UW4GbL40vAG0prRokTwAprc1htvF
	aOEPCpjMGT65aha8oofZlh1xpAZvVJA4nQ9nVg+NHsU26/yxHSXqO4qh36pwAwccBqSQ1Jdob9y
	lsDdHyBHWzMfGa4i2wX59pyTg+3pFerS74wBHlNc4bjAHCKAJoC5QwgKr4BXrV07KR4Gm6qlGSx
	WJ/aoEW+c/zhrYIr4tUBRBkBfmo6WCFuazb5TexqrPuC4v9wnxKyQesBpNelG66WbrCxZ8AsqWA
	/G2M0rzddJLDonoWMVS3HNNYu3wylN+HbCBEhMFWHwRVrd5CxlWk7Sb8cRe+gbFc6YTrCF/ET7n
	3W4ZHBlgs2quL9QfBnVF3G/Tu/EdnK5ubRMJ95PBUartWo3dQ==
X-Received: by 2002:a05:6512:2344:b0:5b6:962:4ed2 with SMTP id 2adb3069b0e04-5b8b660cf65mr2102882e87.22.1789665750221;
        Thu, 17 Sep 2026 10:22:30 -0700 (PDT)
Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com. [74.125.229.205])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8b57e7f2fsm2033374e87.76.2026.09.17.10.22.29
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 10:22:29 -0700 (PDT)
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b899bbd74bso978395e87.3
        for <linux-hardening@vger.kernel.org>; Thu, 17 Sep 2026 10:22:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBz9Go+4qT9+vx7UhqMsoDfIonMmTVzTisX3eDV28BqdaBlBneW+GTmN9/qg/4xjXhfoSqVOpj3KCNcElQ1gEpo=@vger.kernel.org
X-Received: by 2002:a17:907:c1f:b0:c12:e178:9e68 with SMTP id
 a640c23a62f3a-c29e5237e9amr501417166b.19.1789665344119; Thu, 17 Sep 2026
 10:15:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917-build-speedup-v3-0-9ecf4163ff36@kernel.org>
In-Reply-To: <20260917-build-speedup-v3-0-9ecf4163ff36@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 17 Sep 2026 10:15:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjwtJQPW+MRAkQCcSGA1EZWehxBTUiEUUhdACCNHSKvTQ@mail.gmail.com>
X-Gm-Features: AcwNN1VkAmOFPymjE_dcKSWc6Q8Z4LvlbW-9yRGSGQmATfVxYq3jdlUQ82g4gXM
Message-ID: <CAHk-=wjwtJQPW+MRAkQCcSGA1EZWehxBTUiEUUhdACCNHSKvTQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/20] kbuild: significantly speed up kernel builds
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
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
	Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 17 Sept 2026 at 09:06, Lorenzo Stoakes (ARM) <ljs@kernel.org> wrote:
>
>                 == defconfig FULL build ==
>
>                         before    after     delta
>                       ----------------------------------
> Threadripper, gcc        32.5s    26.3s     -6.1s (-19%)
> Threadripper, clang      34.5s    27.2s     -7.3s (-21%)
> EPYC, gcc                28.7s    20.6s     -8.1s (-28%)
> EPYC, clang              39.8s    32.2s     -7.6s (-19%)
> M2, gcc                 519.3s   512.4s     -6.9s (-1%)
> M2, clang               634.5s   569.4s    -65.1s (-10%)

There's something odd going on with that M2 gcc build. Why is it such
an odd duck?

             Linus
