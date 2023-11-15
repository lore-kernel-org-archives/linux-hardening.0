Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA2A2E651
	for <linux-hardening@vger.kernel.org>; Wed, 15 Nov 2023 16:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="gT6deisK"
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD84F121
	for <linux-hardening@vger.kernel.org>; Wed, 15 Nov 2023 08:00:46 -0800 (PST)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1f48b6e0388so1154973fac.0
        for <linux-hardening@vger.kernel.org>; Wed, 15 Nov 2023 08:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1700064046; x=1700668846; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eFmbaY0oGVZ7sScVBLanmu7D2D9vxvb7T+NtcQ3NkJ4=;
        b=gT6deisKI4WEaVwsq+NFFTt6ergwIaW4HqJ4M5a1BlMxrKIPGufiSXnGNKkhonwvBW
         ou3uzIVEUQIbGU2kWZGyg2o4A5D9R+GbXtCrgEz5eeCymCAAR18Xwyv133Cvzyog/eaS
         Gtd2f/DsabugquTwOGhyVYDMc6jrPt6bSHDO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700064046; x=1700668846;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eFmbaY0oGVZ7sScVBLanmu7D2D9vxvb7T+NtcQ3NkJ4=;
        b=Obcd3NsLXOmPF+o6jBSdMzJ24r+e7AWe0D5oGewa7cjugQXAPV7jiJsX8p91cS7DgA
         Cg8A1QCWyVkF7OJlHWVkRiqKkxsitMaaimGfgepkiSFGRC16Dn7dj/BIZhiU9wyLCxMQ
         Xw6kw/DeOzlLsTGMOh29TJT9o4gvItcW16/83sflR3RneQzdxbI2PgEyuRoLpoXcc2NU
         B9c53RMmbGkAP/xPZsdRtJnwVD9F/PKu1BpLceSvzYehNBBusJus56jVqfupQnRh9tVC
         Ej5JNts4XcIoasgafiS8tmNQB5DC9jkZHlyHJUuYpXe2rd2w1/eJIYRnL4JMj38OusDa
         nF8Q==
X-Gm-Message-State: AOJu0YyAZAvlFDzhgRiwQbMcg8bv2+2q8GvP/zEQ+OdJty7TCUQ5/VUD
	cOmWy3qWVvB1tMBGs0utCZ6n/BsDoc0EJayXmByAqw==
X-Google-Smtp-Source: AGHT+IEC7e0xzEZvfFar3WHPgtO7pOAY07ejbJf+y9ARFz7vkcAW/xxvlGk01OR2uItXzOvVmoLvaArE9Pf6m0XXx+0=
X-Received: by 2002:a05:6871:5c47:b0:1e9:bbfe:6458 with SMTP id
 os7-20020a0568715c4700b001e9bbfe6458mr7237902oac.1.1700064046168; Wed, 15 Nov
 2023 08:00:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231110200830.1832556-1-davidgow@google.com> <4e0c8bb796a67af5fb901f831c5f87fe.mripard@kernel.org>
In-Reply-To: <4e0c8bb796a67af5fb901f831c5f87fe.mripard@kernel.org>
From: Daniel Vetter <daniel@ffwll.ch>
Date: Wed, 15 Nov 2023 17:00:35 +0100
Message-ID: <CAKMK7uG-FH6iLpNpQ74xXPZoyGoDGvg+L99oCK3nFZT43o6GcA@mail.gmail.com>
Subject: Re: [PATCH 1/3] kunit: Add a macro to wrap a deferred action function
To: Maxime Ripard <mripard@kernel.org>
Cc: David Gow <davidgow@google.com>, dlatypov@google.com, 
	dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev, 
	Arthur Grillo <arthurgrillo@riseup.net>, Benjamin Berg <benjamin.berg@intel.com>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Airlie <airlied@gmail.com>, 
	Emma Anholt <emma@anholt.net>, Kees Cook <keescook@chromium.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mairacanal@riseup.net>, 
	Nathan Chancellor <nathan@kernel.org>, Rae Moar <rmoar@google.com>, 
	Richard Fitzgerald <rf@opensource.cirrus.com>, Sami Tolvanen <samitolvanen@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Thomas Zimmermann <tzimmermann@suse.de>
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 Nov 2023 at 16:51, Maxime Ripard <mripard@kernel.org> wrote:
>
> On Sat, 11 Nov 2023 04:08:26 +0800, David Gow wrote:
> > KUnit's deferred action API accepts a void(*)(void *) function pointer
> > which is called when the test is exited. However, we very frequently
> > want to use existing functions which accept a single pointer, but which
> > may not be of type void*. While this is probably dodgy enough to be on
> > the wrong side of the C standard, it's been often used for similar
> >
> > [ ... ]
>
> Reviewed-by: Maxime Ripard <mripard@kernel.org>

Acked-by: Daniel Vetter <daniel@ffwll.ch> for merging through kunit
tree, since I guess that's the simplest way to land this.

Cheers!
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
