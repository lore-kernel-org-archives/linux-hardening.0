Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AYy7QYf+"
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8B11BD
	for <linux-hardening@vger.kernel.org>; Mon, 27 Nov 2023 16:34:41 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6cb4d366248so4084914b3a.0
        for <linux-hardening@vger.kernel.org>; Mon, 27 Nov 2023 16:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701131680; x=1701736480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AhnUEdFFWqGuqKk7HcQygs9znr/gnHSS65isK2aLNIQ=;
        b=AYy7QYf+oxjKLHl7ebER8TWBRE7sFj2W3Ya6tRqK/J4hi9ekwxJfIzRe805o0RyRri
         iYTOy3iuOqf9qcARwoQhMl2gwz4wO0t+nNiIrGGfVBvYhuxdsPAmoJd1fq99qwl5C3y1
         F82e49ZcFss0zdDxcrQWu+JX031MpUN6C3EZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701131680; x=1701736480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AhnUEdFFWqGuqKk7HcQygs9znr/gnHSS65isK2aLNIQ=;
        b=AL4CBL47i8Vcl16dL4gOOdwMJZb8eSxg/rmLkdLtv4rJdhXl/8p4hArwgTr4IJVBm9
         eW5aJTyqqJ/X2uvmVOxoQkHSzDfJR0ryIN+wZnWt3+fm40Mssvu0qVQ1al7Xh7s0RbrK
         IntatiY9rSK4viuT7u956Xvj82YItISjhcv1FUf7c/j2NjFOgjYjSJqMLpGkRERmSeq0
         2pkdGGUE64SGKd/jfOTXYHiKrLPWfg4LoQkm/k3lwuVZMreT2UVfQDCOAC1gBukmI0aG
         FgQ1WXXPne9gA4Gf3vFqKJzgb7taILBQphzEd3FQb7/L+oTsDpHgyEQsUlqZYKKacKQ5
         wLiA==
X-Gm-Message-State: AOJu0YwomQaMWX3ZSrWOPM7Hh9FLQ/sZK7tG0g+841kWVW/ojMrdkaDo
	MiHuxLSiBZdJmFj2DnWUN5MnOQ==
X-Google-Smtp-Source: AGHT+IH8yKr0KWQ8B1QkVC6xlixaU8xQM4arSGv8CqVXdwMbGLUcg+jOsXYMMokJ9vwGI04H0p1cVw==
X-Received: by 2002:a05:6a21:a5a0:b0:18a:e40c:682f with SMTP id gd32-20020a056a21a5a000b0018ae40c682fmr15260148pzc.41.1701131680675;
        Mon, 27 Nov 2023 16:34:40 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i23-20020aa787d7000000b006cb4b7ffe2bsm7647456pfo.195.2023.11.27.16.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 16:34:40 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] gcc-plugins: randstruct: Update code comment in relayout_struct()
Date: Mon, 27 Nov 2023 16:34:36 -0800
Message-Id: <170113167459.1670911.15084763564199264156.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZWJr2MWDjXLHE8ap@work>
References: <ZWJr2MWDjXLHE8ap@work>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sat, 25 Nov 2023 15:49:12 -0600, Gustavo A. R. Silva wrote:
> Update code comment to clarify that the only element whose layout is
> not randomized is a proper C99 flexible-array member. This update is
> complementary to commit 1ee60356c2dc ("gcc-plugins: randstruct: Only
> warn about true flexible arrays")
> 
> 

Applied to for-linus/hardening, thanks!

[1/1] gcc-plugins: randstruct: Update code comment in relayout_struct()
      https://git.kernel.org/kees/c/d71f22365a9c

Take care,

-- 
Kees Cook

