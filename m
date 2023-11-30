Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FdkbCL6b"
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5636F1712
	for <linux-hardening@vger.kernel.org>; Thu, 30 Nov 2023 14:00:26 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6cb66f23eddso1296685b3a.0
        for <linux-hardening@vger.kernel.org>; Thu, 30 Nov 2023 14:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701381626; x=1701986426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mS+xZFkauPj5AGx65h3+Kf7iUVStiVqpHLg3qeSM/lc=;
        b=FdkbCL6b6isQxB7ZLVpja3MFdedZ5Ts+Yg9oNbNx32cVbq1Tnx1H8P6/k8TgrdLb+E
         egjZCOFmD2yx50DGAGybT/z3osVAICDFX3m3dn1Pm/csZUxaMju150DBpocb9+Ry7gQn
         3sNlcGn2pqhT1qKjVwiwwWnKHqxWHLjFTgMrE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701381626; x=1701986426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mS+xZFkauPj5AGx65h3+Kf7iUVStiVqpHLg3qeSM/lc=;
        b=QdTJ+lkXdzTanVmWrgcx74CBKghuOQ3k/waUchDdQw3GtZRX2KE/yGyhL8xr+z84zT
         yPYcvgs1DQjq4UhaQ0fh2qmh0tzKy+zexbrFCovWI/5VSC7SipiR3zl4+/sU567roBTn
         Lh4CK8sPzOzuKLZmoDOWxpQkzFJ7q5MTNXc5jOC71NpOrxpkPeOuFt0tARFHfF9P1TrB
         Ryb12a7agAXL0Dq/1c4MugCqMt9m/yJm3jhxrIq18XLJL+cYe218OBdvSmFHrUGYt7cO
         UilNjc1VP6ftesEeLozbLopEbG5BTXGccyNcDWzU/iqxEdqr+D/2SE08NwbHMW36pW+j
         f4Hg==
X-Gm-Message-State: AOJu0Yw2uKxHrERwqBC2ZjirNj+2LinwjQuzkdiXiJRm6B0zOMk48mYJ
	akjUJGjpwFcZRuAnFzGDOsHINg==
X-Google-Smtp-Source: AGHT+IFvg3rt5HT0uZoTR0TCtDK9qT29w6HrEKwrACLRv00otPgC1j74T2H6xf8MsdG2Z6cRmkPsFQ==
X-Received: by 2002:a05:6a21:328a:b0:187:15e2:fdd9 with SMTP id yt10-20020a056a21328a00b0018715e2fdd9mr23858335pzb.39.1701381625674;
        Thu, 30 Nov 2023 14:00:25 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id gx12-20020a056a001e0c00b0068a13b0b300sm1743924pfb.11.2023.11.30.14.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 14:00:25 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] afs: Add __counted_by for struct afs_acl and use struct_size()
Date: Thu, 30 Nov 2023 14:00:19 -0800
Message-Id: <170138161643.3648998.10002287194260761975.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZSVKwBmxQ1amv47E@work>
References: <ZSVKwBmxQ1amv47E@work>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 10 Oct 2023 06:59:44 -0600, Gustavo A. R. Silva wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> While there, use struct_size() helper, instead of the open-coded
> version, to calculate the size for the allocation of the whole
> flexible structure, including of course, the flexible-array member.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] afs: Add __counted_by for struct afs_acl and use struct_size()
      https://git.kernel.org/kees/c/7403e688f0c0

Take care,

-- 
Kees Cook

