Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD55941E25
	for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 18:46:19 +0000 (UTC)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF361AA
	for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 11:46:17 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c724577e1fso44729155ad.0
        for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 11:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696013177; x=1696617977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oa0jeuOHt4Ygw+vX2a1/F/6PlmjBYIo0hM9//kmfJYU=;
        b=H4bNxhoX5k64IHNur9UQuAolyRs/rPBIr1qCZqFo+FXihIHN35W1DQQw8ns0QX9lvS
         yTSHSpW8vpWpjCe14WQtadyZlXKQp3+cjKLuG3Smvb6u6+NcPV6Fe0eGwiNhb65VKwTM
         XTt4sExupCa1969zkbPyJh8OPjhKwaKKP8G2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696013177; x=1696617977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oa0jeuOHt4Ygw+vX2a1/F/6PlmjBYIo0hM9//kmfJYU=;
        b=AZp16O4DzPt9jImqGUwO+Z73bTM6MOiY94TohKlEFYo4RJLyPYJ9aFL7Iw6dBOnpvd
         b5sujm/fWMDqegQ5Udnm1e34enPzxIyRcR25QRk9rN2XiMqkYtDvpq+CVB20gnDdfVZL
         9NPLJyhfB8Rm1ErCJrAc0WFJLYj1uK5I9I+7fEmM1MbqOIl85Z7M7niFRiwGg0AOb1UI
         /hrKfExhUIL3qZEJody+xKDXOLqsM+OO3QpTiAXBof36PIYUUN2wtF/rr2zpM6OZs+6E
         qJzYwwl/NM+RJnr/4YyCcdk50cdFbwBODIZ6PxiOhmrxO8t4JPiwjDa51Cd44MVSpc6D
         0pWg==
X-Gm-Message-State: AOJu0YzhXGz15TED0KZBKblRKLWD3h1ulS3+wPVkqCDsxBffmc8hY7oo
	lJUdaXxU4+jNNj6WcXkcLlRZMw==
X-Google-Smtp-Source: AGHT+IFaIItATlDRNYtcD9NZzG6YXArn5AX8jrSe1vJMwigpZOnGOphSVTghcOXwMrz7Aid2q4S5sw==
X-Received: by 2002:a17:902:c115:b0:1bf:4a1f:2b57 with SMTP id 21-20020a170902c11500b001bf4a1f2b57mr4844128pli.13.1696013176804;
        Fri, 29 Sep 2023 11:46:16 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l19-20020a170902d35300b001bc6e6069a6sm17300448plk.122.2023.09.29.11.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 11:46:16 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Justin Stitt <justinstitt@google.com>
Cc: Kees Cook <keescook@chromium.org>,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] firmware: tegra: bpmp: refactor deprecated strncpy
Date: Fri, 29 Sep 2023 11:46:14 -0700
Message-Id: <169601317381.3009991.4885445233179317899.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230913-strncpy-drivers-firmware-tegra-bpmp-debugfs-c-v1-1-828b0a8914b5@google.com>
References: <20230913-strncpy-drivers-firmware-tegra-bpmp-debugfs-c-v1-1-828b0a8914b5@google.com>
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

On Wed, 13 Sep 2023 19:38:44 +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> We should prefer more robust and less ambiguous string interfaces.
> 
> It seems like the filename stored at `namevirt` is expected to be
> NUL-terminated.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] firmware: tegra: bpmp: refactor deprecated strncpy
      https://git.kernel.org/kees/c/5a4b8c16f53f

Take care,

-- 
Kees Cook

