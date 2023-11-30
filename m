Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q3dhC8qj"
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E0D1716
	for <linux-hardening@vger.kernel.org>; Thu, 30 Nov 2023 14:01:04 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1cfb83211b9so13530725ad.3
        for <linux-hardening@vger.kernel.org>; Thu, 30 Nov 2023 14:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701381664; x=1701986464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LerepnGMUiOXT/0UGMgfJC9H+FWGcQr9/NrsSWwAYiw=;
        b=Q3dhC8qjpdGvSN6yf4sstv1lscPUiM7AdYCkZeyAZwM1+tcrkBL9mPq6BWnF+3XEFz
         WyMCIYCB+/8DFNZ3PmxRP2Z01h/3cQ65NyxGve/qLeviTCOzAsv2NhaAAerloOYcOu1B
         telNaPWDg/xcoYoO/q0N6jGyLGcn6aZpdqj7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701381664; x=1701986464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LerepnGMUiOXT/0UGMgfJC9H+FWGcQr9/NrsSWwAYiw=;
        b=mu79NUvuQVJa7p202ftOgCD6aKAi8Fp4hdOO83fu6Gx01WvtnmInTutYTMBrWMp/bo
         FCHb9LGzafL/XLB0wwgqNgjw+EpemZDASTu8aV17D+jC+oqb52Z8sIlK4PfHXCnbMRjO
         3ajiJky/qnNJIx6JOzIpoMjDJQEUkDFB1tEC4HrQnG8xoMJdgzlUDjpZFDugEKuPWuRu
         O5l69tGOzOjBNs0DlFBzpIqsKiz+rAFIr+tc5rZvBkP28lcZd+atn1GNrtB8nCQtasU5
         ISVWRMcPIcLbedMayzXSYzpdR+s07Pso5x9cte8ASwzvGlVjekyKlllASS8k4gWi3SJc
         8ydQ==
X-Gm-Message-State: AOJu0Yzt5wXvDr4Fw7r+unuTVJE8N7Cg8KyxsQCpWWai2fPXGSHGXWY3
	Zjm1cxK6AYBL7G3R4Q7TURM50w==
X-Google-Smtp-Source: AGHT+IGXEBsq8mJGgfRrzCqpP9iVTEjhPsI63xlSBWuqXIohnExKvOFH6N2uRWv3F1zWbr5pMAWXTw==
X-Received: by 2002:a17:902:7045:b0:1cf:b4a3:adae with SMTP id h5-20020a170902704500b001cfb4a3adaemr17178400plt.44.1701381664185;
        Thu, 30 Nov 2023 14:01:04 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b11-20020a170902650b00b001c71ec1866fsm1910128plk.258.2023.11.30.14.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 14:01:03 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Justin Stitt <justinstitt@google.com>
Cc: Kees Cook <keescook@chromium.org>,
	nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] nvdimm/btt: replace deprecated strncpy with strscpy
Date: Thu, 30 Nov 2023 14:01:01 -0800
Message-Id: <170138165969.3649414.1104286704035557609.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019-strncpy-drivers-nvdimm-btt-c-v2-1-366993878cf0@google.com>
References: <20231019-strncpy-drivers-nvdimm-btt-c-v2-1-366993878cf0@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 19 Oct 2023 17:54:15 +0000, Justin Stitt wrote:
> Found with grep.
> 
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect super->signature to be NUL-terminated based on its usage with
> memcmp against a NUL-term'd buffer:
> btt_devs.c:
> 253 | if (memcmp(super->signature, BTT_SIG, BTT_SIG_LEN) != 0)
> btt.h:
> 13  | #define BTT_SIG "BTT_ARENA_INFO\0"
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] nvdimm/btt: replace deprecated strncpy with strscpy
      https://git.kernel.org/kees/c/26b4ca3c3901

Take care,

-- 
Kees Cook

