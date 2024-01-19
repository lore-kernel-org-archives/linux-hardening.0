Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212B457888
	for <linux-hardening@vger.kernel.org>; Fri, 19 Jan 2024 22:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705704804; cv=none; b=VMsCBDjJYDT2OJP9dxrNWACbp5T+n84mA450TF8NYnx7ptbKnjtPVt5V2v9SKfNd4HoKbOFNiqbMw8L7LTtYTYf6y4udloqTSo+5p5+lTjs3xLWz1nIRL2SOr6cNdeFI6JNuXMs8zkahL4vCDJ1n5zIfR90zpCHkreoruN4hezg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705704804; c=relaxed/simple;
	bh=cXFQABVkDQ0a0E3pFCzVsdT8CC/V4HbLE2EFYUk9T0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dBD7kfcmwp181vAp0RSgnq71OtDvEDbz3vhntfl97oaV4KTKtv7XZMnxT13/MmqOBjqy4ep0we1W2WVq9ZOmyzSn3C/dgaGcLZU+kdRnecdqHZgCxvac/e/ahdwDis0J9wqLnIUbQEv3DbtO1dIwfwYxxKJDa84GSO1lD9GdeIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Wsj84mse; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Wsj84mse"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6da4a923b1bso1102809b3a.2
        for <linux-hardening@vger.kernel.org>; Fri, 19 Jan 2024 14:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705704802; x=1706309602; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sWad+tkSe47JjCBUATlLgY9DkjlP39hvBfIJ4tcS5v4=;
        b=Wsj84mseOuuJwWKO5DTTHSZOePaHDDj2v9gpifG0cMQDIJvA47qHZb6hMliEhYd+9E
         vfuSfgoblCtjHtIVQ0Tjbp05dyrQ3EgeQd/0sIXLH9K2CNcqnB3HGCa/xfX4Wck3UBHt
         kj00AktNWWa/WnHZHI7sRgiROmZUW3O8sObMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705704802; x=1706309602;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sWad+tkSe47JjCBUATlLgY9DkjlP39hvBfIJ4tcS5v4=;
        b=fgCCM8n0258acKFjKviucxjGROIFhmP/Hk6W/2o/S0Dj/Tr0Ncho0SG+PId3CU6Wpc
         TwvAQppCWzJX1QWX2l2PLI+B28ApkCxqN0GbZebxz2CJ3hAjvBwPFh2QT6oACfZkVwxC
         9LBsnqTWy18Wn+sUWLzasnxlVpuw/D7mDF/rQmwLKIRPZw6HM2pbSz3gkKPhnujPL+ow
         EODHlr7b2zz7AkqWyJhk+mNYRDQ57bQo+Sy4n7me5qOg+aFKSrVcqgAThAzH8kMlKiMp
         O5TuOI9x153KfGKpJuwaM6no2dHtLqPI2c/UZfCZJjA163FmydTm4telwiX8ankot1NT
         zrrQ==
X-Gm-Message-State: AOJu0YyyFt5sc6fSNgiazeZe5ba6OdHEa1YBmFVHyqlftOw8WIkNnRMW
	a8fmhgF7FN7Br+1DSGWQwxfdPerCZh+e/jaWsx1Ib1qefwTm2JJmBLyikq5aqA==
X-Google-Smtp-Source: AGHT+IE+IQHn+4YqB/lmtgA3p4J8DA8wXFp6+0CzprVWrwhYC9bV9FJqlGyXVmXghPBe/oDy22G7SQ==
X-Received: by 2002:a05:6a20:3943:b0:19b:827d:ee10 with SMTP id r3-20020a056a20394300b0019b827dee10mr553889pzg.92.1705704802463;
        Fri, 19 Jan 2024 14:53:22 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id pl15-20020a17090b268f00b0028bdc73edfcsm4660022pjb.12.2024.01.19.14.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 14:53:22 -0800 (PST)
Date: Fri, 19 Jan 2024 14:53:21 -0800
From: Kees Cook <keescook@chromium.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Andy Whitcroft <apw@canonical.com>,
	Azeem Shaikh <azeemshaikh38@gmail.com>,
	Brian Foster <bfoster@redhat.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Joe Perches <joe@perches.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	linux-bcachefs@vger.kernel.org, linux-hardening@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [GIT PULL] strlcpy removal for v6.8-rc1
Message-ID: <202401191450.CAF805687A@keescook>
References: <202401191311.B6AA79D@keescook>
 <CAHk-=wj0j07B=n1Bt4EkDJpN5CBmxMuZhv+nnFdi0DxDVSiZAA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj0j07B=n1Bt4EkDJpN5CBmxMuZhv+nnFdi0DxDVSiZAA@mail.gmail.com>

On Fri, Jan 19, 2024 at 02:00:14PM -0800, Linus Torvalds wrote:
> On Fri, 19 Jan 2024 at 13:14, Kees Cook <keescook@chromium.org> wrote:
> >
> > The kernel is now free of the strlcpy() API!
> 
> .. still mentioned in docs and checkpatch. Maybe remove that too?

Sorry, I should have called that out in the PR, but the commit itself
had my rationale for intentionally leaving those in:

    Leave mentions in Documentation (about its deprecation), and in
    checkpatch.pl (to help migrate host-only tools/ usage).

If you feel like that's not right, I can either respin or send a
follow-up patch?

-Kees

-- 
Kees Cook
