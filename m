Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034AD37F75A
	for <linux-hardening@vger.kernel.org>; Tue, 23 Jun 2026 19:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782241960; cv=pass; b=FVlUBfTjEAAIgK/oecmHLnFRWWGYscql4z6hm2T+iEtj0R6ZMbXyexJG+5HCvrwynm04YGRqiBIAr1LPLEneCm9nYa0xSVK4YbimlMhBg0GJmecgVHn6fiYlQaZYS/Z5aqpasKbNkPqVovYgkUGoWbJmEQvh1CTh04fXXklutTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782241960; c=relaxed/simple;
	bh=ii6MvtTjLi70cljzH6vlCK19qdEyYEgO4Rik7cd/sMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dBpfWXp00AZ7NTBbW1tp/dEHdrA0HN8XpkFtlXZ/KB42GEW6E9V/rq0g32PctXQ1BzGVkZ+9DoYwiyZJudt+cpbd9tQ4IVpiEV8Nqiysd9jn59iZ5it5L4VwrIf8ZqPERUSVwsZA9AedDNcGVI9L6cCg20KaVfRA9zeVQvzA89E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20251104.gappssmtp.com header.i=@amacapital-net.20251104.gappssmtp.com header.b=muhNy7DX; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20251104.gappssmtp.com header.i=@amacapital-net.20251104.gappssmtp.com header.b="muhNy7DX"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5ad4c89ecd8so164061e87.1
        for <linux-hardening@vger.kernel.org>; Tue, 23 Jun 2026 12:12:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782241957; cv=none;
        d=google.com; s=arc-20240605;
        b=NhP60G/3DEhnwzNUBGuk2OmoQWWvXIWekRexwNqyuCvR+IgX23qsoZ4hKnt+0DTHjy
         3kvvHAmUn+PPHCpSMSQALkpdAU9Q1xHLucAc8lDfpNJLlL79sS6JXD1ImiOXPIE2OAkE
         fX7yPYRh3COujqHxO4hC+QS8TCqgHBvzpBhay4HBZTVCzlBTMksSfWpyZfsAo1RvDySI
         E51De24ATjhOiYQ53OX9hi/uBNCr2Zlrbw2vgpFV/+/36PBfT9jTIMGwBDXGmeGVmTyx
         lnybpZpZy/pqsi4b+1cTQxze3nnFejg2A3gnf3ybwoe1jEv0xa7w9eeEBSfN+txgikJZ
         zSDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/vvDwAJenwF6coS01e9xCYrLEyTAVwYfnUT70JedLS0=;
        fh=Tgpk7Sbk9nl2drAk+eckx2lwlBLRdcJpdzgrHcR613g=;
        b=PKg2XIxQb50T2T1XjXxCl3ANHxZmxEmtkZlpD1AMPTORLfNhrBC4T6GG1AHhC4fsVX
         2biCLUm0B7Yhg3/gIrNwgP+oE8QKonmUd7f6zp5CI2rQrn/6Ak04Ex4mBXC6yHmGYRbM
         iiNa0P+Z8KrzB/iHgUZfFdOJObpxJasaUFn7Js5fejjXNf0IdXk2wCQMMs+smdiNh1St
         JierUoroSjUV8g+6Y5MSg9Xx3cjtT0qDc8TbIRdNvgrruaRLnMvX39DLjOngUFTg2kXW
         UJyr5v2ZweO5WElR8BbCNMKiaW2jNky6A5x4jS5LTDpcdGNft1qd5ncifKONNXLuH/CQ
         5hdQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20251104.gappssmtp.com; s=20251104; t=1782241957; x=1782846757; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/vvDwAJenwF6coS01e9xCYrLEyTAVwYfnUT70JedLS0=;
        b=muhNy7DXA2jhxWRc7VjyBLC2W5K+vsw6ky4fhELzH5+mRCNYrMENNAMsiac1FFAwAN
         5Y7j8e33TdHsCW22GLfJnZxalkzwM7GZWN02MUoYYDLU91tQ91K3wGjQo9RiX+9NN9Ls
         al2Xadtgum6dohsjBdSHYFJm99lajb9XcLcpmLnhl+4ZzLY7YoDqjg+6+Z56p/czMQxo
         5DzqbALLVqR3t38rJOEeC+XAe6FvKLOnedaTm2N69vu+ZPlWy6eznEgmzxQP1DLGzai2
         lh4LkfW5orbRHtlQc57Hs7Y4xakKRD9UQaDbbmG4cuuSZ+WUomrh1AJkUW+YJZSrzlA/
         x7xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782241957; x=1782846757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/vvDwAJenwF6coS01e9xCYrLEyTAVwYfnUT70JedLS0=;
        b=WKsaoxlt9L4gzmSfOOCgJqIhvdnvKCMcv7udTaui4bQO8TLFUs5/DzqehgpkallKoh
         U6kXYKMSneFUZ3I5hRtQyLhw2QJVSFD/sxZiZ0J/Hugm98+/RzKoXqcrNlw12S5VJVnh
         4m1wKB7sTSMwXlRckAU0XznNraMZ02t/7fxANAdCuZOPa3u50CTbfG3vVTg/L8ntZYD0
         LOUpwIM8LWKs2So6mDahHjVq1Dq9E9pIkYgG+Bch48xzpUTvokBVMWZIeYD8esGzQboT
         ebgvLM+NJOTcDYFfqWe6E/C6vMDdZS4g+26t6Z8lGJFvm/VTQZaRrYz91fbVfCYpS92/
         eehQ==
