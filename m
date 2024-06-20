Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8125E7E107
	for <linux-hardening@vger.kernel.org>; Thu, 20 Jun 2024 21:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718918031; cv=none; b=Sr1MLq6ZEn1uquoWq1sSxxjD4/B4PxU7mZic03m6frxhlYdo6hMKyQybABmHeCUnA8g9Cy8aQVLXsce67L5FbrltqRzAaMx7HPT1TFZi8kt9WAQcjDfEakT6yVJ+mR9J9KrN+6GhwXzsK8WV3iXeX3huGJpWTSzj3u94i4ZTd4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718918031; c=relaxed/simple;
	bh=/XhhmhhowDYXjOJixYSeA/pTMAKP6y9kWx5xd+g6HSI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TWK8Ycmd/9L1Qkhr512NMPiiAx7DoeISOexj/WUYgREyBXFFmG7Tc0nJrR07tJiDBLbQzxdkOE/+VAp+2CoXGbUmQXvNu7n7uilDOg5R6+PRO+g2sLCJqTjFeiJ0MMidM0vInGulTu2VINYFkOZ1isrrOyySOejKYey+PFhPHD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2teeYkrw; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2teeYkrw"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52ca342d6f4so2281e87.1
        for <linux-hardening@vger.kernel.org>; Thu, 20 Jun 2024 14:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718918028; x=1719522828; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3J5efzHbrBSBEUK5Mw1SAdOtVm61ZWMUI1FF8AD69eY=;
        b=2teeYkrwq4d7hQgYPLM8sQgVwStRk2Wbxca3QqACfhyCeSet4np7WykAlsovLTxTgP
         gevqBPywOzZ9agMGpTlAGbn6elyE5FZ0Z4fVwnCbr4vTlk5QUYiGUyR1X20N5/3uBV1X
         HCIJzLVOXhaSboWSDvnCLaSr/B2U32TevWL2sPwp12KADsqdD013l6rDOd5GWC7ZJCyA
         lYcxUxxyopA7/CGd39IdHCJ9RkOhsLoKUVItTi9ROpp/x5/aE6QVVEnIe3/Gvvj1MeQZ
         d6bd+bWrR+CVVUIgH5OlXkMzWKWQN/Lu7Dy6DSAJftpxzfaeJ1URnU3NeDjWMl+uBr8q
         XCkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718918028; x=1719522828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3J5efzHbrBSBEUK5Mw1SAdOtVm61ZWMUI1FF8AD69eY=;
        b=wwcQ8v4s3G6BYc26I48/56EMxIeEjdo0Y6Cg2wMWatTxs/yffjWw1EPnANWSxlnx89
         wlH36blyxHB2JP5wH3jt8UXEu6Q8/ADgb90W5SZennj4fd1DV23foWVPpwtafc9mjtM4
         /ml8KrqS2+B5uglCUvlEZbY5tvfwKz7+BBHK2CcH7lcj8iIjbA1VVlDFoYNJdGyXi+lL
         uqR1xw4JAnyJHwTKV15P0UdfHDK+p7/EQUr39CsvOXj9C6A5MO9VC2+rzVxVOdQJFr7g
         rZhEqCbjiG+6xmp5C9WnDH1ApzkyfOLkzztw5FNZBs1kTN7BELhn+ADSyEf5V5Jzf4b6
         3YWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVN+eY6NBr7U20KYEyCOPlDVxw4pp8PossqNOjJlADG2JgV7t8tGNe58xy1vIuLML9KWN5YQo9om4M7sNI3pBInyttIHwzyQBE2TGI/J0gc
X-Gm-Message-State: AOJu0YwKdPYpD7dBOK8NeZW64EnBLewI1RLYcbeZv7AIQpg/9qH9Jgk3
	fL9Z3AxXCQBAShEz7tydZUsUqAtEeJaDdL0zUczx0nZbM5hNDafZpi4BlonWdZ24nZDB5SCC2jm
	vy+gIkcxut5jlrJYhYrrhA7NvdFh2QwluVnkc
