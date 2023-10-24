Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659CA749D
	for <linux-hardening@vger.kernel.org>; Tue, 24 Oct 2023 23:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dFVTLNtv"
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527CE10CE
	for <linux-hardening@vger.kernel.org>; Tue, 24 Oct 2023 16:57:28 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6b497c8575aso5039210b3a.1
        for <linux-hardening@vger.kernel.org>; Tue, 24 Oct 2023 16:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698191848; x=1698796648; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+jb2uj/CUvYCQb1nd+7JiDUO6KWcdpkh68n2gxqAFo4=;
        b=dFVTLNtvHQfbRipS98kn+yVzA+Agdcob15SjfGynY2TXh6lBmY5+yVtDG7YL0u2P3x
         boX3eatRc/mV8CPlTZ3o09QO45iBV1nKsGaA5wAplbcsD8bfPpMfFUPiYzHGqb2CoDJs
         N5hBnmo3GkAaB4reJF0hk0iIVBQA6fLl7MCfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698191848; x=1698796648;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+jb2uj/CUvYCQb1nd+7JiDUO6KWcdpkh68n2gxqAFo4=;
        b=Jn7+A3oMKEopnbN0sjKdqMIVq9HiqZe2Scwfx222VrEYwpx6Pu/N2CC5SU9yYtE18X
         HenwPjAFh913S8rytt3b4DlI1A4tpEOhLMBZzuiIUOWsmdAWld5LjrRTUKKyfDud5nBN
         w1LzTGZQ9ltGZean4v8WAMjSnuhsxGtyubILyLKYYgXr5on3sOns7SR5TfbZrTu2Hdha
         gEx7ZEBXLDIclmGfQTQSuJCEZjcRHmjMXBtCMw7fQNgyoT8SODWClpGO6PcS9nGU82nb
         5D+GS0a8zXp3anvQ3ePN+naCXn6lHfgWPfp8WtRgDVxEPIlx/mkPfZEnJ3WKmCvM55Ta
         xpwg==
X-Gm-Message-State: AOJu0Yx/tSecymxkMlqSINbB4cd126ZduCl4NEPhVqfd9BwkPkBAHV6D
	dWUK3WuvuCQxz/l+oAGQ/mY1kQ==
X-Google-Smtp-Source: AGHT+IHiWgIbAS3C1mTQBzLM3/k+ba7tUzB32559w73G+RDb4OoKwzd9S25AXPmtWjJ4RMWsEs69UQ==
X-Received: by 2002:a05:6a00:10c4:b0:6b5:608d:64f6 with SMTP id d4-20020a056a0010c400b006b5608d64f6mr15661946pfu.20.1698191847785;
        Tue, 24 Oct 2023 16:57:27 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id v13-20020aa799cd000000b006933f657db3sm8127484pfi.21.2023.10.24.16.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 16:57:27 -0700 (PDT)
Date: Tue, 24 Oct 2023 16:57:26 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] s390/sclp: replace deprecated strncpy with strtomem
Message-ID: <202310241652.0A3460C@keescook>
References: <20231023-strncpy-drivers-s390-char-sclp-c-v1-1-eaeef80522bb@google.com>
 <202310241645.62B11FE65@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202310241645.62B11FE65@keescook>

On Tue, Oct 24, 2023 at 04:46:04PM -0700, Kees Cook wrote:
> > Instead use strtomem() as `e.id` is already marked as nonstring:
> > |       char id[4] __nonstring;
> 
> I'm surprised the compiler didn't complain about this -- I thought that
> was the point of the __nonstring attribute: to diagnose when used with a
> string function. Hmpf.

Wow. GCC only warns if you call strlen() on it, but literally nothing
else... :(

-- 
Kees Cook
