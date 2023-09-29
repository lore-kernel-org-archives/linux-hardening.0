Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDBA66693
	for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 18:20:30 +0000 (UTC)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9374219F
	for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 11:20:27 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-578e33b6fb7so9916156a12.3
        for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 11:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696011627; x=1696616427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H/kevk4tNSCK4yq8Y8Eq8euOICXuk1g8ja9WwJ3j9fE=;
        b=ObxzFty48yclGWTgW3DznT3hAu8oEygwLdBhCChH95bXA/2BdRnl3Cf9WHgOH5aLJq
         nVeIiB9v3r6MuEuUO92otna9q+2wYntCfcDoOtFQTP1ae8hK+jPiNExgXe/3imvnK2ou
         QMUkLZx4zyd+p6cf29thDHYN7RZjjg38DfBUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696011627; x=1696616427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H/kevk4tNSCK4yq8Y8Eq8euOICXuk1g8ja9WwJ3j9fE=;
        b=aV7nE4XTLuXhdWh/BgfcRuW1L1hNO9Emdc3cypVUVJHSz0cvMeeNpy6D25R8tvvbiG
         XfWXlxjsMVQLVOA7T1C7hkyz/yfKa03lavb3frDfJwOueSYw7ncyYD7cTcqPXfZ+5M5P
         BcWVsXSx9DYwlfSnbK8ZaVuH1plmBG21PLke+kY/1AqFgJMLX50C689D1gm1uoPoKt1g
         /txYOpIt0j+jHMnmPBHQ08il2hnzAzf0QszpYb4PVYVyj7YeSJLW32ibdw0bcaEXgMsj
         lGCNeeFnDk7XO4YQOFypAJL3nQApYa+KBJEtljRvKsW83sQLKJodr5iy8Ze9XUDQNNh/
         2jqg==
X-Gm-Message-State: AOJu0Yx4/7VIGRXKTtZiF0pdktIc5BhbGbzB7QDkMLUbpFRW4aQGRvaN
	TF1VWxuxfPBuUUFfXAFEgzqa/w==
X-Google-Smtp-Source: AGHT+IGcMZNuu5by/ybQZhXigau4jvxccIHAaE4PpspYWQGaz1tg3yDDLn1/20+ox//v17UMP49BKA==
X-Received: by 2002:a17:902:d2c7:b0:1bd:a42a:215e with SMTP id n7-20020a170902d2c700b001bda42a215emr5862019plc.38.1696011626675;
        Fri, 29 Sep 2023 11:20:26 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id v3-20020a1709029a0300b001b850c9d7b3sm17135700plp.249.2023.09.29.11.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 11:20:26 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Ben Skeggs <bskeggs@redhat.com>,
	Karol Herbst <kherbst@redhat.com>,
	Lyude Paul <lyude@redhat.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 0/2][next] nouveau/svm: Replace one-element array with flexible-array member
Date: Fri, 29 Sep 2023 11:20:01 -0700
Message-Id: <169601159821.3006883.15782981674963813068.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1692208802.git.gustavoars@kernel.org>
References: <cover.1692208802.git.gustavoars@kernel.org>
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

On Wed, 16 Aug 2023 12:03:06 -0600, Gustavo A. R. Silva wrote:
> This small series aims to replace a one-element array with a
> flexible-array member in struct nouveau_svm. And, while at it,
> fix a checkpatch.pl error.
> 
> Gustavo A. R. Silva (2):
>   nouveau/svm: Replace one-element array with flexible-array member in
>     struct nouveau_svm
>   nouveau/svm: Split assignment from if conditional
> 
> [...]

These look trivially correct and haven't had further feedback for over a month.

Applied to for-next/hardening, thanks!

[1/2] nouveau/svm: Replace one-element array with flexible-array member in struct nouveau_svm
      https://git.kernel.org/kees/c/6ad33b53c9b8
[2/2] nouveau/svm: Split assignment from if conditional
      https://git.kernel.org/kees/c/4cb2e89fea5f

Take care,

-- 
Kees Cook

