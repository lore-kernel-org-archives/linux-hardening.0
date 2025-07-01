Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F100275841
	for <linux-hardening@vger.kernel.org>; Tue,  1 Jul 2025 13:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751377336; cv=none; b=FLXPyrJAJlt6Q11amGfBPT8ItMRMEaGjPBcnqR3qLjZH5OLEHXD0MG/OwkvlmrGxioWBndMViCPANE1Fe5MaqRh/lPGUAc3JRsj5ZdPkg1weUge27pruUYoeBJFiToOapTZWiMPY4o8ZGRiujY6kMMYLaWKwAwVMnduC/Mu51RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751377336; c=relaxed/simple;
	bh=l53+up7iBS1qHbvga47bs+kjEPQBMaO+IwNLLfxJzHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zs3qviEttahx7Lgtoe/2gI0twB7/O0B+xJ6bbGPTOAMy5ZnwYByEouCLIYnFzbz+w+gtaVOYGUbH/q7UD2TjOjCES9XNY8brGChIGXiHqMECirCcReAeWcgh7zWwMo2MCmnvPgrJsTVmNtBImu3KkBvXztspa++2k58rR0QWL7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cn+EjoAq; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cn+EjoAq"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-609b169834cso11720a12.0
        for <linux-hardening@vger.kernel.org>; Tue, 01 Jul 2025 06:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751377333; x=1751982133; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l53+up7iBS1qHbvga47bs+kjEPQBMaO+IwNLLfxJzHo=;
        b=Cn+EjoAqBbrDKOfHp5fqDsV8kEgPUGw285JhOjZ8uP/7i0GbWrbUpgLNlLW34DtA4q
         MTJ6FlH0sXf54PZREy6eLHI/ihyM63WmqVu/5uauEPoojPr52i9n+o5OOevidosts15h
         2zplKgeEc32bX7p0t01+roQ5cVe+28Cd0MSgaNTGLGE3INRPizQZVm2KfZkQE/8lF6Go
         SaD13qUc9LOLkF0DOxeXlZpAqPAH9Jc3TMyyXNrcbtS8AINT3Q1yiKltsHXoWODJwqNe
         2hel1RQ7ruaQILFo47Zo+jKo05d6DYp+JX/BS0uK0e7jAmckYNYP7cxgBw8Dfp16MFKp
         HDqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751377333; x=1751982133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l53+up7iBS1qHbvga47bs+kjEPQBMaO+IwNLLfxJzHo=;
        b=Li9lykeMk5L/9Sc7Ra7AyFCi7IBpOSxfZhiIcf5wjih9Xp4bGK00NcY8tQVH7ikWvG
         8do7LO8TxyeL11Q5C0ho0b0uHrPK4BSBKAm9D/mnBDpGhcnkdhF8kcFp2aJnSD6ZqPfd
         kmHLppDWFOyews/Cq32iVMeAOxg9jqLm89KF+aiiLLSSGEQAN4hUQinWetOEyJeqcOTn
         RyO0iQUglJg3k1d2GctsdeQAOCI49e0GcU8YotsMHE4dqw/Nase6EZI/A173pwsi9Xmx
         LcYyQvfod34VTSrQXClLXyKYVN5K+UoZ1fqUYTv3tWJOJeVAzzj+VkdWaLBh/naNP+oO
         4v3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWSNeUCiLNiMzKqNRH8xGAhgUzyImtC3zsvTY05cfYj4udbdxOagrUkb0t9+gH0Gg9LYcmGCfHz48mkrPNxDfs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFFAoWHLDwrjGMK7Whxb3d/IxKfxYcFPbvVMw8LVh1SlJU7n2N
	H6FUl1lkM9TyxBwV2LnImYvk7ZRqAzHmm65GpaZSZg/ojIFBiV3IHkofAk5/MUU4mab0Rh+MnYF
	UOO0DURteMQ5gdbfWhgs1aT+oYobcuY1x0aJSjt9eJZTCpjV467YOIW1YmOA=
X-Gm-Gg: ASbGncsw55i/H9jj2ZhNLr4sAl2sqAdTmm51VVoK3RrOQyHL6a0/TrSg0+XCuLRjmVt
	/iWklYcKd8/mHl99gPTxkrsfWjPzbY0rUk+2Ca/e/iJNp+ohNp4ljaK5dIQH6knT/RZzMSlzfC/
	g8DLsPYHRN0joc3yopC9ALrcSay83N8/44O5lpMnyUogsEmu7SnwbPjGbepmHCgkuhyd+B+nEMZ
	XdxQXKxUA==
X-Google-Smtp-Source: AGHT+IG8i4Y7S9H/asInCH7TGD9/vuiOqqrIhQdHNEBY4YIe1hmb0pRdeOhNZmNhr9/Rh8lPWDairwcma09YPdiesMs=
X-Received: by 2002:aa7:c342:0:b0:608:fb55:bf12 with SMTP id
 4fb4d7f45d1cf-60e38a44816mr71027a12.4.1751377333023; Tue, 01 Jul 2025
 06:42:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250628234034.work.800-kees@kernel.org>
In-Reply-To: <20250628234034.work.800-kees@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Tue, 1 Jul 2025 15:41:35 +0200
X-Gm-Features: Ac12FXwCp_bfivLffFtsPlz6EADiU4bpUi0pVVqVqpSbuvTlWBItorTjM1ha8VM
Message-ID: <CAG48ez0n1E0iuOxPe=jq4MuuP3w2wMSNixmfNmBbB89jyJBSbA@mail.gmail.com>
Subject: Re: [PATCH] kunit/fortify: Add back "volatile" for sizeof() constants
To: Kees Cook <kees@kernel.org>
Cc: =?UTF-8?Q?Jannik_Gl=C3=BCckert?= <jannik.glueckert@gmail.com>, 
	Nathan Chancellor <nathan@kernel.org>, linux-hardening@vger.kernel.org, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 29, 2025 at 1:40=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
> It seems the Clang can see through OPTIMIZER_HIDE_VAR when the constant
> is coming from sizeof.

Wait, what? That sounds extremely implausible/broken to me.

https://godbolt.org/z/ndeP5chcb also suggests that clang does not
generally "see through OPTIMIZER_HIDE_VAR when the constant is coming
from sizeof".

Do you have a minimal reproducer of what you're talking about?
