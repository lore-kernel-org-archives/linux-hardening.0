Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7E858227
	for <linux-hardening@vger.kernel.org>; Tue, 23 Jan 2024 00:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705970159; cv=none; b=b5cs13PBxCZyEHDMNpVFxxL2m2Cw6M9fpUF5FS242seOWbkydkFjeAHO76mimZ1eXd8NA6iLXdD0CEDqSvtC5tn7NlUWPjOXzUhrsSU15ftSQAX9N47wAvyWS4iHNbQBdEnUKEB3mfu9D76z6VCOqAU3FARzvhj0VWvZg8tYkbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705970159; c=relaxed/simple;
	bh=uCq9BZALf0j9/ETUS3uuALuSJ7AAwOFns9U/7aqT71s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ikqmwLyT2KYf8jSRlTXCI0Vpvvl3BTSSPWAWGMEPIZzT4IbgdwwUn06F6UTxlCWL/rJBQvysPmXILusXzCw6r6zMe1qQivG2QRSEw4mug2M+lWvyBfkkwrreT93MUrsFsYvVrOvoXyQTsVn5pz7PT3RXscqcX7KfOaLO/bjQSUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=elAG1CCq; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="elAG1CCq"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6dd8cba736aso2699090a34.3
        for <linux-hardening@vger.kernel.org>; Mon, 22 Jan 2024 16:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705970157; x=1706574957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wG9hLC1Y8Qz4XIU+37knJUuWpfkMo15LFrj6UcsKSzg=;
        b=elAG1CCqmiezPmZ1Yi8gmmxLq6vfzRQXyLvOsjBxatFVACT/cZT6uSlbKKSwRha3H2
         fUcW+SacpLLXbMKfAi/fAzXceA2s6bzqhAh7miE9xONWIoZ+CnzPLsbamIErdyFI11GJ
         oogrMqkGzct8WVZmPTI8hltWwS6MYXM2RyYDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705970157; x=1706574957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wG9hLC1Y8Qz4XIU+37knJUuWpfkMo15LFrj6UcsKSzg=;
        b=I70n03FKiGNAcl0ZgAgIYWA0FRrkF2wSqYjJFm9JNrHieB/xgs2BrVWyZqrk+IuEVV
         71jzPMS1wIcD2Im8UIOVcj6AjHatxREjPfDJ4csmdU+jxp+0kx2+qwAbb9w2q2Bb9JDW
         4tjot9hiCUF4kvogczHYPbTUEsXSVqWAaeWwqvi9pHqzCzVTSt48ojw81E7eeK/vug+8
         7ZfjXQuDKVOAuP79Q0SyXymY+Fdok4mcQTYUIJ0hRmvbJc6Fv86nFoStw7NcohFYCCaj
         ZXWbzlu1mu/VANHW8ocrzD3Khrt+eI3s6PrQCqtTeFLE7J0qqM67iVi5erA0SbnWTkx5
         eyqQ==
X-Gm-Message-State: AOJu0YzZil6veZlFj2Pc+oiqJXB/a05pt440PwaInhxI/9XbvBZs4LKV
	spWZ6POkae1bXuQNlTVIgibbETbLfq8PgdNfeeewiHeKKVWoSnOzh2eGJ9pqZw==
X-Google-Smtp-Source: AGHT+IGbgL8Un0khLBlsN1pl13RP4p4uyS26GBQlOHuEQ2+m+4aEmkVM5e6HKgLY7UQK+FMw+Gq5gg==
X-Received: by 2002:a05:6358:3a1b:b0:176:49e6:d1be with SMTP id g27-20020a0563583a1b00b0017649e6d1bemr2746628rwe.7.1705970157322;
        Mon, 22 Jan 2024 16:35:57 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id cz4-20020a17090ad44400b0028ddfb484bfsm10223874pjb.49.2024.01.22.16.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:35:55 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Kalesh Singh <kaleshsingh@google.com>,
	Fuad Tabba <tabba@google.com>,
	Mark Brown <broonie@kernel.org>,
	"Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>,
	Marc Zyngier <maz@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 40/82] arm64: stacktrace: Refactor intentional wrap-around test
