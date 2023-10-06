Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB35328A6
	for <linux-hardening@vger.kernel.org>; Fri,  6 Oct 2023 20:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KnhAYIbY"
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B98DCE
	for <linux-hardening@vger.kernel.org>; Fri,  6 Oct 2023 13:41:21 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-690b7cb71aeso2021710b3a.0
        for <linux-hardening@vger.kernel.org>; Fri, 06 Oct 2023 13:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696624880; x=1697229680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RA6Sc7k2eYudohPOyjS2xNwEbkA0LuukS0jdW+sshIU=;
        b=KnhAYIbYofbLdRZzQedmFGPtAW4ACp7+OYSB3BKlpT1JZJbYezQdp1RNZxQaB0s8qT
         o/nRZdUPQgkSF69MyKiEJDCVCR5Ko2j2yusuyn0YjFpJqsMeK3wwg5W+7K+j2llAyUaW
         y//kPdOAFZSmXDTNKesN+s8SzpsbtnyVY6NNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696624880; x=1697229680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RA6Sc7k2eYudohPOyjS2xNwEbkA0LuukS0jdW+sshIU=;
        b=UDJl63Wd6Zm5j9P3UqFddYWsxncSDdoARxQzZOfG+Z2zOGPBWQcQZthWTcBK2k8fvC
         TKei6dut8qsgA7bUHsln0s/whjX+Bn3Iv/srqNNGoqtotJX5fkchsR716FaOlUcX5Z+e
         IIQlLWlvwCwE6nms6FpyNbly9sZCL3NSARPtLSk26nmCOEcd5s5wGKxhAXIUBrloPy2h
         MjYWTpSdXc+mYdWmvyBD9+nwqpOL8OzJgBxUoHMvAFeARxXYbMkdvQ0G1xyGtoS3VVrg
         3ZRyfQLBcRv+MDN8NG08CY05GOL1PuEJICZyij3n6EqDjCy/6vctA7hgpRsVWz2OLEsq
         u9kA==
X-Gm-Message-State: AOJu0YyOA8RyCol2zwOjpSR/LedK9bSijNSu6U9ubmJ78M1Nk27JtTAe
	Wr89QJN/A22rn+yxZCfKkV+pMg==
X-Google-Smtp-Source: AGHT+IFSmFU6FkhA8Oz6MBMj4ikhUHOgSULluvCcw1BxoKIl88jeZRsxIUFaVyPPQ1RvqNgCCc7Y6g==
X-Received: by 2002:a05:6a00:a1b:b0:68f:cbd3:5b01 with SMTP id p27-20020a056a000a1b00b0068fcbd35b01mr8784952pfh.13.1696624880594;
        Fri, 06 Oct 2023 13:41:20 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a25-20020a62e219000000b0068fe7e07190sm1905152pfi.3.2023.10.06.13.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 13:41:19 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Andy Gross <agross@kernel.org>,
	Kees Cook <keescook@chromium.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Amit Kucheria <amitk@kernel.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] drivers: thermal: tsens: Annotate struct tsens_priv with __counted_by
Date: Fri,  6 Oct 2023 13:41:09 -0700
Message-Id: <169662486916.2156024.11406030732291665443.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922175341.work.919-kees@kernel.org>
References: <20230922175341.work.919-kees@kernel.org>
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

On Fri, 22 Sep 2023 10:53:41 -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct tsens_priv.
> 
> [...]

Since this is a trivial change and it's been 2 week without further
discussion, I'll snag this patch.

Applied to for-next/hardening, thanks!

[1/1] drivers: thermal: tsens: Annotate struct tsens_priv with __counted_by
      https://git.kernel.org/kees/c/aa0a14629c2d

Take care,

-- 
Kees Cook

