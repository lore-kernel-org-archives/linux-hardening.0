Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A9D3F4BB
	for <linux-hardening@vger.kernel.org>; Tue, 24 Oct 2023 21:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QMyilAzb"
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75BD10E5
	for <linux-hardening@vger.kernel.org>; Tue, 24 Oct 2023 14:19:10 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-578b4981526so2985150a12.0
        for <linux-hardening@vger.kernel.org>; Tue, 24 Oct 2023 14:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698182350; x=1698787150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nf0I5QNq2gKNhp+QWqAtgU2BkAhFb6b7w3QJr2Rt56I=;
        b=QMyilAzbJ+Q8l2faMzH1U1cR8U2WtjYEtMB9fhAIe2RtsGng3XqfEO15rS9HI360mK
         qQ+v8vGkl9xwO/jQb9Slc3/bWyDRp7AWjs8nvuSk2A5XxAqrnL/iahomgj0ozOru8F59
         r0X5xK82ydIgv1UbjMN1/Q/zjNJDgixm+Gd88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698182350; x=1698787150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nf0I5QNq2gKNhp+QWqAtgU2BkAhFb6b7w3QJr2Rt56I=;
        b=gz46gaiw68wK2+wNGDxbuf8QzG9kzMl0lVexB7EqdorkbRiPi3pj9OZllHBbfxuPX7
         A4UW1P2QUS5UE5kU7UQT7OiP6w+G6Z6DSKYn1NipuIeO+oyPPdByJw31iJ8cDv0cmFfD
         wVknWGJmvEqyMes4sn2bWyIr2WcoMdoIERcp0HYempYH7BCSooG26SVlcjJFbWS3wGYp
         k5awaMriEhEV/aPUxlLtEDSkhnK8BA1N+fN31kr3q3Pw4/xa7L59lcLl2Zen29mke1Li
         q4NDGqOc0qVlfup/loJZaYfEx65s9wSKWEEb903nfYzh9iegcqFs1qkh4s0Gahk+9y/C
         9WYQ==
X-Gm-Message-State: AOJu0YxU0DQ1as8Om+1lIMT+RLrB9NTdZmURSFDof7o5QgmNFiIuMzf6
	GHLwJjbYJdWy7NwGD/GHPfFEGA==
X-Google-Smtp-Source: AGHT+IG4QxdxC8vQGJgNfcCeZZI6jENfk4ntlbbjFZnDCc1T/n//1rqezHHk0nSA1UzaU5cN06ODAQ==
X-Received: by 2002:a17:90a:d995:b0:27d:4901:b0b7 with SMTP id d21-20020a17090ad99500b0027d4901b0b7mr9801197pjv.30.1698182350137;
        Tue, 24 Oct 2023 14:19:10 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ci7-20020a17090afc8700b0026b46ad94c9sm7669915pjb.24.2023.10.24.14.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 14:19:08 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Eric Biederman <ebiederm@xmission.com>,
	Kees Cook <keescook@chromium.org>
Cc: kexec@lists.infradead.org,
	Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] kexec: Annotate struct crash_mem with __counted_by
Date: Tue, 24 Oct 2023 14:18:54 -0700
Message-Id: <169818232965.2100071.5860676864005280334.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922175224.work.712-kees@kernel.org>
References: <20230922175224.work.712-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 22 Sep 2023 10:52:24 -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct crash_mem.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] kexec: Annotate struct crash_mem with __counted_by
      https://git.kernel.org/kees/c/15fcedd43a08

Take care,

-- 
Kees Cook

