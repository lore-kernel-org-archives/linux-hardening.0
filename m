Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985107C6DE
	for <linux-hardening@vger.kernel.org>; Thu,  1 Feb 2024 17:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706809969; cv=none; b=tMHeIIxfz2XF8mz2MfVzEMomxjXVBKgev4CbVAtq13dPVpcAc5GRKgyT5R2BJuKcNrqzAX6D7Cyhy9/1y7n3pSYw39P/Xo5VAup1QwXABD34PHCWX6Ifx2/1lm7/zVcx2CVsr18mqQxpreSBhIV6Ej+q4dwoC7upYFvVomcDEtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706809969; c=relaxed/simple;
	bh=lIJSSJQHgI6dPqglJX+BpS/xv1aEFSMZz/COulwXiUY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U50bfRgk/IM5aZLh5oQ3woOraSvn4nznwnKMH8XVuWBLNcJa0g07vcBUbP4yMDgcfjclPK6dbQhmHy5C9JwAGx2XHmritPngkz4LbFiwfSSwh+XcchCiG4EsSu08hlfEiJBim+yXGv4q5YKDQN31WbdeVfawkWfKJaWu/BVLWJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GjA+1bOf; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GjA+1bOf"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6de28744a46so888572b3a.3
        for <linux-hardening@vger.kernel.org>; Thu, 01 Feb 2024 09:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706809967; x=1707414767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oeB/5jBcZmtDcrKzl0YysnvyegKxpdljcraOQkK2rDw=;
        b=GjA+1bOf0PHXpamV9zWbxgGlKY89zH9SKsbJWVgbc6GrPlgcTLmIbX602grQlhL1Jy
         LCdTG5yOn4cZZsvGGEzXqhuX3LMSDiLkLU2Ihy9MEJhzeTLFZRu93yDkrIkqGJCbvRrt
         Hzgyn9apx6GsEd3Eb/V6VE/LXcxDIcLlrOG4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706809967; x=1707414767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oeB/5jBcZmtDcrKzl0YysnvyegKxpdljcraOQkK2rDw=;
        b=njreBeIkE3ugSkJ9MbveIGXpTlkzINRtNXuL9cn9cMQ0jnyIsEscUEIyn8Ugd7mCvy
         elgL07U8scHDcgTQsfHhVhpyxoobVJp2DU5NXHjHqVu1tdWqK9hQMu6U71yU8rcmF11t
         8ggPE+g+aIXOBUHYTUDAe2CeCxEjg1S4xcH8ZToiogJQKuexAqM4kt5+/dT01wf93FZA
         o0bYI3Rel8N7NDh5X7DFfRWQZ9Gsu9mEmWJHQeLPMBj7eIp8ZkEkaJ8Zdm3OAfrPqXjK
         QCCk9a19bO3p/qLxqSbE+6gVQ/YIy6UlFUgSSreqI9/5CLg/jTyMqqqDqoRWHKddP7ln
         +Riw==
X-Gm-Message-State: AOJu0YwC1igp0H95KiTK9MKeM/Yeq8XNR2BnXuEZyNr1LX00yzwG5ipi
	0lWLjGQJDtIcRHa2dR+0ZLczS4O87ovhgyskaCU0gWHGRbVedemmdwrUuCbpsA==
X-Google-Smtp-Source: AGHT+IFywQN1VuW1cJxTCfwWkXxphyAozHQiCzAAuSTqK+KpTMUrHhQklPCAnJl9YxQODGS8sDGZEg==
X-Received: by 2002:a62:f242:0:b0:6df:eb95:f50b with SMTP id y2-20020a62f242000000b006dfeb95f50bmr1998531pfl.11.1706809966859;
        Thu, 01 Feb 2024 09:52:46 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX+hPHocTN3Krdrwx2BAO45nqlHKtddyMcZedxVYNqfzp1g5llrSQ77t/t9540v3ksZVJyxQHtPp7krFRWB79cagtGUcq8AeS2fk18vBwQA2d1Wxj5V+bsCqzxwezYa7X+BNRsEjRuA/DD5VtS1iXq9O6G7yNUp/ZLFgvOLS+nnsn7Imahnj2Zf0LcZ/e/RxzPcoteP0ppMFjLjaYdlU9LM+9f19epNvqqjUk279j7/+ZLgKsnTnB5zzxGMAcwvNfd/ZARI6PYz8PTcHSfYa8MANfTeAB443UY+Kl+gFLoC1VvSo7sXPQZvKjZIP5CDlrpicY1s/1vQEd5uHQJEK1Lzz0LMiP+z8Qlgw31NG5qePmuYhJasxqV5
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i1-20020aa787c1000000b006ddc133f1d3sm12700pfo.194.2024.02.01.09.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 09:52:46 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Nick Desaulniers <nnn@google.com>,
	Tanzir Hasan <tanzhasanwork@gmail.com>
Cc: Kees Cook <keescook@chromium.org>,
	Andy Shevchenko <andy@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	llvm@lists.linux.dev,
	Al Viro <viro@zeniv.linux.org.uk>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v6 0/2] shrink lib/string.i via IWYU
Date: Thu,  1 Feb 2024 09:52:00 -0800
Message-Id: <170680986503.3370813.7406880929037173095.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231226-libstringheader-v6-0-80aa08c7652c@google.com>
References: <20231226-libstringheader-v6-0-80aa08c7652c@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 26 Dec 2023 17:59:59 +0000, Tanzir Hasan wrote:
> This patch series changes the include list of string.c to minimize
> the preprocessing size. The patch series intends to remove REPEAT_BYE
> from kernel.h and move it into its own header file because
> word-at-a-time.h has an implicit dependancy on it but it is declared
> in kernel.h which is bloated.
> 

Applied to for-next/hardening, thanks!

[1/2] kernel.h: removed REPEAT_BYTE from kernel.h
      https://git.kernel.org/kees/c/66a5c40f60f5
[2/2] lib/string: shrink lib/string.i via IWYU
      https://git.kernel.org/kees/c/38b9baf19469

Take care,

-- 
Kees Cook

