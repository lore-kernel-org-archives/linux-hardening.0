Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715C91428E7;
	Wed, 21 May 2025 13:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747835453; cv=none; b=RzzgOOjBMs9fgKM5WQkdvExYIYj3U4YeEBI3WRSIzxFR2K3mPeaIlcXhLuf3mfmtF6anaAUWKQAJEK8EqftGsvvD8wgv6CwlAt9sqrD6y//ztc4xiUOmfBQI6ik32iVslv8Z/trBUiogpETMzf9MITIljdZyl5QRkqPO4hqGnsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747835453; c=relaxed/simple;
	bh=UsA9YoJF2otEMcdV3c1rOsX8L26ArSdMgD+keKpiMxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YscoocE14y5LJMsJ99PHPkx+LOZcjb59QrGTLGaFw4hJFVkuIGaQhUwiZFLfjmXnT/HyU/XhmUJghk2ShxdCDZkFKgJ/XrtYl+sMC4ez4D7OGylnmKHJtVkI95zMLvb8IIA5v4iXv35qS54GtchMBmWRaYuTsfqOy96Q25zf+TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B5f2r/NT; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5f2r/NT"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7390d21bb1cso5951202b3a.2;
        Wed, 21 May 2025 06:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747835451; x=1748440251; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R46w2tr8IxWCBsHZquRdLIceMnJPkpXIZ27lFgmh76M=;
        b=B5f2r/NT+rMPJ8MlPU0WOOhKT1DVfOKROnhrvxAu3YaL/VSyFisVcI8hdz0cSNzUNF
         WS/LnJbJOU4sfVAIAiHCvBf5zZT6AFrbWCPugTYWN3N6ROG/eKzHLBvSALBH6Xv4bPuK
         wuW9XtT9iVEZKmz7B0shVH72coR8dZy/jQd9voMybIutBkDMtus/VrADEXDZPQYwXh8x
         gzc6/2Klmdd7/cCzN/XPKVGRZLHmsWCLoWs59xpWUsfmeAdZMBkIAg1S/z+fC+jbDOI8
         5YV5lUssy1N1KmO+Ar+o6ftZbb5kP2KfgH2fzrRRnwTyoOPrmCq2B6geKlMdLOpc7Kny
         R1QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747835451; x=1748440251;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R46w2tr8IxWCBsHZquRdLIceMnJPkpXIZ27lFgmh76M=;
        b=h5/GAijFzWfVmZRsmclHDfhreNEHKi9k+d3EvwMgf94J49IFPFoJNfJ9Ln58AeILcG
         TJycMT4IN7mnV0IlphFILYgdCjdq4b79hCmC6PpXhbz775u6jKp7JWqTxpdH7nOQYdFG
         UPaSS418Ab3wR5ERzfPGFwLoA4U7guFzrdkSuxhZ5XsGqzLA3pxpGgz1Wd/J+7IeK/mK
         PppLI1mjlCjDHA9+l/hcbdLXRsxJyTB0fnxfJw960jJOPPdUtHVS1ICLJl5WyTwL6sJQ
         UE1JlyoCGuKalyApm4Dm6TPSagjz6JKxgEUyPibRzYkBuWrSLWKH1HZ2qIVkqWICOoMw
         0clw==
X-Forwarded-Encrypted: i=1; AJvYcCWvBYDSAddiAu6KWRjdSvTShZXwHITLNxkeEeeYGuxyubOqdlU7NNW4PdRzJAoQU8XXCcs8cLsqxLv4KS+K@vger.kernel.org, AJvYcCXN8hrSo4DJYdNfSDXg7ysEZuaNkRhZXZ/v38XVOshYarLo157h2HEqGyV+cnbETZXyqoG5CawBdPHqct+g8b4=@vger.kernel.org, AJvYcCXRq2KdeNPBs2NN8IAXT50gkfrq10eD42JHV56AqOes+ET/IslMq+MvhLne2yt4G4DiWhSE5QzfIGgYeExj3tI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/pFyBE+HYWgonI0TqVeXGPSgPV8F1M88dRQ507vTwJB55bM2C
	zfguQctmZrvVeGwKXRgslIw8mTDGTcaew9PGPLZ+nMurOY4n8KaPqgO7
