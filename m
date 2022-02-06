Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31BC4C4332F
	for <linux-hardening@archiver.kernel.org>; Sun,  6 Feb 2022 17:45:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344989AbiBFRpT (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 6 Feb 2022 12:45:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344848AbiBFRpR (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 6 Feb 2022 12:45:17 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B97C043189
        for <linux-hardening@vger.kernel.org>; Sun,  6 Feb 2022 09:45:12 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id n32so9697214pfv.11
        for <linux-hardening@vger.kernel.org>; Sun, 06 Feb 2022 09:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vqdb+IjvR7W8E5ZbYWXJikM0js3mZmH+zUbAZQxhgw8=;
        b=CD2cSm+Jq/YqWHrsk91+IgI6ZtNrSFWIZi4U225H/t3jQslCYy7ZusGLWFch+Nqa5o
         6cf8TP6OuQL4NNV/YI9/dN29UEneYoQDDCjSI2vFPM0k+6gBBXmBNREyEc2cLADqQR98
         3+OJykZ7Y+YwhWGkvn/y6NFZOkBdehWpaiagw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vqdb+IjvR7W8E5ZbYWXJikM0js3mZmH+zUbAZQxhgw8=;
        b=SVwMvG8NFPfvsAM9Fu2nvRJi5+ZnmdqeLdr3ASjYSsWRjcgIfATSQ6yeHrgLkaUpmu
         iYgX7BD/0ddf9qH1/dXaYAq/xdrrRSWWTAglrgFuGX0Vb8weOEynpfp7+Zwow5FNdhKh
         57BkruwLFyOwn0tQdjLZt6ZFZAoszv5EoRQRd26+Mp941rni1oEZP9tzKl60E6wmdmxA
         +k26KpxhuehiOsl94B82TjduZoAFU/TrhFRPojjcz61yL9ygRaGTgKVBqDe0bhDIkSyj
         i15t5HZ7rOYTPU2DmoD0rINOBayeq9VB115N/exsxAJ+2Cq5F9hBqHkNvqD3yHduZpLm
         lmWw==
X-Gm-Message-State: AOAM532VxQvSgEHl6x45ZumcXrLDIIwGt5Ev4eGgJQ0uoD9pWxmj1ixi
        K5f/ho8zAhoRM+6IY43OvVtO+g==
X-Google-Smtp-Source: ABdhPJyEofsTh8CiCMqluEuIuZ1SrpnKNOKrVsxFi0C1QiJP1PbwZoDra0ohb1ZaCI+aRJ92f52J5w==
X-Received: by 2002:aa7:9d9b:: with SMTP id f27mr12269201pfq.84.1644169512496;
        Sun, 06 Feb 2022 09:45:12 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f3sm9537609pfe.67.2022.02.06.09.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 09:45:11 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Alexander Popov <alex.popov@linux.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH 3/3] gcc-plugins/stackleak: Ignore .noinstr.text and .entry.text
Date:   Sun,  6 Feb 2022 09:45:08 -0800
Message-Id: <20220206174508.2425076-4-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220206174508.2425076-1-keescook@chromium.org>
References: <20220206174508.2425076-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1210; h=from:subject; bh=pVDpB0fLeXzkw7qtOTlz2Xjee/LCaGQ3lZV5lGGvWcE=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBiAAkjkTUerpEggmIzHyPJuyDEgbgzPKYmgGRrnVOi cs5tNtOJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYgAJIwAKCRCJcvTf3G3AJhwwEA CMMwXjllOJPlCgUdB/Vxpjt1yZo3bgDDu0djnWckBM5Fdstv8Pm9MoCDUdWaCOhgCM5JWYowz91COz e4xHfc0WiPZE9YvNSQ/HjlAewWRP0D4Qdfz3hRfxBL2h2lqOAD/kqbkbJutoB0FvsaR743uPk9lfsY S904GcaCkeMn7wBkzR/jEiJht7Z0TmKDahakj5yOfUiQXKckEO/k+NqdrfxjEQdJlJgNHusa9aREVG z4M/hxIuTSBZNjkI/zU/CJtPsZcxODRzsof+af4XcbH/wWHZGetGx2MyTThL381ZheVCCz/MPjvhDN 1OBV4wRzNrTCWrsUAiTCGLFgcAa6quWbqGJQ7Vg++5UXXjY0bxWSCea4ouYA9G8uLyUhUYjkp1ch30 yozbt2bpcWX5uwGFrIO/yjv52WnpDwwpSLnkbNkDiJSVRkMtAmoN7npt5M/stzHbZgEISVGONmcbNl cJERD8Whq8p9RQUM5KuSTCfl/BMoxDfDuZfINCB6TCG497jTLQq0+OEJ2D+9XklmTFYmVn5JqIjK32 SQxtSUW2Rg+2barzot9TFsjVzZXaXAO9ntsYn4Blm4vWEFxvaaBkJAy0OuBRU2HFA1Ib6MUxBLe9Es gqI1DbTc5+7Aw8Uzt1vfvxXR9+2IKquvEnSkrNpMrLT6gWPd801T5o2S9Hbw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

The .noinstr.text section functions may not have "current()" sanely
available. Similarly true for .entry.text, though such a check is
currently redundant. Add a check for both. In an x86_64 defconfig build,
the following functions no longer receive stackleak instrumentation:

	__do_fast_syscall_32()
	do_int80_syscall_32()
	do_machine_check()
	do_syscall_64()
	exc_general_protection()
	fixup_bad_iret()

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Cc: Alexander Popov <alex.popov@linux.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 scripts/gcc-plugins/stackleak_plugin.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/gcc-plugins/stackleak_plugin.c b/scripts/gcc-plugins/stackleak_plugin.c
index 623bcad6d0c7..c8dc7fe4f959 100644
--- a/scripts/gcc-plugins/stackleak_plugin.c
+++ b/scripts/gcc-plugins/stackleak_plugin.c
@@ -463,6 +463,10 @@ static bool stackleak_gate(void)
 			return false;
 		if (STRING_EQUAL(section, ".meminit.text"))
 			return false;
+		if (STRING_EQUAL(section, ".noinstr.text"))
+			return false;
+		if (STRING_EQUAL(section, ".entry.text"))
+			return false;
 	}
 
 	return track_frame_size >= 0;
-- 
2.30.2

