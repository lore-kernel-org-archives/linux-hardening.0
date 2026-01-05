Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299292D77FE
	for <linux-hardening@vger.kernel.org>; Mon,  5 Jan 2026 07:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767597977; cv=none; b=Op/l1dRoqm0sPrt92GT7sN4n2RUTrzxwfcXlUXkLQ/pG4r86morzsPtkGAxjw4Q60OJa2I3YB6sOWjTa9hl/fYM3S/p+aXovR/IiD2d5lu/Xu0Psv8fm3UdkhKOcXVHQJuFKmqV1aOHFa89s2MZCeHZ/guRvNGG94jbCtL7a0I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767597977; c=relaxed/simple;
	bh=J+0zgzblPWcILdaJe+sS8PZ3YqSBzV7Z4n11YbyV75A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sJFBHV3UEThWJX+Qtr7Fz9qd4KNjiRkmd6DUiiBsCHIUEzMX4NBNlv5+hyL8TWylSY/VQQ57zT7NziL5j8vf2l9sHmZc+lbUPtjNVYHdKQDfhsDrxUA1VB5YRrkIQImEKDj8n3Mnq0xVS0VY2gH59vgQPD+XdmJ3Q2uvwbFhvYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=e5wBrHfr; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e5wBrHfr"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-477619f8ae5so87361965e9.3
        for <linux-hardening@vger.kernel.org>; Sun, 04 Jan 2026 23:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767597971; x=1768202771; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tqXPGRlmqIR2c73hehXqAT4WnRWsCFlwnXSzbZ1gZgI=;
        b=e5wBrHfr2i2YxmjC/xSZl8aZSdU/c0xU0A0qfCMbcYd6VYpTU+XKBer8Ge7syUWmu/
         KyD6yBdkixqrcBJPL+OMgoZfI2M3afqS+wO8+88CAbNgPgR1iLJsVjvSGVdQQmIQ5ESx
         0ElZAULoxYK7l2f+9R9btlhNco1OYiU0JmT33Hc0QNQIC1KTOxe8FHD4MXi1MLXWTgFP
         98Zzs77itmNp3mMSfKDl7UfEkX0nljzsflDfQ/cCojXoA4hvX9safE2PuEsku50tGmXe
         GaIaJ2HPYfi1wYIDpU2eNdTLx6g+gZNK1bGT4YR7siJL6ElJ873WKWdBI2neDTYYXHfz
         LH0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767597971; x=1768202771;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tqXPGRlmqIR2c73hehXqAT4WnRWsCFlwnXSzbZ1gZgI=;
        b=Pvmk4SGVgiFwYJ4LIZez+XSZ0e1oH5HK5G5cDjUUr6WJkW+UjNVmUnqIKNaxfBlPtM
         PkJe1dKbvIglVXWhatQyNbA88E/sc+NTO5+5i1+sB9OXedbBgClPwqKcreovqFIv/7Ku
         bd6wWpzqBu4QxljvxJwm7Zawb3ee5rP/WPcQmF91eejKgPQBznb36zQqATXBdFxsaF6m
         APLgwtHqhePYy89Zlj/KtUAlgKvGv0fN7RW6Ha8ct9MfB34Nfv8imfP9LebqhpkIstuH
         c8odggD0zNbqjvb0MUICAjy0vgdwBeKRVhDXeGHAv44w4GtKoefKHE/k9kIg0dQ+N3cj
         Xa4A==
X-Forwarded-Encrypted: i=1; AJvYcCXMHxneHmiVjIGa2wLziDvts6bPY39Tiq5Qxe6R/DNVOeHr5hsvPCba4awEHvMYnR5tGtBVGbQqhHtwaUsscPM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy6tnPVV8lGX23o1c2F2MTh2G40KtJX+Crsk5vYuHJc2w1cUu8
	D4bWHsow54jf+sujEgE61hwHHKGSLTjF4rghV5mnD9Mc8RIjRWj+itv3KdhYXetJgV4=
X-Gm-Gg: AY/fxX7/6smzpn55om7Le8JvUj+Fl19hE3lI8pM5r0PB7ELdoFMnZtonGmcKsSPCBmV
	3BXsP4bh/m8mMy8OGCstc0YzdOlBOfl1RfpRoXpaMG4Yr5mJAyi8U8H+fENS4EgcUg2l/F8fdVM
	n8li2VkyBt6vh+hKrjTHRi/65hYaHYI5Rn51qFQDZYeQi4lFcFiP2gtT//X68gkbyaOuSqFFCqb
	Dbp9jQJzEe41YsyV4YNRqvyraaz9TaqlxA5A63jpt25EcOVJZUjnDFhWAynZbkczdvRK/0bK8Ck
	tEbm8tFzjXJLCx31+nw3T6JHcRYAYe9gDHDT817bgIfMwagnTxEmMVFg0wv8VRuy/qpmqZK4EBm
	dhDIHu1fGWUKMak3Vgv1l6qsNR8S3t6hvM7FQSL9eY4AT3IxuXxryIEEB91Ehsx0Ait8dYvhPSk
	81VWy+d5itrrNV/0JN
