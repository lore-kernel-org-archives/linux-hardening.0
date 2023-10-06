Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF1C44462
	for <linux-hardening@vger.kernel.org>; Fri,  6 Oct 2023 20:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KOET+slU"
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C95BE
	for <linux-hardening@vger.kernel.org>; Fri,  6 Oct 2023 13:28:13 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-692c70bc440so2188945b3a.3
        for <linux-hardening@vger.kernel.org>; Fri, 06 Oct 2023 13:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696624092; x=1697228892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UdDFi4NoIdKfky4gxD+eJQUbrV7mhgqDmFd2bTgvDgw=;
        b=KOET+slUdofgm4Z5MZD5VgaA+MU7xFza3K5BxgPnBoAi3I18FIrvp9y10Ad0A7cl+e
         AR5XdKFQjeWQQJ73m4apNBfAoHj4ia2cVK11Bfj1sZFmI5QcHsvUmsiFa8mg3/zKyr/c
         BYPBTK7/gDBnpzWnmng77LGdzq5TV+Gom0jQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696624092; x=1697228892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UdDFi4NoIdKfky4gxD+eJQUbrV7mhgqDmFd2bTgvDgw=;
        b=Rcr5aB/amjaszudTLvltCzHRQYDJBPT3gMR5ov8M7OPAy1SFePo+P0QR2Stc5psfmf
         iGWi6BVNdqJOyobJuoHhaUOvHqkz+A7J4DgQur3VWO9lP+JZI+ZMpKE8LoVp1UdtU2KL
         t0pFdrsD1vieRTWdwmgCsWbsNHtL01c/5qtWs+6pMqkAfAqBu02u3TdbtMeEVO2cQLE8
         ZxMuIMrLyNilFn21E3mP9p4zoRlLXY9j571lEdbGbPO2f+XwC0lxTSMv41mhCU+gDrvI
         JA7vXiTrB18Q1NhpHsF0a1KIoxCj7yDGD0828m/81JDkkBzRdHhGHtRC15Oa5wJw7MUW
         5BQg==
X-Gm-Message-State: AOJu0YytNr0J323vhraNei0EfrTZ1TXK/LxMhE74So3WCt8ts57PCLoL
	6ulMQRUVhF2cp2rj+T3aN+5lkw==
X-Google-Smtp-Source: AGHT+IHzavjcegg0su2LV3PG5i2JGplCgrkDJGkfhDYDgXFWCha9xijJu8LR4T++xQ/Q93fkWVoRgg==
X-Received: by 2002:a05:6a20:3952:b0:163:b85e:631a with SMTP id r18-20020a056a20395200b00163b85e631amr10348902pzg.39.1696624092561;
        Fri, 06 Oct 2023 13:28:12 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ff18-20020a056a002f5200b00690d4464b95sm1974172pfb.16.2023.10.06.13.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 13:28:12 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Michael Tretter <m.tretter@pengutronix.de>,
	Kees Cook <keescook@chromium.org>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] media: allegro: Annotate struct mcu_msg_push_buffers_internal with __counted_by
Date: Fri,  6 Oct 2023 13:27:57 -0700
Message-Id: <169662407189.2154681.1298231079393484992.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922174935.work.699-kees@kernel.org>
References: <20230922174935.work.699-kees@kernel.org>
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

On Fri, 22 Sep 2023 10:49:36 -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct mcu_msg_push_buffers_internal.
> 
> [...]

Since this is a trivial change and it's been 2 week without further
discussion, I'll snag this patch.

Applied to for-next/hardening, thanks!

[1/1] media: allegro: Annotate struct mcu_msg_push_buffers_internal with __counted_by
      https://git.kernel.org/kees/c/63eed8dcdf49

Take care,

-- 
Kees Cook

