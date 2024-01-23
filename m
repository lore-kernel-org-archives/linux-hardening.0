Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D8F1586EE
	for <linux-hardening@vger.kernel.org>; Tue, 23 Jan 2024 00:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969740; cv=none; b=Tzz4sCN6FntnY5bO3U4kFueJxXzNsmI3z3XTPplw2/W351KrlpoKJ2NRJeZuxqXy/BndQ5QAnT0cS0vjY9iicwM7ASfUioip1LFmVwtYnwlQsdMipzDabYhL47hEodOOW9a1Bjw44eqQAXBJYC6jSMI3HcFUUrEPsCfOyKjEi8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969740; c=relaxed/simple;
	bh=JgonJZnxkTCS8vYti6xK+vM63BFoTeMVUBVyb+CU9a8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hnyR9nq9lNOPsUON+/2/+fUBF8rc0vTCgORktcsD6WaOskRUokdCXMcCV3Z0Cfq6e59Ab7JjwKJYvxleX7kyVUDUx2zStacuWHMHvvU4vSk3lPQYb47hnuf0rkXfuG8z+aR3VIL3qtcZTudhGl9MNdIjNGII2lDPY/H7+pQQWkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aH4tfvw3; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aH4tfvw3"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5d24c9b3c8eso231841a12.1
        for <linux-hardening@vger.kernel.org>; Mon, 22 Jan 2024 16:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705969738; x=1706574538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ti9Pce6Lpu2kUzlJNdDw3MDPT1cyRxs9AHo9YOvXXwc=;
        b=aH4tfvw3xYJkOkqDFOs7n+3cdJvceqVk7JpZkM1/qFbNECn7IeL0tXqXxwUt9oPyCH
         EnNWu62AsknRSDAIoMBL4mBXKHiUG606IYrPR6VrltQWWaNW1pZMoNtJVFs8znoNu1/y
         yfoJuOEyHHjI6Wa95nfhkNjriVK1oVIWGC754=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705969738; x=1706574538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ti9Pce6Lpu2kUzlJNdDw3MDPT1cyRxs9AHo9YOvXXwc=;
        b=pFBw7wV6/pJijbJlEJYG14DF8n1BIBMLXMrAcRCBonWrhhLg7MR8ds5FyZCfUbPxuR
         xnkiuCDEMn2/kb9eVlWmRIhh/XKrAmntFu2oQlZquJv6ZLrQrbZESvAbhUForoVusPU9
         w/KRfQMe2T12+tQU1Dzuev6vOgl+0Rr2jhNFa87qNVUmYO47GnMnkEUuTDVheQUuq7hL
         MMnBOLMkfQvH9gPI3x1HE+AbnPwE1WVO8lIdBVDH6keIzPVEFmxL5iBJ+VcAoufkpZeS
         yhCAWrOfz9aUf2Xpo3zX8pSVYZvaHcXNhIfUvH5eqL2u/HRJRntQTQviZXEZ2WSahXFT
         1xbA==
X-Gm-Message-State: AOJu0Yz1LSw3z5J4qvHSLpCQtrKYFNHVdSMqL0Ud/sQ55FxEcptm95ih
	Q+4m0j7VTSf+BHqOBXy/F6WM/JgaCzqhNIDZha658G/hKERoxFao3TugBVAKHg==
X-Google-Smtp-Source: AGHT+IHxysOlKojjA+pzT7YKshwDp7mEoKxiFORi05Ne2gh5Z7r5EGY2fIV1rixzNAo1ByfAlcIy4A==
X-Received: by 2002:a17:90b:3786:b0:290:666f:7be2 with SMTP id mz6-20020a17090b378600b00290666f7be2mr1543735pjb.82.1705969738187;
        Mon, 22 Jan 2024 16:28:58 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id eu7-20020a17090af94700b002902076c395sm9968033pjb.34.2024.01.22.16.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:28:46 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Maxime Ripard <mripard@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 17/82] drm/vc4: Refactor intentional wrap-around calculation
