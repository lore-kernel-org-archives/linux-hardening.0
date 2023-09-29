Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295A720F9
	for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 18:32:43 +0000 (UTC)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CBE1199
	for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 11:32:41 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-69101d33315so12357952b3a.3
        for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 11:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696012360; x=1696617160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SF6n2eufv24UNtvoOGLmOHY49lmjyqKXfDP05Zw/ODU=;
        b=laaJX50eAyYEbQc+fvnKCztUz6fDVfl+/0tdP1N/EPbnY/iIFKnCnMsHbs1G8f8I2a
         t0gH3EMd8rhtA7VOdwqa8VXbWVmjJPZpvcjBoRg429HX7avSOgV+OBJ7Su4+IzK2KKUP
         XTOFOLBiEp+vNzOmQ98YLe3LNYd9+aJwDJlGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696012360; x=1696617160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SF6n2eufv24UNtvoOGLmOHY49lmjyqKXfDP05Zw/ODU=;
        b=dUSD5PeYl0iQ9Mzw4pTiLlHZrjvafNb4+FgECRxAvCWav9TFaY0LBOC7qrFywd3wv0
         gfrAb+hhoESOr6AQ1VLxDIOnZrkgosZ1AVy74ZumE0uwaei1YwrojEbwT1eHX5cQUuOH
         b+349FDQaoCVnYncNR+zdGMjVznukhtAGtG6irbjvIWP29Zks+yoa8+7otJMh2GI7wvy
         WJ99OazmGxgsBNDuYbzS8tCBhWBWzon1cVSf3UGn8LQzVaUTAjzmMIQNY4j990qxf8Ez
         9DsDeCmaVRRutIORD7CiHt0Ch7MiVR9kKHPHxs/GMyzGt6jrf4ltAiOinKATXa/3QsAD
         UN9g==
X-Gm-Message-State: AOJu0Yyzv00bYRtRx5J2+bUCT6MSg4nVD45IJQS+9QO66VW9nsqTJ205
	VlV5knOfrTnObjQLmlJd5QDl1g==
X-Google-Smtp-Source: AGHT+IEvX1oEeUKbJDfcj50CrRy49qfzCBzl6yJV/KOKS/JsgDFnXD5aAAqU/2nWkWm8ccindXE2oA==
X-Received: by 2002:a05:6a20:a11c:b0:14d:7130:7bb3 with SMTP id q28-20020a056a20a11c00b0014d71307bb3mr5797622pzk.13.1696012360531;
        Fri, 29 Sep 2023 11:32:40 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y3-20020a170902864300b001b8b2a6c4a4sm17133890plt.172.2023.09.29.11.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 11:32:39 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Justin Stitt <justinstitt@google.com>
Cc: Kees Cook <keescook@chromium.org>,
	linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] um,ethertap: refactor deprecated strncpy
Date: Fri, 29 Sep 2023 11:32:37 -0700
Message-Id: <169601235586.3007879.13354261591100704778.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230911-strncpy-arch-um-os-linux-drivers-ethertap_user-c-v1-1-d9e53f52ab32@google.com>
References: <20230911-strncpy-arch-um-os-linux-drivers-ethertap_user-c-v1-1-d9e53f52ab32@google.com>
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

On Mon, 11 Sep 2023 17:52:44 +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> `gate_buf` should always be NUL-terminated and does not require
> NUL-padding. It is used as a string arg inside an argv array given to
> `run_helper()`. Due to this, let's use `strscpy` as it guarantees
> NUL-terminated on the destination buffer preventing potential buffer
> overreads [2].
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] um,ethertap: refactor deprecated strncpy
      https://git.kernel.org/kees/c/d4e178fe19c9

Take care,

-- 
Kees Cook

