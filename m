Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6124B132C36
	for <linux-hardening@vger.kernel.org>; Wed, 24 Jan 2024 19:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706125914; cv=none; b=LIiyt/2Edyvop7uNNlIEhXh+wlKH/ZAQtiFrd+QRtkoLuGtJH8WsoJipazYOtVsneERqKW3fwj9Lppeo0PjWU3FODQZbvUGD/ujDZ9tAtGmCY+HQzq/iDKB2BqTgODi5JdF3zvhZsycs8q8/PdQ9FlGe9VrFTIYG/oeDLXYaA/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706125914; c=relaxed/simple;
	bh=+IYqSxEQ9oBa5c9r8B0bfIvQXLqXBMpi4Ryc4G+HXuE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JcceiO/Y7hYYN675JRph/xdc8WdqFbYjjrusp7RhiU8uC2jHBJZcLmdcJ2ZRytQ1ETRkCVV0NPRCPDmmr5VyoacGnXgb9usX8XaGHgNayXkx32OszBRzYnFrrCYp15Z+wsdgmfrcwZ3wJply8ezFg25DXhIwE3zps9l94t2VzAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=J4Diar6n; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J4Diar6n"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d70a986c4aso27674395ad.2
        for <linux-hardening@vger.kernel.org>; Wed, 24 Jan 2024 11:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706125911; x=1706730711; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kA0mFxG1k0QSiOKDeUD/WDcdNFn8yF9DrGJFsA48PEc=;
        b=J4Diar6nU/37c0/UwBQQFu7zCFodAGZNbMK8zK5T4ksD60wf29XsDjczDxsZMoOkG8
         VWNui00mTtdF2GLDTKMEYsm80XO6z1961TZkKiOaKfAmeJPEEG9nw+44TX83kwwOMNbj
         w/zguEDg41/bg68FDXI9OEyyVi7Lkay37ry3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706125911; x=1706730711;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kA0mFxG1k0QSiOKDeUD/WDcdNFn8yF9DrGJFsA48PEc=;
        b=cG5xRyqyGYdLgdv1YqBToZFWKtWVeXOk2sx/B3Tc8vzBikNYWUKw94+keGbF6lE7mE
         PLoD7dOafHETEubNjvWUdHsLbALGGjXgVP3MeGs9Y3UG3VwTgh9X4hclM4GwCpvtBEPZ
         nTfXyZ6ObAn1GTY6yfdz/e36cCdkKqTQbobuilDPNXFci7rGdUnqx/uHVz55kwWygGVO
         aBPUVlYjGvbl3yXaWuyerV2415pAOdD4aA8PKmMIkkSwChrMxQADloDJWNpb6jcuG+5X
         iC23n4V/T+VlYTOZvF2t0gX/IPIMRGtoBZZYf7yCwSymxl5heh8v+0Ic1m1JLvHOfADC
         rYAA==
X-Gm-Message-State: AOJu0YwyljVK9VV9M5KruJ9KoQsHWoSNzMQczOve1yRUohPsAZ64o+TY
	oHekoroey4kfC9Llebai9yZaKdGbS2n6zWTyIiN+9xDwgZePS7WEPe02/QhCeA==
X-Google-Smtp-Source: AGHT+IHOo2S4XZPrJkJAVWNIUu5O2sihiMmNygdfJCCs51/i38ljraqICbhZ/brbhlRxs5RoeWJoDA==
X-Received: by 2002:a17:902:8685:b0:1d7:70d7:c05a with SMTP id g5-20020a170902868500b001d770d7c05amr1210754plo.98.1706125910737;
        Wed, 24 Jan 2024 11:51:50 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d9-20020a170902c18900b001d707163122sm10456896pld.7.2024.01.24.11.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 11:51:50 -0800 (PST)
Date: Wed, 24 Jan 2024 11:51:49 -0800
From: Kees Cook <keescook@chromium.org>
To: Kevin Locke <kevin@kevinlocke.name>,
	Josh Triplett <josh@joshtriplett.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Kentaro Takeda <takedakn@nttdata.co.jp>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Eric Biederman <ebiederm@xmission.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] exec: Check __FMODE_EXEC instead of in_execve for LSMs
Message-ID: <202401241151.25D468FE@keescook>
References: <20240124192228.work.788-kees@kernel.org>
 <ZbFneq3URF5lLAT7@kevinlocke.name>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbFneq3URF5lLAT7@kevinlocke.name>

On Wed, Jan 24, 2024 at 12:39:38PM -0700, Kevin Locke wrote:
> On Wed, 2024-01-24 at 11:22 -0800, Kees Cook wrote:
> > After commit 978ffcbf00d8 ("execve: open the executable file before
> > doing anything else"), current->in_execve was no longer in sync with the
> > open(). This broke AppArmor and TOMOYO which depend on this flag to
> > distinguish "open" operations from being "exec" operations.
> > 
> > Instead of moving around in_execve, switch to using __FMODE_EXEC, which
> > is where the "is this an exec?" intent is stored. Note that TOMOYO still
> > uses in_execve around cred handling.
> 
> It solves the AppArmor issue I was experiencing and I don't notice any
> other issues.
> 
> Tested-by: Kevin Locke <kevin@kevinlocke.name>

Thanks!

Sounds like Linus has taken the patch directly, and I'll send a follow-up
PR with other clean-ups.

-Kees

-- 
Kees Cook
