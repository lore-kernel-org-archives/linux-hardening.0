Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CE83D45E5
	for <linux-hardening@vger.kernel.org>; Tue, 13 Oct 2026 13:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791896851; cv=pass; b=mf7EVB1vfA0af6nHZrZmAIw7JK21+SAVduSdPMu1+r+13KtQV/skz+ZFns0vg5bqChjvgkhiB7vG117rT7bIEIDM1SFnExf+50J9+UKAYXoROBmr1wZIhGqxeW7aWcEN9tWu6ht/TzzSvFAo1oKFKH88SUqVKfJhYJzrBIlfnJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791896851; c=relaxed/simple;
	bh=6TiVNxxeDpdSAagBOty9+KDqgyZClTo7hXYVmhdgD4I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NCeIQYNDrpInemnx6UIwMhdGQ+DerSy4y7Lb0qQ3JT3Loqe2l+3sRiTemij6lm2kD2bOaytIYVBUfE8nYxC/dzRZV/seNzGHoVUUnl0dx3LsgvPfyuE1umAWe40xdJxK4w3qtkp7+NXyWNy98uyfee5O+jXuQ4lDOnfBn/AvEK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ChCnLLDN; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ChCnLLDN"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-67921b515a7so2395951d50.2
        for <linux-hardening@vger.kernel.org>; Tue, 13 Oct 2026 06:07:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791896849; cv=none;
        d=google.com; s=arc-20260327;
        b=PclFhWc8g/46lv/zZWlVtF1OKGrFNd0qQ4GkaF0XepmKEAPad1Q6M/baLMQmy4hHPR
         o2LzeaPgCGimriUWy45R5dYAdp7Kmpj7s0LhTLBsIhDR8PnTyl0sXVVnp3iyRsHa7DeZ
         MLRCG0lhLjKWsZeiAJds9ro1y9jJIIHwctvHz5sWqfNrqoyNZhefhlDwvJ5MBUqxqG3K
         DHHaDE4fapwRz9Ir3cLYSnmWQt/GHjb9OIMPvkacF3AZMfMwhvNy4KIyuVz8G5U322DB
         Uk2QQPxl9ztORqqYzhvB57ymBDl9WkGvYo149yttcw/C0lGdAXnRXIPw6uAkZuc+j0Z1
         C+JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=0ncwg+itbdhvll8NWmaHzhsCbDAbH6eG1xlYXFmq6Oc=;
        fh=lFTUH6YfmHaTKvYmMZzchECMg9WtKS2YqQlNVNoH+ok=;
        b=QDe77cZUq6BkMvpXJEcpGmZZUMH4QdlSzTYv3FDwGHbFrK7c87v7SW8uR7mZKcRqVj
         T6KXEC6Sd7xGn5xAMR/E4Xe9pJouAJqzTY+J8y8mx1WVZS4+/QVdGvIEylUOjrgEQY8k
         FDEpBrkq1L/neitS+9uMrJQN4AdSqDXMyk93mhT8CRCV35OgJAAaJfluMzn0t3nUHDX8
         g/Xi/5g3E9VTLvLz/cVB/+M481V+AecfDDDsHnVdN191hdjBxWCg0VXDk99Xn2F8fEXM
         5WdpwIb2XBiv502a4/e5sv+u5zS+aCNiiWYuY1BUrE4TvtJ/c2lFA4IP2CREIIC6ZWtX
         p16w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791896849; x=1792501649; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0ncwg+itbdhvll8NWmaHzhsCbDAbH6eG1xlYXFmq6Oc=;
        b=ChCnLLDN0HrodCru/tKtCUmKXKNwgnQaCvvNBUByqdBDCIQ3mkdmJCGpAeX3jAxF+P
         R+Oo89B+esq6iTJ3eV/5t9BE3qRS4VEfVQi9pgkqVmt4FF9u0zfVTTj7wNlyRpw5BvvI
         1TEhSMDZDbfk1ZIu5DcPfBqeOQ9+Q5Itab85rR0g7WWrIEfGe/WNZG9HXPiuVwi+skLr
         jFZPFRbq4J1Qi8pJaIgXl//pZnHFTo44Vhfa1DRyF/xMxs0LWZQs6rQYxpDRpQr18P35
         WhU23F57sI9D02Hzcp/l5i0TMBs4CxoJxS6IeQ9yyTueHAm8+WDXoDYChnuDJEmpQVhE
         xF0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791896849; x=1792501649;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0ncwg+itbdhvll8NWmaHzhsCbDAbH6eG1xlYXFmq6Oc=;
        b=oXnlvyFvdEAJ8cllQGJu6aW2FLnYbbW0Ts5NQtHtPVN9HaaODXE3fNRcTYf/6IIj3F
         ZXPDEVW5CkSu1ihWApp2cY/fQ+uvIG60iamfYJKnCETihiEEv/Dhs/hJWCISx9iQF1ZB
         7blJ511knDG9BO8WddnSj95nPR1MbbhBQ2ij+mzm2kHE5RXWDqeGEUVfxdcRnDaVM+Hy
         4iYW6r6wjY2clBv5AQUn1PthohmDILm2k/B9mXbSShlAskrj1gdjuAouF/sBMNSvT9eK
         ilPKtiZXi25fgQTyO8onrVa4IGpmT3mWgF4zLCL+Bve4n5mmEGjUSSracfqSNLJESAE4
         BJTg==
