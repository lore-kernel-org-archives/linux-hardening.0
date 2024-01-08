Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9797B55E67
	for <linux-hardening@vger.kernel.org>; Mon,  8 Jan 2024 17:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="btZUj6hu"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5bdbe2de25fso1613566a12.3
        for <linux-hardening@vger.kernel.org>; Mon, 08 Jan 2024 09:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704736677; x=1705341477; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GvMazmgKoWsnbBpLVotpsngL1oQ/K5uRYIxujPwKFyo=;
        b=btZUj6huR1TasDu5KvFVxrCcA5Cm2gdcQ+BiuJOFoeDqAkmyS9e3wtLmI/m8TAxNnG
         jXDZHK0csCiac7llVS6fLWwZAs/tcybxf+ajdert0LvQ4MIWF84kCXeHwLw1pS/3R8ty
         Am3ID93IVSBA8vgb1ou02G3UWIlVd/RRGcVFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704736677; x=1705341477;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GvMazmgKoWsnbBpLVotpsngL1oQ/K5uRYIxujPwKFyo=;
        b=fJP8KopIXC6TgXjEaCmozDZiBeIsrE36bQGb7V9IXl1CshYLAe/CWeoK97B4upm8wo
         pWmIdG+VUCndNDt8XVAj4ErBZx27ddrojXwKhxVcXM/FH6D1BbtK+tm88n06nrD3iex2
         KUKvsU0AhZWf55gTnfHpr7EaiPHNKlomX3+bxgVBxD82k8Hmes2zn2fcQ0CHCqX7jeNu
         k7f0s8uzt0W8ioOZFB5VpbIZxYdrE+6F93bCDK0GPEcxHzDcs+VFi+zzYNfDQDvcrI1A
         LlAq7K3KA5/7M8hYLxrt6/ORMXfLcFy9YueyVePT3AMNPgedaNUc2HQ35w3ctdH/PgX9
         dfbA==
X-Gm-Message-State: AOJu0YzKT+/uL7B12xJnjVcCwJQygpUc6hQ50rD2dPKP4GVUCS98K6WU
	xo2YTc8Dq5HrRjqMFKfU7kj83rIjjmVo
X-Google-Smtp-Source: AGHT+IGwtRPXwmYzpN85L0M4dhNyX8jGEFxMDSCpkMmD+9xGIVhAjN4ikUgXAVStQmAFziY7f1bV8g==
X-Received: by 2002:a17:90a:7566:b0:28c:287b:dd96 with SMTP id q93-20020a17090a756600b0028c287bdd96mr2073284pjk.8.1704736676908;
        Mon, 08 Jan 2024 09:57:56 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id w7-20020a17090a4f4700b0028c8a4fb12fsm240139pjl.49.2024.01.08.09.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 09:57:56 -0800 (PST)
Date: Mon, 8 Jan 2024 09:57:55 -0800
From: Kees Cook <keescook@chromium.org>
To: Jingzi Meng <mengjingzi@iie.ac.cn>
Cc: gregkh@linuxfoundation.org, gpiccoli@igalia.com,
	john.ogness@linutronix.de, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org, pmladek@suse.com, rostedt@goodmis.org,
	senozhatsky@chromium.org, tony.luck@intel.com
Subject: Re: [PATCH] cap_syslog: remove CAP_SYS_ADMIN when dmesg_restrict
Message-ID: <202401080956.7FBE02F54C@keescook>
References: <2024010306-tweezers-skinhead-083e@gregkh>
 <20240105062007.26965-1-mengjingzi@iie.ac.cn>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240105062007.26965-1-mengjingzi@iie.ac.cn>

On Fri, Jan 05, 2024 at 02:20:07PM +0800, Jingzi Meng wrote:
> CAP_SYSLOG was separated from CAP_SYS_ADMIN and introduced in Linux
> 2.6.37 (2010-11). For a long time, certain syslog actions required
> CAP_SYS_ADMIN or CAP_SYSLOG. Maybe it’s time to officially remove
> CAP_SYS_ADMIN for more fine-grained control.
> 
> CAP_SYS_ADMIN was once removed but added back for backwards
> compatibility reasons. In commit 38ef4c2e437d ("syslog: check cap_syslog
> when dmesg_restrict") (2010-12), CAP_SYS_ADMIN was no longer needed. And
> in commit ee24aebffb75 ("cap_syslog: accept CAP_SYS_ADMIN for now")
> (2011-02), it was accepted again. Since then, CAP_SYS_ADMIN has been
> preserved.
> 
> Now that almost 13 years have passed, the legacy application may have
> had enough time to be updated.

I can't find anything mention this warning in recent times except this:
https://sysdig.com/blog/container-escape-capabilities-falco-detection/
which is mainly an example about how to apply Capabilities, not a
software failure.

> Signed-off-by: Jingzi Meng <mengjingzi@iie.ac.cn>

Reviewed-by: Kees Cook <keescook@chromium.org>

If you can boot a few stock modern distros and verify nothing emits this
warning any more should be sufficient evidence that this can be dropped.

-Kees

-- 
Kees Cook
