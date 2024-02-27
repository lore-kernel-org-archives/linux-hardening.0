Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8890A250F8
	for <linux-hardening@vger.kernel.org>; Tue, 27 Feb 2024 17:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709053248; cv=none; b=F1ghCS4St19/+J7casVVm6P4FhOcLd25sS0BBYakpn8rwy5zpvlp5/LtTRPZLBcQMzQMHmlFikSEBDy1xWtFULckZUA4E+QS/jhOpcZJjAgcuHbQpLX+Hy1L3AQo1VtwQfawdsjHXuS9kEG/ggzoINzZ2/zx5XVYVaNQksD+tz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709053248; c=relaxed/simple;
	bh=kaZPwy1DnnJwKmEiqW49+N4tGBugK5KqDPoQuOPHqX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EeRI7hyuqPvvyV8gWtOFALLQ9BsU2RM/3y5TkbVM/vElahZVPw70LK4uqOn0GBoJuaXCs8I7bkd0JPsPQgVox6+qslAdcEF5uBGKLmwWXr7bVMiWCsG5dZ9e3Ny8MsSFAQJEHmQFbCPOn+EBb6RP+oiWliNfQxICsQ0hBZcPkFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=h8IsAKtw; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="h8IsAKtw"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5d4d15ec7c5so3664377a12.1
        for <linux-hardening@vger.kernel.org>; Tue, 27 Feb 2024 09:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709053247; x=1709658047; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fVB/mgTuOok+gnoF/FjLnOVs65Yn1KQT4qK8xBXRKZk=;
        b=h8IsAKtwLq4NbTtRLrIFV/bMl+10yUh/J82+Opm7iJASboxzGvaKTgcwZqzXnDZObH
         Tbd22PMnsydlCmb3JVxTJRSzQXgCmTJsHhtot2yc5FH1XYVHRQ0sVeorvjCuPnkzWQoG
         +Gl+OMMdAPMS20IqC2Jvv5q5Lqrl2xpYWEZ9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709053247; x=1709658047;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fVB/mgTuOok+gnoF/FjLnOVs65Yn1KQT4qK8xBXRKZk=;
        b=cw//Z6cpCvZpMs0ryZcjQgFoSVfV9I3kFG3tiDWSfU89E1x7NXH5l8dnwO5n0vPVax
         RY/br2k/aNmD01w6zcph7ugegD00iupT4LR2pzcfRAIauhwHXRB6MMVOF9Jf92WSjh9M
         HDxeWjv8Eh6Zg6W3QZyu0OyVTUwIaaQV73F3a83ln1MvSrrl/7xd+WAeMOmmbqPLfG4w
         ny020BXSc0MrfPdK0GD38wG5DrmnnTsjYIQoep1R0n4hRoX1eCLdZneXljv3Rb16dMMr
         Mgp+M4CPw1UzMXqduChPHoNYDQWWslhYjob2woGY8PLAIYrV1Ndh3MLLYNwVW8S7Ww6G
         3AKA==
X-Forwarded-Encrypted: i=1; AJvYcCVp+9BgjAPZdiK2eKUM+XKrh6ez/DLCz19gWqHiRfqFeAiGP29b0lf0i+Dluh1LC2w5US6j/TBX+dbkYWPNC9N3MTx1dk/peGpzG/7e/DHD
X-Gm-Message-State: AOJu0YxUKQZiKhVSeFbrftNur7Nm0pVRYTE7D8vmVe+u7/aFmeGaLprH
	0Lp0tJl19nnzkQVbm10GHBXpmVf9N1H4tChpprc7crHbRoJPKxOEiIb79MIHBTaQJCjsJ2R/aHg
	=
X-Google-Smtp-Source: AGHT+IFg0NCtYbETJpvRCOpzy0XTL7KtmhpC1VhxZupEkO0MpW4B3yevf7ZLibVvBRAtyz/LEba0cQ==
X-Received: by 2002:a17:90a:d90d:b0:29a:a39e:e651 with SMTP id c13-20020a17090ad90d00b0029aa39ee651mr7555235pjv.11.1709053246818;
        Tue, 27 Feb 2024 09:00:46 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u3-20020a17090ac88300b0029a4db713b9sm8760981pjt.39.2024.02.27.09.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 09:00:46 -0800 (PST)
Date: Tue, 27 Feb 2024 09:00:44 -0800
From: Kees Cook <keescook@chromium.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>, rui.zhang@intel.com,
	lukasz.luba@arm.com, gustavoars@kernel.org, morbo@google.com,
	justinstitt@google.com, stanislaw.gruszka@linux.intel.com,
	linux-pm@vger.kernel.org, linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev, patches@lists.linux.dev
Subject: Re: [PATCH] thermal: core: Move initial num_trips assignment before
 memcpy()
Message-ID: <202402270852.E46A5268@keescook>
References: <20240226-thermal-fix-fortify-panic-num_trips-v1-1-accc12a341d7@kernel.org>
 <6a6be01d-3453-4268-8b2e-0279cc20835d@linaro.org>
 <CAJZ5v0h87k6xoi-9V0Cfb2rHQcr-STfG_bNWpzfoj4Dy46U0Lw@mail.gmail.com>
 <f81af0ae-7458-47d3-90ae-71d5217ee7dd@linaro.org>
 <202402270816.0EA3349A76@keescook>
 <bbc65508-eb0e-4d63-921b-85d242cc556f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbc65508-eb0e-4d63-921b-85d242cc556f@linaro.org>

On Tue, Feb 27, 2024 at 05:47:44PM +0100, Daniel Lezcano wrote:
> Ok my misunderstanding was I thought sizeof() was calling _bdos under the
> hood, so when calling sizeof(flex_array), it was returning the computed size
> inferring from the __counted_by field.

Yeah, sizeof() has a very limited scope. __builtin_object_size() has
more flexibility (via the 2nd argument, "type"), but it was still
compile-time only. __builtin_dynamic_object_size() was added to bring
runtime evaluations into the mix (initially to support the alloc_size
attribute, and now includes the counted_by attribute too).

-- 
Kees Cook
