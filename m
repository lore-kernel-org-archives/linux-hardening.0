Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M97g5dWU"
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8627410FF
	for <linux-hardening@vger.kernel.org>; Thu, 30 Nov 2023 12:43:36 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1d048d38881so4749245ad.2
        for <linux-hardening@vger.kernel.org>; Thu, 30 Nov 2023 12:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701377016; x=1701981816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vdNYtN41s2jpwnfeA1V4jjdLs2pUYVZuwjOD5GJva84=;
        b=M97g5dWUv2qK7YEVeRI3SH4KalaygsB0vB9UgZW08qVyJZlaABUPy54+MiBd5H08AF
         e43J3cLT79T4SGPNp8150+na/fR2kAxGilUSu9YKNOLFjQFYMjtgCR9dtHbV+HQQQucB
         i5yQLS6rF6m7LyYKCpf+VnVe1cX6cOyz+iH/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701377016; x=1701981816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vdNYtN41s2jpwnfeA1V4jjdLs2pUYVZuwjOD5GJva84=;
        b=RjvEBy8kY5z7DrUuSrYV7tKZfO3wgVDcMqi00r3uc91swV6OCd8zHEagrF0x+ivs/L
         NLBp8bL8mrnaQOdkhxMNJRL3jstUugt1n4bGcblcTSiYk2htbA1XSbAmmTNfL/z2TkZS
         E5ntlXV2LwZQnHhK/Up/WA3kvlOJ6ATwCIzbrBtA1WItHhKStVtUZNRdje9TuThS+9D5
         MzHQNdxqva9JCKeO3aumDL53lD21373dPRg0DATpixCa1SO7VVGZlqh0R3WZ5c7t/n9n
         g1vQkb4RdqyzR5o/ele5PLYpNlLXDCuaww6iIoYBqy70DcS/3cj+/x8Z393HuQGHQHT/
         imCA==
X-Gm-Message-State: AOJu0YxjZCLVpRQmUhO2nPZ27vWiaa/6lRN5N1xnlsbYdm6DSrZfpTEK
	gQbC5v5qhbZVFbj+SNwDfDqJRw==
X-Google-Smtp-Source: AGHT+IFcCWPCS5aAuYhRFgwSXNFOr9+0EHuLwrCI1lVTjpQUPkKOStN+Dh+dc5+CPp21DSIvXhJYxw==
X-Received: by 2002:a17:90a:350:b0:286:40e7:e99 with SMTP id 16-20020a17090a035000b0028640e70e99mr2520980pjf.28.1701377016042;
        Thu, 30 Nov 2023 12:43:36 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 5-20020a17090a018500b00283991e2b8esm1872854pjc.57.2023.11.30.12.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 12:43:35 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Kees Cook <keescook@chromium.org>
Cc: Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org,
	Azeem Shaikh <azeemshaikh38@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] SUNRPC: Replace strlcpy() with strscpy()
Date: Thu, 30 Nov 2023 12:43:31 -0800
Message-Id: <170137700879.3640204.581331941374933494.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231114175407.work.410-kees@kernel.org>
References: <20231114175407.work.410-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 14 Nov 2023 09:54:18 -0800, Kees Cook wrote:
> strlcpy() reads the entire source buffer first. This read may exceed
> the destination size limit. This is both inefficient and can lead
> to linear read overflows if a source string is not NUL-terminated[1].
> Additionally, it returns the size of the source string, not the
> resulting size of the destination string. In an effort to remove strlcpy()
> completely[2], replace strlcpy() here with strscpy().
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] SUNRPC: Replace strlcpy() with strscpy()
      https://git.kernel.org/kees/c/cb6d2fd30ddd

Take care,

-- 
Kees Cook

