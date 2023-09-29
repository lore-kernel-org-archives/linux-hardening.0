Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB11E6588D
	for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 19:21:23 +0000 (UTC)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59AFFCC3
	for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 12:21:21 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c3d8fb23d9so110624595ad.0
        for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 12:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696015281; x=1696620081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wNsDO1TdEpCGLaLxGAq/gTTVsrbL7yU9yl9SCIkPcCY=;
        b=JG28XOl0oGwZTJwdjdwAkJ+nltGy2fy6gYOzfDBxmIWc3JTsoHXcGRmd+ntzS2vpu1
         4KdR7J2P4kVx8epzO6iU37KrqAE/+ab40fFry98HbfLwTZFOM9nZ080HNsECWN192Reg
         Y+OBOyKHTuC7TSOORuMpt4KuCJMGnUq/0Zak0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696015281; x=1696620081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wNsDO1TdEpCGLaLxGAq/gTTVsrbL7yU9yl9SCIkPcCY=;
        b=jv7oKGKqTeiRfzdF3gGUmEnJPsvSWF8yGJSn6hdHKbyiEh6pQifb3ff4lb/tUfbfa2
         s/RdZ8it1Kd4NfggoZybNuWv3KR6wJEuFc7TmdbUiw20MdyhKwVWUWyHtknDYWb+6iGC
         dclwE7kIiud4sZZrWbita0NXOYTxirPREamKSuoom3PlWn0wXWAbewdzCvjChVsWKslw
         uYjFilioxtCPqSzfWmd9XFpXOJMkACmgBWpeVVqbUiqqxjTlPMYx4zMFxBYj2toDcxS6
         j88nRhG0iAyEynsLWYBGTBsd0LwKzSop/NqrPCOa61YbGsYCeTz02w90Klv4mFw7sQy1
         +wUA==
X-Gm-Message-State: AOJu0Yy1hKHCDRrzudJWKML42Djd7w8gFg0usIu2KON7LtwrE77qxf2/
	QL2oqyC40/O43zxt0QNQxyWaNA==
X-Google-Smtp-Source: AGHT+IFjyLlRRTeaeUecf9XWMNrkK0uGGpsZzK0vctMS8QPYI0ipJfXP8O++f7NHEfdRJEQBswkXCg==
X-Received: by 2002:a17:902:c409:b0:1c5:ea60:85c1 with SMTP id k9-20020a170902c40900b001c5ea6085c1mr6240720plk.12.1696015280740;
        Fri, 29 Sep 2023 12:21:20 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l16-20020a170903245000b001b89b1b99fasm17247784pls.243.2023.09.29.12.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 12:21:16 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Alan Stern <stern@rowland.harvard.edu>,
	Kees Cook <keescook@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mathias Nyman <mathias.nyman@intel.com>,
	linux-usb@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] usb: Annotate struct urb_priv with __counted_by
Date: Fri, 29 Sep 2023 12:21:10 -0700
Message-Id: <169601526966.3013632.8979451725349830093.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230915195812.never.371-kees@kernel.org>
References: <20230915195812.never.371-kees@kernel.org>
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

On Fri, 15 Sep 2023 12:58:16 -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct urb_priv.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] usb: Annotate struct urb_priv with __counted_by
      https://git.kernel.org/kees/c/a5683963b3f5

Take care,

-- 
Kees Cook

