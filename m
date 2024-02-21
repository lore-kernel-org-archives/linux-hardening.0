Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66860365
	for <linux-hardening@vger.kernel.org>; Wed, 21 Feb 2024 06:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708497558; cv=none; b=OvDzvCGRaD/pr2YVjKKtRKG12l6Azazxb77wgNadKEheHzvrUNY3bPD7TUG3xW1MKNstVKJZKdjyZuiFG2C79r8qfITdKBcQ9C14tGGC4lx5wwk3+RJpFvBd2rCIzoGjS25kufWyx5Yxyfexm99oBW6zRlYveaGnkwbY40BWnuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708497558; c=relaxed/simple;
	bh=f0HDwa1vf5SRBb3ZPUrzmRhDIF3eBxQOxuTRSxuw4UM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QxhKrbEoo5QHR5IaCgndlWdL/vtZojLzitMELGeASNHf+Oj3tz2AT5nlRmDnYKYzJOWux4ZHdzivDgug/eOs0jU8MjJrJERyaDRHxddTNb/ywPGC4nQ68OOvgAkmG53jaEG7w+OE4ASMQXKQDuruCnRTc0xl+YZsW8+hBqekvlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hXMmRKNK; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hXMmRKNK"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dcc4de7d901so5564753276.0
        for <linux-hardening@vger.kernel.org>; Tue, 20 Feb 2024 22:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708497556; x=1709102356; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C/kx0MMgzpebCxflYE7VD+ZZKlLv7LbIjirao9DRCq0=;
        b=hXMmRKNKO+o4LWqDRkIDLFmWIWac90Q7TlXzX6G0HZaryly4v0BZKVFcHIF+MHE+zc
         4qj0+Ansbrxd0xUPKBPV+x5sAdpJsOz+iW70xaxxbVV7++cqMp8HD9RxcixWNHGBkhvV
         aJwKnK/kzobZWD/e6ofJ4aza19zs6jh2ZDdCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708497556; x=1709102356;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C/kx0MMgzpebCxflYE7VD+ZZKlLv7LbIjirao9DRCq0=;
        b=Db4uTbVykyBwIgKHciJvY3YABM2KW5a+tSBDqE11oO5AXxc/S0F2j00IiCHO5APHyD
         Ki91dQVxxM05Wzm38Q7mqIv3PLQK8MkXvNuujjDd/x3oSz2cZIR2FNL+MpM978sH/hpY
         LTJ1nWuOeKzgzNwnrHScc43FXc1292w1E95Pw76cQJku9ZDIq/QdY6/NYrecUMsk24A8
         tTqfywaDW3bux8KBHt2LK8e9QlgmZNhVS8cEiTFoO2nkaOsBjyoYj9t5MCQ7+SZlIUU9
         R60OGHSJu0P9hDph8XBuLp94ly2RyrCpwlrb/daBxpkwuwPthXzuIhwp+IJsiyvo2dSn
         MNwA==
X-Forwarded-Encrypted: i=1; AJvYcCXEcNZqWpPbliJpoN4CByIGFb2+eWSBcRPxqBAwnkpLqnZWKc5DOocJkkTctdUaWJeqinQxcnWCO4aoLTwrJ10cTmGJbCg9zHLiVzZL62Nu
X-Gm-Message-State: AOJu0YyKlELLZpNzUYNPPmi2NhfhM88qMGw5GzOfqk44JKaNCyyAdJEk
	YIBb4NNoee2DWlEk6V/32KDw1MDHqijaqMoyX2iBIyFp8lHJP31EQf8/jhfA9w==
X-Google-Smtp-Source: AGHT+IEDBNlgi9fOUdqyWnl61n6BJWPOOAV7EQV0qVdwgnub+GBgpaz0jIe8FwPV8Mtvha7IwXR11Q==
X-Received: by 2002:a25:ab27:0:b0:dcb:c0ea:6abc with SMTP id u36-20020a25ab27000000b00dcbc0ea6abcmr13836899ybi.64.1708497556402;
        Tue, 20 Feb 2024 22:39:16 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i5-20020a639d05000000b005dc4829d0e1sm7729634pgd.85.2024.02.20.22.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 22:39:16 -0800 (PST)
Date: Tue, 20 Feb 2024 22:39:15 -0800
From: Kees Cook <keescook@chromium.org>
To: Russell King <linux@armlinux.org.uk>
Cc: Mark Brown <broonie@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Wang Kefeng <wangkefeng.wang@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ben Hutchings <ben@decadent.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ARM: fault: Implement copy_from_kernel_nofault_allowed()
Message-ID: <202402202235.A77C9AD@keescook>
References: <20240123011238.work.301-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123011238.work.301-kees@kernel.org>

On Mon, Jan 22, 2024 at 05:12:38PM -0800, Kees Cook wrote:
> Under PAN emulation when dumping backtraces from things like the
> LKDTM EXEC_USERSPACE test[1], a double fault (which would hang a CPU)
> would happen because of dump_instr() attempting to read a userspace
> address. Make sure copy_from_kernel_nofault() does not attempt this
> any more.
> 
> Reported-by: Mark Brown <broonie@kernel.org>
> Link: https://lore.kernel.org/all/202401181125.D48DCB4C@keescook/ [1]
> Suggested-by: "Russell King (Oracle)" <linux@armlinux.org.uk>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Wang Kefeng <wangkefeng.wang@huawei.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Ben Hutchings <ben@decadent.org.uk>
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Russell, do you mind if I carry in my tree the 3 ARM patches I sent?
They're mostly pretty trivial, and they've been in "Incoming"[1] for 2
weeks but haven't shown up in -next yet. I'd really like them to get
some soak time, and for them to reach the v6.9 merge window in time.

Please let me know what you think. :) Thanks!

-Kees

[1] https://www.arm.linux.org.uk/developer/patches/section.php?section=0

-- 
Kees Cook
