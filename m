Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AB366683
	for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 19:17:51 +0000 (UTC)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423A61B0
	for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 12:17:49 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-692c70bc440so9192277b3a.3
        for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 12:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696015068; x=1696619868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uDYWsdWil9zbQW5R6gj/5ZmSzR6wTayh9fz7CUaf8pU=;
        b=Goktd67Tg8lYDKiXaINvkN3AaVpYaA3ud8M9AflT92uWcrPjuVt1t4P2eH5blKq/yT
         NZ8ulKNgRaJZqwgFxJWaZi6BAGE/xo2xkMZSat/WyY1NNpXc71HMFCKL/lGgmtQdIAs7
         AkHJueEsis8GCrXrwsH7SBHV9+albejbZoEd0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696015068; x=1696619868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uDYWsdWil9zbQW5R6gj/5ZmSzR6wTayh9fz7CUaf8pU=;
        b=Ggvi40vMw0RfszMZv8dC0xNYsYe33kGuaEDS133t/dhyys7nKuzhgJf907AG8AJWbr
         fkMwdF3GtGd+MNTWtNErUpsGJiUyfPRTc/RHVNbOV7ta9OdBCwzecvtSU/GP6rXTHhfW
         V5HRnaDk8V7/ZG+ZTvbAT2lVHsjTKkdrcTlY5Xh1GXLeFFKAT+ZmYeukcrj64L/nmvLC
         HTe3WKfUMEoVESf6h7K986OuwHRu5o3Q4KxThTlsbYspdseBZ+KcoEK1VUdMhGaYuYhS
         rJh9sWmlsOf4AS4laSsbSGx0a/JpLO+jhltvFdw7gxYLr6wd9YMVH66U99XfgPeOVHWS
         iQdA==
X-Gm-Message-State: AOJu0Yyegq1Nprx+vx0Bxx5Ao2hmQcSOEj4Kii5EoH+mvnVHT6kXOeBF
	JzSXVXVvhWQxoqpl/9AR5gArdT4Lkoce4FpFzs8=
X-Google-Smtp-Source: AGHT+IGdsmoNdh/Arkb8UEaGz2niq5l6pVZkZZWHMJonh+QTEtqj7fKdMqUpwLVu/aGM0F0r0Em/BA==
X-Received: by 2002:a05:6a21:a593:b0:14c:ad99:22a9 with SMTP id gd19-20020a056a21a59300b0014cad9922a9mr6139280pzc.32.1696015068592;
        Fri, 29 Sep 2023 12:17:48 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n3-20020aa79043000000b0068e12e6954csm4745873pfo.36.2023.09.29.12.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 12:17:47 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Mark Fasheh <mark@fasheh.com>,
	Kees Cook <keescook@chromium.org>
Cc: Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	ocfs2-devel@lists.linux.dev,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ocfs2: Annotate struct ocfs2_slot_info with __counted_by
Date: Fri, 29 Sep 2023 12:17:46 -0700
Message-Id: <169601506493.3012633.12707221094157928597.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230915201522.never.979-kees@kernel.org>
References: <20230915201522.never.979-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 15 Sep 2023 13:15:23 -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct ocfs2_slot_info.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] ocfs2: Annotate struct ocfs2_slot_info with __counted_by
      https://git.kernel.org/kees/c/7c993785ae63

Take care,

-- 
Kees Cook

