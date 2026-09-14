Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C25396D19
	for <linux-hardening@vger.kernel.org>; Mon, 14 Sep 2026 22:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789425346; cv=none; b=aK1328SPPwaby/KdNPxH0AkFwFy7q3Yfp/gCdqbmr/ucYRnGj9o0GSTsa0vhJ9cDow6nL/lCwh1QTHmWXCfjBUDVVOGRIot56pljPLRHP2GP1lOb1WsMCEKRsgkhl+xT0owazxZDuTjZowFEOwyZCl2ssCWoA//TfLbHu4uWJ44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789425346; c=relaxed/simple;
	bh=3pbB/cdA2n+mw9ojxn7xAJ0JjyYJsv3yomOKFEBUOog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UIal8Lf3t+VyiOlAvusasby8LqwoCBQaBlzdjYfcz2uBFgYg6EwB4v5T4NwehQCUX6ymwp30zVus/fkuDPNFTn4bj2WM4hF+7NeCMeimMJgNKZj/eF2F03xCoKoB9jRaWo0CFukp/Qp7FRbLxzUNOd97BZxbRs1RFxIcrPJ1CQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=N1VjgvOQ; arc=none smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="N1VjgvOQ"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a9984f9adcso5150957a12.0
        for <linux-hardening@vger.kernel.org>; Mon, 14 Sep 2026 15:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1789425342; x=1790030142; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=doHeCbdvroV7mGBSmqv1XRXXxfYTXe+sNzLZzLwqdyM=;
        b=N1VjgvOQ3Jm1SQCaAAwZwxzc4teYnovSvo/sMrlp0MZMQoRhNIg3RUWPGqbdzQv2Ta
         SJN2JQ71jmud/yHO1BZJOUTeT2LuzeEih1A+gOU/P/TcNsco6YusnXRCDdSVpgvweNSI
         RX2+W76z73HPf6tMi7nvCZeA+9hMkzv5xFcZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789425342; x=1790030142;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=doHeCbdvroV7mGBSmqv1XRXXxfYTXe+sNzLZzLwqdyM=;
        b=hvIrsTcrGVhtbOr0IHlil12O0V+0e1Rpc4krI7ZskiYWEa1L+hv387RYbfZ87BKvHR
         IrTLILoq0OVzbh7MsPAJtWZYhoNTGZF1k+T8L8/zAw1o8snl1qxsaaGrRtwWLLdJ2xCK
         nXgk5Dr7KzX5w2x+NURQYsEf468khlgBnITuSEteZW4dlS0J8GmOy29zf/UJbyGOF3EI
         QxRbx14bQcIdNht2Xl3LLAMlKjfPJhUok/4sXdvxazM1ik+c2nL6/SYRbTdy8k4v1kJZ
         eOMZv7nFuMbf+REkRnPX/AcQawYcR44K+V1pWoqPbl3SZFKGAbHV8i9WwHVBpZN63ved
         T6PA==
X-Forwarded-Encrypted: i=1; AKwUvBxkCz++nxkrPTkmS499cPlh4PpVZiMEmqzs3GQJCTHrkExx8yhSqRKgoHrvUEdHFJksLLWviALuRc0ge3c1J+I=@vger.kernel.org
X-Gm-Message-State: AFuF++mqDLjeuNc/o6NmxZauAWA5ILoctF/cMjUZPrFpMajVb+iSluii
	GW8f+FwrvEHCXK3NQSWPuS0rQCz8hY90/V5iTwxFnNrzztqFbk1CYFZrLmfQ5SZ0pSD+zRRhVf+
	S7HZr0ZZt2A==
