Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA73633E3
	for <linux-hardening@vger.kernel.org>; Tue, 13 Feb 2024 23:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707867736; cv=none; b=T6/HO89R8vFM/Ht+4pPx9izq946+40nO9jnr4hrO2cJvf21qIlZyfb474CTleHSki/T9qiaE0OfaeM6XUKk3axyr4VOIeapZgcUgY3yf9kr8lzptbWK+Ke83dQS2jcdr74cNJHvN0Obx2Hv3jl98kxh2ics/hDR9SwGqXPgJpRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707867736; c=relaxed/simple;
	bh=Vl4fdN5cpGUJaEVd/d0wmt2xUmRLpJ113oXlwnbICno=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jKAlUX/DE9/0adPkKFOK3TruM+bP3Xu5YGzno7Zg5RCxq8ZWcg+MZlmvrPsvwjNOnEfg5fnWMpu6YWuceJweGWag+7ojSK3M7/m19D2HS9OShGj+AUtb2sevjE0L1KzSRvj6UbWuAyE7BlRAWCuRr0sdyNwzyn+WBlZD7WTj2dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=anNxmPUW; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="anNxmPUW"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d94323d547so43245325ad.3
        for <linux-hardening@vger.kernel.org>; Tue, 13 Feb 2024 15:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707867734; x=1708472534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kl2LWzzN8MyLhz/HbCD4r7+bt4+VkpQDGtXfFs0staE=;
        b=anNxmPUWkU3k1Bjt6yqXzcrBgXBU/ObGoY2T/aIAOR1B9z16vYkTAlUFm+TwSigNp4
         ztI/roP6UEbWOb3qZsZbu569DPRmQb5aFwUeNxmn7WGjpC6kl26r/6w/67dPVCtAwHSI
         RTO0Hvnz5t5/RNg61LmRekTikwsUtFVu0NCAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707867734; x=1708472534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kl2LWzzN8MyLhz/HbCD4r7+bt4+VkpQDGtXfFs0staE=;
        b=JZqRqlivllXCilYBSADzkzVkYyF1B2nvf+XZn24cK0yokZEWzLriIhasj2h2as5LLH
         yDxXZtSyuho+a+dgixAdwELe24rYPBRf1zcWAjo1uGx1hiixMDVZB2Uq0UjzVRu0NM9j
         t2BIvlpDVeRIln275AczoBAEYrc3+4Kk1+ug4UXsN3bcqJbvgpKtkCb2+ypbhsynC5Kw
         uy7A3b+Gey8wTBI/1NPChmlAoF/M7/mmwT56o5mCvpD4QNlowPrnpPW6yZ9WqtkIYyU/
         IvRvmJH0Jh1n4+n93cnyA7pGRpVvDuAipOfkVyIKD8VHLSZoNrSyNN78OITNVatY6uGy
         BIfA==
X-Forwarded-Encrypted: i=1; AJvYcCWo74F0oB5RRoYQwL1Cw9qgWrX7NP9l/o5Y/dn4pCDLV9RcuBZSU8KQ0ABncNL47M52M6LJbcYhrMTH8rIl1sPPKJe/43yXMJkaS5QITgMB
X-Gm-Message-State: AOJu0YzF4YqKa/9sHzc0w+swLT1VKkh1d3JahMj2v0u3ffQd1IqeQXMB
	6NMtOAeG7qPwigbBGNIU0FW/x/jDyUb4i1YS22sseD4Yd3wBvJtWjBdH2uRkfg==
X-Google-Smtp-Source: AGHT+IGtSgnWyCSH3qiLiPQZFC2sSoW0AvKsvDJfLvbHlsqg7pCLSM5fOCksbb3s9CdwRIlw+Fhesg==
X-Received: by 2002:a17:902:bcc4:b0:1db:4213:41e8 with SMTP id o4-20020a170902bcc400b001db421341e8mr1065887pls.69.1707867733891;
        Tue, 13 Feb 2024 15:42:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWz2viB/lB71RPgqINheT2b5dsUoRzdQFbqLreZCRsMJA1WJTSmCqzNAXQ8vLgFxvOITSdL2S4gjMc4StKNV/JfvxTXTTXrlo5SSaausKtQswwku7LybJtVCBL29himU7p5+kc08BeX+Ws+9mnpIIBnuU66RCW0Rp6mdgPvcP1ILo0SOqJXDhYYLpxVqYLq2wyrno0lCVhb/xijD9bMYp7EjFbnCazl0Zl1vNYijxJjmeJqYQ3Q4nevYmj3dT7wYeGjD038BIWd/Xb3aMJuzSuD3XoacGI29/SWgAgY/xggmiXqFSJLfx7VYz1n1qhh1M6aSWgB0SAwuGE/irr8fxB2j9Di/AnLTwC9zwV8F4rcp2VwvXkE3XK1Ut29nN18l8Q6T+YGpSSCNZHX1E0qfVvC6mobsbSFo7/HPP/fgsJIw+DSUGp+qucHlCLcTdwycYSQMws88W+NzCNCrkkaWUujD0WgNQxcwvRKki35FgBqofesb5nitL/dTtZv/jIQ
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id w2-20020a170902d10200b001db5432449esm220101plw.18.2024.02.13.15.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 15:42:13 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Dan Williams <dan.j.williams@intel.com>,
	Keith Packard <keithp@keithp.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	kernel test robot <lkp@intel.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2 1/2] stddef: Allow attributes to be used when creating flex arrays
