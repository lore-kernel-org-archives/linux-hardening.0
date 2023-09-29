Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA827521A7
	for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 19:15:06 +0000 (UTC)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB691B1
	for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 12:15:05 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-692a885f129so10432108b3a.0
        for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 12:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696014904; x=1696619704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DGE+mhT2J6BxwaI8MX/iLRb/F1GWPeFnuoGQKhDB53k=;
        b=GVglu8Nj7jisIEkxrDhQbeuRbWX8htfLe5FWp6e9gQlQIHEQDDf4krF1LXH7orhySN
         MQ7P4AjCuyt3oRcQJqJB2l7aOomyefTHgCL/YFnCHRkUbMCkTuOWUiEyvxU6Jvpp5bpi
         S3ibDWSG0pYApj1tvwpQbUYsnZbXudff7oee0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696014904; x=1696619704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DGE+mhT2J6BxwaI8MX/iLRb/F1GWPeFnuoGQKhDB53k=;
        b=MmVnVYhI5MaO/Q2E/oh5Yx58TuW1IcFPKJn6FM2pDMjT/buIAPBgJ2wJnnT+u7maet
         VT2GlSDSvV3CwEDqfyRNYcI5CLPIc9gmKlr5jWIL5wp5WKyPkX9/N9fF0cIfz44lxmMq
         neX+yxV5haWlft9mcD5lWorE1uof4Ds9WT1PqonkCYWKBP4ULMaYLiljBCOFCEdufMN1
         p8mAvkCGj97H0baR12q5+CsnJmp3V45lEZ8yEIo1V4MGTub6TawYNG3za2zncnBMb7Mi
         wGeYNv4AePg4NqahaP43yBFFF+hzE4MABLwByi5HMX2i6eBUsk82oKzDsOVfPvZGZnrL
         TjwQ==
X-Gm-Message-State: AOJu0YwbM2/vA0aG0Yof1dtKcHMYCNBrrRX3kOjSnWF7j1MnrjF6OgeO
	2CjEPY3IQ6gvnvV9LHgjjU90PQ==
X-Google-Smtp-Source: AGHT+IGdWrWALlMstgZLw0gTzX8sPC+R7tbZh2lrWw0eupjJZhVRje8lP169zMl1usYEXoSsJDs8vg==
X-Received: by 2002:a05:6a21:4985:b0:140:c838:2b2e with SMTP id ax5-20020a056a21498500b00140c8382b2emr5182838pzc.22.1696014904595;
        Fri, 29 Sep 2023 12:15:04 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e20-20020aa78c54000000b0069337938bdcsm4816734pfd.125.2023.09.29.12.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 12:15:03 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	sound-open-firmware@alsa-project.org,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] ASoC: SOF: ipc4-topology: Use size_add() in call to struct_size()
Date: Fri, 29 Sep 2023 12:14:59 -0700
Message-Id: <169601489953.3012131.13922425518082792309.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZQSr15AYJpDpipg6@work>
References: <ZQSr15AYJpDpipg6@work>
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

On Fri, 15 Sep 2023 13:09:11 -0600, Gustavo A. R. Silva wrote:
> If, for any reason, the open-coded arithmetic causes a wraparound,
> the protection that `struct_size()` adds against potential integer
> overflows is defeated. Fix this by hardening call to `struct_size()`
> with `size_add()`.
> 
> 

Applied to for-next/hardening, thanks!

[1/1] ASoC: SOF: ipc4-topology: Use size_add() in call to struct_size()
      https://git.kernel.org/kees/c/93d2858dd630

Take care,

-- 
Kees Cook

