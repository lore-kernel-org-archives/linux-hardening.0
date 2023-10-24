Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A254F3F4D0
	for <linux-hardening@vger.kernel.org>; Tue, 24 Oct 2023 21:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58886133
	for <linux-hardening@vger.kernel.org>; Tue, 24 Oct 2023 14:33:16 -0700 (PDT)
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-58410ce2f02so1983116eaf.2
        for <linux-hardening@vger.kernel.org>; Tue, 24 Oct 2023 14:33:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698183194; x=1698787994;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ydoeA8bMPTFfL7KIyd2iImmXpydvV8NCmR/UYsYbpxw=;
        b=mFfvjVqQ0fFweEPsgs5WC4mdEDa0wGIQuv+dyq4Yhyvfo4Wk2vRpW9LYgkwxwJfSkb
         RqjfBjmfRcbX6KY3eEX1rgoh9f6AVmoA3QzeP/KmOCx77M5ZOx5VjufGFgdq+c9qKAOs
         iZfBnrjtp+bTNVNxiFhuXiQ3O+mLH1XOQE+TR44avDM2foGDphUsfVSA0LmJ5WerxjXo
         y0ZEOfgOKNiKnFk8JFPYOKZeFeGNM/wZcg1jSPLNBoyIHQeixgclx3dKMaIk2+yOXJx/
         8P1zTJc0MciVrtAOxdpLM6UFI1X2/NreXRGpNzn5JRAH0mhNA4q0UbaXDO/Q1EuWTj96
         HedQ==
X-Gm-Message-State: AOJu0YxnTNvKUiL1m5ED7inYFGx/NOi7p2RRCQoFmk/8sshqgrnOi3/7
	nWpxO8/5g8Q2raE58jc3T+Hu
X-Google-Smtp-Source: AGHT+IFqScwwPuBCfU8gLwXESZj/TMXWuFnwg6pun1lrsaq6xPSm0Hu7AUgBAWsoFigBdJfZnWdsrw==
X-Received: by 2002:a05:6358:72a3:b0:168:e707:2e56 with SMTP id w35-20020a05635872a300b00168e7072e56mr4769109rwf.16.1698183194698;
        Tue, 24 Oct 2023 14:33:14 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id e20-20020ad442b4000000b0065d1380dd17sm3840065qvr.61.2023.10.24.14.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 14:33:14 -0700 (PDT)
Date: Tue, 24 Oct 2023 17:33:12 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Alasdair Kergon <agk@redhat.com>, dm-devel@lists.linux.dev,
	Justin Stitt <justinstitt@google.com>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: dm crypt: replace open-coded kmemdup_nul
Message-ID: <ZTg4GA005km7mmgC@redhat.com>
References: <20230925-strncpy-drivers-md-dm-crypt-c-v1-1-eef875e4f9b2@google.com>
 <169818232968.2100071.5806064081646325604.b4-ty@chromium.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169818232968.2100071.5806064081646325604.b4-ty@chromium.org>

On Tue, Oct 24 2023 at  5:18P -0400,
Kees Cook <keescook@chromium.org> wrote:

> On Mon, 25 Sep 2023 06:35:54 +0000, Justin Stitt wrote:
> > kzalloc() followed by strncpy() on an expected NUL-terminated string is
> > just kmemdup_nul(). Let's simplify this code (while also dropping a
> > deprecated strncpy() call [1]).
> > 
> > 
> 
> Applied to for-next/hardening, thanks!
> 
> [1/1] dm crypt: replace open-coded kmemdup_nul
>       https://git.kernel.org/kees/c/17348b0a6a6d
> 
> Take care,
> 
> -- 
> Kees Cook
> 

Hey,

I had picked up this patch and the 3 others in my local tree
yesterday, was going to push shortly... do you still want them to go
through your hardening tree?

Mike