Date: Tue, 13 Feb 2024 15:42:10 -0800
Message-Id: <20240213234212.3766256-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240213234023.it.219-kees@kernel.org>
References: <20240213234023.it.219-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2745; i=keescook@chromium.org;
 h=from:subject; bh=Vl4fdN5cpGUJaEVd/d0wmt2xUmRLpJ113oXlwnbICno=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBly/5TQc6E64Lzj29qmQN4Jwy7MrKuI/F1MJFh2
 tmtoHAY6iKJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZcv+UwAKCRCJcvTf3G3A
 JrCAD/9dUQyB4Kg2htW/OtV1/JApegYxWNiu0BRZxvGYS5pHECr/K3BxDugfXOko4/zESjBoXjf
 oKne0LTCU+n6HuPlWp6zmQdUyux22FU/GI1RK+CAPWxrDo7Eoaak9k5mVZlkyE6LD8Ur6gpQnYQ
 5spQWCBBmJPZBxZEbArwX9oIAyueehEhaKnNnpuOwLwS2n3uItshYSU0dl7bHLiykxU9IhDOTS0
 Addl13oIkvwVsAGt5fSXKor/Yl5ngDyBFQIImhm2IyFU2lGqVhjJLrEA5y86fHBxIwzpNQLn1BF
 b3VUXrW7G/SWYh/zz8T2miyJkQd68mFy0Qg8LOYVe+dlxtCoaq/TCB0mL1aFBOsSces26kbUWGK
 KydqjzrCcM0VZ7KlMxbCydJB6nQEEDt/PvalBi0LVIor3+9kPuOV1lzkMK0GBDM8ZdhG3GtbWxq
 /yQA8FhQA8og1cCFordZak+S9xid/nf2DXzA1/pa8ZkwJyMfOMAKvz3pNgKLfFSER+p2CSY8+Hq
 HWrc3oXSv5OmGw4mxX7QFe28Z89lG1Zx40NxOU7khlU4GWSK04QnxYjfxLwcF3HEHNhnBHuGjnw
 10bvJcrtCAtn7+5deAIUPhecENMUcoNsCrhff7IvMnLS45PKWWnb5SVt0DCqvUxFHcmG/wPnyPF PQc/zLP/3RX7jkg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

With the coming support for the __counted_by struct member attribute,
we will need a way to add such annotations to the places where
DECLARE_FLEX_ARRAY() is used. Add an optional 3rd argument that can be
used for including attributes in the flexible array definition.

Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Keith Packard <keithp@keithp.com>
Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Dmitry Antipov <dmantipov@yandex.ru>
Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/stddef.h      |  6 +++---
 include/uapi/linux/stddef.h | 10 +++++-----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/stddef.h b/include/linux/stddef.h
index 929d67710cc5..176bfe8c0bd7 100644
--- a/include/linux/stddef.h
+++ b/include/linux/stddef.h
@@ -82,15 +82,15 @@ enum {
 
 /**
  * DECLARE_FLEX_ARRAY() - Declare a flexible array usable in a union
- *
  * @TYPE: The type of each flexible array element
  * @NAME: The name of the flexible array member
+ * @...: The list of member attributes to apply (optional)
  *
  * In order to have a flexible array member in a union or alone in a
  * struct, it needs to be wrapped in an anonymous struct with at least 1
  * named member, but that member can be empty.
  */
-#define DECLARE_FLEX_ARRAY(TYPE, NAME) \
-	__DECLARE_FLEX_ARRAY(TYPE, NAME)
+#define DECLARE_FLEX_ARRAY(TYPE, NAME, ...) \
+	__DECLARE_FLEX_ARRAY(TYPE, NAME, __VA_ARGS__)
 
 #endif
diff --git a/include/uapi/linux/stddef.h b/include/uapi/linux/stddef.h
index 2ec6f35cda32..028aeec3d7f1 100644
--- a/include/uapi/linux/stddef.h
+++ b/include/uapi/linux/stddef.h
@@ -31,23 +31,23 @@
 
 #ifdef __cplusplus
 /* sizeof(struct{}) is 1 in C++, not 0, can't use C version of the macro. */
-#define __DECLARE_FLEX_ARRAY(T, member)	\
-	T member[0]
+#define __DECLARE_FLEX_ARRAY(TYPE, NAME, ...)	\
+	TYPE NAME[0] __VA_ARGS__
 #else
 /**
  * __DECLARE_FLEX_ARRAY() - Declare a flexible array usable in a union
- *
  * @TYPE: The type of each flexible array element
  * @NAME: The name of the flexible array member
+ * @...: The list of member attributes to apply (optional)
  *
  * In order to have a flexible array member in a union or alone in a
  * struct, it needs to be wrapped in an anonymous struct with at least 1
  * named member, but that member can be empty.
  */
-#define __DECLARE_FLEX_ARRAY(TYPE, NAME)	\
+#define __DECLARE_FLEX_ARRAY(TYPE, NAME, ...)	\
 	struct { \
 		struct { } __empty_ ## NAME; \
-		TYPE NAME[]; \
+		TYPE NAME[] __VA_ARGS__; \
 	}
 #endif
 
-- 
2.34.1

