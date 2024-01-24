Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A732135411
	for <linux-hardening@vger.kernel.org>; Wed, 24 Jan 2024 22:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706134182; cv=none; b=cEV7pMG9pwIuGDC1hVCBKFA5FLcHgCLH/TUKNvYHgt252i4AGUu8fad8AuiPMHN7OW0sk/4nIAAWw/sU/22wfxYkb4nIuZSjLnK+ceXzOpT1P/GFcWH8cUUPXnOCKgr6PMCbnZZeGYR3phqzTspz1uz8EZb/v360atToYaQ/Ncg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706134182; c=relaxed/simple;
	bh=UQmXMpFOIh4kaKkMBDQ4eCuMf1Sn6QVhCPFE62Hwr5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hRxwsIr74bx/zZLTNrnp5XBDX6N8JMHyM899BzJr54qVQTtAELBe0WF3lVzg97VTeyPBT0P4XKkIjjQ3Doq9PwYAVfH+9RULijK2iPjs3epB6KF92bjx0qxa1E87zYHlkiEzFULoaDq9Rbp1aAxNF75rso6DiLvWRIfz3yHGh9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Bm1uM0Iu; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Bm1uM0Iu"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d70a98c189so37497105ad.1
        for <linux-hardening@vger.kernel.org>; Wed, 24 Jan 2024 14:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706134181; x=1706738981; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+2HfF9lupAEm1OXAQn6hzn1NaSwJWDcoC+WNHu+TurA=;
        b=Bm1uM0IuP1+QnewQhVXpyXRow9FD25u+xJffrKC4wMTBzaLmSABFDKIzqIM2bx/SmM
         t0tfn0eMt2jaRHmC+liWPK1juyfVJmT4Me/jviogAndspfKZ/ROKj1yxDrZK0+Dgocwy
         2C1+ShExPYRU5V5n0du+wD1RhcllEGiHcAemM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706134181; x=1706738981;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+2HfF9lupAEm1OXAQn6hzn1NaSwJWDcoC+WNHu+TurA=;
        b=Ikb5jO6vJ4nOi3WktIolZMRc+Gbxi36REeKoOnrdQvxH4bGu+OV6Xct6Zs7osEWFj9
         nrx0QwvMsUemoVpyQJvizt115Qqx4l4vW7lKK5IqczQZ3AIScGQurNqz7iTcaiSHEyOm
         Ir4XYGLX+CpXxr/v7eDnRQ0f2Qxd+3RO23VsF37sT7+GkHKUtQFuFzeqzD1+0WzSJE39
         oHLV3boI3YH7kdHxD9uRimzDLLruXH7AiuWeWxbMQlKUfoGZidtphh3wSunEozCXg/UT
         GvkGlXKGnRkqRdTFX0mVx7O8VNy/3oFp9/83n4kVd4TFoiDlCon+DPlH+1FLHDrMkGZz
         UT0A==
X-Gm-Message-State: AOJu0Yym9kgKqLZeZCUXYyNODAgbqdnBtE6FYY5X8LdhjTqrEDXL8wYW
	b4sCnhcd4AXIo5P8E3GUm9qI57RCiXn2BY3142rY4ShLmetDosKSTfiM5YekUg==
X-Google-Smtp-Source: AGHT+IHwjfVcQfQSMaltTGpvSx5H8mpO1d+72MKHAgocTXkrSUI+xD0uCoBa7P9UapqyrXYteTG9ug==
X-Received: by 2002:a17:902:c3c5:b0:1d7:1b61:579e with SMTP id j5-20020a170902c3c500b001d71b61579emr51632plj.89.1706134180745;
        Wed, 24 Jan 2024 14:09:40 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g9-20020a1709026b4900b001d75044fb5bsm5572290plt.141.2024.01.24.14.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 14:09:40 -0800 (PST)
Date: Wed, 24 Jan 2024 14:09:39 -0800
From: Kees Cook <keescook@chromium.org>
To: Kevin Locke <kevin@kevinlocke.name>
Cc: Jann Horn <jannh@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] exec: Remove __FMODE_EXEC from uselib()
Message-ID: <202401241409.AD68CE57A@keescook>
References: <20240124220619.work.227-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124220619.work.227-kees@kernel.org>

On Wed, Jan 24, 2024 at 02:06:23PM -0800, Kees Cook wrote:
> Path-based LSMs will bypass uselib() "open" checks since commit
> 4759ff71f23e ("exec: Check __FMODE_EXEC instead of in_execve for LSMs"),
> so don't set __FMODE_EXEC during uselib(). The LSM "open" and eventual
> "mmap" hooks will be restored. (uselib() never set current->in_execve.)

Ah, nevermind, I see Linux's commit has taken care of this already:
https://git.kernel.org/linus/3eab830189d94f0f80f34cbff609b5bb54002679

-- 
Kees Cook
