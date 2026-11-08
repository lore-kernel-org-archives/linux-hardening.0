Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794153200;
	b=22iN+fHvFl4g104SSUSlYx03TBQ/llS/dbEzhwdR/iitQniy88MyLURsLAM00QELbsJF
	 03mt/VJBAx8im5BP+o7jrfpMeYgd+rTldZ5af0fvPOLcXmt4q0FQURpxpYQWRPgNvxjw8
	 9uWiAfNAApiGgjb/ym+B1p4sp1RbNpY3SpWPqJreRO6KWHon9MreGBOaYiME8lWBJ2mJE
	 wH5yo7DRD+5uAn5uanwNleufuBjn0Ki1bKSVBfg3ckios7LlO+mE8lpWVjOFEVFT3q0IQ
	 Gjl+0WPI9qnmhHTJQ/PRDTB8xy4x4DFuafT4ntTbdlttNFQuUlnNxe0/owLSINHlxmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794153200;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=/S9XJ5Sf+ha4mJ4om/24R0+J7GuBzOrBmWjf2t5Bxd8=;
	b=AsNvje9oj9C0GHm2Z6/S8iuNwLsN+qZFyjyPY6V83odtiMJ2FNUZ/vbwORrM6bm5hAw7
	 nvPoBWt3ow9OZ7NXfsKYsqvCAoul4GO5IfIaMNkt1oFY0W+pZHHy7JAapAI+KB6g9o1o0
	 cojnN888GvPLFUmvwQdxNpaYQg6qCpBN+zv00VCGCo4fsGXvFjhG/NXGB79rVe4WAlIhm
	 xe+N+LuXROYRo2OIBW28qI3FzkZDpvvMUpB9aWT63QrSJg/67mxMukP39ZEu1cZMuQlOb
	 sZ9J71cNmmwEqnk2Aahpqw54GM6QxGrtBSWZflOvofEKS4GhqwiZuSO6Dd2kWG540uA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cFJVzurq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536E7606A31C
	for <linux-hardening@vger.kernel.org>; Sun,  8 Nov 2026 15:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cFJVzurq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22EF41F008A7
	for <linux-hardening@vger.kernel.org>; Sun,  8 Nov 2026 15:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794153200;
	bh=/S9XJ5Sf+ha4mJ4om/24R0+J7GuBzOrBmWjf2t5Bxd8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=cFJVzurq9HbKbqEWGxr01b1RQqds6QMtBC1E7K90XsZMRtQnK9HSjS+nFUW7T7IsP
	 1XCemhABaTppK7yZQGG/tAkmTDOtTiq0yPwAV66Cc5PQxt/PxinItvHkqIDsSgKzGb
	 NaIHxPjkAoglzLoYp9V7yVVDLWYfRHZtS3BpRQUhwXHoRB0Q0ZEZFIZx6wiIPQ49uJ
	 aaLuW0CDkXvmDBYbhqDT46xbhfycfXg6rGn2sOBzT1r+m4tTApb26Q2Hrnx20etEdl
	 9PdohjnYg224/l+HXjePyqzQvx+azdRrtWzz77DZrjauVgsRBfdLndiQkNy6f2rJwG
	 /nPBWtWszVooQ==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5bfbc25a76aso216112e87.0
        for <linux-hardening@vger.kernel.org>; Sun, 08 Nov 2026 07:53:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErG/arMEs1ZVmtCo9CJNcnwixjQnDEAV/8HrPQPjNjRSoLHatjGYJn4ObMQCyPcvrQsrKlhz1ljZ1ozLFKIjDN8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/wq9ZhqtAqgFH8W+HbtsR7lq9+IALRw1VjNSEzM7VUi4t3p8Rl
	lW10DiNovp0G2jSr8j0rx/F3h1lboZ6lVoMj16/s07aXhik3pIaA9UxqDdAe5MNdd3NYjFY7DKR
	qLu5OwxglRrf8ixumPPEVtI7Rwf68Clw=
X-Received: by 2002:a05:6512:250d:b0:5c1:4f4a:68f4 with SMTP id
 2adb3069b0e04-5c14f4a6a11mr46761e87.32.1794153198892; Sun, 08 Nov 2026
 07:53:18 -0800 (PST)
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260928063824.1386524-1-morbo@google.com>
In-Reply-To: <20260928063824.1386524-1-morbo@google.com>
From: Linus Walleij <linusw@kernel.org>
Date: Sun, 8 Nov 2026 16:53:06 +0100
X-Gmail-Original-Message-ID: <CAD++jLkm-S_0oDt9K1xn5kOVp7f6KwG7y7nCNE2asD5K69M=PQ@mail.gmail.com>
X-Gm-Features: AclHuK9CiXVomc9vdDMRXSjLJTZjnIEg_krpNQUFLmn-Tbw0yt_ODEgP0qy0xbA
Message-ID: <CAD++jLkm-S_0oDt9K1xn5kOVp7f6KwG7y7nCNE2asD5K69M=PQ@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: annotate struct acpi_gpio_mapping with __counted_by_ptr
To: Bill Wendling <morbo@google.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	codemender-patching+linux@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 8:38=E2=80=AFAM Bill Wendling <morbo@google.com> wr=
ote:

> The 'data' pointer field in 'struct acpi_gpio_mapping' is associated
> with the 'size' field, which represents the number of elements of
> type 'struct acpi_gpio_params' allocated for 'data'.
>
> To improve bounds checking via CONFIG_UBSAN_BOUNDS and
> CONFIG_FORTIFY_SOURCE, annotate 'data' with the __counted_by_ptr
> attribute.
>
> Analysis of allocation, assignment, and access points shows that the
> pointer is never accessed before the count is set, which guarantees that
> this annotation is safe and will not cause runtime panics or
> false-positive bounds checks.
>
> Cc: codemender-patching+linux@google.com
> Assisted-by: LLM
> Signed-off-by: Bill Wendling <morbo@google.com>

Prerequisites handled in EFI so:
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
