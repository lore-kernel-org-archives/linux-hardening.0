Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE3E1E98EF
	for <linux-hardening@vger.kernel.org>; Fri, 21 Nov 2025 19:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763754404; cv=none; b=YnSNWomsXnZVyPU3kP8fyrbBsm1KEG+ubXH8F18eDsNoK8TYgek6SILrkT2Zgk82Y+qAo79+leRVTo8/Xw96JIX3YjKqpXq/8+k+j853oGgvM+uEfJapHDWpaJd4T1sHH8mnvFK3dnmEsGCrc02rxvtUI6rn7F92KCXcc33tg+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763754404; c=relaxed/simple;
	bh=yUuMHZhtam+fWQpdtjevcS7n36pGZwwGi8DKaiYIIvw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ao9/5cXSXh9RvxvJL7qhijEmekGiwcVam3uHDJBN2qns8uXkwldl+CXa7R4sYfLOmbyxENoSpKCcoOyLhyn4tIsNDMR02SlGmEHyXnEm9cQW1fGMsrxic/mPs9ypu/EIWZhKTKknQdJMTkE4zINm1xzvi+P7wl6n70tszkn5clk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k33golpS; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k33golpS"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-644f90587e5so3791551a12.0
        for <linux-hardening@vger.kernel.org>; Fri, 21 Nov 2025 11:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763754400; x=1764359200; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3n1zfzwkLtLkmv960SYF4qIg8dCLJqHxMdIvlW/MVpE=;
        b=k33golpS2X74CETL/48zENsGx6s6sD44c7vcTDwx+c5IyKS2awdAlYV7q7KJSb9z6s
         ugWjMNVbrQv1CNEgrAiZ6uQrpvX0Yoh7M0vAag/Rh6IpozJ0MkWe+6ZIrtvgSY68inkM
         7aw4DMn7r3cBrC9pfswn/o11HQOpm4srS3XtloNY53FmXPGBj9kMCemK00D7HOSm7EKI
         Id7r9VbcU53/itWUIwqMCZKuFw9ANg5It/OyUR9eMjVnfBXGTnQrgLrR4s63tGY4pPG5
         J/rmk9X0F2PauGMhejV2bboQg6TueF+0bWwr+cvD2om2wJ9GD4/WvmVeuTocUGrBRCV8
         GSAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763754400; x=1764359200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3n1zfzwkLtLkmv960SYF4qIg8dCLJqHxMdIvlW/MVpE=;
        b=OuoPCAisR8St1PgnM7MeLCKSkGQ4mRfGzHYCpisGuXbRwfnsDpy8akOcpV23qy/uSN
         Yd7jhY4dD5SHD6ZpeJHcTRiInGNvo2xaBtW+dgQRP3Fb0WGxf9mBX8vfM23WLTPL6KJt
         LpSUiZLuvy3o39ybjN6DBZromv2MpdHOzVkvPUV/stTCrC5dwVANFKsbrTnKQCvxga0G
         BWBd2Wrh2gwb+p7ZL5PqjGqoCMYG+qabIh3qk2UGrhAMCd72F4cxc0Ss7vDWlaibys0d
         de0m2wEYgAwyGEK2pN30xGoDD9u6s3vwky+2PWjbQiHYn5Xn9fl/M3Ze2bJsjDt6JzFG
         U9uw==
X-Forwarded-Encrypted: i=1; AJvYcCUvub9UIaGxrSU1yjBdfCXH3O5hbXCcy479iFbobH1aVbFAz+JLILMKHAUD+kcnTZ5yL72lll3ISEKtXWSPXHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9WtChXBczJ6+Jw1NF4NQTjWYMhSA2xnvvolnkaI6qqp8giKQn
	tOiPf1oYbOOMgnDQgecHquxH+j+lK3sb6xAffmwn122gh3Vl7+BF5OHzGehUzVSJmN4OWhwCxjQ
	m6hEBT8S1d3v/LSaFrGCajx8LkIr+UR0c4kUfdiY=
X-Gm-Gg: ASbGncuC0G3KjfNTunyO8O3tNOqE1S0RrULSAX4czJFzST5xy0QuPOg9gzb7E3q4+gh
	fKFZ7IEiMdOhHH0LTeJ/y7UOOS794d/wm7+fmxAMjVtkO28Mmk5ddMRdXz0Bu3fHBRsS58HOJop
	jQiPu4mS6Hve7mLHcRr5Y2FCwj81/2Qo+x2Tnj+BAqQko13dgFUCMbtSMLuu1vNNW7t1gyk2apt
	V3iu0jdJHe7z1JfNuGFscIUxoO+ynEqlcX+tHciwyEoNqYj9iYxjLi5Y/EuPXd50Fd2V5Iew9qu
	wzU=
