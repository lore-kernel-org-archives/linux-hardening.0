Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29406667A
	for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 19:21:16 +0000 (UTC)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5868E7
	for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 12:21:14 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c5bbb205e3so131187225ad.0
        for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 12:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696015274; x=1696620074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lm/Ps7g202MOlVqh0mV3HRz4xTXb5X6yozpQbIPIl6I=;
        b=gSRDOGOZbB2n64eG/cfkxWTEBrmAqSZ22g6OdEVJpp8LUVBubU9NFOIbU1TxDfprBf
         TPd76lbdz3x30qwuU7ZJ/spBaLvWqOUmUt+yXlXEEmwxS+DUA/uxO7kJ8+lakSBce6nS
         s8IUFaWwzXY+zs/Auu1psX5OZLcUFW6HfSpmA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696015274; x=1696620074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lm/Ps7g202MOlVqh0mV3HRz4xTXb5X6yozpQbIPIl6I=;
        b=QHVGta8xvdxaV/W+sEBrQmhxkR7RGMhYFO2GQAqXSJcmdGuA/JcVtHNnkixrMm08nN
         cy0CKu/P0UKNyKmEKtN0ISprEivzVB8EDWSTjLgNY20OIKjhSiPCK/G7fED2S2fqo92A
         2vXca9JFrAZ0K/0Ec8O9n2iOE/RuxdbY4Kq1+JiNShoOGUna85TW+k/hRciCHKW9c1Jw
         cnX6HyZzam+djrCd/9NMqXa5LeB30/C7OeH8WRylhm8FGpeeOc6R0az7fJ88JArahlGV
         KEhR7/CXZq/uvdkBH0BJAZ1b3lFucFI+HdJKnx1HHG2si4ymf5ClCQfAiecVJQeSsiSr
         HDKA==
X-Gm-Message-State: AOJu0YwRv+y2HPlZr7eTT2wUt9by8MMPxPyhw8GzO+8GP0LN74pwjOUB
	vGCGDXyWuWr5vMrZCz+91BT+jg==
X-Google-Smtp-Source: AGHT+IHzxuvEn9JIX48urjncDPYH9dBw31tAucVspB19q62Zql14kwcg7Iwk6ubcIA4im2QxAPeqyA==
X-Received: by 2002:a17:903:230b:b0:1c3:4565:22f with SMTP id d11-20020a170903230b00b001c34565022fmr5848461plh.21.1696015274330;
        Fri, 29 Sep 2023 12:21:14 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id je15-20020a170903264f00b001ab39cd875csm13499524plb.133.2023.09.29.12.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 12:21:13 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Alasdair Kergon <agk@redhat.com>,
	Kees Cook <keescook@chromium.org>
Cc: Mike Snitzer <snitzer@kernel.org>,
	dm-devel@redhat.com,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] dm: Annotate struct dm_bio_prison with __counted_by
Date: Fri, 29 Sep 2023 12:21:03 -0700
Message-Id: <169601526975.3013632.7773910905391133937.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230915200407.never.611-kees@kernel.org>
References: <20230915200407.never.611-kees@kernel.org>
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
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 15 Sep 2023 13:04:08 -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct dm_bio_prison.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] dm: Annotate struct dm_bio_prison with __counted_by
      https://git.kernel.org/kees/c/1eb1f6b6c911

Take care,

-- 
Kees Cook

