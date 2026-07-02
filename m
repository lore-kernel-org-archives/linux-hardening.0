Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0F430FF05
	for <linux-hardening@vger.kernel.org>; Thu,  2 Jul 2026 15:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783007704; cv=none; b=A/FWyDh5k/mTUyRIBT1DbtNO+zlWBKGaMV6zxR9yfan4LkVsSu/QaiI97JgdKfiSeu6VLboKP2s6fdtjhMqRLFgc1T23IjOjzb3MwYrU/tRNOZCdYwIGWm9xHASBRkx/XpBao3haQPYmXf5Qtz3S/am7jq5/v7d24uwCg2OlYq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783007704; c=relaxed/simple;
	bh=EBaGVlFtaU5cgkN4vkEjpdW+YdCqJZ1tqKuOPRWWN+I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AHgNv/2hlqxy2Fs/Z/xEHDjLHu+Ptcv9cz+ongVdjncsat1fFfmYYbGpTQndgMEbRxOCCVGV8oNrB+Wr++Bl3UXCDvcCqFl+R9dEFYsqf69fb/DdkBMvCL0T8Dok5ACtMQmWkISnMA4ZAa+M20P8WCzIdEuf4TQbGT1+ZVWA1Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j5VDd5QI; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j5VDd5QI"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490b1bbcf3aso11198725e9.1
        for <linux-hardening@vger.kernel.org>; Thu, 02 Jul 2026 08:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783007701; x=1783612501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yQp7blzNTKwxZMSxGZDcTyFP/mvOADqzAmk2csJY+sU=;
        b=j5VDd5QIxnejQIbC5UTyNAg3KServZL+NY/mHjq/BxpqeXCZVG+Wbo76MRKzNxg2Ik
         jzzu7jH2QqCdc0/OcZmTyEat8lhcxSgY+EOkIWska0UkJHm+SuYbjgyDo+chS1gpuXI0
         eGVQh2bWX1VrPnQYpFaxsf1XmqvIeu+VcYZoeeI/gqc7uM1xpQXp8Z2z0oH7uGAVSVAK
         XaEQypt6BqeE6NypyFZHTIzVWDuZDMhqQk6MBTC8dRLdDOOrOSabsE6NjXAs4iZmbMJ3
         AalZyeDyJVv48yf5lTTWRXbn2XHXeg44ap/OPH4i5OC+kkzTWLW6/8jlvL+nA5KI3jUs
         plZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783007701; x=1783612501;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yQp7blzNTKwxZMSxGZDcTyFP/mvOADqzAmk2csJY+sU=;
        b=rWXlUz22JNjAx9G84Y09uFcEj8MlYUGfEJt+aGXHKRzGFiMcWoeSXy96wdOWsa7SN1
         6a1AlBB1CQYZedyVpSg0ziz+4Yd6LqVlTNl3EC9YG06kANlxeul5M/uOMjsOng6Sl0yx
         bTLH0K9+OXq6zXvwT+3r83LU7RWD3JaQH+xGX//r/HsDZ34kc7duSxfNb5VWEsEaeAPc
         uwHw/AwNtjnFndr1psIhnMh/mptZSEeO3uI+vlsuUWDL8n1E+2d1ZEIkljpkgKx1unB5
         V7GKZYccNB7MvqC3G2Rbkh0KYqw0wSQurK/X7GG7owwBRPq0qs+2b76P/t5NkQN1Jerx
         /MKw==
X-Forwarded-Encrypted: i=1; AFNElJ8d3woGuRQKr49eSznOUOqOOmg0//owuqXO/ZQLP9CegjuE0wqZNpXzU81R/19mXbotfM8wgs4aBaodWZWL84E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym8rbLiNcpGKwjbeYKKYRZCfqLeKef4OoVo8BM5jpJCh1tmGNS
	T/TmYIxBD0m9LfKd0plu4XQOfhV7/izFBHi/ZRalA6SUaK++GTRqF/gc
