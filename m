Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4443076022
	for <linux-hardening@vger.kernel.org>; Mon, 29 Jan 2024 18:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706551249; cv=none; b=DTPHjyjKaRRpJJGRLVp+Lyd2BfT0mS2L0jlRavVMEWfvVPD6e5hpxLoVE1ytw8GAPsF45lYVLK8Cl9Y/7ATccHqmhOLXMK6nIfnkF32MuGg+NG8z1MiZ0td7FHoCDrRPtLbF+fR9PvJiIW8Fk1jvo/6RG1jXmP2srk6JlaDnCas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706551249; c=relaxed/simple;
	bh=yH6x7koGVyqkzXPlS5DuuMQ7rErHxIAyUsPCshZXJqo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MctCPxCqQ42liZX3P3HxUpsi0DwWHaQRdDhdBYBJe2UxJq+dVptfziUPkoSmXeZ6y/aaMyuGp/UBDz58egStcLx3HwWYB53a1koqQyp9V3um+640M1/sLjSydYDfxVn8lSJxfkOPtmOLAgARafbxkFFbtBjVCCgR9Oa60zTg09Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BQOUHIJz; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BQOUHIJz"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d8e7ebbbadso6206775ad.3
        for <linux-hardening@vger.kernel.org>; Mon, 29 Jan 2024 10:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706551247; x=1707156047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O9sYK7z3WbbgkknvMvwfZX35RqRNyf5Py+2kBlCGv4k=;
        b=BQOUHIJzk7qIgxq0A48NuWzrXBkZnfWYkpwALRhYZJsy3S4r402LiU83b3Uw9iB+W6
         2fy8oiGgfNKqTNELeQr/9IPNBRKSCX8IIeqX4DQVBuGhnlr+VhJ8iuLrFyIJJpS/pbyj
         Uw2wIRhXe/dDzB+ZIvUMoJIxaEahmAo8HmTgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706551247; x=1707156047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O9sYK7z3WbbgkknvMvwfZX35RqRNyf5Py+2kBlCGv4k=;
        b=MBWXhg8A2u7XWXVYQ6lSF1CZfpUrubFQ2pEU+wNINvo4TfQaLfubPaBYPoMyjWvSqt
         b7cqyuSnWSxCxpm2MwvwAk5MJsUs7OpKRVhxCbBsEVqXxNOImFZ/l5GwR3fpQl5+ItWs
         +L98APvcq+Puh74s16EEeSZUZ/V1rCBXS4b5SiO0468G0UL++9r5s/IILJ72KupsKfRy
         fL/yXc1T6byt8fchfPRGUx7Mw3cRBjGIns3w4V5/6L0DnxJqOU/mNIvKYLnOpVvtHF8v
         /Q5/I9BioHEABtrzOv/BvdYK1QS5mCJbiVsjP511y2wZUUiLfHpQnp72wCccVPNqZ4IE
         HVvA==
X-Gm-Message-State: AOJu0YyC5ROqcQx5eKtLLxgZMf4KnsnpwJ/sI+H7Kivrwpc/BEp8R7zW
	RNQLoj9IHr3XTFymM3Yn0ArmcdUOI0cY9PJwVFhVN/Z9s2BsMmWLhVYcClKcz9yr5tdYgrgfJ6E
	=
X-Google-Smtp-Source: AGHT+IEc+tDx6sfLTEL1mhumbCvDSbuCKsykyNGM2srfWvMprXBfegwjmTD5lvLJxAzPxS4f7WeABA==
X-Received: by 2002:a17:903:451:b0:1d9:1e1:76b3 with SMTP id iw17-20020a170903045100b001d901e176b3mr199139plb.107.1706551247632;
        Mon, 29 Jan 2024 10:00:47 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l4-20020a170902d04400b001d8dd45b9b1sm2374739pll.134.2024.01.29.10.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 10:00:47 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Marco Elver <elver@google.com>
Cc: Kees Cook <keescook@chromium.org>,
	Fangrui Song <maskray@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kbuild@vger.kernel.org,
	llvm@lists.linux.dev,
	Andrey Konovalov <andreyknvl@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 1/6] ubsan: Use Clang's -fsanitize-trap=undefined option
