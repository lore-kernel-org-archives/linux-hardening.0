Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C12360B91
	for <linux-hardening@vger.kernel.org>; Mon, 29 Jan 2024 19:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706556534; cv=none; b=SxMZHwzyF9KWvnnuoDSIgOdHp4QjFvfvlWrVnPo9VNMX9mU+Pf9v2woz1uup19GudfKAO92GoDJqlheXWR+J+022lN2yFZSFxJgAnV3+GqkKOQKbrWfFmcb4h1OaXZ6WaY+6PR1vX4kVYfAv+dlAmASkIaw8O3HByP3b28a2FLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706556534; c=relaxed/simple;
	bh=7bdNepJiP6oLjPO0eQ1b0b6p30oE249gYYVwlVp5kNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C16/LKebnyc8ahv/NfpARGFF/3GG+sbczy55vwDORvNqf+dBs93+N0FBQaOHMS4Xmqm61RUVC1G8RMk27eS0ZGwXQoyhMZYErbg2rGMN96U86OeuTpYrIovTRk1Zs3mF3SWYQQz7JxZdylmTBtlsFWyt/y8tSJfTy5b3xPGTYxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YeLcOT08; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YeLcOT08"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5cdbc4334edso1402313a12.3
        for <linux-hardening@vger.kernel.org>; Mon, 29 Jan 2024 11:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706556533; x=1707161333; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ScNmg44xBpVe63VfoguT/abKN6k7Q/YMRMqssyi2qYs=;
        b=YeLcOT08wAr6us5WfNdm+sX1X57U6nAnpnNPEG2UjHinAoWyLn+5A9f0FiqWtMLyCE
         uKty/YqqBsr6H9GhpReVTJUx0YTT2K9QVU1hgzo8wevw5riRUK3jpnyQTc45IW1IaBG8
         /0N2k+sdRgtjLv4oBqz7dQwsJukzXSw035lbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706556533; x=1707161333;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ScNmg44xBpVe63VfoguT/abKN6k7Q/YMRMqssyi2qYs=;
        b=OJS6JpuABL5z1VHEsO87CMApnUUYERVoFuw0OFs4PDOUq3ICqDtbc/2QSD0zDWnyKb
         3FvXdNlGmwrVYpZh4qQCag7JgFEWP3996NtU2K7j8a8RJcZJySQ4gAt6xNa8KcsKZN2I
         bxmeO/5VIPRk0nl9WM9m4DKqhrPfv1NbMgY+/zFeR7UFfM1xYJca+RM8l3ePh3CryKtP
         Ko5b9GfJA42M51FR/sSaW2dn+RUrw6P3lhraJQt75d46QZF3ecOdF293EiYl76Ky+Mmh
         bVk6PEhzfqzJdJCEfAdsTgzRJkmBLwo8tNFP9tzwCTcWY4ElGErWvC2eiWUROYZqYD5d
         loOg==
X-Gm-Message-State: AOJu0Yzhfs2i5dzoONWdziLbmhj73vBFbGgy5Gg5rEzXyhfk51dGndTz
	AX9eGjPQCpmuPNJ0WV1D884edJjUBcQqYrNnya3ofaTge7Ly64PP++lcpb7Org==
X-Google-Smtp-Source: AGHT+IGSosZo2mtIA7CSE/CntNbdjSj1vJgteTG8YkMeIjNdXyQpn74Y8EkvnRzZYlnmDK5eEZWZFw==
X-Received: by 2002:a05:6a20:841f:b0:19c:73e4:2a14 with SMTP id c31-20020a056a20841f00b0019c73e42a14mr3369660pzd.34.1706556532724;
        Mon, 29 Jan 2024 11:28:52 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s1-20020a62e701000000b006dd815b57c3sm6214024pfh.31.2024.01.29.11.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 11:28:52 -0800 (PST)
Date: Mon, 29 Jan 2024 11:28:51 -0800
From: Kees Cook <keescook@chromium.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Behme Dirk (CM/ESO2)" <dirk.behme@de.bosch.com>,
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-hardening@vger.kernel.org
Subject: Re: rcar-dmac.c: race condition regarding cookie handling?
Message-ID: <202401291127.CDB6C65@keescook>
References: <12ff20eb-d4b5-41f4-a494-cfb6b7abe617@de.bosch.com>
 <CAMuHMdW=igXesjxvNk=+in62neW=kipnFW2BUH3P7sfDnqXzEQ@mail.gmail.com>
 <202401290926.67193AB2B@keescook>
 <CAMuHMdWjjjDbVRT6Dz0gnnNpTk2f4nKDBPKZr1GoDOhgAdEpJg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdWjjjDbVRT6Dz0gnnNpTk2f4nKDBPKZr1GoDOhgAdEpJg@mail.gmail.com>

On Mon, Jan 29, 2024 at 08:08:28PM +0100, Geert Uytterhoeven wrote:
> Hi Kees,
> 
> On Mon, Jan 29, 2024 at 6:38 PM Kees Cook <keescook@chromium.org> wrote>
> > On Mon, Jan 29, 2024 at 10:57:40AM +0100, Geert Uytterhoeven wrote:
> > > CC Kees (for the wrap-around in dma_cookie_assign() not handled in [A])
> > > [...]
> > > Was the system running for a very long time?
> > > dma_cookie_assign() relies on 2-complement signed wrap-around:
> > >
> > >         cookie = chan->cookie + 1;
> > >         if (cookie < DMA_MIN_COOKIE)
> > >                 cookie = DMA_MIN_COOKIE;
> > >
> > > but given the kernel is compiled with -fno-strict-overflow (which
> > > implies -fwrapv) that should work.
> >
> > For my own reference:
> >
> > typedef s32 dma_cookie_t;
> > #define DMA_MIN_COOKIE  1
> >
> > struct dma_chan {
> >         ...
> >         dma_cookie_t cookie;
> >
> > Correct, as you say, with -fno-strict-overflow this is well defined, and
> > will wrap the value around negative if chan->cookie was S32_MAX.
> >
> > In the future, when the signed integer wrap-around sanitizer works
> > again, we'll want to change the math to something like:
> >
> >         cookie = add_wrap(typeof(cookie), chan->cookie, 1);
> >
> > But that will be an ongoing conversion once folks have agreed on the
> > semantics of the wrapping helpers, which is not settled yet.
> >
> > If you want to handle this today without depending on wrap-around,
> > it's a little bit more involved to do it open coded, but it's possible:
> >
> >         if (chan->cookie == type_max(typeof(chan->cookie)))
> >                 cookie = DMA_MIN_COOKIE;
> >         else
> >                 cookie = chan->cookie + 1;
> >
> > the "type_max(...)" part could also just be written as S32_MAX.
> 
> It's actually more complicated: this code is also used to make sure
> any other values outside the valid range (e.g. initial zero are
> converted to DMA_MIN_COOKIE.  So the above would not be correct
> replacements for the current logic.
> 
> DMA cookies can also contain negative error values, hence the signed
> type. However, I don't think that can be the case for the chan->cookie
> counter, only for cookies stored in descriptors.

Ah! Okay, well, if it was true here too, then the "if" would just need
to be expanded:

         if (chan->cookie < DMA_MIN_COOKIE ||
	     chan->cookie == type_max(typeof(chan->cookie)))
                 cookie = DMA_MIN_COOKIE;
         else
                 cookie = chan->cookie + 1;

-- 
Kees Cook
