Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9874CB2E
	for <linux-hardening@vger.kernel.org>; Tue,  5 Mar 2024 09:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709631127; cv=none; b=dH3qmEP80XHjXMtSsi0pyuggZnn9cMOVkuvLu+YoLC2Ig9g1SqFaUdu0IRUCDhb/YvLlyBXxzv+LwvpyVKrtBp0NprGxdwPdHp8CsccUXnSad0g78uLE1bUqoiZ25zfdIGcnm3+zdo7f+QOTkhvpsHL4CWh1zndsHstQuOL2QXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709631127; c=relaxed/simple;
	bh=zBeKo3AW0umWo2+oVzF0kvmctDMJc7DeYmGkbvuWUkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CUh2dzt6k586qlh9nOSnixZ5jtmT/HiLau65OUWp/KHTT4simZpNu02J90cEEq6udv4MVAio5mG+LUGyCStzxGLsP0iuxmM4rY3yI4hSmOBXmfQJa0r/k6TXw0Iowh1LztELgzv/1Fs6EavMdXKW/b53Bw+zCyx/OnuJPgf/hlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VkMK7cNs; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VkMK7cNs"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1dd178fc492so13560145ad.2
        for <linux-hardening@vger.kernel.org>; Tue, 05 Mar 2024 01:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709631126; x=1710235926; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jwQHCS1RApRdLMtnfYY4Lo44hm6+L8NjNwQTBjGnVfA=;
        b=VkMK7cNsjtRVVRv4Q12/cCxH25ITbWCYfVKc6utxrZ/r1uLkAm16zKTDORrL7o+2ub
         hTaQUJE44SzNGiawHLrxeoyBxSEp0t/UgUC/t19bcKErtrXCvJP0huLcfZu9A5MXG73+
         WpXzTWZuk+smsErVMM7zj4208fgsh4YFv30+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709631126; x=1710235926;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jwQHCS1RApRdLMtnfYY4Lo44hm6+L8NjNwQTBjGnVfA=;
        b=qji2Cjy3XB9nTXzUIjF4EpL5wj8FupSjLH6UHO1du5Ub3TsG+KQSqiqcboEbzoRUWe
         MVh/w7myAsBbWigggYL8JaqaQRhbVX+zT8/sGT+OJyqgBUQbAM7eG4VlmzCM9kY0D4yO
         abvz8tpcEsELsnEFWoc2cyihp+0P9gs7rIr8OPBXEsAT/isUoUffV4oNJcFva46KSqHS
         rm9hkLIskqlM0Cm5c6VlgcA1u2gXOpE/mKGrO8+LnfZ5T4CJTUGI10n9ppam2gMkoA6p
         gW2/dPjFJlC91uTYu6tk6yfjznVnC65Vn3uXn4oXmf8gYKgWusY/raLLNJXd1ypx7Awn
         Svxg==
X-Forwarded-Encrypted: i=1; AJvYcCUpbahtDPr4OH3WpkRjWJfnj3sD7tb9HDivefV208ktA2nfL4HjotAD4s20LHqXmd9+NJgWI7zZRRnINfzZ6tVI7t6+ZRezkmLypRr5ZVWB
X-Gm-Message-State: AOJu0YwPho+MUtQ5Iqi9quwDtEgbhnd5lePtt7TSHIrF41uYfO+mP0gA
	v0g+XiVz9HLkQlVL1qgP3zmlpSod15qLA/gvbtdPyrkP2V3KUY0paKc7UCVOSA==
X-Google-Smtp-Source: AGHT+IEkIjd9sE8/PNSfNzhkY5QnMDDggNLePYzvx388RJGPnJJiHoeKZ/QNY7uY/4Q61sqgAgAuEg==
X-Received: by 2002:a17:902:a50e:b0:1dc:66da:d21a with SMTP id s14-20020a170902a50e00b001dc66dad21amr1054443plq.28.1709631125912;
        Tue, 05 Mar 2024 01:32:05 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id im15-20020a170902bb0f00b001db5c8202a4sm10192588plb.59.2024.03.05.01.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 01:32:05 -0800 (PST)
Date: Tue, 5 Mar 2024 01:32:04 -0800
From: Kees Cook <keescook@chromium.org>
To: Jiangfeng Xiao <xiaojiangfeng@huawei.com>
Cc: Jann Horn <jannh@google.com>, gustavoars@kernel.org,
	akpm@linux-foundation.org, jpoimboe@kernel.org,
	peterz@infradead.org, dave.hansen@linux.intel.com,
	kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-mm@kvack.org,
	nixiaoming@huawei.com, kepler.chenxin@huawei.com,
	wangbing6@huawei.com, wangfangpeng1@huawei.com,
	douzhaolei@huawei.com
Subject: Re: [PATCH] usercopy: delete __noreturn from usercopy_abort
Message-ID: <202403050129.5B72ACAA0D@keescook>
References: <1709516385-7778-1-git-send-email-xiaojiangfeng@huawei.com>
 <CAG48ez1h9X7Qv-5OR6hAhwnSOng6_PSXBaR6cT7xrk2Wzu39Yg@mail.gmail.com>
 <202403040938.D770633@keescook>
 <77bb0d81-f496-7726-9495-57088a4c0bfc@huawei.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <77bb0d81-f496-7726-9495-57088a4c0bfc@huawei.com>

On Tue, Mar 05, 2024 at 11:31:06AM +0800, Jiangfeng Xiao wrote:
> 
> 
> On 2024/3/5 1:40, Kees Cook wrote:
> > On Mon, Mar 04, 2024 at 04:15:07PM +0100, Jann Horn wrote:
> >> On Mon, Mar 4, 2024 at 3:02 AM Jiangfeng Xiao <xiaojiangfeng@huawei.com> wrote:
> >>> When the last instruction of a noreturn function is a call
> >>> to another function, the return address falls outside
> >>> of the function boundary. This seems to cause kernel
> >>> to interrupt the backtrace.
> > 
> > FWIW, all email from huawei.com continues to get eaten by anti-spam
> > checking. I've reported this a few times -- it'd be really nice if the
> > domain configuration could get fixed.
> > 
> >> [...]
> >>> Delete __noreturn from usercopy_abort,
> >>
> >> This sounds like the actual bug is in the backtracing logic? I don't
> >> think removing __noreturn annotations from an individual function is a
> >> good fix, since the same thing can happen with other __noreturn
> >> functions depending on what choices the compiler makes.
> > 
> > Yeah, NAK. usercopy_abort() doesn't return. It ends with BUG().
> > 
> When the user directly or indirectly calls usercopy_abort,
> the final call stack is incorrect, and the
> code where the problem occurs cannot be located.
> In this case, the user will be frustrated.

Can you please give an example of this?

> For the usercopy_abort function, whether '__noreturn' is added
> does not affect the internal behavior of the usercopy_abort function.
> Therefore, it is recommended that '__noreturn' be deleted
> so that backtrace can work properly.

This isn't acceptable. Removing __noreturn this will break
objtool's processing of execution flow for livepatching, IBT, and
KCFI instrumentation. These all depend on an accurate control flow
descriptions, and usercopy_abort is correctly marked __noreturn.

-- 
Kees Cook
