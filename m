Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9489C405F3
	for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 19:15:06 +0000 (UTC)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94B71A4
	for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 12:15:04 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-5859b06509cso1025708a12.2
        for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 12:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696014904; x=1696619704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YMR6LUwPftHKv0r5/Li6NluEAeTRiPtbXaPEQ4+PpRg=;
        b=UBVYx32GUgxii2P9VeGDr1XxGqw9do4g2/tM3vjpNC9nG0EjDE7tes9gRDeaZHKBu4
         vp/hpV3A98dMo62Yzx1vECGtQPuK3Nv3gnvw5cEFwMGP9gwVXJI2GuLKMMLElp7+edWi
         1mpveEyxLXzmsn2Llw8qGt8RBDcp/y/f4Fpuc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696014904; x=1696619704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YMR6LUwPftHKv0r5/Li6NluEAeTRiPtbXaPEQ4+PpRg=;
        b=BlO5KxEX/ZnpNZ4GAzdxF5FBBMAhMqDgqFZj7alkmvC9edhQkY06SN9MJfZP5CfKuG
         seRdvl8Qq0yff6GXwGfojtK8g98hJwWqbjk9tSkfyPy3NrUKDClTfq4hstXVMkfk2b1C
         xAjcQ4D04cxKw7gRwl4GdC7fatwUPGM4H0gftEAp8jm6c4zhNCy16Jhb38kZtVYc2WFD
         c/1n6J/Isv0X4GKYWbT4jSuTjI2LD5F28FN29GA+fTzY/zmwurJao7OBoI/kHUmiy2EO
         WBbSfc7lR+amBfuakahFJY2GMFzx6/rOMvLkJ+/vh8HgPzHCYSw7+9UC9c79X8v40mjX
         5BXg==
X-Gm-Message-State: AOJu0Yw6xIyD9gxIEbnH/vBTCghpAOQynqCOFQq7vaHo+bU/KFVws9qn
	UODP0FZHaCZgJawtVUh6rMOPfA==
X-Google-Smtp-Source: AGHT+IEBopBak8B7MGmd1sJZ3Lf8ZG5V73oh21Tehv4+8J8dAWg7SRzxgWm5FohLg5EVdZWMSxbroA==
X-Received: by 2002:a17:90a:f2c1:b0:279:47d0:d923 with SMTP id gt1-20020a17090af2c100b0027947d0d923mr439775pjb.17.1696014904230;
        Fri, 29 Sep 2023 12:15:04 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i6-20020a17090a2ac600b0027360359b70sm1974742pjg.48.2023.09.29.12.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 12:15:03 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Duncan Sands <duncan.sands@free.fr>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] usb: atm: Use size_add() in call to struct_size()
Date: Fri, 29 Sep 2023 12:15:01 -0700
Message-Id: <169601489954.3012131.16051231116010521718.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZQSuboEIhvATAdxN@work>
References: <ZQSuboEIhvATAdxN@work>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 15 Sep 2023 13:20:14 -0600, Gustavo A. R. Silva wrote:
> If, for any reason, the open-coded arithmetic causes a wraparound,
> the protection that `struct_size()` adds against potential integer
> overflows is defeated. Fix this by hardening call to `struct_size()`
> with `size_add()`.
> 
> 

Applied to for-next/hardening, thanks!

[1/1] usb: atm: Use size_add() in call to struct_size()
      https://git.kernel.org/kees/c/13f1a60fe04f

Take care,

-- 
Kees Cook