Date: Mon, 22 Jan 2024 16:26:52 -0800
Message-Id: <20240123002814.1396804-17-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2558; i=keescook@chromium.org;
 h=from:subject; bh=JgonJZnxkTCS8vYti6xK+vM63BFoTeMVUBVyb+CU9a8=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgFu/g3mFw6uq5pHkL3E8AN7SiAjt9KR8Xix
 +PwApphAJCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8IBQAKCRCJcvTf3G3A
 Jge3D/4u45AQKfLOVnFIwiv0NBxYETFmX3tUKTuc2dXJyNb2JL5HZVqwUSUaSPll1jigd0ESq+3
 vBUnoJAMixRc0Wcmv8+S+NzuWlj/nljcpFOhIBrWsZt2Zdv0oFPuvDGXKWBwxohbLWGWqb2Otbc
 y99plRk4kHDWrILvbtqc+mviNEDD63DUOu70L2aT0MgDBP2WJHf/KckoFqWe9Gh49tuCZQHmX0e
 b9/uQAFad4dpfrO0Y7gWYu7QKC3HKK/EUXkvazbYav+WeTBL3JuifNiSmEE7wjLNSEod/GqFdt4
 tnTvyCjEqXGwfLzjaX8TyuOvKZZsj+VZ6ZypG+E8d9qBmL3zZoVTvVXLyaQKv8sSLmPT87PN2tA
 jlCMKrZYqld0WN2mSdTGlYWazdKvBvQ/wfaaeUY70H8G0dj2cWTwoC+wF/Wp/Ph1MIymiasAvIV
 Ntw3se/q/tquahs2oNjMCDDmarRwr38iKcMtNt8Pewb9eY75hXI61eRzFQWcI7e+ksu9xOdHTgy
 eV5ukAWCsrtg03FBRVxNX2eKCgWHTheAxQaBRGBD/XowDB712zwukECG7veQEoxDhY4DqRk3DlO
 ts+/zz0xpt30cc8yvKxN1v+A5ldw0a38veiStkHBXthkzyl3wr9n0DChf/4UhYKH7XME3RBusVq 0W443HcucToeoOg==
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

Refactor open-coded unsigned wrap-around addition test to use
check_add_overflow(), retaining the result for later usage (which removes
the redundant open-coded addition). This paves the way to enabling the
wrap-around sanitizers in the future.

Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
Link: https://github.com/KSPP/linux/issues/26 [2]
Link: https://github.com/KSPP/linux/issues/27 [3]
Link: https://github.com/KSPP/linux/issues/344 [4]
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/gpu/drm/vc4/vc4_validate.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_validate.c b/drivers/gpu/drm/vc4/vc4_validate.c
index 7dff3ca5af6b..9affba9c58b3 100644
--- a/drivers/gpu/drm/vc4/vc4_validate.c
+++ b/drivers/gpu/drm/vc4/vc4_validate.c
@@ -305,6 +305,7 @@ validate_gl_array_primitive(VALIDATE_ARGS)
 	uint32_t length = *(uint32_t *)(untrusted + 1);
 	uint32_t base_index = *(uint32_t *)(untrusted + 5);
 	uint32_t max_index;
+	uint32_t sum;
 	struct vc4_shader_state *shader_state;
 
 	/* Check overflow condition */
@@ -314,11 +315,11 @@ validate_gl_array_primitive(VALIDATE_ARGS)
 	}
 	shader_state = &exec->shader_state[exec->shader_state_count - 1];
 
-	if (length + base_index < length) {
+	if (check_add_overflow(length, base_index, &sum)) {
 		DRM_DEBUG("primitive vertex count overflow\n");
 		return -EINVAL;
 	}
-	max_index = length + base_index - 1;
+	max_index = sum - 1;
 
 	if (max_index > shader_state->max_index)
 		shader_state->max_index = max_index;
-- 
2.34.1

