Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136C642C0B
	for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 19:37:31 +0000 (UTC)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0D31B5
	for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 12:37:29 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-690ce3c55f1so11531052b3a.0
        for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 12:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696016249; x=1696621049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ss65P0lXSqzHkUmO/JhleEGBdIvRYTwXfMVQ4cN1Xig=;
        b=SngaIz63KZSwTBz1gy47JDDQ/JlewmYlswaoebnTmTf5q73Clm2NlEt2ujQtjP+xEl
         Ofvef51+mQ9FVixNVtvM5kPw9r2rcQ7kH+cfgBxFCITdTjp9sLaO1EHqMtbl24Ur+Bo4
         Rskg7gVEU5sYBsJ+h0ovuRzSHoP3clJPHUSfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696016249; x=1696621049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ss65P0lXSqzHkUmO/JhleEGBdIvRYTwXfMVQ4cN1Xig=;
        b=XPTjQhD/a5Wm5qMEG4LC8hpAUrRi+rmpxgV0B4CbsoTQTP2kop5BfF3Itfzx0BR08W
         Qw2g0r8P4+99Sig80WcTCvbsWdVn9Ohz8ROP9mfX+7vfX4PYglFQB2R6yy48O510jedu
         k0V2eNq3X6vHbOEEXb8hMMz5rXUrKAzxIBbg0MyvmTs5X7jyhn6larXlLxvAUvgT6UzJ
         sge7LD2E7R0m+5bq88hnsFWtc7P0+UKNoH/Uggu3WFa/C+pqs7KWC8oibRbjMXxQGi+O
         q27TzIaPrjzsIvde2J20tK8+tu1NFJNBHrCRsPHqlfuSwMSr+jRz8o27ysRtV/lX75h0
         IDrw==
X-Gm-Message-State: AOJu0YwdkmTqbmyL4038fyUADqe+k0GgSofzyJPGm2oTJ6u0PceMsb1S
	l4Aa8U1zSmyGbh4skkCAEY5HOg==
X-Google-Smtp-Source: AGHT+IGFvyTd654VGOEd4QzTk2oJA1lmcFCtL++Z/vAMyBSOR1XO2UHlo8aZw97smjkuf4IZUfFNjA==
X-Received: by 2002:a05:6a00:189b:b0:690:422f:4f17 with SMTP id x27-20020a056a00189b00b00690422f4f17mr5453667pfh.4.1696016249046;
        Fri, 29 Sep 2023 12:37:29 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p5-20020aa78605000000b0068ff0a633fdsm1326147pfn.131.2023.09.29.12.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 12:37:28 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Karsten Keil <isdn@linux-pingi.de>,
	Justin Stitt <justinstitt@google.com>
Cc: Kees Cook <keescook@chromium.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] isdn: replace deprecated strncpy with strscpy
Date: Fri, 29 Sep 2023 12:37:26 -0700
Message-Id: <169601624548.3016093.1290854393358505827.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922-strncpy-drivers-isdn-misdn-clock-c-v1-1-3ba2a5ae627a@google.com>
References: <20230922-strncpy-drivers-isdn-misdn-clock-c-v1-1-3ba2a5ae627a@google.com>
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

On Fri, 22 Sep 2023 11:58:06 +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect `iclock->name` to be NUL-terminated based on its use within
> printk:
> |	printk(KERN_DEBUG "%s: %s %d\n", __func__, iclock->name,
> |	       iclock->pri);
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] isdn: replace deprecated strncpy with strscpy
      https://git.kernel.org/kees/c/a9b065a6751b

Take care,

-- 
Kees Cook

