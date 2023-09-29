Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE3C6588D
	for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 19:23:18 +0000 (UTC)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1D5F5
	for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 12:23:16 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c62d61dc96so58740385ad.0
        for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 12:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696015396; x=1696620196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sj4gKoTPER+a3Rg0p9JfyBeQ5oS9hCDvDWoKv93wILE=;
        b=a/lAaXm+ejXiqc2YkN2nOdhiEaetwdPcB76bNAmtW5Jkq2jwIwukr30QxdR8eP0Jjv
         cJLA6JJ0VQ0JMF8kgcxtv8r9MxiLi8VvnF2J/L467bMD1ETKLOSMfLee5UKZB+lXqOn/
         pqx3aSQZZAkruu+EVIZ4wqu5hHA8bHGW1N0aM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696015396; x=1696620196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sj4gKoTPER+a3Rg0p9JfyBeQ5oS9hCDvDWoKv93wILE=;
        b=RNc3i/mfivW5lxpK2nKvkgyp/I6EyejJk2Uty5HjS42oS1UWopyjH7hL+x0jAZtH82
         vHnwGSYcD+H0hcspICgeVVwPREBn5MzLSNckc+Gi2AoXd01DJz3VV5Wt13qewEvlMR+R
         WIlWVxruZCzDquOz68mT6FSFAv8KwU40P2fVSEfDfVy6aepZBnIyEbtjy9hIHDpspTg5
         c6W2nc0evSiA9mH16fQyqjz0loVmPCivXz/prLN5nt50uBeonQC3uUdDmG+mZ7jVlURU
         arYFP9wePL3mBwXoP1/W+pldthlNZptXloD7AG6trnmQt+E0cby683ldQP+PPT+KArWx
         7BAQ==
X-Gm-Message-State: AOJu0YxR/6ApmwKzZc/le4Cls+e/uHPm8PTF8M8vQIIF2X7pcKBv3Dbq
	E8s7gQw6hRBv5edWEcfD6GqOFQ==
X-Google-Smtp-Source: AGHT+IHeAzZLWR/XUQ0/HfggCdQEIA48Tga8bx8nr8Ck+3J+Jkxeupd6kXb/kPWfsX+RHQbRBmpodg==
X-Received: by 2002:a17:903:1207:b0:1bd:f7d7:3bcd with SMTP id l7-20020a170903120700b001bdf7d73bcdmr5832816plh.50.1696015395852;
        Fri, 29 Sep 2023 12:23:15 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c2-20020a170902d48200b001adf6b21c77sm1692175plg.107.2023.09.29.12.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 12:23:15 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Kees Cook <keescook@chromium.org>
Cc: Anna Schumaker <anna@kernel.org>,
	linux-nfs@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] NFS/flexfiles: Annotate struct nfs4_ff_layout_segment with __counted_by
Date: Fri, 29 Sep 2023 12:23:14 -0700
Message-Id: <169601539364.3014051.4375069928549336780.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230915201434.never.346-kees@kernel.org>
References: <20230915201434.never.346-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 15 Sep 2023 13:14:39 -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct nfs4_ff_layout_segment.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] NFS/flexfiles: Annotate struct nfs4_ff_layout_segment with __counted_by
      https://git.kernel.org/kees/c/f8ead26ffdee

Take care,

-- 
Kees Cook