X-Gm-Gg: AYBFou263mRrJEK1FadOttfUh54tGSdptai7TnL3cR6/R68JLMJAMqNy8KljlAICq+m
	3xJMwDK2Nn1rUzRCULk/958SBbbTxSCxBx18zWDE3HjKUziOnislmI5Xq9XJajJqPWkfeYrDd5K
	5ELR4xYFAc4dTlerGUyV1XuECr4g17fyF8+IiNo2tsj7gBAJ9kZ+nyK1oaWDC7rRyYjLNohRDy/
	vNFh+c8yDPV3n/6jjCaOeil8X3Y/vAIdqZUEPwCypIVDIAWZ2Mmxm22sTrmXFlcMmX1PqWUEzkd
	v7EiSREonz4tUcSyEJCauYZRg9t46YwuyjGC0v5lk3FPEDCuJOsKrVJf6UJHmLdM8X3t5ABRxxO
	px2FSlaFqBXfgEY4slLTvmvG/iE9KnRy4iVNCvA0asOOMZKGKYBCkt9P9bL5LBmE2VrnR5mQo7O
	WwS5kdflpw+H4BRt620/Vzd4HtRhe/5NrwE2aK9TxJ8xpLHf4GQtbkAIXSWOBY5jDnwoWYDtO9H
	DKtYJQeE6LWSJxo4koC5EPkBurjbFIZn7aFeTo1lmMa3HUobg==
X-Received: by 2002:a17:907:3e07:b0:c26:1648:a062 with SMTP id a640c23a62f3a-c29b872595dmr310943366b.29.1789425342192;
        Mon, 14 Sep 2026 15:35:42 -0700 (PDT)
Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com. [74.125.228.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2966147b46sm487425266b.60.2026.09.14.15.35.42
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2026 15:35:42 -0700 (PDT)
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f705536so619732866b.1
        for <linux-hardening@vger.kernel.org>; Mon, 14 Sep 2026 15:35:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBygY7W1EKoo3A5C2lM7foFXB1tQjvwNvqQ7rjrgIYCog5ycs+iKcOSL313HHyEku3Ae/HNMPlx4GDPC60uloEc=@vger.kernel.org
X-Received: by 2002:a17:907:97c9:b0:c29:4415:2ebb with SMTP id
 a640c23a62f3a-c29b860109bmr315536666b.8.1789425035842; Mon, 14 Sep 2026
 15:30:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914-build-speedup-v2-0-39817ec5db23@kernel.org>
 <20260914-build-speedup-v2-15-39817ec5db23@kernel.org> <aqhLhVMkNzf_4oJw@jpoimboe>
 <CAHk-=wiB9MX7vBDQ+WHTUVfSYubLhR-PbABewscqTsxRhg-LbQ@mail.gmail.com> <aqhmhmgrnN3Mw8yG@jpoimboe>
In-Reply-To: <aqhmhmgrnN3Mw8yG@jpoimboe>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 14 Sep 2026 15:30:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj3BKkCYtmfs5sORF_+Oumv2Gc8D+YxkMp9W2-mvLS=Ug@mail.gmail.com>
X-Gm-Features: AcwNN1UnWAKTndckmaJ94decAtfrWRGA6P58dk0oXtHcS9ajgGc6O7ZKSXjYJOY
Message-ID: <CAHk-=wj3BKkCYtmfs5sORF_+Oumv2Gc8D+YxkMp9W2-mvLS=Ug@mail.gmail.com>
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

On Mon, 14 Sept 2026 at 15:23, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
>
> There might be more efficient ways to structure the considerable amount
> of data, like replacing "struct instruction" with "struct basic_block"
> or so, but it's hard to know whether that would be a net positive.

Yeah, I was thinking that you'd only hash instructions as you find
them if they are obvious "I need this instruction", and then try to
hash them *again* if they are branch targets (and just have a "already
hashed" flag).

That way random number instructions would not be on the hash - unless
they become branch targets.

And you wouldn't ever really have to track any complicated decisions
(like that whole "basic block" thing - I agree that it's painful,
because the shape of a basic block will change over time as you find
branch targets).

But not a big deal. More an idle thought brought on by that other
patch that changed the hash table size, and this discussion that was
talking about the hashing - or not hashing - of sections.

So more of a "if it is easy and straightforward" kind of thing.

             Linus
