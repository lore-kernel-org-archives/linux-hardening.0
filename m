Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C3B3CF673
	for <linux-hardening@vger.kernel.org>; Wed,  5 Aug 2026 17:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785950688; cv=pass; b=j6QcZyH1fSUxz7HZZ5qkMx3lv0F345l8lMmYXggQxqUZAAaXWkmw7JAk7FJ28cz5zHiYWh/XbxHH7PLbpzX7CqQKqai6BVb+zqw2i+x5GH5JCKnrTMCFgU9utQAkNXbRn81SMCJsJwMOOKX9K1lkfZUTK5k32I1s/DvRGD5qQHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785950688; c=relaxed/simple;
	bh=lqsoXm6msVcY9U+iIeiwYgdVs6Tx/P7U6/+PspA3yMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WWImNuE6g+gqJvgxgKfBeuZVtSiH05NBDrsQnJnn8V8/wlMUrbOKZIF1dYJQF3DOo18R9w+U2t9ED6ns9fJ5pqmp5CiFogKiUtzIkvoB2X09V5tRyiK2S3+hJkxlwxE/iG8SQ141DZpyGr5OjxWzdPUaR4JcpLIjG4cfwcXuRB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=JkY8VfBU; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="JkY8VfBU"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ced3386430so14677645ad.1
        for <linux-hardening@vger.kernel.org>; Wed, 05 Aug 2026 10:24:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785950685; cv=none;
        d=google.com; s=arc-20260327;
        b=bFDkJdMcKgUxknFoFbvYPyKweW6vQPhYwJFLLf3EfrO/5sXKRQMBsVjH56wU0j+NIS
         g+jH5iQGqZfqEoo4Bv/D0J56nZB5bnRTaMTJmSXZpr2GWvqvnB1yf11ibg3f2kv+uXQA
         1xOnWjglOoHOs1SpXjs0/44f3exCLwYrI8cLtCUaWAdEQeZmW8atCrQgJsJzrb2uWqY/
         6VtEzAKLm9BVW2nZ9wegW6zdajfZN5sh7db5uYE+Tr27mQd1dwAkHz+InNEXgsv7q29W
         V/zEtqFMD35LfdXHOrxpojWIOsxQcg3EKn6bPytM/2VEFxFlzzMaIQVy6WXGac9Q5pIP
         jwwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hhSYt4d9matGJuiLLAOV82UjY/nIME2EtOpvh8wRLTg=;
        fh=pwxY+VDGH3yLRL50skEWj9jeVue0/J1GAkmBTgS5MuE=;
        b=ajBQo2RYPtPNYjAT81MY7MpWVNMUTMfPeK0qk8J3ZwE4aqpeN+oXeEJ6nr9fSFrmDK
         Ia96Usc30zEITyXtoBrAPjOK/yU5f650s3TNog18b8rcqSu/YwJFmWMnaUzFA9rw56sE
         bmAejj848bZGDD92zBT/mVBCVYEoDs7OhiZeDX39KGZFnNM5Vk+QWSNq2f/KBtq2+KfP
         FfcW8Uc/PVlP5c1pW/c+tsYs/FhhRqdU3Beh6WoLB50cACUT2IDF7WrhauBrEd1gQQK+
         0ZAt3Ncbg4A0sNnrlfB2BzhDTcwRJg9BhW5zYBUxMCP9d5LnFnCKaD+GAa3Ud1YyMqVG
         S4HA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785950685; x=1786555485; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hhSYt4d9matGJuiLLAOV82UjY/nIME2EtOpvh8wRLTg=;
        b=JkY8VfBUk1kB+aHrcnZ/zyJYMbOgb+woFfma9U/a80ijWK/f0dtwcNN+6Fj/6Pt3sh
         1pohZzw9l1NZFLLSUX6RLacfVN3n0TpNbuZ29TxWwZn54u2ewdOQNCOXTlmTwQj9X2au
         Km7cVlAv/5TBJ107Hsh0RZSOoI7zcg38H62LkgMcUKRkd0tWwVtPZEk3q1B1ZdWjL5jk
         1+uZzX8Cdiy1RYVncaR9ypFUtcfaBO5xXbopVRbpVVDuB9AegGwUAp19QojpwY6ksAhC
         C4o/q7kB0H8pS4mk2X4MRJbhXkneiLMwXli79Ch+fq+hh+QXOpj1OCHdnIfZghtX1yB8
         vhSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785950685; x=1786555485;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hhSYt4d9matGJuiLLAOV82UjY/nIME2EtOpvh8wRLTg=;
        b=ahDiiuex7mWsRIjZ2rVYx93Jfel/611PfIapzYYMDIKrtFPJukhS8h2OYM10u5V/Nx
         yGK2OIQvXeXSxgD3xagiGlJ5Nt00a+/8QB7GNcxkICb7xD4zs19GzyDnrje0/eUQmAFV
         MtA1zi3SdUSCw2Ioo+uHGtvz2ASCPSa8FAjDgoZKKCyL2SdF1maZAjN/AMQQg/j99oB5
         DPO1J/ye1RcBTcDXaunvggs5ePZU189bNVHH5/CYzyYliHkJpi4eN0fIcdloRADJvz+V
         pda0RzPg8TzWQiKI6I65zaW9o2uSPItwNt0bAwLVQSgupCBchqrGJhseWSqjrZcymGe5
         zcdQ==
