Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C484F12D1E0
	for <linux-hardening@vger.kernel.org>; Thu, 22 Feb 2024 21:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708636215; cv=none; b=U6E2/HuIKWJ7hbpOw3/ImqPYXMvT1lAbEotFMWDRmn/HsWIsa0FsGqKlq65ueyVbXr1sNtV+EHzatgUVFTKB1P5ZehzSZkUhar429EZmXDANk+/jrzCD+/v1mDGSvWNBaUT47yvvq2rR1tbZPShkQ+KnNG5pwhku1cw1yXA0Xfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708636215; c=relaxed/simple;
	bh=2wKUaHte55mMdugPouwLtNpZ3iu4duEXOyG89NHGuJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AwnXy0rQlSwF6o3jfBVOHfW/O3mjg97OkpCxFovdgBDEtdUTK75Gs4eLHqkIrnfZKMo0CljkQoj3pIexwr8XWf9EfClfk5Qc3CrdXjP16aSQUCO4KjxKEpHvfJhnuetX3nmmjdB9l1JeNJmXiftDOMR1qvzYTCR0bjmtFzW9hII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jbFYj0it; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jbFYj0it"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1dc1e7c0e29so1752585ad.1
        for <linux-hardening@vger.kernel.org>; Thu, 22 Feb 2024 13:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708636202; x=1709241002; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VOezS8N/LfE8pkfky12K99tbz+EeBQVE3XgUFFXVk8A=;
        b=jbFYj0it3hlCjZKtuB7SBwoMeEYMvwGAMOhPjTLnCuKwM9eKfSR7eN28dgbhFe/pdH
         hsgzPfRSbYUJHahR3xAoUX2fBMinFLKcchiVL0H6DxgBuelOoLV+9IOYkozpKoddjmQf
         uj0t23/hVPd46EQrUamvQbo6L48H650bscF0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708636202; x=1709241002;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VOezS8N/LfE8pkfky12K99tbz+EeBQVE3XgUFFXVk8A=;
        b=H7KflyDH+0KZbpYh74duywKFifWaqDu1uVr9epTE89oPv8U9fVs393nbLmsj0harIy
         3ozqj7oJ0xOMimIzq0ucMdW4z9FlV9CkMBEY8KD3pPGe1JleA2d+4Xy7WULqdzwVAPxG
         4tgUy65X4MPzG7b02x6D9XhMOReB9oPbTt7T8NioSDeJPIsJZgXfzfh4PZD9qjKstQfv
         K8ihSjf4tOcR+D+zX5mLMHQn/kYKex7ulz9nN9nql+LI5zB+Sv3kn4BMVqxWd56NPs3o
         oBvMl4BgNyb3q7S7IhUTfcxGduudMEKl6IdGOpPPjTn3tBJeSUk3bmUhuSHW8/CNhWAo
         0CAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwL2jSFny4JeW+oE658kr1wYQkcEmdjSxKMp2U+XoO28v7POgHlesO/L5GfGYOcMcGBrvlnhLPpvr4M9k3zrRT2oN65GGPaGhGGYZnR4QJ
X-Gm-Message-State: AOJu0Yxac91z8QFbEWXAe+sn57ceNiJ/g/ABIA8rQ9hHcVOkjh/HkpHS
	Vqg7uAV+dDO+GoRW0h08kYMxRRf1p2EPhxO+a42/DzpnEFZtVRrzhVoBbihzDfqHvPUFOMMPqWQ
	=
X-Google-Smtp-Source: AGHT+IGe7RcTvv+Gw2VSQYVpNTITFOnZg4g3TWDSv6mUvXe1ZoXod135v7RQzTHNtgRQSLfQDOENLg==
X-Received: by 2002:a17:902:6b87:b0:1dc:693b:4083 with SMTP id p7-20020a1709026b8700b001dc693b4083mr27378plk.20.1708636201651;
        Thu, 22 Feb 2024 13:10:01 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x3-20020a170902fe8300b001db47423bdfsm10233731plm.97.2024.02.22.13.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 13:10:01 -0800 (PST)
Date: Thu, 22 Feb 2024 13:10:00 -0800
From: Kees Cook <keescook@chromium.org>
To: Tycho Andersen <tycho@tycho.pizza>
Cc: "Tobin C. Harding" <me@tobin.cc>, Greg KH <gregkh@linuxfoundation.org>,
	Guixiong Wei <guixiongwei@gmail.com>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] leaking_addresses: Provide mechanism to scan binary files
Message-ID: <202402221309.79CE163C@keescook>
References: <20240218173809.work.286-kees@kernel.org>
 <ZddnEtnxhJsafdcF@tycho.pizza>
 <202402221249.FA17A8940@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202402221249.FA17A8940@keescook>

On Thu, Feb 22, 2024 at 01:00:40PM -0800, Kees Cook wrote:
> On Thu, Feb 22, 2024 at 08:24:02AM -0700, Tycho Andersen wrote:
> > Hi Kees,
> > 
> > On Sun, Feb 18, 2024 at 09:38:12AM -0800, Kees Cook wrote:
> > > Introduce --kallsyms argument for scanning binary files for known symbol
> > > addresses. This would have found the exposure in /sys/kernel/notes:
> > > 
> > > $ scripts/leaking_addresses.pl --kallsyms=<(sudo cat /proc/kallsyms)
> > > /sys/kernel/notes: hypercall_page @ 156
> > > /sys/kernel/notes: xen_hypercall_set_trap_table @ 156
> > > /sys/kernel/notes: startup_xen @ 132
> > > 
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > 
> > Patch itself is
> > 
> > Reviewed-by: Tycho Andersen <tandersen@netflix.com>
> > 
> > And if you can carry it, that would be great (see below :).
> 
> Sure!
> 
> > This does bring up some interesting questions. From off-list
> > discussions with Tobin, I believe he is not particularly interested in
> > maintaining this script any more. I was never set up to do the PRs
> > myself, I agreed to be a reviewer to help Tobin out. I'm happy to
> > adopt it if that makes sense, but I'm curious about the future of the
> > script:
> > 
> > 1. is it useful? (seems like yes if you're adding features)
> 
> Yes, LKP runs it as part of 0-day, and it's found leaks in the past[1].
> (Though its usage could be improved.)
> 
> > 2. does it make sense to live here as a separate thing? should we
> >    perhaps run it as part of kselftests or similar? I think that e.g.
> >    681ff0181bbf ("x86/mm/init/32: Stop printing the virtual memory
> >    layout") was not discovered with this script, but maybe if we put it
> >    inline with some other stuff people regularly run more of these would
> >    fall out? Maybe it makes sense to live somewhere else entirely
> >    (syzkaller)? I can probably set up some x86/arm64 infra to run it
> >    regularly, but that won't catch other less popular arches.
> 
> We could certainly do that. It would need some work to clean it up,
> though -- it seems like it wasn't designed to run as root (which is how
> LKP runs it, and likely how at least some CIs would run it).

This is wrong -- it's not run as root. It was fall over very badly. I'm
not sure why the CI output looks strange.

-- 
Kees Cook
