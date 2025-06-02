Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B1A221703
	for <linux-hardening@vger.kernel.org>; Mon,  2 Jun 2025 13:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748872120; cv=none; b=ranhfVDGWd3DAQG2UZUChbhEjoORI2Qe1j/lwpeQMTJPJ+goFt8F/4xAy2h8cPqJVU+6VyZ4TGj7lZO4oOUfp+pUK7BwZjalE3mRjc9tPBylzgxV07JYYFWuOKihWtkd/Vcuv0Fgj1H0N99OpSl16dwbgCrRdpLjpoC06rqsGi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748872120; c=relaxed/simple;
	bh=zOSeXNcd8Limb2V+zOaCZevg9OAEa7wcn/HbXg+RdIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gHXEBHATtLKIRK9VjEswi0ljtPw+UKxETvtzIlBUlBbkiATJnNwyEv9D1VI83G7TrrU0dW95TptsBPya0eqDph57A/trDsDS+V//LPp9W8XzW5hDu7T0/LbHPCuxxiyZQ64ZhymfXMGinaL6LkmTCkVo88cmAzOZ7YOrQEul9ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1QpiWp9b; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1QpiWp9b"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2e3e58edab5so1753184fac.3
        for <linux-hardening@vger.kernel.org>; Mon, 02 Jun 2025 06:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748872118; x=1749476918; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zOSeXNcd8Limb2V+zOaCZevg9OAEa7wcn/HbXg+RdIo=;
        b=1QpiWp9b9h3f9od5DTIyQjVX+XhTPDPRxupc/Hq57596+G307Hp2LQsTI/ZgqVSHt1
         FFib3xiB5SdwgLUVbPzJeg8HfsDkwcSVxWBfxYeXBmLDXDMPG2vtaS6/QkJhAyu1KtPc
         usR2V3kt2dKuq/AMw9uIav7EFiuR/D1KtiwUrMPVySf/1bgDT9CF3IsFr+MEaZ0Oi6O+
         izBBHvjXm7hmeBvHzpBCKBcTbYGpxIa2a9H2gZHSeotBq/DywUpdVZ/R9oQYHUhniUdO
         MDArjRa3cKlPJ5EFUWZ/fVKfZ8PTSVHelYqghJAzZOVgwq65DEaaXarZ/x5LlCmz5vDY
         pOYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748872118; x=1749476918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zOSeXNcd8Limb2V+zOaCZevg9OAEa7wcn/HbXg+RdIo=;
        b=F+0S42gbgOO+8FlmXHOzmn4QH6ZGX0Hr/uz6U1uQ3vjbQAbJ/XYtoxf1WESVb9ezzM
         XpptuFmZVastIp5LxqOg70od8wZTnkiInAp1LIbTj3xbac95l6sGPM5CRY6ZOSzDImoq
         0QtlKtn5CoMtU2UVuQbr56PalzKYPNcfwFAYTGLRJnFwTeHgvYWHl/EkIjAWcVVKq4EC
         dmYE7mRkWWC4ZjVwMhdXqTn9XNMie0L1vZX5ZkLRJiXWgcxt0tXmphtCHiG6rA2fj6EW
         CwmRnpNiNPFMJEYWT9/cRzAa2KsFJCHj67lK69m5PpI0UaHHvagpWFNSUWlmswX+7gjA
         k48Q==
X-Forwarded-Encrypted: i=1; AJvYcCVHxJ4YXQS7Yo0MKXiES7sRr4vvB7bI8fikm+QHc2kclGe5cQH6VBz213aF/bQTlrPWiJ3Vx9cTOVu5afeEBgU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXEDeqrW483ZVN02g+PlSiOVGd/A8xO6T71rWZSLD8qMK6z4GU
	VfrGR43EEZ6TcJnCrfT9Hj1szQXzqJvsTPh7N3M2I3/n23NEnaVZ3hS8lpHDFncMx66JF5TVWET
	WasU5VoIeSDXk+aFT0h3vudHrGN2SfJJmaK/Ln1hY
X-Gm-Gg: ASbGncsuu4x9Cb1Tj6SLiTs/NSczxvOSt1YsPVsEgVIvSfG5O0c4qRrBgYPgu3n7NWx
	bev0pwSYr4xxNwYt0KU6jTb/TSEQmrifEZK4W/pM3VhzHypI0oODFgP9XsJ6jyGzfqssNoa8Ssx
	SWyKO7RJUy+kOsfPUcJ6sqGtR2xyGm4P6d2zDmOA1AE7+WnE83LUE/FOyhYynkudBxnVxJVyIq+
	Q==
X-Google-Smtp-Source: AGHT+IHZcil0xtLyST3sDOJtjEJ8Q1w8t4vE+wRo5JvoAI0L4YVl2hM6fja6W80hRtiHTsXppngSkoU4ekQc+wPvxGM=
X-Received: by 2002:a05:6870:9106:b0:2c2:4c92:77f with SMTP id
 586e51a60fabf-2e92a478289mr6485269fac.38.1748872118156; Mon, 02 Jun 2025
 06:48:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250602133653.1606388-1-bqe@google.com>
In-Reply-To: <20250602133653.1606388-1-bqe@google.com>
From: Burak Emir <bqe@google.com>
Date: Mon, 2 Jun 2025 15:48:26 +0200
X-Gm-Features: AX0GCFtH8q7_iibcqy7PZfc8_r0qw0yaACH-9rlFYCUQZJ89nTglDsYGq_wrzcg
Message-ID: <CACQBu=UFGmCVK=tpcerBXZBQyF87EhPJqD62eAgm0OHtW6yc1g@mail.gmail.com>
Subject: Re: [PATCH v10 0/5] rust: adds Bitmap API, ID pool and bindings
To: Yury Norov <yury.norov@gmail.com>, Kees Cook <kees@kernel.org>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, Carlos LLama <cmllamas@google.com>, 
	Pekka Ristola <pekkarr@protonmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry for the spam, please ignore this version. Had to fix one more
typo in Kconfig.

On Mon, Jun 2, 2025 at 3:36=E2=80=AFPM Burak Emir <bqe@google.com> wrote:
>
> This series adds a Rust bitmap API for porting the approach from
> commit 15d9da3f818c ("binder: use bitmap for faster descriptor lookup")
> to Rust. The functionality in dbitmap.h makes use of bitmap and bitops.
