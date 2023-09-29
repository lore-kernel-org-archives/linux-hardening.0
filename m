Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C1A8F70
	for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 18:42:40 +0000 (UTC)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8B2199
	for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 11:42:39 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-578a62c088cso752250a12.1
        for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 11:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696012958; x=1696617758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T9uvG72rN99E2O8Y/qdqLqMjg2c8kFRNHVwd2wswc8k=;
        b=ai8S07hGdEesJ+tYar8luKkbXpHUG758UVb26RdnyRp+Wa+XGuEkEXFWiD8w4KnFs/
         cbg5bh0lNo4lc0eih3XoGPHbivHmkjPcC5swHb3cRBNqex8owFm/fAvT91LoWxtBbNQb
         jq+om0zlZczrNzoiuM1T5LCmDxuyohfrbDSkQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696012958; x=1696617758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T9uvG72rN99E2O8Y/qdqLqMjg2c8kFRNHVwd2wswc8k=;
        b=aNRClCti1X+gl/ENbx+o9sbL4PqOpHIEifsGWgFmV1rfXKTGr6iH+Obppw1daz91jl
         xkq9iBy9B9XcoNmJwUgeibhDGHCa1//Z7PLGBYufDo9lKfwl8IV08UOgM9ZpAkogdxh0
         Lz3t5RoZQI65OqBLY/WnTWT14/R1ZFa5UZjP3yFBvpb5XDuJ9n1gndXAT7mWGnqVx7hn
         P8vHQTen48oGFUh54rTxZu5jf8jstajgNVKw2FBwHkq++ZxAfAJ4K+PQ3l0t1leunbgW
         7yI2P3hTCdY+9VikSFk4jfut4+EIhpgFmTs3nSU+xmHW/Miit/7K61fR7fuIqsvzU9Z+
         8+ag==
X-Gm-Message-State: AOJu0YyljuQYwsG2BjpPQooHsAwmf5nuTOnu3x1czX/sXKUVuo/Fg/X4
	eJNe6q7dneEkYr7mC3D0TfLJIQ==
X-Google-Smtp-Source: AGHT+IFawLQKnjWvqnv/R1ichCDj6BPDnUafRPjmIJgk11i3pS1JnzbcQn+xqetwefwI/Zpyai3aeQ==
X-Received: by 2002:a17:90b:1982:b0:279:dae:2d3f with SMTP id mv2-20020a17090b198200b002790dae2d3fmr7807149pjb.22.1696012958637;
        Fri, 29 Sep 2023 11:42:38 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 14-20020a17090a01ce00b00271c5811019sm1932915pjd.38.2023.09.29.11.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 11:42:38 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Willy Tarreau <willy@haproxy.com>,
	Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Justin Stitt <justinstitt@google.com>
Cc: Kees Cook <keescook@chromium.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] auxdisplay: panel: refactor deprecated strncpy
Date: Fri, 29 Sep 2023 11:42:27 -0700
Message-Id: <169601293865.3008733.731908758021441164.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230911-strncpy-drivers-auxdisplay-panel-c-v1-1-b60bd0ae8552@google.com>
References: <20230911-strncpy-drivers-auxdisplay-panel-c-v1-1-b60bd0ae8552@google.com>
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

On Mon, 11 Sep 2023 20:51:04 +0000, Justin Stitt wrote:
> `strncpy` is deprecated and as such we should prefer more robust and
> less ambiguous interfaces.
> 
> In this case, all of `press_str`, `repeat_str` and `release_str` are
> explicitly marked as nonstring:
> |   struct {	/* valid when type == INPUT_TYPE_KBD */
> |           char press_str[sizeof(void *) + sizeof(int)] __nonstring;
> |           char repeat_str[sizeof(void *) + sizeof(int)] __nonstring;
> |           char release_str[sizeof(void *) + sizeof(int)] __nonstring;
> |   } kbd;
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] auxdisplay: panel: refactor deprecated strncpy
      https://git.kernel.org/kees/c/0456f788873d

Take care,

-- 
Kees Cook

