Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AC21D692
	for <linux-hardening@vger.kernel.org>; Tue, 24 Oct 2023 21:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mT4s4Uka"
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD0DA10D7
	for <linux-hardening@vger.kernel.org>; Tue, 24 Oct 2023 14:19:07 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6b2018a11efso4801782b3a.0
        for <linux-hardening@vger.kernel.org>; Tue, 24 Oct 2023 14:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698182347; x=1698787147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nN6qLLiV1hMbAd2ABROBC8TqYl495gWbFutxERKWZ5Q=;
        b=mT4s4Ukao4U0XP3DnWwD9hL0lnywK/bw3sgWt6Obl8bftn20XFbV51NPQ+SRr1/l04
         jSRw0NG8tauKCbkmDjytC0I/+WH8qg+78JLFCuvgMOCa06cvD3AYP2dJTvj0wBrbiJyz
         uOuayNPuk3DEGn2h5EBgIlKxpoG3I6F+3NZi4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698182347; x=1698787147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nN6qLLiV1hMbAd2ABROBC8TqYl495gWbFutxERKWZ5Q=;
        b=kQxrDDEX3qLBWDOS2k+ZZdvCr6bkL8nb/XNNgz5Dd1gkmR5pxdl+R3lrWvjXUu/BgI
         Kgo0KQoglGvYmYttW0H5d+xZLqGDmbCyVcy4xp63MJRN0rUdVd0jG6XYAiNXh2wycmI7
         3tS6ll1rsKZsx2OQ0M4/SnUJK+SUy3OoVm8zILXk/klHP/MD65eNwzjMcZl/EXtACrWc
         cCD/j427fPg478CSd2jrWqX6gPLiGQBCJf5k2ED3TC2b7qAQojbNK4YQziz8AsSo9nHN
         8Qtq+dvFvFg5W5PuLq4YojZMCirMEpC5g2B/Gkr9XdPryOGrpQWArfQL8Oob7jbTFZ2S
         cMkA==
X-Gm-Message-State: AOJu0Yz+6Gz46DN6Pa6QFiwW/RreHinisRcHZCjK1fvykdOtN41G5eP0
	otULfS+aGN8SZeJrgLG3b5PGRA==
X-Google-Smtp-Source: AGHT+IF34WCz22LleHdBIoXGoj6CerzAjgn+5ajfqq2LqtYNzNXC/G3yfQWrDrbHRch4V57IWmaAtg==
X-Received: by 2002:a05:6a21:7983:b0:170:3e5b:bccd with SMTP id bh3-20020a056a21798300b001703e5bbccdmr3039533pzc.30.1698182347115;
        Tue, 24 Oct 2023 14:19:07 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h29-20020a056a00001d00b0068fbaea118esm6013685pfk.45.2023.10.24.14.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 14:19:04 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	dm-devel@redhat.com,
	Justin Stitt <justinstitt@google.com>
Cc: Kees Cook <keescook@chromium.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] dm crypt: replace open-coded kmemdup_nul
Date: Tue, 24 Oct 2023 14:18:50 -0700
Message-Id: <169818232968.2100071.5806064081646325604.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230925-strncpy-drivers-md-dm-crypt-c-v1-1-eef875e4f9b2@google.com>
References: <20230925-strncpy-drivers-md-dm-crypt-c-v1-1-eef875e4f9b2@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 25 Sep 2023 06:35:54 +0000, Justin Stitt wrote:
> kzalloc() followed by strncpy() on an expected NUL-terminated string is
> just kmemdup_nul(). Let's simplify this code (while also dropping a
> deprecated strncpy() call [1]).
> 
> 

Applied to for-next/hardening, thanks!

[1/1] dm crypt: replace open-coded kmemdup_nul
      https://git.kernel.org/kees/c/17348b0a6a6d

Take care,

-- 
Kees Cook

