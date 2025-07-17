Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9A5291C24;
	Thu, 17 Jul 2025 09:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752745883; cv=none; b=RDiWPzZ/KjTaEhC4gQKHoGG0r6EJCdhb0T6ZFbjboWsa9LJOcZKz3OeC0/7CPnc65NUbLoX5G/2/nehYzS9UZab9HOqliqpTRf/IYpWFWE1wOnMhs+V0/crdZ+kGz3s4UBhXSSjV4F+6+cQTlbwlf92HC8OXloQJ/dv10CDMwuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752745883; c=relaxed/simple;
	bh=cQaqVDgy4SckeQJyFWnR3lim3RXCi4FuZHi/y1GNXJs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OvygcKmQB9ThMInNaLbosDJFa+CczfdCLaOD+RbXXR+XrrIq2yelqwfQxoVWpZqFrKovuad1Qk0Usjr8nwNM2RsiFe8q5p7efj5axQkYsJs+zdCRA668UMBJBKX+N0L+mmL50GuOtQUcpY4mJj6jB+NJjy6xKR2+KsID3psQgow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EKB+l+Ki; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EKB+l+Ki"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-313756c602fso152921a91.3;
        Thu, 17 Jul 2025 02:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752745881; x=1753350681; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yoOezcET8UmypwzwvlrLUte+8S0VuNqGvHQFe8FNIeo=;
        b=EKB+l+KiZXcP1eugPjKbz42Nh+G4DdTMt5yWq7ABS3Lo8HfTDIsVtoqBKSJ04ptZdc
         Ft1ij/6sFB8iEuZ15doguR5V7+v+eQltCeaerssPnG2H7DPzdBq5d9rZGeLt2lIwgbNB
         rDqQ/G1NrAN8ZnCSOUJgvDIaeXTVWbphwkJzOcXURrwE0mKWlmL32Z8BiE1/Eq4CZu03
         jJYjf64YVLLZfCD7iGQk0vnZiJ2ydD7d3eIVqEv7oZSH7wVroSUNMbWmBxYCC6vCBjx6
         pKWestONsWT/JpOPrwVyixYRFocW31pTJRE1nf1mMtUMiDJ1qdNC6t0T6Te4djzTkurj
         mwJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752745881; x=1753350681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yoOezcET8UmypwzwvlrLUte+8S0VuNqGvHQFe8FNIeo=;
        b=qkybQvInRwR+qi0VJZAKeSOemuh4xPWJFZQXfxU/yikBEU75Egicr7GvmTdt2l2Gpp
         PPO4Wi9AQscQKD+WhbTsQMTMqzC5fwomhirj3yOKRZE3MUzaSASnwMP9VKxqzTDHQkLo
         1+devWDdOU6v2e5ZQAQ6Y74AAUuqPgLo6XlB+Bx12L0jjKFn0EeyuYshe5FjcHgjyJ58
         6zorBvyCzvaT2BHqXoBmCwh0JFYDVRZqi3wIcS1GkUB0/CdtQvoq7lQDo3QwANhulh8B
         QO/vBgMd+P7dvwASnZLk+VdGOWDz7jc2vmio6ar9Ib9qnp8aFLhqTCzsat+i5KCe5M3R
         UHxg==
X-Forwarded-Encrypted: i=1; AJvYcCUKcurhjTPHhHZT/x8wJiD8mlugdclxd1ugvGfIEy2oRNk31sCZYrnz/pAulVz/7QvXesto/yeEkowqnyoUAFA=@vger.kernel.org, AJvYcCWgjZp6mrW9HVCJHxrHMzX9Fl8IOtTCD/68HY0igRLL7ZVJ4IkhVyPp9dL/9I53DCTi091mJ54mi8FQym9T@vger.kernel.org
X-Gm-Message-State: AOJu0YwLVE0DlUuVRX0q1SzPT9vh0fjplOD+ZsQEfWbI6NX+929apAbz
	h8kDhMTJIVRjJ05OLaEbPZBYuxBVrNOYKR9QErEUlK3c3U0CaR71dyXd7OobEmEIAwti/Ih7MC0
	65+H1fPx3CqB50a6sxHOPcjXWR33b3zY=
X-Gm-Gg: ASbGnctp57s6XsotzWdPvH2n4jKh08Dndh6CT72QxBlp+598K5+W4hH1eoxoNPrw67k
	s9COW6dxUSDktTTzwv2+rsjb/zp6WEbPTwd4vKLvmLfD89DMtejUErOSXPc28uHBANzfPWw4Rq8
	EOQWXbaoYAtiyZTtqkGCa+t/5QRwTElyYuuUhLIhGKN5VSkLAy/22+1am1Ju4WSH9l3tFdKWhvX
	nVKCliu
X-Google-Smtp-Source: AGHT+IHE3RFua6d6j8prMWudh7Xejt5xhZFdrWjbGlRuZ6pE6iadIeZ5MEbdWSZJS9fjWLKxIh9W/S1HkVJI8kJs+So=
X-Received: by 2002:a17:90b:1cc3:b0:311:c5d9:2c8b with SMTP id
 98e67ed59e1d1-31c9e7767fbmr3584725a91.5.1752745881278; Thu, 17 Jul 2025
 02:51:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717085300.work.146-kees@kernel.org>
In-Reply-To: <20250717085300.work.146-kees@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 17 Jul 2025 11:51:09 +0200
X-Gm-Features: Ac12FXwEMlRfz5cT5iny1Ggmin54LlImEScdSudxaMw40mhL-yA8t_7Hq-Yl4KY
Message-ID: <CANiq72kPmb+7Ygk_Qvsiq+22EJVSPjjwn4whdLuTGCPwvTAssQ@mail.gmail.com>
Subject: Re: [PATCH] Compiler Attributes: Add __kcfi_salt
To: Kees Cook <kees@kernel.org>
Cc: Bill Wendling <morbo@google.com>, Andrew Cooper <andrew.cooper3@citrix.com>, 
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Justin Stitt <justinstitt@google.com>, 
	llvm@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 10:53=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
> Add support for Clang's coming "kcfi_salt" attribute, which is designed
> to allow for KCFI prototype hashes to be separated[1]. For example,
> normally two "void func(void)" functions would have the same KCFI hash,
> but if they wanted their indirect calls to be distinguishable by KCFI,
> one could add __kcfi_salt("foo").

It would be nice to have a quick sentence inline summarizing how it
will be used, e.g. what kind of functions will need to be annotated.

> To test the result, add a corresponding LKDTM test, CFI_FORWARD_SALT.

Sounds good.

> + * clang: https://clang.llvm.org/docs/AttributeReference.html#kcfi-salt

I guess this anchor will eventually work -- I see you asked about it at:

    https://github.com/llvm/llvm-project/pull/141846#discussion_r2209236363

From what I see, this still has to land in LLVM, right? So I guess
there is still time to land this (and the discussion started years
ago), but if you need to take it quickly as a base for some other work
or similar:

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel
