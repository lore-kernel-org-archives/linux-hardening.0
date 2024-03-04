Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0110045942
	for <linux-hardening@vger.kernel.org>; Mon,  4 Mar 2024 17:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709574004; cv=none; b=mW6VkhEe3rMEuhfn8+cSiR3kkPg25J87qhxqlh3/spjHta4ggV8d7WhueJ1LthrUEoESyOkl1HXTah9POozx0cGWuGg6Raww6mBOj+Y34w7sp+PMOJx0VaPcmU2ayMg7l5Ayel5zm8SYLnsaKzvNo9aepEgyPM6N2dvAtlAbypo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709574004; c=relaxed/simple;
	bh=vvUOD0CFjw9j0T2nZIns184UVZGkZxXpItCCB1Xq4zY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jlh2eA/ODtQYmuA7/RtWMrhKga6pgXlForD93xJ4hpEM13+64d82Joq31IH6lf7sRb2+kQy+kw1AoYlkWi363Ia6Q1DlkYd9GSm+Bmm3jJ03AEevOl8XiemFYGvtkUPbJs7OZIuKfNWs01+/XRI5RcWPPA4Rkt4nz5RIveAB7fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KGQRTfXF; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KGQRTfXF"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e617b39877so1154957b3a.3
        for <linux-hardening@vger.kernel.org>; Mon, 04 Mar 2024 09:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709574002; x=1710178802; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RyZsHAo58L7KMnZ/iYkcv6g6DGnJjygri39sflW2A24=;
        b=KGQRTfXFACD7/rggYCxUumWi8IGfDY45wgYkCRYIvS4yhX/bXIrkjH2Rwe+xMeaw2f
         xdp/Rt8Wpi5FTEYBnXO3+kcShFHxWJhseJxpDhrnYQtlXoSgdjBWW17uAiMuU0oyuVwm
         3FFoD60rcV+iglREYO6qdsxsvbHIdjTdyyOXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709574002; x=1710178802;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RyZsHAo58L7KMnZ/iYkcv6g6DGnJjygri39sflW2A24=;
        b=TJccCVbszbjT4aREb4Q+ZSeBXhwz3c179xdRoKCkm/Z15JG4rwPDXYlE/v/QgmJzEH
         Osl59EAWQ6/CFxx6J3SAMho3rB+BL3IgHtqpYJkfd6/pLUnzLUL7OKKiwT8uIU642w1z
         kBm1Hjoo7SXZjK2gT0HmviivhkpoxN+uj9ZSZNf5VI/IdAc/0zRoX9QQvKKl6UDOsMlq
         UinwIKJC1cNxX1m4JmvbzfpDu9fzhhSZtQtBE2NJ5EoO/o92JQ705yBwi/6XJdUVrrB0
         WEYiFqiMfCYQ+aC+0J9WjZWVeWngFqnp2j37ZtuW/cfBHQV5FAttn68oTS7g+h/Rdiul
         KlVg==
X-Forwarded-Encrypted: i=1; AJvYcCVxSwiWG7AM6+gaEG1/5ts1zd3zfaZbyAW7HBLf0i26P6NLk9jPb1+P+ZaMXqdxx8Cj3u5Lm6oj3r26zbij511VaPwXUa0jcPs/VbmirO43
X-Gm-Message-State: AOJu0YwDzpS2vs1qwOL2RCg6Ki62HaXvVHIv85zzMrI6mDQyteFQ0CIM
	od2w+KOVK4Ac6lhKMsj1flqRUYjOgkDahUmBu30ckj8IDdfgXP1VFy67zIZ09g==
X-Google-Smtp-Source: AGHT+IGQ7bchTfFmOCc/+mlkhCkqHxq4az+ZQyntLHbRLi0vYhRoD1GW4l+IVJmIASmmaG0WZgoZEw==
X-Received: by 2002:a05:6a00:4b02:b0:6e6:279e:3dc2 with SMTP id kq2-20020a056a004b0200b006e6279e3dc2mr2611552pfb.25.1709574002161;
        Mon, 04 Mar 2024 09:40:02 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u20-20020a62d454000000b006e468cd0a5asm8103347pfl.178.2024.03.04.09.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 09:40:01 -0800 (PST)
Date: Mon, 4 Mar 2024 09:40:01 -0800
From: Kees Cook <keescook@chromium.org>
To: Jann Horn <jannh@google.com>
Cc: Jiangfeng Xiao <xiaojiangfeng@huawei.com>, gustavoars@kernel.org,
	akpm@linux-foundation.org, jpoimboe@kernel.org,
	peterz@infradead.org, dave.hansen@linux.intel.com,
	kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-mm@kvack.org,
	nixiaoming@huawei.com, kepler.chenxin@huawei.com,
	wangbing6@huawei.com, wangfangpeng1@huawei.com,
	douzhaolei@huawei.com
Subject: Re: [PATCH] usercopy: delete __noreturn from usercopy_abort
Message-ID: <202403040938.D770633@keescook>
References: <1709516385-7778-1-git-send-email-xiaojiangfeng@huawei.com>
 <CAG48ez1h9X7Qv-5OR6hAhwnSOng6_PSXBaR6cT7xrk2Wzu39Yg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez1h9X7Qv-5OR6hAhwnSOng6_PSXBaR6cT7xrk2Wzu39Yg@mail.gmail.com>

On Mon, Mar 04, 2024 at 04:15:07PM +0100, Jann Horn wrote:
> On Mon, Mar 4, 2024 at 3:02 AM Jiangfeng Xiao <xiaojiangfeng@huawei.com> wrote:
> > When the last instruction of a noreturn function is a call
> > to another function, the return address falls outside
> > of the function boundary. This seems to cause kernel
> > to interrupt the backtrace.

FWIW, all email from huawei.com continues to get eaten by anti-spam
checking. I've reported this a few times -- it'd be really nice if the
domain configuration could get fixed.

> [...]
> > Delete __noreturn from usercopy_abort,
> 
> This sounds like the actual bug is in the backtracing logic? I don't
> think removing __noreturn annotations from an individual function is a
> good fix, since the same thing can happen with other __noreturn
> functions depending on what choices the compiler makes.

Yeah, NAK. usercopy_abort() doesn't return. It ends with BUG().

-- 
Kees Cook
