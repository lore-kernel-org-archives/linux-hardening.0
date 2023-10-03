Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7167B3D996
	for <linux-hardening@vger.kernel.org>; Tue,  3 Oct 2023 23:55:08 +0000 (UTC)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13D1E1
	for <linux-hardening@vger.kernel.org>; Tue,  3 Oct 2023 16:55:05 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-690bd59322dso1154011b3a.3
        for <linux-hardening@vger.kernel.org>; Tue, 03 Oct 2023 16:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696377303; x=1696982103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2zDSZaEXmJ2Rq3hJpJCUNWtVnDT1OU4Zatqdb0xDsNA=;
        b=oCPyIjonwDbbQcQ/j8mCdWLmijTjql6Qk0JNCezOsz6FZLz2/fS+AojQJ8z0hdQd2R
         NiymEJ82Cx9XVK0SpqTxE5ABU5AcRLcIHg36D7WVYHNClfUUUx6CjQcfSVOQgMXBuXVk
         73Dlhm27P8lDk4zCnOVR5qw87hHO0k/89i6b0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696377303; x=1696982103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2zDSZaEXmJ2Rq3hJpJCUNWtVnDT1OU4Zatqdb0xDsNA=;
        b=XXwPl5QqNGLKLneZHJJaMcrUAy+3cW2tp3oDTqnLAIP3Acefj+VJ6PYdmb6Rj+0HWP
         1XyngbWlW2n3RyLot1vJr2BZyjToOIRbb35O13VJobC0nDQ8XnpqmN5EApUmIAlosHUe
         2bo/FrG3vh0qGnYSJfl9OpRWuJBkJR5G3PegbdnSMaU6tJFZEeJbv9pYmBr2/i7Mj6iS
         BDMe/gVNDOnno8f6fSuqwzbb8ZoVvrlEgvnbLIGOxAw1oMWu2AJ+RPMSc5QOkXlreloo
         RbBaVZSXBOoVmPt5IGB+ZaFKuFg39UPda1Jkzr4SleMDWCeUJvkweI86wjMECvykL84W
         C+ig==
X-Gm-Message-State: AOJu0Yz7bD6z/8ewVs+RXk6ZBLga9Luen98V5iOXB3/l/YK32gWy/tVJ
	r2ks62C+WmWxkztJraxYr1WN+o4XU70mQ+fCyJY=
X-Google-Smtp-Source: AGHT+IHMLXtu+UBUaiToYMlRU313LQJjnHRm1u9g1daNHqKGmuGOzbiugg/42ZAIhTmGFvHR4Fn7NQ==
X-Received: by 2002:a05:6a00:1511:b0:68e:2cf2:1613 with SMTP id q17-20020a056a00151100b0068e2cf21613mr1144614pfu.3.1696377302885;
        Tue, 03 Oct 2023 16:55:02 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id gx13-20020a056a001e0d00b006934390d0c5sm2012467pfb.175.2023.10.03.16.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 16:55:02 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: William Hubbs <w.d.hubbs@gmail.com>,
	Chris Brannon <chris@the-brannons.com>,
	Kirk Reiser <kirk@reisers.ca>,
	Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Justin Stitt <justinstitt@google.com>
Cc: Kees Cook <keescook@chromium.org>,
	speakup@linux-speakup.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] accessibility: speakup: refactor deprecated strncpy
Date: Tue,  3 Oct 2023 16:53:47 -0700
Message-Id: <169637722416.168837.4167782621423487593.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230918-strncpy-drivers-accessibility-speakup-kobjects-c-v2-1-d5b1976c5dbf@google.com>
References: <20230918-strncpy-drivers-accessibility-speakup-kobjects-c-v2-1-d5b1976c5dbf@google.com>
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 18 Sep 2023 05:30:15 +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> Let's refactor this function to just use synth_write().
> 
> 

Thanks for the testing! It's been 2 week without any more comments,
so I'll snag this.

Applied to for-next/hardening, thanks!

[1/1] accessibility: speakup: refactor deprecated strncpy
      https://git.kernel.org/kees/c/692c013e8f37

Take care,

-- 
Kees Cook