X-Forwarded-Encrypted: i=1; AFNElJ87q4ZglwlUup5ERkBxqZiop3DEcQi4ptPbQ/78k0PBMudfmxBouoOE6AnNqiYhAiPvAxcftwuBK7LuBds6EJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBppLDyi6JoIzJSFF9IOMCKPmzsEwbGQy8f3AfgGjtpJDREf1L
	jfA28F1fUclcnHdzdTHWreBl0YF1JC3j6Bo3IrD4KWZBRwv6FpSLO+n7YECGNVKME4s1AU31OEQ
	qIxTI9SU7aJygKYU/W1XY8D0U6rgy6wptDTdu2Jn9
X-Gm-Gg: AfdE7ck/cSOx4QL9mD9gesYsykmtZClzMEjBh1Q+Fi5lyMWqA6Oh5Umx4gITYIwSxE8
	h44DDkkuxFFXWGnkP5FZLcLp9ZrgpF9L0fYvPbVaAxUUeb5sqHDcPRK8tiL6NNTNO1D7Hk/nwX5
	aB6i3fhmtOoQ5LdODnFdfA1wdg7QnE+V8XEeJ70wO3W5JSnxDvjj5IIGwkio5RmxOUuCmIib1Yc
	gJ+dmF7dk6XUj8V5oHhOtu/gPjHD0KSmKn55bt8S1TAbbw+kJtKLKx2YHcUYD6MdyrYhlg4
X-Received: by 2002:ac2:44d4:0:b0:5aa:8822:b874 with SMTP id
 2adb3069b0e04-5ad5771ec41mr4233175e87.46.1782241957214; Tue, 23 Jun 2026
 12:12:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622234803.6982-1-ebiggers@kernel.org>
In-Reply-To: <20260622234803.6982-1-ebiggers@kernel.org>
From: Andy Lutomirski <luto@amacapital.net>
Date: Tue, 23 Jun 2026 12:12:24 -0700
X-Gm-Features: AVVi8CdurCE0Z4nmJzTanxEgxUT-VwvR4nCHq2kkCJY0BXv2CrDitgelAGd8YoA
Message-ID: <CALCETrXPj0u=FZ=aFcZAHk3fFZa7rCuPEjx6cOMXmT3sdkC7SA@mail.gmail.com>
Subject: Re: [PATCH] crypto: af_alg - Add af_alg_restrict sysctl, defaulting
 to 1
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, iwd@lists.linux.dev, 
	linux-hardening@vger.kernel.org, Milan Broz <gmazyland@gmail.com>, 
	Demi Marie Obenour <demiobenour@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 4:49=E2=80=AFPM Eric Biggers <ebiggers@kernel.org> =
wrote:
>
> AF_ALG is a frequent source of vulnerabilities and a maintenance
> nightmare.  It exposes far more functionality to userspace than ever
> should have been exposed, especially to unprivileged processes.  Recent
> exploits have targeted kernel internal implementation details like
> "authencesn" that have zero use case for userspace access.
>
> Fortunately, AF_ALG is rarely used in practice, as userspace crypto
> libraries exist.  And when it is used, only some functionality is known
> to be used, and many users are known to hold capabilities already.
> iwd for example requires CAP_NET_ADMIN and has a known algorithm list
> (https://lore.kernel.org/linux-crypto/bcbbef00-5881-421b-8892-7be6c04b832=
d@gmail.com/).
>
> Thus, let's restrict the set of allowed algorithms by default, depending
> on the capabilities held.
>
> Add a sysctl /proc/sys/crypto/af_alg_restrict with meaning:
>
>     0: unrestricted
>     1: limited functionality
>     2: completely disabled
>
> Set the default value to 1, which enables an algorithm allowlist for
> unprivileged processes and a slightly longer allowlist for privileged
> processes.

In our brave new world of containers, this is a bit awkward.  The
admin is sort of asking two separate questions:

1. Is the actual running distro and its privileged components capable
of working without AF_ALG or with only the parts marked as being
unprivileged?

2. Is the system running contains that need the unprivileged parts?
(Which is maybe just sha1 for ip?  I really don't know.)

Should there maybe be two separate options so that all options are
available?  Or maybe something between 2 and 3 that means "limited
functionality and privileged modes are completely disabled"?
