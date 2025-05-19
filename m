Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B4B288521;
	Mon, 19 May 2025 18:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747678329; cv=none; b=Dp/FCwlNl1lY/K5RaxupEElX88i4ue5Kty7uIopCSWYm6TXWlv9FGCKwzMRWCzIEsoix6TSJvnxrHy4qgNF7qBxcGU46IuOnEOW8jRPCP4QknIJDA9+l29C5l1khEUzssuC3ZiUDjFBTK6QdGxlzqwl41lxJKX0jABTX4zgsI8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747678329; c=relaxed/simple;
	bh=NL3K12gpHB+s16FElh/0GdqTTWovydOiWo4+ndoLaVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kL2pgoxhAjWXugc2bnmoW54/+ufUODaK/z9l9D9F9cg6wbUKT4bVVUn+AVzvDtSVjuUe4/U7ENvDpHhvCbMi9MLrhP9G9MYy+oTNLvGjTH+7/y3Dj4gYhA4vRMthhneEKVxUerAQpGdK1A2Bi6Hy6pvY+w3wf7tTncr14QLaJHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lqg8u8FM; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lqg8u8FM"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-742cabe1825so77388b3a.2;
        Mon, 19 May 2025 11:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747678328; x=1748283128; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NL3K12gpHB+s16FElh/0GdqTTWovydOiWo4+ndoLaVE=;
        b=Lqg8u8FM6V6zi5OHkq4b/UsdzK7R8HnFXE+855HQ+qUvKY54vpoBJpjLj35FreOqLn
         sNQeWmq+OKpUXsR2B7ievRFfOs4BLSMal9H0yX71DM5SM5rk2VOjPwLFOpafbAhpMq4S
         kG0JlA3yPJBkVwKqYtXpI7nsOg1knjjtVqkC+3ZBfXhEghb4GA5yymEVp4jPPdYL/JBL
         pB1ClGAM3jRirk0YgyWd7TN09/RrD9YYn1KPR5sjgjKAdW0tqWrwt25VplYGjpssqpbc
         8mhQEgcbFfKkMKIG1USVdDO5EYh/ScT8hDoCV/Lc32YFJUe75bVKjxUGvZqMs59bY+uK
         TVWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747678328; x=1748283128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NL3K12gpHB+s16FElh/0GdqTTWovydOiWo4+ndoLaVE=;
        b=fou/jsJWe1kMuUTTb/tvXOxu4zcO6rQhaFC+B+RvJuIM1hCSGaxj/tH9p9wVKNERM/
         UpdteX0mWdaFUlbX9MuLH17VYBxwjkANANUBV3ro6kTMYVtQmH8zmy2JPcYnvLUjSQCb
         6UWjxyuIBstnHzM9hzq6/x2p0F/qRPiMO0Ci/1uTswM3HBC0l8Q7wcqTVOMuA4jruFh0
         3h93LVKd5wgLIEyBFEKVoIWudL1HTVHNN4O/1jJ7xER47NqwM/38nklXJUtVmQepAxL3
         3LNMSgSzMar63GuxMr8OqYq/iL0YQ28cB9A/UCvRXTUNxaZMhF/uhJdIhvHTfAUbju+1
         tVBA==
X-Forwarded-Encrypted: i=1; AJvYcCUCHUgi2aGzKxoHlWDb2dNGsW7WSHkZH7aGuHLd3pzP3Wz/NLQXminl1kmbA+ikJhzPQXG5e163QOvylyeAcho=@vger.kernel.org, AJvYcCVduyy9XozZGj5Vk8v96WhDXiVX6IPqaUL2+gfhTG/jDeShWZD1PPrIFn1Zve0UPL6uXAgBbRCY2O/kPR56Ytw=@vger.kernel.org, AJvYcCXaMT/my/kiiooGG3OhXQfgAh0vzEfmXdEHW+k8TPU4pAETErnwoIG9yLx2rcdomOaYI9Jaw9gxKjGlm5CI@vger.kernel.org
X-Gm-Message-State: AOJu0Yx59hKhsZrJoJsLVXHliJcGhAuHNyCffd850MofN7ykxIwK3JW/
	L7I1+WJnx+0qCFSQh0p/sPJLyFEPN54EcceqvOrikdvGCrCKlXXF90LFNMnEcJ2yCgBeVb50T7V
	dVlyoKmwmFwtgdOfaSrdiSQGA6S76BdM=
X-Gm-Gg: ASbGncvbr49E5m4xAuVOpYeUJxUq2Op8/BSCJ9hGpEDR0oY91CM/3Z0w5bq/Y/sjl/0
	1R0CUDmOwyZN3WxYMcYz+RgNwIZrMOqr6OlerlchH0wMozCdZM1yzL+uKURarEDduYDvr6HZS4H
	6CFN2/BguazEsGaYxnc0x0QtNLjbX9z1Dj
X-Google-Smtp-Source: AGHT+IEd6emKzSXXJKUJ620g5wKtQynaEWDCezY6EuosLlYg/uAasrDg3GtdMz1Efp8Cj/NXchnh6YCYqo9VBJMdh0w=
X-Received: by 2002:a17:903:1987:b0:22f:b902:fa87 with SMTP id
 d9443c01a7336-231d450f7b1mr77128145ad.10.1747678327693; Mon, 19 May 2025
 11:12:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250519161712.2609395-1-bqe@google.com> <20250519161712.2609395-5-bqe@google.com>
 <aCtsyA6-kzNLlf4L@yury>
In-Reply-To: <aCtsyA6-kzNLlf4L@yury>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 19 May 2025 20:11:55 +0200
X-Gm-Features: AX0GCFtOo7mlY1kQHv6Q4pFPXJjaOMMqMh9HDsuK3Ydq3TZzhBSEvtw2963VRu0
Message-ID: <CANiq72msJa5O=MnqT0Gna3Gu7M=HA2AoXcYeqGHGEkuQa8TJTg@mail.gmail.com>
Subject: Re: [PATCH v8 4/5] rust: add find_bit_benchmark_rust module.
To: Yury Norov <yury.norov@gmail.com>
Cc: Burak Emir <bqe@google.com>, Kees Cook <kees@kernel.org>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 19, 2025 at 7:39=E2=80=AFPM Yury Norov <yury.norov@gmail.com> w=
rote:
>
> To me it's pretty useless. I think this 'authors' section exists to
> help those having troubles with the module to reach the right people.
> Can you please add your name and email here?

Yeah, we used that back in the initial merge since there were a bunch
of contributors and because the samples were fairly "core".

Nowadays, and especially for concrete things that are not "used by
everybody", indeed it is best to use concrete names.

Thanks!

Cheers,
Miguel
