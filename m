Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A8E2E2DDD;
	Wed,  3 Sep 2025 20:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756931012; cv=none; b=JDZPMV3aRz4tQ+uebKsRorl0+aFDnYZQDFNxyUrK/dLZwXmIcTHZh82JoNxVPzUaU5MqADRmLNdGU/AAk3MITBpFnSwJV/M8B5JwJLvyLN+38hdVBDlH+hXMZlUHmX1LLLOwy7AEenlbp0jD6WtvHIPczyOp7tRyZ+EIU9JWQIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756931012; c=relaxed/simple;
	bh=XKrol/jfuFCAmQQzMJdpHdOxULYYkFNf5bp11Fmwrsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rtNAzcrKTGcLcdQUAOGhiyuLMyag33c3zkJuwHT7KcrCmHJyQq0yvnx0yGcnMAh4aRJwzYE1zsoomFdju+l37olQBCqCNt7cfh//rkIQqFmlX1lD4xeXJ2HisZesxhZtb1rZ3zEiveHqxRBazos0TsV2doVjdWRERCDlXk7JYXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TYSiEuHe; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TYSiEuHe"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-24af8cd99ddso4793575ad.0;
        Wed, 03 Sep 2025 13:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756931009; x=1757535809; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XKrol/jfuFCAmQQzMJdpHdOxULYYkFNf5bp11Fmwrsg=;
        b=TYSiEuHe+jhup7eGwI81lsP6YcvgiLx/QJNQIioHM7eW4tqBlAjawKZAaxpdNFOVxn
         kJChQ0IRwctL9r5ygZB1Uzt60ztiVG5A/ShF0s8L0c/l3tXyJlFlUFKgvUkIr5fbsBjW
         2Elz/tCfH9Rr5k+35YcpeUQGYwZf0W+sFnkxTG5IPiMkj1l1bBo0j3wWNpP7OPWmR/uy
         GGZ/53e2gEo8b/antwwOPuJS3qrSaVVEp8wjurA1sXJyS7RXV7+DxPmgp7RhB3G2wQfP
         ZxJO1FmRFzMayVXMIF/b4iMbEivhGVubhIOrIR+OmD4kyOKMGrjjFd52SPw9ZCyFvGTk
         Xu+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756931009; x=1757535809;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XKrol/jfuFCAmQQzMJdpHdOxULYYkFNf5bp11Fmwrsg=;
        b=qLAlkfAupYvBakkcyvlGkQyxjCIHJOHPygRfaJJTLJ8GkJbxdrYMO99k8kKzYKgzaz
         scQb0nulAVRXVWA1q+UjKl5QjHViZGycKRN4ivhX/j3Och3GaC/Sp6suDGHbSLzItYAP
         4qZLM/AioZ5PX66eOqxEY95XDebtMYw5Wt99h9J2yYO+yDl3caBg4R2uj0tAHeNMmbvw
         MlnaVGKygYIQw6wRz+BJZF2eHFfAMEJb9SD0jd2/AhTSQTtpmYn4GJNhZ9YJcunDjTd5
         v6a71XVDJ8avrjrQpt+jAowyGwCFyMs4JZsTZeccG6BrC/eBBXHMLYELkwweY9K95aKA
         NiDA==
X-Forwarded-Encrypted: i=1; AJvYcCUKIwxqFqd1qUkut/2poNzyVBTr79t6OFwsPZuVkUyVTzimWPvpCPVaxnd1CVoLOQ0iYfF97adlVgqgU+Yo7wY=@vger.kernel.org, AJvYcCUSUceeYzm0ioS9okXMjeHq0XbUAiKDqq8udCDigyaN3QMsC885Q6RmyrnZWxKxLrBa33M/lFgDt0ip3G8jvOk=@vger.kernel.org, AJvYcCVpyvazXP+b+CcYg6JXSCtLDg9Oce6EmI0GaCk3gPqjHduEi/qXIv2bXOISD/wmwxJi1fFvgf2UcHJPKS4M@vger.kernel.org
X-Gm-Message-State: AOJu0YxO2JgUjNDzJczX6h+CeGxoqoORt+ZonX+YmUjnbj+8Dplh+S3S
	F96R8SCLGqvM+VZ4T4MWNnmAk8M7MXfcF6Qpi9xGvQlRN7x+qKnAR5I1
X-Gm-Gg: ASbGncsA6tbznpizLkdL43Agewps8Yz7g5wzixKxrIKXIfNkjx5yPOpP0aipOfioGsD
	08jYXjVUk7MkTIgqfsEES+vODU6P3/nVQ16D5vX8pKVaRUsJvpir6Z2depxl8b2xmF21ULMMRWh
	W8byEuMoVKc1L5NnaxjTVGcC6e4xWimsTKkr1tVJr6/wxH5aaXgPZoG0mfTS6MR2qD756BAWrM+
	tB7hMk/HQWcgwoiUR/5bgMYkUC8TM+fFKHYza2s2PnSUAaWXiQscmejVMLvmSZW1HGZcjkOgzVF
	vsrrXBpi51l2p4Jf9eJ7M1fwmDO2qrZzne7vZ0TEK2v+yyP6tHMQXcCqqUqo5NU0ROlg2WJ0UnO
	haQzL31TlYJmd9teNFUihZQ==
X-Google-Smtp-Source: AGHT+IHlnFY5hTJ0kydoRG8Js74B72lzqORZromXAtkae8dA0NThgILnarSrne93rr4njqiKXFqLSQ==
X-Received: by 2002:a17:903:1252:b0:23f:f96f:9de7 with SMTP id d9443c01a7336-24944b62e7amr182014985ad.51.1756931009506;
        Wed, 03 Sep 2025 13:23:29 -0700 (PDT)
Received: from localhost ([216.228.127.131])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-329e6d6d4b2sm5741810a91.0.2025.09.03.13.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 13:23:28 -0700 (PDT)
Date: Wed, 3 Sep 2025 16:23:26 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Burak Emir <bqe@google.com>
Cc: Kees Cook <kees@kernel.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Carlos LLama <cmllamas@google.com>,
	Pekka Ristola <pekkarr@protonmail.com>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v14 0/5] rust: adds Bitmap API, ID pool and bindings
Message-ID: <aLijvpTZbXP764mY@yury>
References: <20250813153548.1650533-1-bqe@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813153548.1650533-1-bqe@google.com>

On Wed, Aug 13, 2025 at 03:35:41PM +0000, Burak Emir wrote:
> This series adds a Rust bitmap API for porting the approach from
> commit 15d9da3f818c ("binder: use bitmap for faster descriptor lookup")
> to Rust. The functionality in dbitmap.h makes use of bitmap and bitops.

Hi Burak,

I'm having hard times trying to merge the series in bitmap-for-next.

$ git am -3 v14_20250813_bqe_rust_adds_bitmap_api_id_pool_and_bindings.mbx
Applying: rust: add bindings for bitmap.h
Applying: rust: add bindings for bitops.h
Applying: rust: add bitmap API.
error: sha1 information is lacking or useless (MAINTAINERS).
error: could not build fake ancestor
Patch failed at 0003 rust: add bitmap API.
hint: Use 'git am --show-current-patch=diff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

Can you please rebase and resend?

Thanks,
Yury
