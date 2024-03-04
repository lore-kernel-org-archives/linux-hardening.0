Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034EE5C603
	for <linux-hardening@vger.kernel.org>; Mon,  4 Mar 2024 16:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709571198; cv=none; b=UpBGmeVDAam9+mEF0qCBlL4gT0bkLbNW38Gi1lbQGMvmjNM4jjOeoy7dzrfeya24/b/9IyDlHoM1UrDrOP7rBTXKC/HCC+jCfec2Q+bcRds21lCOrUy3fYGGnjomBi0VpxAqLKkeaFAdI2RryknbIGxNIFlKWUc4/AFDUEATJ3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709571198; c=relaxed/simple;
	bh=uirtXHt2GRmTN/MJHpx0AE7MnBAQPCAKYbtW//3AYqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jmsWtKwibkzkyj/5f0OU4DGaaKoIOORUAGclW+Kh6NW4FZGw4tMStaYVCFypWFEomn0uuvRjyHZGmKWQ28qubbwb9nbyLU/9uRfen6latcaady9zBALX+plEL/2ndGaTa6NMpk+VHGMzS6DrJ7wt+iyIgm0oe+42cDeQRjnlI2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oJHNJCZy; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oJHNJCZy"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-412e783c94fso5588855e9.1
        for <linux-hardening@vger.kernel.org>; Mon, 04 Mar 2024 08:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709571194; x=1710175994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lmfK1qwaZeZanYojHD0RUbXhDuCbIKpAYEoB7wzNyKE=;
        b=oJHNJCZydzgvwwg0pPpvODiubSxP83AXeOYfrOvYNRX1745RjAPD07MslMP/m9h9bf
         e3eDlVl9yBqdMb56ueaTtMcFXIm6+iauxnmcIbZSo70xHzjrHHcJZoBrHJNMJ/kForqH
         7TwD0b1oxFKSEclLU8+bJEcic3qG/iwr3vCfCVSwpde71J5EFyF/LwtqfR4/P8hqGyCo
         XGxokaKsOuEQ4FpVgFLgDw5Yj9THP2+COyHlHzt1l3i08sMq1+CSWRRxcUtsexcvjJtg
         LIcdGmRXl+GqZXv0Gmz6P1mDaryOOIdIRdRI7zWrREMx6cm6huCsUc7hQObUGD63hDXi
         t7Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709571194; x=1710175994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lmfK1qwaZeZanYojHD0RUbXhDuCbIKpAYEoB7wzNyKE=;
        b=ak6jI/1QWWK3cjzdh8gGueI2cv8L7Hfl1QF5yt8YVyk/FFbsybsZL33AOT9UVQWmJU
         0jXziPQf4ygZYf5IwUTP9dZDFd8GPU81wnFepNsY6zlYVOjg+fYMOsnK0d8AfpUjo6XY
         uhP53ONwHVrq+443pyjrgia/Li7bD5O4s84lDMMjlCa3Q2OHyXgR3+s8zdZGh2mJTbni
         /aBMt8U38+pKCfm9q959BPQnFPtzkdhFHMbDXO4Qjd6wmcc8X8xcT7q104GoMW660p+R
         Y0xtaUEpkofyzKtKmJJ1GFT/TlEYudDx9K56P6Tr6dGqGZ6SUAGZ88RaGWHcXOyh4uIS
         k3kA==
X-Forwarded-Encrypted: i=1; AJvYcCUeoPd8A89Ijk1l9cHrf4G3LxDrU+oaOhBfaFc2CW0S+YVkQOcHRwEUMQ3UQSOLXM4Ca1eFl10lMXOFOIc6+XarD4qdq8/UkQb5Me0qBhGN
X-Gm-Message-State: AOJu0YxRQnOW4A+eBZg+vJeu8d5b2lovyWWv3VH0WD/LN3ZSN8fuog4R
	+4FVnRg9elTOswCsWxeGkZ3o+WEZ8fJjogFZ1JTHOyjkUXwHnPmolwsbH2/aj1zgtcZ/1HrcPVH
	9EPnZIJE9KfuyeTnXO1+m9vBSMdA/vaMTu42w
X-Google-Smtp-Source: AGHT+IHO0Vyyj9NTmtrzCpdzXYPsNb82jFuB6Tek6U/mE6kJNdZ0Szp7dN5s8m6Is2RH0XDeJ4uHDoLAJmI7qfo9wFU=
X-Received: by 2002:adf:a441:0:b0:33e:4524:e473 with SMTP id
 e1-20020adfa441000000b0033e4524e473mr993953wra.50.1709571194160; Mon, 04 Mar
 2024 08:53:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301044428.work.411-kees@kernel.org>
In-Reply-To: <20240301044428.work.411-kees@kernel.org>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Mon, 4 Mar 2024 08:52:58 -0800
Message-ID: <CAKwvOdkzQCSM1+Z1mRphgu3Vs8SdiDpgxywWiO_OHn+S_Z6UwA@mail.gmail.com>
Subject: Re: [PATCH] compiler.h: Explain how __is_constexpr() works
To: Kees Cook <keescook@chromium.org>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	Jani Nikula <jani.nikula@linux.intel.com>, David Laight <David.Laight@aculab.com>, 
	Martin Uecker <Martin.Uecker@med.uni-goettingen.de>, Jonathan Corbet <corbet@lwn.net>, 
	linux-doc@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 8:44=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
>
> The __is_constexpr() macro is dark magic. Shed some light on it with
> a comment to explain how and why it works.
>
> Acked-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Is Documentation/kernel-hacking/hacking.rst perhaps a more appropriate
place for this block of text?  Perhaps as another :c:macro: in that
file?

You know I'm not a big fan of increasing header size, even if it is
just a comment.
--=20
Thanks,
~Nick Desaulniers
