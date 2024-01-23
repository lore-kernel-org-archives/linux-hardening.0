Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF8413A248
	for <linux-hardening@vger.kernel.org>; Tue, 23 Jan 2024 00:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705970174; cv=none; b=MHXNPHerg6YMYHmnv32f0ogfIGjSBf4d33wLTcy2c8knHYYP28QmDgvNUB37nQs4lxi3LwYt6oxBeZVnbwVQ4MlChHOiDA5fP/0TeyVYQIqj9HCdu9Q9Ioadp9MdxkBp4PdIGx0ylbMg4UduGp7ITz2Bg1OhMLju3G7Hfpokq/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705970174; c=relaxed/simple;
	bh=oiG+TsWcxpCmRd1+V7WC6Rzkst0Tmp3FWPUBfyk7tD0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kby09t5EJNewmu5VxnQPt9pi4sgTHDYDuKtD16SCXeCvII3Aym+ViqAjgfYOJ3vb+M2CJ0N0lJ5VGLsosDbMrbECj5FKr6eMC9quitfBzRxlaZDvaT5gcC7XuB3TWi1IJ//Td6Ctps766h7it7ro1DWRJUDyZYPRYXqAcBdSFfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CHYfJeVP; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CHYfJeVP"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-290a55f3feaso1085241a91.2
        for <linux-hardening@vger.kernel.org>; Mon, 22 Jan 2024 16:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705970172; x=1706574972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ci14tXfoLWF8H9KP6TbhVJPvd4jolXPuWJ+qfgosDMI=;
        b=CHYfJeVP3CDJgqZED57usa0B0HVtYgLBTeIVkTP6tODa6HF9ZA/OjW1ZjRThClqANA
         uYKEXU2u8YY1xIEa2v4Uy/1Z+/gXT+sF6juVV69vtEV1hoz7cH76f91WIbFEsdICTgxY
         tWc5mHyxSHtXxTzycef0ILzaVGFD4rHgRKHaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705970172; x=1706574972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ci14tXfoLWF8H9KP6TbhVJPvd4jolXPuWJ+qfgosDMI=;
        b=O87YitdXki0JeAklnRf/5lSBwARMBThQyEeplgI45eZq6BG3UyWnCWCOeJjO8dde8e
         jfZ+AIMS1jqViifYHbjj05SzpVeCkNrLcmbQGXPUo8HMKu7aZY6f44HsTBiXMVAuO9GT
         ycOzuGDHCuLADK+x3j9nV+vTY40toz1/wMjrgRdMjYBUzPgYWtfhs4e31tjpM7FWeB2G
         EJphGsKMDDKl+QnqD0oJZ0dHEUwcbCz/XjucVIP7yKofF2bEYXbN8kAPI67ZQ+jw7ZZL
         xNS6eD2gEXYtI4TjAVrZ6UmWDUgQCr6BnhwN07tT1T8593Usk7t++jfoAYFC3Fgg5tXm
         qGWw==
X-Gm-Message-State: AOJu0Yzgu96b/33VlHYXmweIkbTK/P5m8zFIJvh+L5UdEHg3f/VQTaMm
	0f0VCLkZEw+LvJUh0hX1bM9exy9jXhXzfEicQC/HioHFifr+jrRAitjObUu2Sw==
X-Google-Smtp-Source: AGHT+IHbtzvrk4iZs4Gm8Yr+QrGFjKqhpB03Ocxh4U4TLvusg96tLGgJ15R5wkOaXT55grFNSwGjcg==
X-Received: by 2002:a17:90a:62c7:b0:28f:ef2b:e0ed with SMTP id k7-20020a17090a62c700b0028fef2be0edmr2421887pjs.5.1705970171811;
        Mon, 22 Jan 2024 16:36:11 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id sd14-20020a17090b514e00b0028d9fc97c29sm10365268pjb.14.2024.01.22.16.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:36:08 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 49/82] drm/i915: Refactor intentional wrap-around test
Date: Mon, 22 Jan 2024 16:27:24 -0800
Message-Id: <20240123002814.1396804-49-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2342; i=keescook@chromium.org;
 h=from:subject; bh=oiG+TsWcxpCmRd1+V7WC6Rzkst0Tmp3FWPUBfyk7tD0=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgJM8j5gj77tQNAWNgLrGW9Rf152U5LzsLsJ
 LLY7jY3zQCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8ICQAKCRCJcvTf3G3A
 JlTyD/9tInsgMQJNhzXLV4lkjEdwrZuxy10l8+2Dh6eeSAQbaL+DgNMujkfU/ewIc6vsc6zeZLn
 3ACm3O16LQN/0j5S0RYKIeVgjfXSZAYGJuwYmW3jBM3o8s9hNPi/SXXGp0toQyaZ73L3hcRB4AO
 2C01S7JnD87/2LBgN5VfyCDAUOfgYSqdE4ibXD+3+uyUSrbM8B+GimE4cH4ORUxm7YMLto9zpu+
 oxqd7qMyF6AyMavkv5ySlinqmiOVJ83f+YZ+oRowh0q5fTfSibio56QvEqpQZCtefn09GEz+IoC
 Tnb8E/IS3JJOLLdskrUiX3bNAd51XjStK5+qpc0F35indv1uLzV53YFhU5912hmIDcxwPmmtHTi
 OXiRWa2TWfKEgQKSVyJmGL9esA3rmPtERr7goeI8/nFMWEb4Qy+cpevxG1qft33h0Z7enHXDTBT
 JHJYXrmewrWmRrBpNFH54MHVPInL6YqLuU56FYnU3go2zz3tsoo8VutSaww+foZj6VUcti/X6fF
 PHZBFPajfhvY94xWQMXnk+iHmY7GJNwyVxOdnF8YsTZv23cXzWc9GXdAMMp6lw4By2hz73i3BNZ
 JSnAMxGSHmwnz/DNjaVSvjUSE5b/U82hIxtLLj6mKkDb5Osg8f47u2KWYVVd868CRAaVvfeVUVJ 1IBIdYvVvwQ4wvw==
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
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/gpu/drm/i915/i915_vma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/i915_vma.c b/drivers/gpu/drm/i915/i915_vma.c
index d09aad34ba37..1a4f048a5df9 100644
--- a/drivers/gpu/drm/i915/i915_vma.c
+++ b/drivers/gpu/drm/i915/i915_vma.c
@@ -1535,7 +1535,7 @@ int i915_vma_pin_ww(struct i915_vma *vma, struct i915_gem_ww_ctx *ww,
 		goto err_remove;
 
 	/* There should only be at most 2 active bindings (user, global) */
-	GEM_BUG_ON(bound + I915_VMA_PAGES_ACTIVE < bound);
+	GEM_BUG_ON(add_would_overflow(bound, I915_VMA_PAGES_ACTIVE));
 	atomic_add(I915_VMA_PAGES_ACTIVE, &vma->pages_count);
 	list_move_tail(&vma->vm_link, &vma->vm->bound_list);
 
-- 
2.34.1