Date: Mon, 29 Jan 2024 10:00:38 -0800
Message-Id: <20240129180046.3774731-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129175033.work.813-kees@kernel.org>
References: <20240129175033.work.813-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1398; i=keescook@chromium.org;
 h=from:subject; bh=yH6x7koGVyqkzXPlS5DuuMQ7rErHxIAyUsPCshZXJqo=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlt+fKRyYbL1VJp1m0ZRn8657+TY/Q9I2OhsIfr
 Nhr+eEyD8qJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZbfnygAKCRCJcvTf3G3A
 JvvwD/4oBxFkh5fzUJffPCV7wy9Y6k2huiVfHjonoBRkDeyjaKqfQYTecCk/CL+c+TO65fhCT+q
 xqSs2LGuFyyj7eOZGVYhpL+fAeyXp00kJeJ9NO48Zit8cDCVOojomAjG68UBgx7SMDH9RrcGsCW
 zKM1fWgaWgs6y6q25ikHsKAQ7cGyV/ccKJlhd1//ttzhOufRHmHl1LFtqGGHwgaNA3VNKoFSbJ9
 Oj0pG0RrZWSc1cUZWHhw6X12fopRpJKdMPethlAGh8DSRUCH+Qp8S+c4Uvx5Kbflb28/q/w+1P/
 zUabY1h1VH0yC8NAe8xOBilIj5KXfjjkMAMF02LmZMDFPbVbAfTarNEBT3anpykg4TB6OjJUpeG
 JnnqzvSGbO9iveLeJWaN+9nR2qFV59NSmvyvLnIMvYf3heAJYgWyf1Ac10HNTUVuyPrvlLDm7f+
 rfpkI7Xd3lzR/l64/lRkqWcSDg+ZtSkQW+h1T6/5rzYkoxhC9BeJ5hl3PCuFtAgF1VmSVbnqkCE
 HVawUkwEyNpURWxmfTF7cmTDPpYe2V7SoUU+viFzi+mDZoSumju/sQWzFqG5usxniFDaa3H0Gse
 h84FxDEHMfFv3vs75+fQ00Ra4GKbQta90pHtfeZtrlf9zymnXZw60aQCN1CQRLFQL4eGd8FHP4d U4aVwGwI1l81C6w==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Clang changed the way it enables UBSan trapping mode. Update the Makefile
logic to discover it.

Suggested-by: Fangrui Song <maskray@google.com>
Link: https://lore.kernel.org/lkml/CAFP8O3JivZh+AAV7N90Nk7U2BHRNST6MRP0zHtfQ-Vj0m4+pDA@mail.gmail.com/
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Nicolas Schier <nicolas@fjasle.eu>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Bill Wendling <morbo@google.com>
Cc: Justin Stitt <justinstitt@google.com>
Cc: linux-kbuild@vger.kernel.org
Cc: llvm@lists.linux.dev
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 scripts/Makefile.ubsan | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.ubsan b/scripts/Makefile.ubsan
index 4749865c1b2c..7cf42231042b 100644
--- a/scripts/Makefile.ubsan
+++ b/scripts/Makefile.ubsan
@@ -10,6 +10,6 @@ ubsan-cflags-$(CONFIG_UBSAN_DIV_ZERO)		+= -fsanitize=integer-divide-by-zero
 ubsan-cflags-$(CONFIG_UBSAN_UNREACHABLE)	+= -fsanitize=unreachable
 ubsan-cflags-$(CONFIG_UBSAN_BOOL)		+= -fsanitize=bool
 ubsan-cflags-$(CONFIG_UBSAN_ENUM)		+= -fsanitize=enum
-ubsan-cflags-$(CONFIG_UBSAN_TRAP)		+= -fsanitize-undefined-trap-on-error
+ubsan-cflags-$(CONFIG_UBSAN_TRAP)		+= $(call cc-option,-fsanitize-trap=undefined,-fsanitize-undefined-trap-on-error)
 
 export CFLAGS_UBSAN := $(ubsan-cflags-y)
-- 
2.34.1