X-Forwarded-Encrypted: i=1; AKwUvBzDrcdIctpwMe4rFuuevpDnhwjFIaAigZDLlEKSzqAn/fNgOVsdgpSfLr4qb6qTksxeOSJbDmuBmBAQqC5quQY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJNq2cwJtqd3VrLxrR36td6ro2Q5t4Q2NKKvCSPeFVkzGyDvBTx
	R3RrmDJtYN97+YsUYAAhSbQSZq7VKD4W2jQFkcGvk3Palt6eQ7vLM7fMMEFGNLxwFfkHnWx2El6
	vHgB4R83XvM3R7lElcAexZkeHYLy6JNw=
X-Gm-Gg: AYBFou2bAWU8TcQwBIA5bbbpt2/QiM2eDq297lvisY1eXTQe9PR1IwLJXmpQ83xiWYz
	l9fSwskD5u8MXCI8KRjCwhfxXY17teaOxUenrLphkRvnS66+dNDLRg/lfcXb6JyRZq2L1nn3QiQ
	vpXNHT1owACItzXngTgG64vXn5KkXj1xeUeVtHxVwW5q3Sx+9/v5PuBAXhLkIpZWc49LbSYcbt2
	dfOFeJboFpJfDRiNcSEk92Bj4TgtE5yqjJMCfWpSXQ6onuXbNp1aHuPf66mIPDjC3DCMyhwFJ1I
	s4L6mIG4JPBj+xwIeJILs4YkzfM2VD+OhSttk/L2w5TlFcHNYametlkSHHxMh+kcrJ+ki6hUdVN
	vGah3Iv5n
X-Received: by 2002:a53:ac90:0:b0:677:aa92:7596 with SMTP id
 956f58d0204a3-679362b5a2amr4638672d50.67.1791896849528; Tue, 13 Oct 2026
 06:07:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261007-b4-landlock-fix-domain-fortify-panic-v1-1-042e9108f5f8@oss.qualcomm.com>
 <CAKwvOd=nPgEm=AZbEu12Eb90GtRUThY6YAjSiHHuNVHP8TZHwg@mail.gmail.com>
 <66usntltyie7ii2rrqajy3izxrvwubwf2vqnery552v3akhwo2@xwb4t76d37wx>
 <CAKwvOd=E7wgGPf+kgOY8sGi0xO-cFMAJK4PMBFknoEupJi1CXw@mail.gmail.com>
 <20261009204554.GA778522@ax162> <EF8E7F67-39BF-4382-AB18-98E9D6111CA5@kernel.org>
 <CAJJ9bXzLgzZG+836_2+pUVOWzndSFNoOh8Xu8Pw++_i1RMJzOg@mail.gmail.com> <20261011.Veiquevah3oh@digikod.net>
In-Reply-To: <20261011.Veiquevah3oh@digikod.net>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Tue, 13 Oct 2026 09:07:17 -0400
X-Gm-Features: AclHuK-jtD50bA_uKkhScngguvSwky5SkR9YZhcx-GIvRlFpZZ6iWS7kxU1PPVI
Message-ID: <CAJJ9bXwBo2hqcov46pLykJcdWp_fO8r7bXcDEw7JdZjWVkRxaw@mail.gmail.com>
Subject: Re: [PATCH] landlock: Move the domain layer counter out of the
 anonymous union
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Kees Cook <kees@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Abel Vesa <abel.vesa@oss.qualcomm.com>, 
	Bill Wendling <morbo@google.com>, Tingmao Wang <m@maowtm.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Justin Stitt <justinstitt@google.com>, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"

mic@digikod.net> wrote:
> Thanks everyone!  We also received another minimal patch that I rebased
> and applied.  See the final commit:
> https://git.kernel.org/mic/c/3d8cc52db2f86b624308321c58513019f6b21eec

2x FYI

1. I boot-tested the clang PR in [1] and confirmed it fixes the issue
on rc5 and rc6 before your patch

2. I boot-tested rc7 after the pull on clang 20 and confirmed we're
good on this side too

Thanks!

[1] https://github.com/llvm/llvm-project/pull/228309
