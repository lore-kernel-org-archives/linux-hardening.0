Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF6D1848
	for <linux-hardening@vger.kernel.org>; Tue, 27 Feb 2024 00:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708995183; cv=none; b=G0PtGsOQ1D3opHu2ufC77P2VMN+MMzUV720rmqVFUL0rtAnz6etkKue33pEFVnmyhMWkOsXDndywDfFDQ1Skp4SGQryUVfgpKLQABigF7AB7hULO+IExKAZTmtw5d3Ipg0T8rsdHncuAwTEt9de1F4UiFVblEXJVXgVcPglP76c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708995183; c=relaxed/simple;
	bh=V6A7al1ppGka0azTB8qp3lV4rogqK7JhSynkjAKsxYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X1VciZ6l3uASBAABA9PaUgLPoS9R90tQsdQe5vhK5Y39avkzwFp+FAmfHy41mwudIa3DEHFBvIQ2Wb5R78k3WBIGYENu2dhNmz9WTFdOWnAf04IKHf8YMT0Ro5fTAKJK61ejtkXhekJT/VTrBqFufi/h1JlDKtMMgZgVAjtVReI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JRQIksFS; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JRQIksFS"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6e544f927d4so338659b3a.0
        for <linux-hardening@vger.kernel.org>; Mon, 26 Feb 2024 16:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708995181; x=1709599981; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BZbMzkvIVzOfkFlvvubcJk0J0hloUqaH3xyhrZRKFHU=;
        b=JRQIksFSOBMZLWcmRlVGnx75hNRXVEmKBqY2aaDC1XffXWmuaTAmRIAPzuxdLzyVzj
         9uRV+y4GAqDeOEXut+LFTDwtJyphzoT9IRwgVkA1PQxovXtPB9Up7OCF+m+AlWqUR+7S
         bw4ivt4B+D6xQlV126bErH9mRPtWuE0/frcHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708995181; x=1709599981;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BZbMzkvIVzOfkFlvvubcJk0J0hloUqaH3xyhrZRKFHU=;
        b=IzOt9pyoun8CDmyuBcav8aFwSlLLRODKidf2WXL2AoKec6H0+Rbk5k4uEizlZeoCSB
         p61IWxJWyWFMU9s/pm6g+zKW48FrQCd1IFP/jw9K1w/f3XuWq9cgoWbB2+gJFylvcGOc
         pEcMfPnvd/PY0Qvqj+hUJvgqcXpbDsG63/MTAz3gAoQ5IT9NlJC31pfOv3TktU/Ot105
         s8U6c0E7GRqqAbdXrU1Fm+W1QqvFCSq3tFghI/xBNJGRufvEJhT55yWoPFZhbdGWqjb9
         wfLe5MMfVSpZp8/SDyY/aLHKu8uJ8trqc1IM9O5lbkiIehTV7wuSsUkmYNRiqoDmSBTZ
         BuhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTOvJ/qjGr5vIBgckF9SQ45Ug80hik/Jys8B5OfgknNlaI2GhpTR1XZJ2gxKPq1vIp3nq7EbpV7O428BqWovOykr4Z71qHGw0bjr37GIMH
X-Gm-Message-State: AOJu0YxUqG7k1xFSkMCaMfkxAeUJthYX9NAzzwmADyjwOPMnssLlJhb1
	WhxoeZcqslR+qapFpBmYYl6P15dEb+y6J4nlors5P7EpBXFB+1JpwmjhjwedaQ==
X-Google-Smtp-Source: AGHT+IGymmYDQSZ5/XUv6z4QO2Px0IowCoCW3KGp+FsYBiIOOkSnr19mWBPp31IKLedgPuIEP0pvTQ==
X-Received: by 2002:aa7:8883:0:b0:6e0:50cb:5f0a with SMTP id z3-20020aa78883000000b006e050cb5f0amr10992854pfe.12.1708995181484;
        Mon, 26 Feb 2024 16:53:01 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 16-20020a056a00071000b006e3809da4fdsm4573143pfl.83.2024.02.26.16.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 16:53:01 -0800 (PST)
Date: Mon, 26 Feb 2024 16:53:00 -0800
From: Kees Cook <keescook@chromium.org>
To: Doug Anderson <dianders@chromium.org>
Cc: Adrian Ratiu <adrian.ratiu@collabora.com>, jannh@google.com,
	linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@collabora.com, Guenter Roeck <groeck@chromium.org>,
	Mike Frysinger <vapier@chromium.org>,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] proc: allow restricting /proc/pid/mem writes
Message-ID: <202402261650.DE0601F01@keescook>
References: <20240221210626.155534-1-adrian.ratiu@collabora.com>
 <CAD=FV=WR51_HJA0teHhBKvr90ufzZePVcxdA+iVZqXUK=cYJng@mail.gmail.com>
 <202402261110.B8129C002@keescook>
 <202402261123.B2A1D0DE@keescook>
 <1405e4-65dd1180-3-7a785380@32026879>
 <CAD=FV=Vh7Ctaj6N_k9gdkrqpb687zJqQN19qTZXMyDw6TujvLQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=Vh7Ctaj6N_k9gdkrqpb687zJqQN19qTZXMyDw6TujvLQ@mail.gmail.com>

On Mon, Feb 26, 2024 at 02:37:29PM -0800, Doug Anderson wrote:
> Hi,
> 
> On Mon, Feb 26, 2024 at 2:33 PM Adrian Ratiu <adrian.ratiu@collabora.com> wrote:
> >
> > > > [...]
> > > > +config SECURITY_PROC_MEM_RESTRICT_WRITES
> > >
> > > Instead of a build-time CONFIG, I'd prefer a boot-time config (or a
> > > sysctl, but that's be harder given the perms). That this is selectable
> > > by distro users, etc, and they don't need to rebuild their kernel to
> > > benefit from it.
> >
> > Ack, I'll implement a cmdline arg in v2.
> 
> Any objections to doing both? Have a CONFIG option for a default and a
> cmdline to override it? This way if a distro wants to restrict writes
> by default then don't need to jam more stuff into the kernel command
> line.

For an example, take a look at randomize_kstack_offset and
CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT.

-- 
Kees Cook