X-Gm-Gg: ASbGncvZoHTv3iGNai/jVTo/UGcO1sHMz94Vyvmxm0fGacE7uqiAPvEYP2aTLzVj8Yo
	PWTW5v3s/CDxkfb5QO5zMmwQ/AYwx6vR8nwH8xeBFUL2CfUJD8JmCVAtxM+hC1f7IbioAXJjYNL
	lwVttjflc71RW11pr06vI5HyAs504BPQYwkbY451Cms8y2aeRzXMoT8xUS9Vq9V59qONyj5dV1E
	hKk4SEx/qdB2mnaEoT9Jy6ZbNefnxKiSpz6xWWHUV8ccPHcZPsbNB7xmmK3h2C3C+NTYQdKiPjY
	6SSSCFKufPS5CRHpj9XXX9SkH8lNcWakOIaIc6WkXUpGAJ1frGY=
X-Google-Smtp-Source: AGHT+IHq0eKFjeI06BIzgN/0Irky/CQsRzAEPDFf/mbGOmUNgOvRZ0bdxlbo1gFAcVOpwE59CRgcBw==
X-Received: by 2002:a05:6a00:3985:b0:742:a334:466a with SMTP id d2e1a72fcca58-742a97eb677mr28920367b3a.12.1747835451476;
        Wed, 21 May 2025 06:50:51 -0700 (PDT)
Received: from localhost ([216.228.127.131])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a9877056sm9880588b3a.143.2025.05.21.06.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 06:50:50 -0700 (PDT)
Date: Wed, 21 May 2025 09:50:48 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Carlos Llamas <cmllamas@google.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Jann Horn <jannh@google.com>,
	Burak Emir <bqe@google.com>, Kees Cook <kees@kernel.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v8 5/5] rust: add dynamic ID pool abstraction for bitmap
Message-ID: <aC3aOHWEGzjjDNgb@yury>
References: <20250519161712.2609395-1-bqe@google.com>
 <20250519161712.2609395-6-bqe@google.com>
 <CAG48ez2WdxXVCzVsAPeQWgso3ZBQS_Xm+9D1FLBx6UHFV1bGHQ@mail.gmail.com>
 <682bc528.c80a0220.13f632.9ec0@mx.google.com>
 <aCvTYHMtuWZZizn9@yury>
 <aC1PQ7tmcqMSmbHc@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aC1PQ7tmcqMSmbHc@google.com>

On Wed, May 21, 2025 at 03:57:55AM +0000, Carlos Llamas wrote:
> On Mon, May 19, 2025 at 08:57:04PM -0400, Yury Norov wrote:
> > + Carlos Llamas

...

> > Carlos, can you please elaborate your motivation to switch to bitmaps?
> > Have you considered rb-trees with O(logn) lookup?
> 
> Yeah, we tried rb-trees. There was even a patch that implemented the
> augmented logic. See this:
> https://lore.kernel.org/all/20240917030203.286-1-ebpqwerty472123@gmail.com/
> IIRC, it just didn't make sense for our use case because of the extra
> memory bytes required for this solution. The performance ended up being
> the same (from my local testing).
> 
> I'm not certain of this but one potential factor is that the rb nodes
> are in-strucutre members allocated separately. This can lead to more
> cache misses when traversing them. I don't know how applicable this
> would be for the Rust implementation though. Take that with a grain of
> salt as I didn't actually look super close while running the tests.
> 
> I would also note, this whole logic wouldn't be required if userspace
> wasn't using these descriptor IDs as vector indexes. At some point this
> practice will be fixed and we can remove the "dbitmap" implementation.

Yeah, I expected to get this kind of feedback from real-world testing.
Your reply to the patch you mentioned above answers all my questions:

https://lore.kernel.org/all/ZwdWe_I2p3zD-v1O@google.com/

Let's stick to bitmaps unless someone shows clear benefit of using any
alternative approach, both in time and memory perspectives, supported
by testing.

Thanks,
Yury