X-Google-Smtp-Source: AGHT+IFrdZFxzxTrmRZMpsP27Ztfl7Uoc6pbDtE/T7BSP5JYGzpyq/KpLAX/yGG7sIYcOpNE6ZVEuA==
X-Received: by 2002:a05:600c:1d1d:b0:477:8ba7:fe0a with SMTP id 5b1f17b1804b1-47d1957da90mr604728865e9.24.1767597970515;
        Sun, 04 Jan 2026 23:26:10 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d6d45bb57sm148423745e9.14.2026.01.04.23.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 23:26:09 -0800 (PST)
Date: Mon, 5 Jan 2026 10:26:06 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kbuild@vger.kernel.org, linux-sparse@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	dri-devel@lists.freedesktop.org, linux-btrfs@vger.kernel.org,
	linux-hardening@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] overflow: Update is_non_negative() and is_negative()
 comment
Message-ID: <aVtnjgJOjMp9cMDn@stanley.mountain>
References: <20251220-remove_wtype-limits-v3-3-24b170af700e@kernel.org>
 <acdd84b2-e893-419c-8a46-da55d695dda2@kernel.org>
 <20260101-futuristic-petrel-of-ecstasy-23db5f@lindesnes>
 <CANiq72=jRT+6+2PBgshsK-TpxPiRK70H-+3D6sYaN-fdfC83qw@mail.gmail.com>
 <b549e430-5623-4c60-acb1-4b5e095ae870@kernel.org>
 <b6b35138-2c37-4b82-894e-59e897ec7d58@kernel.org>
 <903ba91b-f052-4b1c-827d-6292965026c5@moroto.mountain>
 <c84557e6-aa92-42e9-8768-e246676ec1e9@kernel.org>
 <aVlKTculhgJzuZJy@stanley.mountain>
 <e66bd09b-9879-4562-a71e-a1e1a964f3f2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e66bd09b-9879-4562-a71e-a1e1a964f3f2@kernel.org>

On Sat, Jan 03, 2026 at 08:40:17PM +0100, Vincent Mailhol wrote:
> On 03/01/2026 at 17:56, Dan Carpenter wrote:
> > On Sat, Jan 03, 2026 at 12:10:45PM +0100, Vincent Mailhol wrote:
> >> On 03/01/2026 at 11:02, Dan Carpenter wrote:
> >>> Thanks Randy, for sending this to me.  I'm on the sparse list, but
> >>> I've been on vacation and haven't caught up with my email. 
> >>
> >> Welcome back, hope you enjoyed your holidays!
> >>
> >>> I can easily silence this in Smatch.
> >>
> >> Thanks. I ran this locally, I can confirm that this silences the
> >> warning. So:
> >>
> >> Tested-by: Vincent Mailhol <mailhol@kernel.org>
> >>
> >>> diff --git a/check_unsigned_lt_zero.c b/check_unsigned_lt_zero.c
> >>> index bfeb3261f91d..ac3e650704ce 100644
> >>> --- a/check_unsigned_lt_zero.c
> >>> +++ b/check_unsigned_lt_zero.c
> >>> @@ -105,7 +105,8 @@ static bool is_allowed_zero(struct expression *expr)
> >>>  	    strcmp(macro, "STRTO_H") == 0 ||
> >>>  	    strcmp(macro, "SUB_EXTEND_USTAT") == 0 ||
> >>>  	    strcmp(macro, "TEST_CASTABLE_TO_TYPE_VAR") == 0 ||
> >>> -	    strcmp(macro, "TEST_ONE_SHIFT") == 0)
> >>> +	    strcmp(macro, "TEST_ONE_SHIFT") == 0 ||
> >>> +	    strcmp(macro, "check_shl_overflow") == 0)
> >>
> >> But, for the long term, wouldn't it better to just ignore all the code
> >> coming from macro extensions instead of maintaining this allow-list?
> >>
> > 
> > Of course, that idea occured to me, but so far the allow list is not
> > very burdensome to maintain.
> 
> Indeed, but my concern was more on how people would treat such smatch
> warnings coming from the kernel test robot. It is very uncommon to have
> an allow-list hard coded into the static analyzer. Actually, this is the
> first time I see this. My fear here is that people will just uglify the
> code rather than sending a patch to extend the allow list in smatch.
> 

People need to learn to ignore false positives.  The zero day bot sends
a one time email and if you just delete it, then it's gone forever.
Forget about it.

It's really limitting to try be totally static checker clean.  Things
like passing a zero to ERR_PTR() for example.  It's a perfectly valid way
to return NULL and the fs/ subsystem uses this a lot.  But 80% when you
see it in new code, then it's a bug where they returned the wrong
variable or something.  It's a high quality warning.  The solution is to
look at it one time, when the code is fresh and then never look at it
again.

In this case when I disable the unsigned < 0 checking for macros then it
means that if someone does if (WARN_ON(u32_var < 0)) { it's silenced.  I
don't want that.

I could create a much better way to silence false positives like this
if I passed an expression pointer to the sm_warning()...  It's a bit of
a re-work.

regards,
dan carpenter












It's really limitting
if we can only check 

> > I maybe should disable it for all macros unless the --spammy option is used...
> 
> IMHO, that would be an even better approach. That said, I am happy
> enough with your previous patch which resolves my issue and which is way
> better than updating the is_non_negative() and is_negative() comments as
> I did in my patch!
> 
> 
> Yours sincerely,
> Vincent Mailhol
