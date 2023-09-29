Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0018D6588D
	for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 19:17:52 +0000 (UTC)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E561A4
	for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 12:17:50 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c364fb8a4cso130962855ad.1
        for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 12:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696015070; x=1696619870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OdzIkpOORPZHV5wenIN0SGnXWAeNAW/YV8thKJqiWYA=;
        b=DAAre/P0IxxuGdDCy/+xl4p/5Q75Gcr7bioNOEZW84OlE5cz/xmVqD1K9h5mq1kgKX
         fXUXANqF4xJjbWnG6gXnF2bOzR0yoeoG0T0UrTbHqFFEhDh0GJixyxmxQ3jAJWkETrGN
         FpcMI/b7rDsBOP8YB9lvy6ZaPrJubu6ocJTdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696015070; x=1696619870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OdzIkpOORPZHV5wenIN0SGnXWAeNAW/YV8thKJqiWYA=;
        b=Nv48m9YGWnzwmRSw0FzhRq4bQxo9NjMiH1GruUDEyCrDdl1Ye9XLMz+44wgYs79o0x
         o39KHyGyVAvedqHzC508Lm2zDxVhEmgE6w+F+Oai9gd4m9+5+rJBZltUSciZTUZcRTGM
         ZR1gWseLH/HtU5Fc842xURePlTXNHi1/i7LoTy3hGFgb1hgF9JKrTooYW0kbXkQqmIcL
         Z5nU8v5+AJBeoxFcpUDWYnf53Q7tNfRP1bxZhk/dnIHylf1dQKomqsimDPFpt0t1eHdL
         Q8g/JJgKDrwQN+PD6MIs7JaaDoSlaoQ207Hy31QrQiti2ZULu9gR0U5eN8R4WhFtNlBN
         otcA==
X-Gm-Message-State: AOJu0YxtK190upGrf5hhowksqFL0K8F4T4FBpj3oqyvK3VA+cDZY//K3
	mW2NHkMJmTn7AeudqRrvX8oOug==
X-Google-Smtp-Source: AGHT+IHrw1fOyPjJ3jkkEg8ObgcF8Wa58J+gcFGUj5kMKDI7VBoc/1OzIbj48UaSw/kDEy3t3ivkGQ==
X-Received: by 2002:a17:902:c38d:b0:1bf:8779:e03f with SMTP id g13-20020a170902c38d00b001bf8779e03fmr4898508plg.68.1696015069936;
        Fri, 29 Sep 2023 12:17:49 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b8-20020a170902b60800b001c1f016015esm13499323pls.84.2023.09.29.12.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 12:17:48 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: David Howells <dhowells@redhat.com>,
	Kees Cook <keescook@chromium.org>
Cc: Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] afs: Annotate struct afs_permits with __counted_by
Date: Fri, 29 Sep 2023 12:17:44 -0700
Message-Id: <169601506495.3012633.13895603881576903782.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230915201456.never.529-kees@kernel.org>
References: <20230915201456.never.529-kees@kernel.org>
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
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 15 Sep 2023 13:14:56 -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct afs_permits.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] afs: Annotate struct afs_permits with __counted_by
      https://git.kernel.org/kees/c/45faff97751a

Take care,

-- 
Kees Cook

