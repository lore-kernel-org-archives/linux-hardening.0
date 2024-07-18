Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE599482E2
	for <linux-hardening@vger.kernel.org>; Thu, 18 Jul 2024 06:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721282670; cv=none; b=puAbVf1AQKN8Y+jnGSjaxsUBY/Wcv07Ci+cD3gGq0Qn6t6HLhVl3JSym2MNE7uffA85Lwuyd6/yziD4ILuqjAOb29A+K9fSHGhxZZbdH0mOsuZPP8wsXlpxu4TZAU7iQHhH2cIzNalrCEVybYBIqzscDEZlVdbAoeGRWHZiOh+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721282670; c=relaxed/simple;
	bh=QfTgL/I/TgLu6XUSR3k5WsBkx8SZ5zYCe55lbljcCCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EnedGX3+89WV/VgWzl7Yq+neJsL/AZX0iEJquMlZJbm/PzZu4kFSlJ0RTH9bWKf2KaCusRRSTJew704CjTitogT3EP6VQI8as+jaIf6sCjbBrlu91JQQ12V426LNrnEZuMdI/dwoQ96WD5Zqk0QXDqpEomKeheZqZmEBCAilQEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vg2BP8zB; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vg2BP8zB"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-44a8b140a1bso201541cf.0
        for <linux-hardening@vger.kernel.org>; Wed, 17 Jul 2024 23:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721282668; x=1721887468; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E8scQbL3ojunFA2vu6Mm/M82C9xFWuPlbVxUojeYRbc=;
        b=Vg2BP8zByNYsIcilvDNp3aJ4K2xIlWBe6F7zS+/iXd+NSylIaYHadt7LYTSUAKxPx8
         nvczGR4d5p4pH/9Ft4+gE4RLYugTr0WZkaYF1mgWnWUqt8pC9vQS0nEiWUbE2G3aztW0
         dTdwX4Eun8LU5hmrHNi8kv6YqGA+osM6oYayb8xasHpmKHjWo+C+0tq4uRhzB4jL6jMx
         wfkWbr2sUTM+Vb/7TJqtMARAo8EdXKynsoSxEQHwdGAuCdxkCauOL+mHNFTh7xKQNQu9
         Y+x2Erf3XG6Ft6zQQHdj2yAzeAPaIfiImJ4EZfFPSxLxpODSafsEVjoyH+KxzCJcMnvq
         t1Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721282668; x=1721887468;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E8scQbL3ojunFA2vu6Mm/M82C9xFWuPlbVxUojeYRbc=;
        b=QGFv+GrHR0phjeq4IUctfMMfygXFS3cng/9qyIUhMu76ZDGZ6fyWv/HPLbPYHVsg4a
         TBKeYSRVwzAgemAHs+4T/gBktD2TzwCx176GLSeWoiE+IUZljK5HInVPuWQB+wjnQKtR
         LDYtL/ANeQbrW3wcus2GA10R1IICgZUhourFNj77WvOBGwQen+z4tjaykkVmPQLd6zEF
         FZbekK3ZUflz5FRigjcPStsAfXMzuMj8JPTNSURko7EhBbnWkL4HunW8abtD+JhojNYr
         GShp6iJkajsF/EkFzA/F+aEkWS82hgkywIvaXqMlP2ryAyMjzrkTs+1xHRAMN1/mc5xr
         /KkQ==
X-Forwarded-Encrypted: i=1; AJvYcCW87MVm08BtNifNepbULRs8XdBbj+C6VCY5QeIiDWh5aRdg2YlxS5sa0hvICv4Pbn1SU0TwXzgN4mk+6QuEQhEs8aMOwsAg74TmKRjOLznY
X-Gm-Message-State: AOJu0YwkXqeMyy7UkTex4qqVeDp3qPnb6BgsaTt1RJmJBlHHHsFUD7Da
	byWao+syyYDQPZMOYYhpiayPKvleYa0uONzhTc1Tpn/QJdyGY7KFRH7+LVGS3Odr13xpqpqWcDq
	XyAAbZVbq6VEg31Fp5m/qXOFYWR3mKSG7zQF3BaVhmkuQ57Yicqtc
