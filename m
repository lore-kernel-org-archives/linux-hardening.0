Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A806588D
	for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 19:21:21 +0000 (UTC)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43CE1B5
	for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 12:21:19 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-51b4ef5378bso11133629a12.1
        for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 12:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696015279; x=1696620079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tCv+kMrx/0UVGQCBQ46tqfp9gvNT/0LM2qgPxtgaA9o=;
        b=VX4hN++I+aUc1RYQv6yPxwRdma7EuTF2+LNbnhnxHUwwju+e1crZgJgNTyuPIwvvdd
         i2ZkwRKYiUHJVbJpEKaLXNEQeTEho1lzI/nc9C0A0s7LDNWs/FB03nMQnsrkAN4JvCdc
         2lkpELBtihCNmQMAAgMZIpmM7ELu2Cl/4J3v4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696015279; x=1696620079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tCv+kMrx/0UVGQCBQ46tqfp9gvNT/0LM2qgPxtgaA9o=;
        b=encbpXDf/U5IY8xXQTpXMy9owFc0jxSbTcaUIK8hzj5wyBDJhCetX978+rd95z57ji
         0zNrmTSHSCEn/JaGToUY7vkmA+XSKvy3Mg5w5e0Q3U/KAdpPjKeyXOKOsDKmlF6Iw2XB
         jNyIeqf5kKSNoC/YPpZ5EWvqFC4Wei6WVkyRw97owPBZ2Ryes/3dEi5YrnN/RW3rU0wy
         ozYdJJo4QOAf6nG1GcInwuAwQBImQLlofb5KEfMXJ8KhlKQyjsGmVHvjsjoBCyuO/siF
         OdWAv400PNnr++hbLDaQHZBe2Q3DwwiKkifqhVpGqtezri1Dw6si3iOGz9y8dOVQcIHM
         XQ4A==
X-Gm-Message-State: AOJu0YwEisQBNtB5DX5hAXtwbpzAK4IR74rQVWnXCC6L/dNNmV+jlq2S
	pTYbEdPsv5jd1cRfrPG9W1qW7jbtj0IBt/6XtpQ=
X-Google-Smtp-Source: AGHT+IGiBwStaHPR44R6ANK1/tkrYWC/2DFh5Z+5BULeXdWKDr6O8WVqqWNlE6Fy+1azpzu06/HF2A==
X-Received: by 2002:a05:6a20:3d22:b0:160:a752:59e with SMTP id y34-20020a056a203d2200b00160a752059emr5701827pzi.40.1696015279415;
        Fri, 29 Sep 2023 12:21:19 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y7-20020a637d07000000b0054fa8539681sm14767022pgc.34.2023.09.29.12.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 12:21:16 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kees Cook <keescook@chromium.org>
Cc: John Keeping <john@keeping.me.uk>,
	Udipto Goswami <quic_ugoswami@quicinc.com>,
	Linyu Yuan <quic_linyyuan@quicinc.com>,
	linux-usb@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	Krishna Kurapati <quic_kriskura@quicinc.com>,
	Jeff Layton <jlayton@kernel.org>,
	Uttkarsh Aggarwal <quic_uaggarwa@quicinc.com>,
	Yuta Hayama <hayama@lineo.co.jp>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: f_fs: Annotate struct ffs_buffer with __counted_by
Date: Fri, 29 Sep 2023 12:21:11 -0700
Message-Id: <169601526969.3013632.10440475414357366621.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230915195849.never.275-kees@kernel.org>
References: <20230915195849.never.275-kees@kernel.org>
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

On Fri, 15 Sep 2023 12:58:49 -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct ffs_buffer.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] usb: gadget: f_fs: Annotate struct ffs_buffer with __counted_by
      https://git.kernel.org/kees/c/84657a30a0c9

Take care,

-- 
Kees Cook

