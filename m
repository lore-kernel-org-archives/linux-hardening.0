Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8BACCD37A7
	for <linux-hardening@archiver.kernel.org>; Fri, 15 Sep 2023 20:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237153AbjIOUKT (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 15 Sep 2023 16:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237292AbjIOUKJ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 15 Sep 2023 16:10:09 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED85CC6
        for <linux-hardening@vger.kernel.org>; Fri, 15 Sep 2023 13:10:00 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-68fb898ab3bso2120661b3a.3
        for <linux-hardening@vger.kernel.org>; Fri, 15 Sep 2023 13:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694808600; x=1695413400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nk/nOdWGEwQoqrorI1M5M4fwyDhM0MyESikBhRPJynY=;
        b=GoXo+IQumbCh93lMrBeK1O7HBstJmd6H2DeRANwWPg2DLSCVbkK0gy5yFtTg95KYAg
         pMZXG8lSp4/RaWR7OQH/CW5NMO7ogkaRm7zZfoFIYXO/UlVv76MWHShxPn2846QbNmQw
         zzyYtesLZ7KqU7cov2metdcauBd9/3pM8Sr5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694808600; x=1695413400;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nk/nOdWGEwQoqrorI1M5M4fwyDhM0MyESikBhRPJynY=;
        b=NoR58ZssmaqGz9vJ58/1HL6YeMsXCVn9YS51L1t7CvzxpvHaDiGa5sfWYgX6KCkzhr
         LPu/X3i6Iz3Az6guNwyze+ZBQjdTPUaXoOWq0aJy25Cg1fwS9/oi74uBw4XafHlxS4HE
         oJx4ke5wKdawZ7xj+DyV9P6xViYpvW8hcc3wZYT1SDc0gJDrWhHFGkrdZFqki7S9IcDZ
         zdWbSoQAIB4bniuM7J+t4m9cTPDQdGwdhCP9DL+J3ZElEOKOclDHP9pBBNkUJ/JeJcwG
         YKEwRH8SEm01PmJfV23SYd/zbtKY7Oikk7y/iNFH4OLGQCbzDSwPygbIDJMwXYR+5cRi
         CHeg==
X-Gm-Message-State: AOJu0YzWD9yAcjfAdCZriz5N5MXOODCqnu7KnHuTsj/72hs9QtvhUSpn
        9IOBLuv7X+A/Xdf7ktkOgzygPg==
X-Google-Smtp-Source: AGHT+IFkfodOw8key9MPLTpF8gDPsl4mUuf9r5i/8RdhOSnfEKeLKI70UXE9EitqTTeBx6I3fzUqdQ==
X-Received: by 2002:a05:6a20:9193:b0:130:7803:57bd with SMTP id v19-20020a056a20919300b00130780357bdmr3001465pzd.3.1694808600453;
        Fri, 15 Sep 2023 13:10:00 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j26-20020aa783da000000b006883561b421sm3321766pfn.162.2023.09.15.13.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 13:09:59 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Kees Cook <keescook@chromium.org>, Lee Jones <lee@kernel.org>,
        linux-leds@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] leds: el15203000: Annotate struct el15203000 with __counted_by
Date:   Fri, 15 Sep 2023 13:09:56 -0700
Message-Id: <20230915200955.never.871-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1207; i=keescook@chromium.org;
 h=from:subject:message-id; bh=AuQmhyKilUvoXwglsma/MaTlIjm+821tEBgc3NFI2G0=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlBLoTgbluNuEb1ppIxCDVPhVSRR03x+HRH+wGk
 TRaulMR7I2JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQS6EwAKCRCJcvTf3G3A
 JmYoEACdL3vVF2NKECABdmlrHoQg7GoQpORVNGSD7el8DAMl2SBhoB09PyPXllokTqK9Wdil8zV
 zZPIhIGvvUg5oG9N/OMZs9AwUK+CMQNWBG1YsP6za4n0V2TaobBHGIJmhYbBfcYx8ZgAp/bSWN+
 TvG9AQpwF5p5NuHck+/CfHURygXTJpYCHco/6y8qBEuIttCFIsytyfX2AQPbQuSvDyoVXAcfxjb
 iaKhvLFCMqVMnBmihmv6mFyiLZfARMGlfrvAAO642M46+/rMmAx0Fg0TCkLZDrmOwoOXUqiV4kj
 BJSWoBKjM0hUxo0fXw/Ha5n6uDjLsZ9uXNh6cszZO9Dx1z1bCrAWDkyIKpryVLX4ZF0Xn2MZSD9
 y2tF1ooPUPeZHIFOy+ZdXVrUI5Hrcgq6J/85H2zltLR30GOyvTV0cl4wD6vz7T1xZz6JT0jN//L
 tBY+QCaBMaB2e7UPPX6ivy4npGZRvC93WHEHwYZ7pRXA6aDkDEL91tLzVdMdPeGvNvybrASe8sN
 vwcfhZhL+89ozR+go0DF8VBaeAuHatpbKYiUM39R3IB+Lvn5c3v8fUxPUHvkZDJEvD0R7u8gsqi
 tFykTaw5+cMlZFoLrXywMsHcXVrOccqZEt+dOi9SCZnr7CvdKlmoHc+hTlyIOli3HNATBr5UqqP
 pJ1mVkd qJDn93uQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct el15203000.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Pavel Machek <pavel@ucw.cz>
Cc: Lee Jones <lee@kernel.org>
Cc: linux-leds@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/leds/leds-el15203000.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/leds/leds-el15203000.c b/drivers/leds/leds-el15203000.c
index 7e7b617bcd56..d40194a3029f 100644
--- a/drivers/leds/leds-el15203000.c
+++ b/drivers/leds/leds-el15203000.c
@@ -80,7 +80,7 @@ struct el15203000 {
 	struct spi_device	*spi;
 	unsigned long		delay;
 	size_t			count;
-	struct el15203000_led	leds[];
+	struct el15203000_led	leds[] __counted_by(count);
 };
 
 #define to_el15203000_led(d)	container_of(d, struct el15203000_led, ldev)
-- 
2.34.1

