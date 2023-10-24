Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBB43F4C7
	for <linux-hardening@vger.kernel.org>; Tue, 24 Oct 2023 21:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TK6KIaPk"
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC65E10E9
	for <linux-hardening@vger.kernel.org>; Tue, 24 Oct 2023 14:19:11 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c9e95aa02dso1729575ad.0
        for <linux-hardening@vger.kernel.org>; Tue, 24 Oct 2023 14:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698182351; x=1698787151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h+cZiVId6MMrE0VNYNpV7bLYZrEWEZQeY5gw9zkpQIc=;
        b=TK6KIaPk3kelv3Tf5tWtx4WGjOBwy5AthpB3IIGdV/cHAkbO2JdenbHmCUmED/FlYZ
         nAbHS2reyJzkkf1roTmiMyjgnxzVUtvthmuvdtW79Lc1CjiRYyweoyhYzrePggxxT6ql
         yayGsFDMampYkm1xfTjkhSE1rbqMKBR18ELTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698182351; x=1698787151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h+cZiVId6MMrE0VNYNpV7bLYZrEWEZQeY5gw9zkpQIc=;
        b=wmpEd85L8q7LbfkqwLo1F+Ph2omLzyWt+d5AKcVbFI/pN9pkUr72wTZlxZZziAeyaW
         PK3QACmFLtl2KVheBAscER6xqoZDINQL3gtnMUawJzWPJ3K7Q7uWsiVWRCa/OC0VlN4j
         IgM7ij5xGxXstjUhM+DtVAJV7EGqs1F5k31c7b8oCd7QRemKOYVl/OMHTMwZ+3VKiQrf
         ZdtN65jLrsLclsDKndsrWUo/iJE9mARc3xqCnDtAjXng7S2sehv/qEC/IIrhhGnIZSbx
         BNtQZG+rJqG7e017ws7w2Gk42ZNXnhH2RPHE2TMNFjOBluH8JBbqTbxyp3qWCMKG5WSe
         Cbgw==
X-Gm-Message-State: AOJu0Yy2ZjJFanf5z3/5BEuGQSO35tpYTk79V34lyzKArh57lAJNk6Db
	zDoSoYdCAbT70atOaYYzESFZ2A==
X-Google-Smtp-Source: AGHT+IGjL3fm2X2hvJcIZ8vhkMxJoeoI99wJ8vtRUXaY4HddAxAKijf1XivLedwDrIyKkSWlkqxCEg==
X-Received: by 2002:a17:902:dac5:b0:1c0:cbaf:6954 with SMTP id q5-20020a170902dac500b001c0cbaf6954mr19334024plx.25.1698182351138;
        Tue, 24 Oct 2023 14:19:11 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h6-20020a170902f54600b001bb892a7a67sm7860951plf.1.2023.10.24.14.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 14:19:08 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Amit Shah <amit@kernel.org>,
	Kees Cook <keescook@chromium.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	virtualization@lists.linux-foundation.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] virtio_console: Annotate struct port_buffer with __counted_by
Date: Tue, 24 Oct 2023 14:18:56 -0700
Message-Id: <169818232963.2100071.8744701530771099437.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922175115.work.059-kees@kernel.org>
References: <20230922175115.work.059-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 22 Sep 2023 10:51:15 -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct port_buffer.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] virtio_console: Annotate struct port_buffer with __counted_by
      https://git.kernel.org/kees/c/bf5abc17bc43

Take care,

-- 
Kees Cook

