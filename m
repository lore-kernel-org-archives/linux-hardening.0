Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AE4522695
	for <linux-hardening@vger.kernel.org>; Tue, 13 Oct 2026 17:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791911840; cv=pass; b=lV37EvM5ZOx3mqqGQfDgwC3leFJTaAo3C5cnp0WUNY80koZGZtA1OoQbXA3jGJ/qUAVcrTW4JhkY4jmXNm8JfhjscADGou64IhroTeAmILSozBIhA1t0HTfryufDZHxIrdrhhyEru8EdvWcc9+vBWyLJ5KEkYR9oZ1NgSCcNupc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791911840; c=relaxed/simple;
	bh=+XQaT/ideq5TFXn6sLz6MKqdp6lKnHb00yMCE/K7wq4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sQf7xoHv8snWUIHy13a/rVbCHXKQ/oIa0ElKPZB7JlF3y53Ses+uRF9nT4t/T5OhMsoa8c+KfCcUTf6Vjv6tOR7qqbb7qQWbM4AvV5rDUsJ2iHpEVmFYusYsjOxjDndlocowKL7Osbsl9de1efm4JqtX6peWbPppseVHbTOfLBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ewbazzXd; arc=pass smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ewbazzXd"
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-78fb9d46f0aso1734774137.0
        for <linux-hardening@vger.kernel.org>; Tue, 13 Oct 2026 10:17:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791911838; cv=none;
        d=google.com; s=arc-20260327;
        b=KAsIH1a3Syolv+rk9+F7V5oTqiP8R8kv1GPCQOyepMZ8sDZ4JZSr7p8Txh9E61i0mG
         QrzKwzOk3cwRjnD08C9Zh4pLMz05kMtZvcvrpTYuRWk+mrMmrBSyBLC2zGcbH6mczKPO
         VxCiDnbpn0a98VArGqWqA7m8ISQZcMew8aKec366P6PJ06OCRwru6W0xmTw9RgRVi99x
         VBiJ+63+iHFpiBpJbdBSd9nB333WbPsJNpxFxmQoblfrMx0/FCqomY+damaimbEYDwak
         wE5ZMKKXS5iB/d5SGptDAHLlKM5vomjvbYHyoYKjqYO+Kx3MVdGI02C4XWu6BimHIE28
         OYrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DaQpwDjYu505Vk63Cf/nZMg9BHMHTPNDB+uyyd06enU=;
        fh=AqWO8gvJQJ5VQshym+T2HRhEwh5ywALzDBMB4DbxJaE=;
        b=ez54WsZOps9fbQ+zGXqwG/rDxI6Qjz35ALx1dJ5iSNWsv7sQCOvpSD8SAiK7M/XBaW
         QRjBYaTod3xQHIU2z88Qsrnk5u7meQ42kjh6SP9MpBYFAzoLcIgDz9FGtMoJij3fMY21
         o73P29i0fhFjCwMK95VGKIjGfv2y9kyo0p3q/7oeWq6gwrDHAfRLfkgYnXraGp1ngy0A
         N5ElseKcfrtgjl+c6w5srkcFVlL7MAVjIdyV6+csW9SAsrEdNrP3vcyjjfYlQloE6yTh
         m4aMAQblH1BqLHX78fSnTHpr5yp1KMrgPioMFSW4dDasGcsRqU37m7dJvyTJLdd6TbgF
         GbOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791911838; x=1792516638; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DaQpwDjYu505Vk63Cf/nZMg9BHMHTPNDB+uyyd06enU=;
        b=ewbazzXdz4B0TIaXwFKjoKnYE1s8B9Uh4GfmPibXxkFhfBH8hMa0v2uPq5or1KeTyq
         LA3f/QgKh5DdOr6d7zlwo6gbpFMg0qz423CIs2RqhFSq4YO+Xog6QeboZM9V4CGX/6X8
         YxvZp/7mlEdIfFssQQPrkjgntLwZHM1QUFmMcbocmkGJGhJrez3ek/pQzOnerihVCZfr
         rl20nMnWSIzM8ZlQoMzpxToLLRaHRRebaQf7Qf5Nya50UNbvx2hS99yLcCpWP2iP3Kxh
         IMo9hqZG7br5TKwVOBKuQKB4BxoXMZJiifZKvtHn855bFQ591ZWk9isK4ierKEFg7PDp
         REyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791911838; x=1792516638;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DaQpwDjYu505Vk63Cf/nZMg9BHMHTPNDB+uyyd06enU=;
        b=0uchdKwuDZ2KIDXbW6/dQsmWEfTaG3mTtXQ45xn9cvlBp77vvumhrNANd5piOrn/PZ
         4gFscwh52D0BCk/YYLlg0K4MCgEt6IZHmofyFSxMjftz4c3ZQDcb13iPFYaMel6cWqZs
         ywiTh5ql1QtITeIujmxRoeUKK5jsQF3R3d3HywJ0PJk8z9udJxmlth6Hu9TmyoxSFHCu
         K/sdgpQR+1LEvxsFbneVbg044QTAC+vERNAnN+uAxJPDxbxX8MZDphvJhjxNqMoB8ZAa
         vWI+2RQPCmOCYpRhDoo57U/hV54znodyfnOjcsbldwmej2U95PAAAmY+/ndFvzlfRw6S
         FDcw==
