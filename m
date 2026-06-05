Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9CA395AF8
	for <linux-hardening@vger.kernel.org>; Fri,  5 Jun 2026 20:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780691121; cv=none; b=g9bcXyYd4xajRZc6NJ2mvpgaqsa0cJmQDbbcFmo42m0HUGf+azAQJt8gTjr+bNwCoEMJX/GRb6Y4Jy5pND5IEOpWEKylQnPcsazCdEIY+wlwUoAjCwS/sMiyuAn2DFlP/IpDoiLnK1unWV6jmvTJgrQJZagXZ6yv5WLoZOh2i+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780691121; c=relaxed/simple;
	bh=aZxfC/Ti0WO3zECsPq5e0N1KDVe7+tAwM0eSzS/+4dQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NxAukHQhW5OSl1M4ncH83s8V9LBmIifuzoVqZMgUjvEWXstm19gidOcf/crJSLGFcdgUPq1GS5fa9zX3j6Hp7kq1tZignO9otgMi5F91HnC8lGICn2ZPvbl7oNQXtFxXuB7/nLUmYq0pv+nCPcHpWdrpiEPG7EBzOfLZ+lGvC74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yjn-systems.com; spf=none smtp.mailfrom=yjn-systems.com; dkim=pass (2048-bit key) header.d=yjn-systems.com header.i=@yjn-systems.com header.b=LDMYajNc; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yjn-systems.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yjn-systems.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yjn-systems.com header.i=@yjn-systems.com header.b="LDMYajNc"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-490af320e2aso26874495e9.2
        for <linux-hardening@vger.kernel.org>; Fri, 05 Jun 2026 13:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yjn-systems.com; s=google; t=1780691119; x=1781295919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xE+KWhhKl3Kv3XE5cbq9SEozPEP+6kO7jsBvhI2Lovo=;
        b=LDMYajNcG0lyHJbBXFzKq7fspB4/M8cA1zK1uxwlIhrHn9rkEu8wetlPjF64lcULGv
         gAnr+7Y+Q6zzhiJjjvsCG9QK8L4+IcpNNAqUxjxFO3l5ftjs3eF25OhKaYYbshbDUr3T
         9azDx3/o7FElRAmEKSAwXWLiuE6ZoMfVyEZqMBCnQV2QJvZNXBACGg2gckvWB5gNT/lW
         dh7lAnjk1FV53QaVkjwA+f7pzdTzVX/4sAg+0Dcq1onbpoVoqVJHAiqw1fsOVBajvGiS
         A5yT44xLIRqYV6H+Ijwk566dCh5/C0YKmXJgLUWgfuVpYewG+Jjn6r66WlUAcuggv8rE
         ghFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780691119; x=1781295919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xE+KWhhKl3Kv3XE5cbq9SEozPEP+6kO7jsBvhI2Lovo=;
        b=E+wzdlFVsOAzXPXjiQkuWE8BjfwFqYk49piC9jyH5e7B30wiRxMSlhkyoCDhQWW5Kx
         brcrB2a4SBHxCTJrhLg/U/OWv85LgTxMFeuYnbOt0VA/fPjuD8mfS2NlusiRdJOqwDdt
         7HMnQFV1oAw+n90ypiU1Jf+sNjnIt6I8QWKuny+V3UF+oknHGOvXvp8D/yNiY1udruLO
         dskxmBFoGWtWVqKo422UAkR9mMESM7oPc6uLPIhTObIeBoMBOuHMnkLlRP91/xOmAEi9
         QRXZVGYJAcEVw2X5KHyN290yKQG9L0vHkNATNKQfoA0menRndTsTPMp42A4/yFtkWdp4
         uyjA==
X-Gm-Message-State: AOJu0YwMzJIPSWqO5Ef6Jw72b/bU7yqsyi0RPrJp/jn1vGokZsWhQ3WB
	M5UMUBNA7jwlsumiGhvQMFmq6Wi+SxPO/0mre+K6sXV/X3+R0b7A77el090l5XG+RAjEbZt4CL0
	+AYBFzRwf
X-Gm-Gg: Acq92OHO9Tj8FsM7ObkHOJ8A0mIZ0y4ueLRpps4Fp1X+cF26g4nHVD31HYr/DL3q8ME
	GEJ+zBxe1W9tWzi811+6I87eLfnCGU8e+ZezIcEKP6/u4HbbASmG0KnNsrhzbZwzdn1del/q9L7
	gCgw518YdIJI2f+X5C8y2Hd6FAOUaRDgDxgLHH31hr5s4rrxM3zPM2IM5vr1psndy1sq9yuU+g0
	udy+9blFUeSyWNG13enyrDX5RvQ5ryh4LS1R9h+edK7wyWl9X1PwavG2KqcsPCoZulrxNHuil4Z
	R7rtzRk7De5+hpDBA0c8NtEYTkUj4Lv/Pm1LIbpDdgx3uVkZi9gZfp2Yje2BPi1z2EniOUw0DmP
	7bEHZmpWjZ1iLGTGKqK1KpTVAkY4X0m2pDI+q0bQIxfFtsJVDsGbM54RM0EUigiMa2DIW7FoLLk
	NJNoMzKo5QgAebfgDN4Wf+Jy56Gx86BZeqQDJ/NPN8BMN0n0XPc2/LKoOeMCPTM8s5OLo96kmcn
	ItnBh3DMT54lIlLx6/4xTNNF0rpldH+ODL4ltkYTp1Z8XkVAQ==
X-Received: by 2002:a05:600c:3e15:b0:490:adb6:793d with SMTP id 5b1f17b1804b1-490c25f67d9mr87595955e9.26.1780691119089;
        Fri, 05 Jun 2026 13:25:19 -0700 (PDT)
Received: from yjn-Zenbook-UX3404VA-UX3404VA.. (p200300dcbf13e6006c589ea22c400ee8.dip0.t-ipconnect.de. [2003:dc:bf13:e600:6c58:9ea2:2c40:ee8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3a87dasm168442995e9.7.2026.06.05.13.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 13:25:18 -0700 (PDT)
From: York Jasper Niebuhr <yjn@yjn-systems.com>
To: linux-hardening@vger.kernel.org
Cc: kees@kernel.org,
	franzen@sec.in.tum.de
Subject: [RFC 7/7] Ignore BPSLR generated files
Date: Fri,  5 Jun 2026 22:25:11 +0200
Message-ID: <20260605202511.79272-8-yjn@yjn-systems.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260605202511.79272-1-yjn@yjn-systems.com>
References: <20260605202511.79272-1-yjn@yjn-systems.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: York Jasper Niebuhr <yjn@yjn-systems.com>
---
 .gitignore | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/.gitignore b/.gitignore
index 56972adb5031..75ab3befd8a6 100644
--- a/.gitignore
+++ b/.gitignore
@@ -177,3 +177,10 @@ sphinx_*/
 
 # Rust analyzer configuration
 /rust-project.json
+
+# SPSLR generated files
+spslr_section.S
+*.spslr-files
+*.spslr_module.S
+tools/spslr/pinpoint.so
+tools/spslr/patchcompile
-- 
2.43.0