X-Google-Smtp-Source: AGHT+IHyGNwFxSOsJVHNF9rBcAbH6iyf9ovr7WPCBabxzYOfhXb/7KvRkBvNpN6IUsxw4XRIqODC6kJJnpdcIfMRBbI=
X-Received: by 2002:a17:907:9449:b0:b73:8e7d:4fa3 with SMTP id
 a640c23a62f3a-b76717076dbmr362946666b.32.1763754400259; Fri, 21 Nov 2025
 11:46:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121193957.1655580-1-morbo@google.com> <20251121193957.1655580-2-morbo@google.com>
In-Reply-To: <20251121193957.1655580-2-morbo@google.com>
From: Bill Wendling <morbo@google.com>
Date: Fri, 21 Nov 2025 11:46:23 -0800
X-Gm-Features: AWmQ_bmeMC8hpTDqlITfeIZJQkkK-IBh1b3rq_uwnqwXHiE_zh-zaWgX9rzYzq4
Message-ID: <CAGG=3QXOTNaYJMNVB_6p4OF58=u5GFgZ05FAwOLRWGfuqLo_2Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] Compiler Attributes: Add __counted_by_ptr macro
To: linux-kernel@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Justin Stitt <justinstitt@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Marc Herbert <Marc.Herbert@linux.intel.com>, 
	Uros Bizjak <ubizjak@gmail.com>, Tejun Heo <tj@kernel.org>, Jeff Xu <jeffxu@chromium.org>, 
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	John Stultz <jstultz@google.com>, Christian Brauner <brauner@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Brian Gerst <brgerst@gmail.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, linux-hardening@vger.kernel.org, 
	llvm@lists.linux.dev, Jan Hendrik Farr <kernel@jfarr.cc>, Qing Zhao <qing.zhao@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2025 at 11:40=E2=80=AFAM Bill Wendling <morbo@google.com> w=
rote:
>
> Clang and GCC are expanding the '__counted_by' attribute to support
> pointers in structs. Clang has support for it since version 21. This
> requires defining a separate macro, '__counted_by_ptr', because, while
> the attribute has the same name for both a pointer and a flexible array
> member, minimal compiler versions need to catch up.
>
> The effect of this feature is the same as for __counted_by on flexible
> array members. It provides hardening the ability to perform run-time
> bounds checking on otherwise unknown-size pointers.
>
> Cc: Kees Cook <kees@kernel.org>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Nick Desaulniers <nick.desaulniers+lkml@gmail.com>
> Cc: Justin Stitt <justinstitt@google.com>
> Cc: Miguel Ojeda <ojeda@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Marc Herbert <Marc.Herbert@linux.intel.com>
> Cc: Uros Bizjak <ubizjak@gmail.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Jeff Xu <jeffxu@chromium.org>
> Cc: "Michal Koutn=C3=BD" <mkoutny@suse.com>
> Cc: Shakeel Butt <shakeel.butt@linux.dev>
> Cc: "Thomas Wei=C3=9Fschuh" <thomas.weissschuh@linutronix.de>
> Cc: John Stultz <jstultz@google.com>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Brian Gerst <brgerst@gmail.com>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-hardening@vger.kernel.org
> Cc: llvm@lists.linux.dev
> Signed-off-by: Bill Wendling <morbo@google.com>
> ---
>  include/linux/compiler_types.h | 11 +++++++++++
>  init/Kconfig                   |  5 +++++
>  2 files changed, 16 insertions(+)
>
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_type=
s.h
> index 0a1b9598940d..2b0251bb951c 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -351,6 +351,17 @@ struct ftrace_likely_data {
>  # define __assume(expr)
>  #endif
>
> +/*
> + * Optional: only supported since clang >=3D 21
> + *
> + * clang: https://github.com/llvm/llvm-project/pull/137250
> + */
> +#ifdef CONFIG_CC_HAS_COUNTED_BY_FOR_POINTER
> +#define __counted_by_ptr(member)       __attribute__((__counted_by__(mem=
ber)))
> +#else
> +#define __counted_by_ptr(member)
> +#endif
> +
>  /*
>   * Optional: only supported since gcc >=3D 15
>   * Optional: only supported since clang >=3D 18
> diff --git a/init/Kconfig b/init/Kconfig
> index cab3ad28ca49..298c94c4c1b1 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -139,6 +139,11 @@ config CC_HAS_COUNTED_BY
>         # https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D108896
>         default y if CC_IS_GCC && GCC_VERSION >=3D 150100
>
> +config CC_HAS_COUNTED_BY_ON_POINTERS
> +       bool
> +       # Needs clang 21.1.0 or higher.
> +       default y if CC_IS_CLANG && CLANG_VERSION >=3D 210100
> +
I mistakenly left out GCC from here. I'll roll that in with v2.

-bw

>  config CC_HAS_MULTIDIMENSIONAL_NONSTRING
>         def_bool $(success,echo 'char tag[][4] __attribute__((__nonstring=
__)) =3D { };' | $(CC) $(CLANG_FLAGS) -x c - -c -o /dev/null -Werror)
>
> --
> 2.52.0.rc2.455.g230fcf2819-goog
>