X-Gm-Gg: AfdE7cn3k+yxiXa4xPai8RQpEwy17uAfLQZ8dTQd/m4oZR/2HAmNjqna6xwueZ2n+3g
	LWekrbGtH0BQWbQeyMsfcpAPcUp5/Fd52HZqukRSm+DWMT1PD+8iqNh5+uwgK61okN8EqcnC+dH
	esJ8DoMKS7QG87WYMEt8IOzGhpZUvHKdl4zhwc4S/Vn+ewCXQxg+xMeJMQQZFQYh0kpVJQLEK2y
	KmK4XYDFAVp/Wk4kovV/TDdtBrVdC7yX572kgGQNkPseWhhFXnc3+ZE+LzBkewz0kLEZlKelzb7
	Yyqz6yuUjkeoiGMm6xH8e0ibSOrnqOA3pbwtH+l6UyyRMQa0ffPAEoRq0lXFM7uR8lTLzEoun49
	heYUNpK5ncIvOMcRrZDfM/OwejeI4AjokUFXAXazCybdyStXQnUhwzvClGnBsLPlpyW12IQX/tL
	rywTtBUIS+6k/Rz33zctCzgflbwUK0Sx3XeSluwbpFuj2RURIXMO857srUQJnvLFNX8880wFQyH
	bTHbF2ft7YapARWLZsOOWX7AamPVw==
X-Received: by 2002:a05:600d:c:b0:493:adcb:d368 with SMTP id 5b1f17b1804b1-493c2b45ce5mr74061155e9.9.1783007700998;
        Thu, 02 Jul 2026 08:55:00 -0700 (PDT)
Received: from workstation.speedport.ip (p200300d5070afe1af6868251d71bd2b0.dip0.t-ipconnect.de. [2003:d5:70a:fe1a:f686:8251:d71b:d2b0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-477db3dbb79sm9758055f8f.2.2026.07.02.08.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 08:55:00 -0700 (PDT)
From: Mert Seftali <mertsftl@gmail.com>
X-Google-Original-From: Mert Seftali <mertseftali@web.de>
To: Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	linux-leds@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mert Seftali <mertsftl@gmail.com>
Subject: [PATCH v2] leds: pwm: Annotate leds[] with __counted_by()
Date: Thu,  2 Jul 2026 17:54:52 +0200
Message-ID: <20260702155452.67594-1-mertseftali@web.de>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mert Seftali <mertsftl@gmail.com>

Add the __counted_by() attribute to the flexible array member leds[] in
struct led_pwm_priv so the compiler and runtime (e.g. FORTIFY_SOURCE,
UBSAN_BOUNDS) can bounds-check accesses against num_leds.

While here, pass the led_pwm_data element into led_pwm_add() instead of
the whole led_pwm_priv, so the helper no longer needs to index the array
itself. num_leds is incremented in the caller as each LED is added and
doubles as the index.

No functional change intended.

Suggested-by: Lee Jones <lee@kernel.org>
Signed-off-by: Mert Seftali <mertsftl@gmail.com>
---
Changes in v2 (per Lee Jones review):
- Pass the led_pwm_data element into led_pwm_add() so it drops the priv
  and index arguments; increment num_leds in the caller, where it also
  serves as the array index.

Build-tested only (also with FORTIFY_SOURCE and UBSAN_BOUNDS enabled).

 drivers/leds/leds-pwm.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/leds/leds-pwm.c b/drivers/leds/leds-pwm.c
index 6c1f2f50ff85..dabdf0423582 100644
--- a/drivers/leds/leds-pwm.c
+++ b/drivers/leds/leds-pwm.c
@@ -36,7 +36,7 @@ struct led_pwm_data {
 
 struct led_pwm_priv {
 	int num_leds;
-	struct led_pwm_data leds[];
+	struct led_pwm_data leds[] __counted_by(num_leds);
 };
 
 static int led_pwm_set(struct led_classdev *led_cdev,
@@ -81,10 +81,9 @@ static int led_pwm_default_brightness_get(struct fwnode_handle *fwnode,
 }
 
 __attribute__((nonnull))
-static int led_pwm_add(struct device *dev, struct led_pwm_priv *priv,
+static int led_pwm_add(struct device *dev, struct led_pwm_data *led_data,
 		       struct led_pwm *led, struct fwnode_handle *fwnode)
 {
-	struct led_pwm_data *led_data = &priv->leds[priv->num_leds];
 	struct led_init_data init_data = { .fwnode = fwnode };
 	int ret;
 
@@ -167,7 +166,6 @@ static int led_pwm_add(struct device *dev, struct led_pwm_priv *priv,
 		}
 	}
 
-	priv->num_leds++;
 	return 0;
 }
 
@@ -193,9 +191,10 @@ static int led_pwm_create_fwnode(struct device *dev, struct led_pwm_priv *priv)
 
 		led.default_state = led_init_default_state_get(fwnode);
 
-		ret = led_pwm_add(dev, priv, &led, fwnode);
+		ret = led_pwm_add(dev, &priv->leds[priv->num_leds], &led, fwnode);
 		if (ret)
 			return ret;
+		priv->num_leds++;
 	}
 
 	return 0;
-- 
2.55.0