X-Google-Smtp-Source: AGHT+IFWiSFqWtqZYfC0jy++zn1iek0Vig5wz8pSEdHMvDV8US/DapjvjgpSBDodO3pWivnkdS9LQpK1eVFmUnjjxIc=
X-Received: by 2002:a05:622a:4297:b0:447:d78d:773b with SMTP id
 d75a77b69052e-44f919d5b5emr1331311cf.6.1721282667643; Wed, 17 Jul 2024
 23:04:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717212230.work.346-kees@kernel.org>
In-Reply-To: <20240717212230.work.346-kees@kernel.org>
From: David Gow <davidgow@google.com>
Date: Thu, 18 Jul 2024 14:04:14 +0800
Message-ID: <CABVgOSmKwPq7JEpHfS6sbOwsR0B-DBDk_JP-ZD9s9ZizvpUjbQ@mail.gmail.com>
Subject: Re: [PATCH] execve: Move KUnit tests to tests/ subdirectory
To: Kees Cook <kees@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Eric Biederman <ebiederm@xmission.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Jul 2024 at 05:22, Kees Cook <kees@kernel.org> wrote:
>
> Move the exec KUnit tests into a separate directory to avoid polluting
> the local directory namespace. Additionally update MAINTAINERS for the
> new files and mark myself as Maintainer.
>
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> I'll toss this into -next and send it to Linus before -rc1 closes.
> ---

With s/_test/_kunit (once the docs changes are sorted), this looks good.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: David Gow <davidgow@google.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-mm@kvack.org
> ---
>  MAINTAINERS                      | 5 +++--
>  fs/binfmt_elf.c                  | 2 +-
>  fs/exec.c                        | 2 +-
>  fs/{ => tests}/binfmt_elf_test.c | 0
>  fs/{ => tests}/exec_test.c       | 0
>  5 files changed, 5 insertions(+), 4 deletions(-)
>  rename fs/{ => tests}/binfmt_elf_test.c (100%)
>  rename fs/{ => tests}/exec_test.c (100%)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8dfbe998f175..35474718c05b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8211,8 +8211,8 @@ S:        Maintained
>  F:     rust/kernel/net/phy.rs
>
>  EXEC & BINFMT API, ELF
> +M:     Kees Cook <keescook@chromium.org>
>  R:     Eric Biederman <ebiederm@xmission.com>
> -R:     Kees Cook <keescook@chromium.org>
>  L:     linux-mm@kvack.org
>  S:     Supported
>  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/execve
> @@ -8220,7 +8220,8 @@ F:        Documentation/userspace-api/ELF.rst
>  F:     fs/*binfmt_*.c
>  F:     fs/Kconfig.binfmt
>  F:     fs/exec.c
> -F:     fs/exec_test.c
> +F:     fs/tests/binfmt_*_test.c
> +F:     fs/tests/exec_test.c
>  F:     include/linux/binfmts.h
>  F:     include/linux/elf.h
>  F:     include/uapi/linux/binfmts.h
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index 40111451aa95..1a032811b304 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -2152,5 +2152,5 @@ core_initcall(init_elf_binfmt);
>  module_exit(exit_elf_binfmt);
>
>  #ifdef CONFIG_BINFMT_ELF_KUNIT_TEST
> -#include "binfmt_elf_test.c"
> +#include "tests/binfmt_elf_test.c"
>  #endif
> diff --git a/fs/exec.c b/fs/exec.c
> index 5b580ff8d955..5a59063c50b1 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -2244,5 +2244,5 @@ fs_initcall(init_fs_exec_sysctls);
>  #endif /* CONFIG_SYSCTL */
>
>  #ifdef CONFIG_EXEC_KUNIT_TEST
> -#include "exec_test.c"
> +#include "tests/exec_test.c"
>  #endif
> diff --git a/fs/binfmt_elf_test.c b/fs/tests/binfmt_elf_test.c
> similarity index 100%
> rename from fs/binfmt_elf_test.c
> rename to fs/tests/binfmt_elf_test.c
> diff --git a/fs/exec_test.c b/fs/tests/exec_test.c
> similarity index 100%
> rename from fs/exec_test.c
> rename to fs/tests/exec_test.c
> --
> 2.34.1
>
