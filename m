Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E329E24215
	for <linux-hardening@vger.kernel.org>; Fri, 26 Jan 2024 21:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706304185; cv=none; b=T4XGVvpsvVsfhB/K0L9ndz7tDScqRnu0I1yI1/RjCetZ3Dpn3pduqW6Z8lB+pFZwVUgtH838RIiz1uEbUyMVUYFvbTylCpzvheM1XwjYYrt95gf+GXN3RQkugKhev0aHzT8kxpfNn16M42fLZlqxGdBlGEJGO1hjsf3m2TvYOFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706304185; c=relaxed/simple;
	bh=OHfGdigSiNuQI05LLiv9w76Mce3WFxHYfN3o31XlRzA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ik1TnsW8zTWXAYHL0cCEbbBPxzT453++4rJDQJCbD5YWKI6ouKR2POum0enoevlR/KAWBZ2efuBSLQvAWN0rPLeB+L2nYmG7aZZ37WsDL65cfVy2m/Chbq2La+qG0XxFthC34CR+JrjhtUOD18eg7H3MuzXVvjqcJdH4VXbV2dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=U0M6Gsdy; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="U0M6Gsdy"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-55cc182da17so707365a12.3
        for <linux-hardening@vger.kernel.org>; Fri, 26 Jan 2024 13:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706304181; x=1706908981; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VzYJT0Ks7UjMwY3R/pERVBkgLI/CNkWYntnCR1F4u48=;
        b=U0M6GsdyQN9TsQveMaftLDoDFt2370idMTezWhmwO7b6XYdL4eK8ckFpmXVvnvgJSa
         l0m9kfWOOCoxwU3tCXYmsSMKr1twwsNO8xFs16dWcabeDVKCxmUfQud6zkkaBfYc3oXh
         yWjVy+VlWnq7st34206/WsOoKkv2a9CDu3T70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706304181; x=1706908981;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VzYJT0Ks7UjMwY3R/pERVBkgLI/CNkWYntnCR1F4u48=;
        b=De1ZS69nM4F0cPmJ8RczGQZxNiYoUKjfRj21N9hJUEhPHwx0h0Lk4kdK33Evp+pkXl
         0fvN8WjAmWpGl829J+me3SDjQDynowVs54B3PrXUW5jueydIkijOfdqGpMMAJoUKBE0S
         xHsH1Zi2FaSzXxVSISLSv0lP2dro99UN0+a6Vr/sHnYiuBVcrofWo1UUmCFWA+eLIgTp
         j4jBP3gbIH1++zoeRpsEUrQhnucu7aLXgHBJU5UohQS5go69edWgK5NODzEJEndwBE/Q
         fTq+r++7qpsoYFyrr7bgzxm1U1yIGm+BI5P586oLAYFSRs0bAofusCui/kP7Pkj90HpR
         tMHg==
X-Gm-Message-State: AOJu0Yz3tya7W8tFjrvTj7JXUYm9+QgE9gL2jIgg/239ZcVW9rKtROZP
	lUyqVJAAC7TPCvwerR2hdRSVegFRKZBxrcYyKOMzyrwK+JQJ3VBkUJTTO+hI/2nBj2F8jP7mXxD
	3P6gy2g==
X-Google-Smtp-Source: AGHT+IGeJgzGPlUNU2qLiJQSvQmmc4/xJ7KzAY6gZhi8bWOosiqMxbWCArEDYxkLyIEeSlkpL4P87A==
X-Received: by 2002:a50:fb86:0:b0:55e:af69:b7d1 with SMTP id e6-20020a50fb86000000b0055eaf69b7d1mr51858edq.21.1706304180860;
        Fri, 26 Jan 2024 13:23:00 -0800 (PST)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id fj11-20020a0564022b8b00b0055c69e0751fsm970643edb.3.2024.01.26.13.23.00
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 13:23:00 -0800 (PST)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40e913e3f03so13208835e9.3
        for <linux-hardening@vger.kernel.org>; Fri, 26 Jan 2024 13:23:00 -0800 (PST)
X-Received: by 2002:a05:600c:5352:b0:40e:4179:d060 with SMTP id
 hi18-20020a05600c535200b0040e4179d060mr323434wmb.65.1706304179586; Fri, 26
 Jan 2024 13:22:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Za6JwRpknVIlfhPF@work>
In-Reply-To: <Za6JwRpknVIlfhPF@work>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 26 Jan 2024 13:22:42 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjG4jdE19-vWWhAX3ByfbNr4DJS-pwiN9oY38WkhMZ57g@mail.gmail.com>
Message-ID: <CAHk-=wjG4jdE19-vWWhAX3ByfbNr4DJS-pwiN9oY38WkhMZ57g@mail.gmail.com>
Subject: Re: [GIT PULL] Enable -Wstringop-overflow globally
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Jan 2024 at 07:29, Gustavo A. R. Silva <gustavoars@kernel.org> wrote:
>
> Enable -Wstringop-overflow globally

I suspect I'll have to revert this.

On arm64, I get a "writing 16 bytes into a region of size 0" in the Xe driver

   drivers/gpu/drm/xe/xe_gt_pagefault.c:340

but I haven't looked into it much yet.

It's not some gcc-11 issue, though, this is with gcc version 13.2.1

It looks like the kernel test robot reported this too (for s390), at

    https://lore.kernel.org/all/202401161031.hjGJHMiJ-lkp@intel.com/T/

and in that case it was gcc-13.2.0.

So I don't think the issue is about gcc-11 at all, but about other
random details.

             Linus