X-Forwarded-Encrypted: i=1; AHgh+RoLDOtN7M7+I1TJKAX7d7b86Z0NMX+D5kuxqeEkW9OBHdcr7Vf2rnLDRjiRAFxX8HkRl0GPy6NANaouLCndaxY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4JPZ34ByG9QZzk+nl5b6CQsZtTLj8eaRVp42+tnjy9JX9ycl3
	euCI69h1FcQSq24QK1qf45G4rEVjyO6L2N0gqkq2+XYK19tCn/ML+a7L9L5V9XZcPDlAZTA3d+j
	GqNJptgPQASL4FFfZhUrTbZW2euf8c/URzp/7bNJG
X-Gm-Gg: AR+sD13NV1BIrRVl4i5ZiEJzlNMDynHzGqjN9HI+vLLk47qagdsouXVs9Ed1O/hj3o3
	nnnKRO7wF3S03LRa3ODlxYKkT66lIFIsCk7A1uujd8TETdgrlWZYtvQrtvAO18EdiSuWprQgLxZ
	xGE82IjpF/UGh4R3Z1/HixRZTQYJjM0Pt5lTEv31QsuSgezlST7pQI1NCRp14sa6z/OIGUYeRta
	5SALE965Qq0wt/IPGWf5s41Oc0qg1XlBkPTePU+WO+zzVFF8ECcC6Xtpfy2ABlIgG98NCW3ddC+
	f0fa9NbOszwkj+ld4EIZPuNyRBmVblRF9fzdWkDb+Y6R
X-Received: by 2002:a17:902:d58e:b0:2c7:1200:bd7e with SMTP id
 d9443c01a7336-2d0ca9838ebmr108122505ad.18.1785950685533; Wed, 05 Aug 2026
 10:24:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805-rust-reverse-randstruct-dep-v3-1-7b8b2c761d6e@kernel.org>
In-Reply-To: <20260805-rust-reverse-randstruct-dep-v3-1-7b8b2c761d6e@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 5 Aug 2026 13:24:32 -0400
X-Gm-Features: AUfX_mylEjzCXDD3QT1Cy9_QSKHwq2vNWKIY4ZjNvWR0wcVwfxD1mF4zdKJhIk4
Message-ID: <CAHC9VhT6s5G_toXHBsZZ6=pNNfk+v__Wwt1mGE_7C+0WqjP6VQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v3] hardening: Default randstruct off with rust for
 better allmodconfig support
To: Mark Brown <broonie@kernel.org>, Kees Cook <kees@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-hardening@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 1:02=E2=80=AFPM Mark Brown <broonie@kernel.org> wrot=
e:
>
> Currently randstruct does not support rust so we have Kconfig dependencie=
s
> which prevent rust being enabled when randstruct is. Unfortunately this
> prevents rust being enabled in allmodconfig, our standard coverage build.
> randstruct gets turned on by default, then the dependency on !RANDSTRUCT
> causes rust to get disabled.
>
> Work around this by disabling randstruct by default if we have a usable
> rust toolchain and rust support for the architecture, circular
> dependencies prevent us directly depending on !RUST. This means we might
> end up with a configuration that disables both rust and randstruct but
> hopefully it's more likely go give the expected result.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
> Changes in v3:
> - Rebase onto v7.2-rc1.
> - Link to v2: https://patch.msgid.link/20260605-rust-reverse-randstruct-d=
ep-v2-1-93d38023b6f9@kernel.org
>
> Changes in v2:
> - Add a HAVE_RUST in there too.
> - Link to v1: https://patch.msgid.link/20260605-rust-reverse-randstruct-d=
ep-v1-1-45ce9ee8d0d1@kernel.org
> ---
>  security/Kconfig.hardening | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

FYI, I believe Kees has been away from email for a bit, but my
understanding is that will be changing soon.

> diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
> index 6923036e1a2f..81c81ad983ad 100644
> --- a/security/Kconfig.hardening
> +++ b/security/Kconfig.hardening
> @@ -278,7 +278,7 @@ config CC_HAS_RANDSTRUCT
>
>  choice
>         prompt "Randomize layout of sensitive kernel structures"
> -       default RANDSTRUCT_FULL if COMPILE_TEST && (GCC_PLUGINS || CC_HAS=
_RANDSTRUCT)
> +       default RANDSTRUCT_FULL if !(RUST_IS_AVAILABLE && HAVE_RUST) && C=
OMPILE_TEST && (GCC_PLUGINS || CC_HAS_RANDSTRUCT)
>         default RANDSTRUCT_NONE
>         help
>           If you enable this, the layouts of structures that are entirely
>
> ---
> base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
> change-id: 20260605-rust-reverse-randstruct-dep-5a504c861128

--=20
paul-moore.com