X-Forwarded-Encrypted: i=1; AKwUvBwD0yHXWODVsAydZusGioVwjOiPxNSfqN8VqjXvLtUTV9c66vWVo6E1d4ieHwImpGqzIXIGg3StiX6I7tBgJFw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKKq4Kq3gDM0mwHZHSoLUUbry+QOcs54fDlefRNtGrbmmO1Hldl
	Snd335ruYVf2DXCvd08Qt2zByWx2dubIIYcV++LTwT8EyalW+blXtxHe/FxpyR3aBjXj1hqE7Nl
	hayOCWMuHdUNqDLuNMz/WSFjABgw0j6EIEYPM7LoXLx9TyjMpJeGqH8g=
X-Gm-Gg: AYBFou2+HMbgnrd8WAheLf+yRrkNdRX7u40SROrx4ojZnpOOgx/RzVMsUhWA3No7b53
	OuZyUjpDMjq1W0J7r590b1/tfSjSDZOVOfe2/MKwcP/SmhV8+yLnu8kCGg1jqdJBxDVxG7yo4Hv
	+S+/6EElNE3ikR0KkPQtmUx/pE8XAM2+ha7C4H1W1UJmiZgOooPLWJe9yROIhsr7wgH0RN5R+tX
	uysSaHM9aV3i+OOzZdtFMBKZhJEIPmBOmM5xDYhUqnemWawfJVF209lpvZYEXUyB8gnYb9uYMbR
	vOtSZ5ofELso77wCyiJDbtyUt7QcLrhkI3e7YNbDltUdDpSNTCbu3GpFiKPkRyuzVKMd5UJyFiv
	dZPlkMI3FKbUxbcyWqGHs93wZ4AgpnLTNf5o1koN3YanFfWgJl1Pa9QprSYnbueI=
X-Received: by 2002:a05:6102:a210:10b0:7cb:9e72:cee2 with SMTP id
 ada2fe7eead31-7cb9e72cf94mr1843126137.10.1791911837552; Tue, 13 Oct 2026
 10:17:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012205919.4012405-1-morbo@google.com> <202610122028.BB0EDC98@keescook>
In-Reply-To: <202610122028.BB0EDC98@keescook>
From: Bill Wendling <morbo@google.com>
Date: Tue, 13 Oct 2026 10:17:01 -0700
X-Gm-Features: AclHuK_zjWeKjy_Jgf_XC5DPdhU9GiaJNj2dnrZl8y2EXKvi_bVuDtbq67siMPQ
Message-ID: <CAGG=3QUx5oTiwoGbASYrQPZdtA0LGEop+bagegsrdPsrc-_Bhw@mail.gmail.com>
Subject: Re: [PATCH] overflow: Match arithmetic in both parts of __builtin_choose_expr
To: Kees Cook <kees@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 8:30=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> On Mon, Oct 12, 2026 at 08:59:19PM +0000, Bill Wendling wrote:
> > The two parts of the '__builtin_choose_expr()' had different arithmetic
> > expressions. This patch correct it so that both parts calculate:
> >
> >   COUNT * sizeof(*MEMBER) + __must_be_array(MEMBER)
> >
> > In practice, the call to '__must_be_array' is meant to assert if
> > 'MEMBER' isn't an array and return '0' otherwise. However, symmetry is
> > less prone to subtle errors (and far more satisfying).
> >
> > Fixes: 230f6fa2c1db ("overflow: Provide constant expression struct_size=
")
>
> A Fixes trailer implies a bug being solved. What problem is there here?
> I only see downsides to this change: this adds even more layers of
> macros and inlinings to gain the size_add() for a constant integer 0.
>
> ?
>
I wasn't sure about the Fixes, sorry about that. Why not put the "+
__must_be_array" stuff outside of the `size_mul` instead, since it's
only there to catch an error? So something like

  (__builtin_choose_expr(<pred>, <true>, <false>) + __must_be_array(...))

It simplifies the macro itself and makes it explicit that the
__must_be_array stuff isn't useful for the actual value.
?

> > -             size_mul(count, sizeof(*(p)->member) + __must_be_array((p=
)->member)))
> > +             size_add(size_mul(count, sizeof(*(p)->member)),         \
> > +                      __must_be_array((p)->member)))
>
> --
> Kees Cook