Date: Mon, 22 Jan 2024 16:27:15 -0800
Message-Id: <20240123002814.1396804-40-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2174; i=keescook@chromium.org;
 h=from:subject; bh=uCq9BZALf0j9/ETUS3uuALuSJ7AAwOFns9U/7aqT71s=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgIWLuyCnEjUOpchm9ZW7j82YoUv1l18xa4s
 B46n9dQEkGJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8ICAAKCRCJcvTf3G3A
 JuwlD/9oy+jGtAZ3FCSqVsESv3Dn6Ts4xfGimKqQuQt33Bce9y47K5whT43UwUX/FxTZH/tqTgB
 TW3eKjRzRffUEDvN7ZT3GaQZJdk/dhoJFA5OwB26dEaeTJJ87F2CEIcM/XPxpKfWWV8laKhxXPW
 Azdz8NmHKXvqukygGhhgSEkQ2kpnbOFr/4IlSgZyItDfY4qACe9CngG6WRi14g/HSCU9Gywjg69
 ZJ4iAQu4qte9m5QXTwr49Fk4KN/ToizWcH4VTLjQyoJ5q/FZ71Xgw4QOa1223/YsX+bcqYMH4bu
 wrszgLp+AmxgO/JkCu2LfeuzW/PA81WplhvzGnpP0ARDAU9f1b3mGW4MnOu7+xSVcXxEPNBdHUd
 3qHBNykVoYEpQLXhzHp3489ya3gM8EnFQsefLnWYwE5at2WX4AB+AugITjOHRUKIKxVcMw/Yj5L
 vgdwRoSoXJjDDET92k/xcXhH34opUBHZT54vAmgUzK7pw3pfz8gKLwhZviN2r+BHKkBnSdMYFsM
 WjXNz1X2Tyl2wSrR4TmFPmaN+5owOGL0Rtmy9lrY6g0VnA1Ef5oRUD2D3FpyEPLXRpyKfY+/dY9
 jSlhYv7D+Rklx7QQ6QyLp0T/HQfyi460ttQUAt1JSZq2cjQhlrAimUKh31uhzT1WykiwMZzlyPc hxrjR+5ut598BkQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

In an effort to separate intentional arithmetic wrap-around from
unexpected wrap-around, we need to refactor places that depend on this
kind of math. One of the most common code patterns of this is:

	VAR + value < VAR

Notably, this is considered "undefined behavior" for signed and pointer
types, which the kernel works around by using the -fno-strict-overflow
option in the build[1] (which used to just be -fwrapv). Regardless, we
want to get the kernel source to the position where we can meaningfully
instrument arithmetic wrap-around conditions and catch them when they
are unexpected, regardless of whether they are signed[2], unsigned[3],
or pointer[4] types.

Refactor open-coded wrap-around addition test to use add_would_overflow().
This paves the way to enabling the wrap-around sanitizers in the future.

Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
Link: https://github.com/KSPP/linux/issues/26 [2]
Link: https://github.com/KSPP/linux/issues/27 [3]
Link: https://github.com/KSPP/linux/issues/344 [4]
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Kalesh Singh <kaleshsingh@google.com>
Cc: Fuad Tabba <tabba@google.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/include/asm/stacktrace/common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/stacktrace/common.h b/arch/arm64/include/asm/stacktrace/common.h
index f63dc654e545..6e0cb84961f8 100644
--- a/arch/arm64/include/asm/stacktrace/common.h
+++ b/arch/arm64/include/asm/stacktrace/common.h
@@ -49,7 +49,7 @@ static inline bool stackinfo_on_stack(const struct stack_info *info,
 	if (!info->low)
 		return false;
 
-	if (sp < info->low || sp + size < sp || sp + size > info->high)
+	if (sp < info->low || add_would_overflow(sp, size) || sp + size > info->high)
 		return false;
 
 	return true;
-- 
2.34.1