X-Google-Smtp-Source: AGHT+IEn8AqNmJKcntBraToyOLUgVbU+xEWQhtkU0QjCiHRU8X5rQAoXIzT/mO+rjYRWXps3yrWu2Ehhip3ibGm/BdE=
X-Received: by 2002:a05:6512:acc:b0:52c:cbdf:f9ed with SMTP id
 2adb3069b0e04-52cd46a7379mr147587e87.0.1718918027535; Thu, 20 Jun 2024
 14:13:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619202511.it.861-kees@kernel.org>
In-Reply-To: <20240619202511.it.861-kees@kernel.org>
From: Rae Moar <rmoar@google.com>
Date: Thu, 20 Jun 2024 17:13:35 -0400
Message-ID: <CA+GJov5ZpFxKxK44SAb_B8SzWUF9uQV13A8BcVPijo0CV0mStg@mail.gmail.com>
Subject: Re: [PATCH v2] kunit/usercopy: Disable testing on !CONFIG_MMU
To: Kees Cook <kees@kernel.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>, kernel test robot <lkp@intel.com>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 4:25=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> Since arch_pick_mmap_layout() is an inline for non-MMU systems, disable
> this test there.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202406160505.uBge6TMY-lkp@i=
ntel.com/
> Signed-off-by: Kees Cook <kees@kernel.org>

Hello!

This looks good to me. And seems to fix the problem. Thanks for the fix!

Reviewed-by: Rae Moar <rmoar@google.com>

-Rae

> ---
> Resending as v2 with Shuah in To:
> ---
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: Brendan Higgins <brendan.higgins@linux.dev>
> Cc: David Gow <davidgow@google.com>
> Cc: Rae Moar <rmoar@google.com>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-kselftest@vger.kernel.org
> Cc: kunit-dev@googlegroups.com
> Cc: linux-hardening@vger.kernel.org
> Cc: linux-mm@kvack.org
> ---
>  lib/kunit/user_alloc.c | 4 ++++
>  lib/usercopy_kunit.c   | 5 +++++
>  mm/util.c              | 2 ++
>  3 files changed, 11 insertions(+)
>
> diff --git a/lib/kunit/user_alloc.c b/lib/kunit/user_alloc.c
> index 76d3d1345ed7..ae935df09a5e 100644
> --- a/lib/kunit/user_alloc.c
> +++ b/lib/kunit/user_alloc.c
> @@ -30,6 +30,10 @@ static int kunit_attach_mm(void)
>         if (current->mm)
>                 return 0;
>
> +       /* arch_pick_mmap_layout() is only sane with MMU systems. */
> +       if (!IS_ENABLED(CONFIG_MMU))
> +               return -EINVAL;
> +
>         mm =3D mm_alloc();
>         if (!mm)
>                 return -ENOMEM;
> diff --git a/lib/usercopy_kunit.c b/lib/usercopy_kunit.c
> index 45f1e558c464..e819561a540d 100644
> --- a/lib/usercopy_kunit.c
> +++ b/lib/usercopy_kunit.c
> @@ -290,6 +290,11 @@ static int usercopy_test_init(struct kunit *test)
>         struct usercopy_test_priv *priv;
>         unsigned long user_addr;
>
> +       if (!IS_ENABLED(CONFIG_MMU)) {
> +               kunit_skip(test, "Userspace allocation testing not availa=
ble on non-MMU systems");
> +               return 0;
> +       }
> +
>         priv =3D kunit_kzalloc(test, sizeof(*priv), GFP_KERNEL);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv);
>         test->priv =3D priv;
> diff --git a/mm/util.c b/mm/util.c
> index df37c47d9374..e70e8e439258 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -484,7 +484,9 @@ void arch_pick_mmap_layout(struct mm_struct *mm, stru=
ct rlimit *rlim_stack)
>         clear_bit(MMF_TOPDOWN, &mm->flags);
>  }
>  #endif
> +#ifdef CONFIG_MMU
>  EXPORT_SYMBOL_IF_KUNIT(arch_pick_mmap_layout);
> +#endif
>
>  /**
>   * __account_locked_vm - account locked pages to an mm's locked_vm
> --
> 2.34.1
>
