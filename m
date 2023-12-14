Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C4267214
	for <linux-hardening@vger.kernel.org>; Thu, 14 Dec 2023 21:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UJW8IdkD"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-336356d9092so2044571f8f.2
        for <linux-hardening@vger.kernel.org>; Thu, 14 Dec 2023 13:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702590717; x=1703195517; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rOabXrlOXjqrX57IkkKunmqQB/BmDJw6p6tK+zWvuCw=;
        b=UJW8IdkD7HRT58E/yhMWFNFypy56KxSOvJJ0aKJm4q2bdG2wU9oQo+Wa0TlgLaoIiu
         fHYN+QuCpQWufQSNAMIOKE0oXENCxs2EDgtQ0DDHhUskr0Bhg2Jz56frO1oFdehQKzQR
         46hShijm0eJwqhi/3KHRe+nHMRMjOIRvJWfC3nuIcUZ8cwFoBqKqv+UCNSglrlD9lXBF
         mJWw4yi7wkuO2rjUwb+P9f6Oh6QosaCGyswhyatwNLGDY5HbMAQMdGr1T/Qky6t1wfNZ
         F2Up/dujXnqbTXAx85PfLg4vix9u5fM1HxO16/gc7Ml6CR6jHE0XZ7gvEAUZmDTAjgrg
         QLWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702590717; x=1703195517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rOabXrlOXjqrX57IkkKunmqQB/BmDJw6p6tK+zWvuCw=;
        b=kulpZpLJTH1UP0B5am1fCtTHtum54bc12bu2B38R9Aujf1Q5rAcgwECmhn6hwirBgN
         72n32pZJtz+UwKWjv9SAxFYB/vwQWDh1SP2uUn/g5aATLVJJlI7hjMVvaw2W3yVadAhm
         xkpoQuK2+DTznBlez6JiL5Rg9OrdW74k3KxXhmYTNJS3AU67cuLzPwY0fQIiLKjYLkWj
         ox2gCpQRtEps+MD07V0wSmz8MnLFaDBwL/B7M1k+9OBb3Trt6V1z8sXHPpTICTaFa7ng
         2qKlFzg3kUn4a2HyZZfR2pjaialOiLUq+kT0y1q9c75xhmzu++wU02367MMp8xzTmeUF
         Wtqw==
X-Gm-Message-State: AOJu0Yyn0ec+igRdyY2Du0IMHpBEhLG+KYMKlr4y8joyCaalckRUqx4q
	WDyZZe1x8pVYBEGw3AOKTeFsryKfaB+pkErmIQ3nvw==
X-Google-Smtp-Source: AGHT+IGvv9efW+y/4IqkFfsVa8A8WBMmusTIeXCwcuPoUh7g9pdWpzigy7UbMTXDI58NPnBVHdZIE65yxJAA/jiM73k=
X-Received: by 2002:a5d:44c8:0:b0:336:42d1:2c27 with SMTP id
 z8-20020a5d44c8000000b0033642d12c27mr1564779wrr.53.1702590717001; Thu, 14 Dec
 2023 13:51:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214-libstringheader-v2-0-0f195dcff204@google.com>
 <20231214-libstringheader-v2-1-0f195dcff204@google.com> <202312141335.45C785B0@keescook>
In-Reply-To: <202312141335.45C785B0@keescook>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Thu, 14 Dec 2023 13:51:42 -0800
Message-ID: <CAKwvOd=XqPmkqkK9MsCDEhMWdXDQgeatL-+UDfnkNRDSycyyKg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] sh: Added kernel.h to word-at-a-time
To: Kees Cook <keescook@chromium.org>
Cc: tanzirh@google.com, Andy Shevchenko <andy@kernel.org>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Nick DeSaulniers <nnn@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, llvm@lists.linux.dev, 
	Al Viro <viro@zeniv.linux.org.uk>, Justin Stitt <justinstitt@google.com>, 
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 1:37=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
>
> Also, please double-check your email configs: your full name is missing
> from your emails (it's just "tanzirh@google.com"):
> https://lore.kernel.org/lkml/20231214-libstringheader-v2-1-0f195dcff204@g=
oogle.com/

This is the issue related to use of our internal mailer with b4.
Konstantin fixed this in b4 a while ago, but I suspect the version of
b4 we're getting from apt still does not contain the fix.

Or perhaps we need to switch to pyenv and pypi to install a newer
version of b4.  Tanzir (sits right next to me) and reports his version
of b4 is:

0.12.3

On pypi, looks like there's a 0.12.4
https://pypi.org/project/b4/#history
Looking at those release dates, I'm pretty sure Konstantine fixed this
particular issue in the 0.12.4 release.

(I made this mistake too recently, with my latest commit you picked up)

Debian stable says it has 0.12.0 https://packages.debian.org/stable/b4
Debian unstable says it has 0.12.4 https://packages.debian.org/unstable/b4
IDK where 0.12.3 is coming from. Perhaps our internal mirrors are
lagging behind.
--=20
Thanks,
~Nick Desaulniers
