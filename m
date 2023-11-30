Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KVIcu+K7"
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0040C172C
	for <linux-hardening@vger.kernel.org>; Thu, 30 Nov 2023 14:00:14 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6cdd584591eso1461633b3a.2
        for <linux-hardening@vger.kernel.org>; Thu, 30 Nov 2023 14:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701381614; x=1701986414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F3oJFeliwcGWQRUno3CXq/iefN/z87FyQUWuXF3JGq8=;
        b=KVIcu+K7OlsXPkwye8g/BYKLJlKr8R+30mNOdPdoXYIea5Z1sRJykikZYdQfMYjaOf
         u/iJGPPuQPCz1hMizQzgoxlG2mZuqK8MGYj2laJMa3aIOxqqeU05Fiwjl4zM0/ZkQmQi
         hcEGgFdi224y5/1uzm9Vk3cMSiywhUOJh5UX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701381614; x=1701986414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F3oJFeliwcGWQRUno3CXq/iefN/z87FyQUWuXF3JGq8=;
        b=pvf1evc+nhzTce2a4voEiincX17yToftf/yK3SdJM6eAQuNkaTsC1n3oBrOR7x2tsb
         xWEGOuXFLh170UC/FmhImTe02HIqh6dky3pzFgMYBWI+8uudNcoS6976M6tndgLg8WIs
         4f8Ua6GBRdklyFbl7TD8+DhWqVKg0WjpjoizZskV2ShkkYLO5oBxhYH04hoN+o2saGTI
         F85yfu/MuxFzGZrSyAul6uAAoPVRwJPhI+uXNyka5Lcn3cS49XNTWR5/3fYq6m4fJM4+
         NoGtzOwdF2nulncye1vw4bf9dGrYNBB9pSYmZYiVPauVpXhweFL7rk4MXGeOUGSL5TkU
         WNHA==
X-Gm-Message-State: AOJu0YwO61qxsAzSxRxfrGyibS3LlXhfNU3246p9VGupotVJtFMu516N
	KSs1C7VJhBeNYrD9UpPo/++E5A==
X-Google-Smtp-Source: AGHT+IHXj/e2zptmeZA5+AQNZP+QCtXebes1TXUPHkf0woeufQzAqe9Ylzhwe1YtCnXulknD2ks53A==
X-Received: by 2002:a05:6a20:e123:b0:18b:fde7:71ac with SMTP id kr35-20020a056a20e12300b0018bfde771acmr23958783pzb.60.1701381614459;
        Thu, 30 Nov 2023 14:00:14 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d17-20020aa78691000000b00690ca4356f1sm1699814pfo.198.2023.11.30.14.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 14:00:14 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Bryan Tan <bryantan@vmware.com>,
	Vishnu Dasa <vdasa@vmware.com>,
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Kees Cook <keescook@chromium.org>,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] VMCI: Annotate struct vmci_handle_arr with __counted_by
Date: Thu, 30 Nov 2023 14:00:09 -0800
Message-Id: <170138160625.3648908.9493256732138039199.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <56bef519d982218176b59bbba64a3a308d8733d5.1696689091.git.christophe.jaillet@wanadoo.fr>
References: <56bef519d982218176b59bbba64a3a308d8733d5.1696689091.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sat, 07 Oct 2023 16:32:34 +0200, Christophe JAILLET wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] VMCI: Annotate struct vmci_handle_arr with __counted_by
      https://git.kernel.org/kees/c/81c643edd8bd

Take care,

-- 
Kees Cook

