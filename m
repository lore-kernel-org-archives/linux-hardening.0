Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536D143AB8
	for <linux-hardening@vger.kernel.org>; Fri, 22 Sep 2023 17:52:15 +0000 (UTC)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DFF1FE4
	for <linux-hardening@vger.kernel.org>; Fri, 22 Sep 2023 10:51:54 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-274c05edb69so1705932a91.2
        for <linux-hardening@vger.kernel.org>; Fri, 22 Sep 2023 10:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695405113; x=1696009913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZILszX4MWtz7bh2TMVWfqmp53JcjPScOVS5QC17vqfk=;
        b=bAyFRd++MAhZa6YTQQSr2m+eyFy2ovYko+HtobZCZuNCZjliiOVQ/NWhQReL5gf1oa
         ZAkD7N2/jup39syzqE9P6nb/aXe8KBo7EuNXIgRZ9ECwfw2/4opfKF+WTghcH1gXK5or
         0T2fAJD3EJDLLUx0CN1qAAof6dKQ0TEzklWZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695405113; x=1696009913;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZILszX4MWtz7bh2TMVWfqmp53JcjPScOVS5QC17vqfk=;
        b=OQhWldNaLM6sj6qXR5t94UoYo/YELU4gEnMWbaDTMsaT8vdCGh0Uz5tPR0VAcAO84A
         YetkGaxhuRlig3LpPEyDa0adhwEB0Kf94YLgH0EI2Ab14PU0uRb4niC/Vhjp+JXBsS/e
         Kb8GlTWHGZ3skaytckkngTVVei383zDJlrciasnxiY9S+FpGtzn90ZgSDsa+3TkWgkCv
         4EypKRC2TPO1m13zhFqGLBYSCFKabhAvna/zIOC2UGPP6QjEDQpvcr5TTSiJUN4bzG5Q
         xrzFcZi0yOMGDrRjoYtcbUbB7ZrYHAnLAqfQZGnedo87QyN5t6tdxNrmSipjdhDS+ucI
         cA5w==
X-Gm-Message-State: AOJu0YybJoRDhsswUzEyi6jhlBE1JK9Hn3C8+wYTeSc3rVmf8bFqLpRv
	9GXZuKtBnD1dtbu6tjckrE/7LYGo4gtqTk3gCic=
X-Google-Smtp-Source: AGHT+IGJyRN4d5EfONgEzWohOYEXpV8ZyHwIQaIwZgUrXnlaWap5XtP+1N7abHIvI+8NFIgf78FE5w==
X-Received: by 2002:a17:90a:1f07:b0:277:183e:185a with SMTP id u7-20020a17090a1f0700b00277183e185amr407052pja.3.1695405113456;
        Fri, 22 Sep 2023 10:51:53 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id mv5-20020a17090b198500b0027722832498sm76944pjb.52.2023.09.22.10.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:51:53 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Steve Wahl <steve.wahl@hpe.com>
Cc: Kees Cook <keescook@chromium.org>,
	Mike Travis <mike.travis@hpe.com>,
	Dimitri Sivanich <dimitri.sivanich@hpe.com>,
	Russ Anderson <russ.anderson@hpe.com>,
	Darren Hart <dvhart@infradead.org>,
	Andy Shevchenko <andy@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	platform-driver-x86@vger.kernel.org,
	Justin Ernst <justin.ernst@hpe.com>,
	Kyle Meyer <kyle.meyer@hpe.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: [PATCH] x86/platform/uv: Annotate struct uv_rtc_timer_head with __counted_by
Date: Fri, 22 Sep 2023 10:51:51 -0700
Message-Id: <20230922175151.work.118-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1571; i=keescook@chromium.org;
 h=from:subject:message-id; bh=k+Nu3NX5QQ2aJpVbKl87jzPBT9AwnncU9NuJ+rJwak4=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDdQ3/IWfXym/BBCdmz9yiUCx49Gifs9/mFbU1
 fQjtBKVTPaJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3UNwAKCRCJcvTf3G3A
 JqAKEACyJ4XXD0xFdoCxlx2T4B9GXHlkr0u0aIlUPFBN3pQD+P3BF5IzIJwgRcoVsqotPdlY/Rb
 wX8bNqO4HGy2JRIm67/oRWnZHaIhamlnh9HrkPLIWDE9xJOWQsvc6s/C2bSFPfQSlumNLC6yl9q
 9yvvYdOuBn9QAX1xEWsHI+uIQ37ZUnFxvQTQ+dAnhXJRTm9T4CDNYs4Ka6Db57dB7DOOLHPiWM9
 8/L84K0X+266nBtXX6Ux21Utcfzx7XbCCUwhJ6SypTPW/gqUiQdvyIw15WnhJoTYMwauzp+W/UT
 SHLxMwOrt8utH7z9acQen3/81bEmaxiofVy6F2ufC4O44RIwFEl7v/RsLxsfn2KSs290t7QaHBv
 WSniGI3Bl7uuhyCpRjCSYs2gppdfZKvcNu5Q0mGxEKay32lJKCjxnjr1tCV0oOBgFdPJ4RzSxqv
 l4Ssrx1TKwTYA8PavonNHCbyYrCqEeuM0wrCUbTW4vGPmRqEJDEWHln9va6TYtNMOstCSaOrIGC
 M+fyocdkfeTtnGViO++fqOgij3SKB4vu73/iBMRv7Kuzho9/d8vSqvIvaYud377MDl5h98k0tHh
 AmHt66ztgM3wW/s9CwFjN3ChnkNnds29tKewAdepJZO2OPp8hTVnD2V2l5d5YBvLTxOWsa06jET
 52pSu6h sWAZ6zbQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct uv_rtc_timer_head.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Steve Wahl <steve.wahl@hpe.com>
Cc: Mike Travis <mike.travis@hpe.com>
Cc: Dimitri Sivanich <dimitri.sivanich@hpe.com>
Cc: Russ Anderson <russ.anderson@hpe.com>
Cc: Darren Hart <dvhart@infradead.org>
Cc: Andy Shevchenko <andy@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: platform-driver-x86@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/platform/uv/uv_time.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/platform/uv/uv_time.c b/arch/x86/platform/uv/uv_time.c
index 54663f3e00cb..ff5afc8a5a41 100644
--- a/arch/x86/platform/uv/uv_time.c
+++ b/arch/x86/platform/uv/uv_time.c
@@ -53,7 +53,7 @@ struct uv_rtc_timer_head {
 	struct {
 		int	lcpu;		/* systemwide logical cpu number */
 		u64	expires;	/* next timer expiration for this cpu */
-	} cpu[];
+	} cpu[] __counted_by(ncpus);
 };
 
 /*
-- 
2.34.1

