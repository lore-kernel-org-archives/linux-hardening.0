Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CE73F4A8
	for <linux-hardening@vger.kernel.org>; Tue, 24 Oct 2023 21:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DeEa4Phk"
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3AC2A3
	for <linux-hardening@vger.kernel.org>; Tue, 24 Oct 2023 14:35:05 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1cacde97002so29726675ad.2
        for <linux-hardening@vger.kernel.org>; Tue, 24 Oct 2023 14:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698183305; x=1698788105; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NHsb4Ex0pB6bm1QiWPhIzbrZDkhX+OINEs8BrrsAL2I=;
        b=DeEa4Phkr1la2u5YXkC5CeCHP+QSmSPD2awU1a9nGGQAlesheC9MH9+eSHS1O68fU+
         WeVtTf8efKvEdP1EiMM+RkJ0QqL+6GMT8eTQ8EMb7JHkPRrNR4kTum2tjEFXt565xIAr
         u7ZaS5rW1vuQiXLud7qJthLnLrxuZ4lj7Qki4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698183305; x=1698788105;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NHsb4Ex0pB6bm1QiWPhIzbrZDkhX+OINEs8BrrsAL2I=;
        b=Pxszj0/3tlxOAqqGm+kBYAnOn8ybeCQQulq1LyxzXfwF+RcwAgtZf2SSdFU/GSLyiX
         DVqQruKukYxkQgjdozFJon4EHSR25s1KBE2lsyQ4RkW2j1PVhEcICr+v/tNaknq7IiDr
         18l9xm/BFS4DpJJBAXB07Qqr8e6WOkS1r3uTepQs9GUc2S24IfBuGQDrDY5cs48HehGe
         oTnpP+XTi9I1Hlk8QGExgB1iAL/H5cywFNTZ09aETls1TfDXyO757T952/mUOZq5pi4p
         abU+U7Oav3OJCDMAsTh5ZE36tFuUsf6EFJQ8rbmubYtz29FrjJydDBmSwRuEdL1939dO
         47FQ==
X-Gm-Message-State: AOJu0Yzq7PvsAUTcIEHJRRJHuG9Fu6MP3DvkhHJGCPAt89WNFKtPPJJY
	WCFNLZMy/WlozExd+8Cmza/Ggg==
X-Google-Smtp-Source: AGHT+IH8PaF/n/DrhVjd3Tfui8Frjxc0yy2UwijaAjvCygeAOMkANgQntYz5ozjGkte9ZI6XbWx9OA==
X-Received: by 2002:a17:902:ec8e:b0:1c6:d70:144d with SMTP id x14-20020a170902ec8e00b001c60d70144dmr14848663plg.34.1698183305222;
        Tue, 24 Oct 2023 14:35:05 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i13-20020a170902eb4d00b001c9b384731esm7865117pli.270.2023.10.24.14.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 14:35:04 -0700 (PDT)
Date: Tue, 24 Oct 2023 14:35:04 -0700
From: Kees Cook <keescook@chromium.org>
To: Mike Snitzer <snitzer@kernel.org>
Cc: Alasdair Kergon <agk@redhat.com>, dm-devel@lists.linux.dev,
	Justin Stitt <justinstitt@google.com>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: dm crypt: replace open-coded kmemdup_nul
Message-ID: <202310241434.54EF4068@keescook>
References: <20230925-strncpy-drivers-md-dm-crypt-c-v1-1-eef875e4f9b2@google.com>
 <169818232968.2100071.5806064081646325604.b4-ty@chromium.org>
 <ZTg4GA005km7mmgC@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTg4GA005km7mmgC@redhat.com>

On Tue, Oct 24, 2023 at 05:33:12PM -0400, Mike Snitzer wrote:
> On Tue, Oct 24 2023 at  5:18P -0400,
> Kees Cook <keescook@chromium.org> wrote:
> 
> > On Mon, 25 Sep 2023 06:35:54 +0000, Justin Stitt wrote:
> > > kzalloc() followed by strncpy() on an expected NUL-terminated string is
> > > just kmemdup_nul(). Let's simplify this code (while also dropping a
> > > deprecated strncpy() call [1]).
> > > 
> > > 
> > 
> > Applied to for-next/hardening, thanks!
> > 
> > [1/1] dm crypt: replace open-coded kmemdup_nul
> >       https://git.kernel.org/kees/c/17348b0a6a6d
> > 
> > Take care,
> > 
> > -- 
> > Kees Cook
> > 
> 
> I had picked up this patch and the 3 others in my local tree
> yesterday, was going to push shortly... do you still want them to go
> through your hardening tree?

Oh! Great; thank you! I'll drop them from my tree. :)

-Kees

-- 
Kees Cook
