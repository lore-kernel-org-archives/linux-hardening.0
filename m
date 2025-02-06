Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A23D7DA8C;
	Thu,  6 Feb 2025 20:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738872440; cv=none; b=V0oUvm1oGExkZRZpKO4RizeTQwKIw/igsEArTRKoIYeMkfdbKLfAMK3e+lQw+19YwFplu8OuJZXggj0D3FAG+OwN+FCClBE80jniSd1kSaHWCegm9xUTanMJ++w/aHVt4rjaiF4bNcdif1Yq5md4EqeGQ9EswqkOMiBxhIpLA0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738872440; c=relaxed/simple;
	bh=WIzcmDmD/+zJ8s5+zLwVBi39lh4YIDruox3AjDUnmYg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hQHiUfBWOC0pSLgrx/I+ZCpaJivH23EB1zl9uSZJzewr0cwGYU3jZuVlCSJTxfyR+aq8B5306fw333LSmpDA7/FTq5rpSAqGqgn1AN06PbsXTQR5MLq6KKu8foBs+CNq13ymLyxwCqBPp2cspd3JlIn8XybpIABYOE7ektKe5Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WOweDgOt; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WOweDgOt"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2fa1c3ac70cso126141a91.0;
        Thu, 06 Feb 2025 12:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738872438; x=1739477238; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WIzcmDmD/+zJ8s5+zLwVBi39lh4YIDruox3AjDUnmYg=;
        b=WOweDgOt12CkHdiqIqwpNdDQ1U778g5/rw6KJ8QoWm9MGXKIutiYVA+t1OzNBkkX+D
         kSL9edpwuElXUqZ0UjvKedHkALwzG6fIGkFqEi9stfssmiIxb/afTxYt1OIKFkBuHbHa
         ekQiBaq3UKVBj97ZXpDNB6QRnYmNs5xPLejRTR1YhIAgO8ExyCRnwCXBsmy7QI0mB7Ah
         E4ybXvAWOSklnFZdUYvTe8PAqWlhGly5GyCB+z6vQoyx0T6qEU+Ozkf12coHROnG59yH
         KqvzGNT4g97HHmzi/AbLd83aBvBXAgn+HBrdslQdFxq5PdMZrHXeVhGuboK6sxDkDShz
         /0+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738872438; x=1739477238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WIzcmDmD/+zJ8s5+zLwVBi39lh4YIDruox3AjDUnmYg=;
        b=HMn7atyWWKCTx4kplUhS4yPsnbUIuQq3YLsEVhmKyoWUx1jDP5w9UKc3PQtEIdDoPc
         aMHI5D5yl0W2UUnLI+bjC1UX/emZ1k95qEDkOAM4cXIw0YIMc2kF7a6kPMqMvsYRruRK
         UrtF+xbuRDjB+06tpGEIPMVe10TtTJMdbQLMUpiJGX9fRvFpEioDqCTeDIWRs1sTxT8y
         YFlbmHW29vDmPj9Ks+nN+IoqPdbgLZ2JV4Y22VNeCE8WYeOssECnaVbrkSoGLTa78qoh
         vwJkJORbdEcdt8sWWbp5ox9CepwsQ5uoe1qTf3uJ62YuSg7ZFn112gHfPaOVgd3FsqeD
         P7oA==
X-Forwarded-Encrypted: i=1; AJvYcCUSdgHSUf9ecHwx077KeQTujyn02c2V/Lfq0bLjr1Ww8SoKy1s7WP8sEuteMozJcfGV7mUFBHBmxdeU3ig7@vger.kernel.org, AJvYcCWK6EbXeqZvsS52HvPAJMWAzBPDDha7/zj7T8eGaBhzVAokJ1OX/LQkySLvoDMnRIiO8HlJi2VJpMCY9HeQD/M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yweqot4GWdvHWlT7giDcXLMM4gL7SdnXKCj8sK5+GarsemQVbZV
	hic3ZiMimmQOE0UgtrEpbl63D+tuO+rtpZRKusn6jr4IzBN7g6xcaOaOSpSGHfS4JMZ4MZ+l5/k
	8UzDgXx/gUiyqfrAiLVI18PT2sh0=
X-Gm-Gg: ASbGncs2gfVFEMZWjN/GgWaSNbkeax3kSG1DnvuNYJMFOdLq9l/th00vyy7qP5X9Q8O
	gQip+U1ebW5a7UivyMqirvg7iJzu/9PMyk6nSjqbND/iJMVgiql28dB5S9HVnjM45oD2uB3m3
X-Google-Smtp-Source: AGHT+IEm0DywvLZQSzge8Nga2B1PPNnjhE1HYqX+Eh9XOt8eJU/Ve5UT4uuIDtceuJ6hHkTnV1zpaVUikof8w+L5sjQ=
X-Received: by 2002:a17:90b:3808:b0:2ee:d4ed:13a7 with SMTP id
 98e67ed59e1d1-2fa2452820dmr183852a91.7.1738872438291; Thu, 06 Feb 2025
 12:07:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206175216.work.225-kees@kernel.org> <20250206181133.3450635-1-kees@kernel.org>
In-Reply-To: <20250206181133.3450635-1-kees@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 6 Feb 2025 21:07:05 +0100
X-Gm-Features: AWEUYZkvnzTQZ_9UQDhm6HqikSDqn71N3eGzi0s3POCtRKLPNY-TpuHq0_TkCWk
Message-ID: <CANiq72nmAKa4rHsk0s1iqY77T-0MEyA8UJv1y=w9vFQ79FBxSw@mail.gmail.com>
Subject: Re: [PATCH 1/3] compiler.h: Move C string helpers into C-only kernel section
To: Kees Cook <kees@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Andy Shevchenko <andy@kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Philipp Reisner <philipp.reisner@linbit.com>, Miguel Ojeda <ojeda@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 6, 2025 at 7:11=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> The C kernel helpers for evaluating C Strings were placed outside of the
> assembly ifdef. Move them to the correct place so future changes won't
> confuse the assembler.

This moves it also into the kernel ifdef too -- I assume that is
intentional. (Perhaps mention ifndef instead of ifdef?)

I checked that this is indeed a pure move, so:

Reviewed-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel
