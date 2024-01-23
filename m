Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610A313D4EA
	for <linux-hardening@vger.kernel.org>; Tue, 23 Jan 2024 00:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705970770; cv=none; b=bb3InXnoYyfsWbht9cM+mli65omFhOsF5vDEs9VdYuhuXqqMWC3HHZptVXj4xDQmKQwYv6vW9lvwesZy+J+qLya5CdfUKins1pBxh/BxObvuLQsbZ/w7wWf69YwIZ3aEr/gNDoPD/hX8i3kAh2h6w0vubVvNp9tcqr/Ldlcllyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705970770; c=relaxed/simple;
	bh=4HPvynPR3Ko1dXfNMJBApuVlt9+5UyaMefuvQ347bXs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WZaQeEuxLDEZz5w47Eljq1NTJCUEYnosI1loOd9nvlGZn+7OLQeScCf+oOiyKs1ZW/AWN7lCtg0wZnGiWPAMBClZbcXIDTUmQ58oYUMMFTNkj3WzuvLA87P0XNAbchsglOHbqMguZCNaQ8guqLDWk0HoOJCgjveMJPAPRcQYeNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kqm0YraK; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kqm0YraK"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6d9bbf71bc8so2216740b3a.1
        for <linux-hardening@vger.kernel.org>; Mon, 22 Jan 2024 16:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705970769; x=1706575569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sy3Mn0T2j/xVq+cywviUlH77t9Sq4eXs+6SMvLbadC8=;
        b=kqm0YraKJjzpYJ0YwLvcUV9muskZYih0/OWTiUjwU0iTPpX4+z/HD1HqdE0ll8XXQo
         3alVEQPZs49egUMpsaZItiIygz+MgfGy/mQ5mVJQ0Kopo82IFuX0A3Y47OOL/n4iAo5u
         opxu+BKRp50NVXte6m2zV2mcumq2XjSUDKdBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705970769; x=1706575569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sy3Mn0T2j/xVq+cywviUlH77t9Sq4eXs+6SMvLbadC8=;
        b=L8fM5IVw1G7fqA4d3SihoOoLJUXjRvBY/7PuDh3jJWxKgh6SAlyD4YxkOmFPZzlWdy
         nykM0WQeoIGHDz/sQn7ewoejDfOXKMBcqSg6/qGG2FC8TcP9uGecdQ8+EBD4yGde/5c2
         geMXX51qzP9luwELWsGv27/cG2l76MxORLJJkkKPJ8+qF3OHgCEMmItFZ7Ihv+11Bj92
         C2oKEYevuTlOQgId6WWPn2j2aOv+vGccHQ8hsSm+r73UBD//3EuNZtlWwoKy13Y4nA6C
         aV4n5mWcoPAvOju/mpuMIfbZ2zAbaITV8h4WSbtYnhi91TObE2GSbWzwKHIStuS3diXp
         4yJQ==
X-Gm-Message-State: AOJu0YzCwijsHSSnq2YSZyNxofM49FHbt64YoGLjHdrn7lpecqj23Cjo
	g7nN77BVGPnT1ThXIpU4ayqK9h3ADJBX4KswBDwWjvfdJHvZXyBNYRjprXbAWarmT90WwNRyezV
	99A==
X-Google-Smtp-Source: AGHT+IEUqe5dx8QwlTdc0Hf1S1rf52LAuqKi2r9NnTuHQLNKc8Ev2tu0ODkf4nLiv9kWyuVYwBzGmw==
X-Received: by 2002:a62:d444:0:b0:6da:63a5:3f32 with SMTP id u4-20020a62d444000000b006da63a53f32mr2087437pfl.66.1705970768640;
        Mon, 22 Jan 2024 16:46:08 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y4-20020a62ce04000000b006dbd9fd2bebsm3352305pfg.163.2024.01.22.16.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:46:05 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Du Cheng <ducheng2@gmail.com>,
	netdev@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 28/82] niu: Refactor intentional wrap-around calculation
Date: Mon, 22 Jan 2024 16:27:03 -0800
Message-Id: <20240123002814.1396804-28-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2297; i=keescook@chromium.org;
 h=from:subject; bh=4HPvynPR3Ko1dXfNMJBApuVlt9+5UyaMefuvQ347bXs=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgGajy61mavJLiiKlUcTrC+GpKwlQS32yLps
 eqkOZGrbz6JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8IBgAKCRCJcvTf3G3A
 JjxnD/wLi8HDy6bvcWJHrheHwblvygg/rt1qDMgmueTdsD10P2P5hSQT9cDWcxBgYmPx3QSgkoN
 DI0zgPvjfV2y+4HKJvovXZDLUygnMhtUsoRYA/UNHeRo3fxPyLYLjfrT2mt9AgGEuctdamOfJfN
 Nyhy8b3RuJcDOH2afROIUlXeKQW8YrioLMJjJ0wJ/IcOJ96RyjCKSL3bkl5xvm5M44pX1p1msMI
 VeP+/9xS/uFDWzWbIxGAMyJmSE3mvm/7oqHlESxAcrq95OyuSOQELRAZh8vKFCW/rqedozh4HdH
 sVJlLxUPr3Yn2lJrlHD6tPKkVqGzcoeWyHjT+l5gX7BV+4bdXdkPJWwtqzIqi2rDJbgdC0K3nel
 nWwtV2xdyauZ1lhOAg26PgxW9+keBeEYI+M5ce14tRu5NjyjSKkqzT1oC3bjhXpmHDTXuyC5ncX
 z1CeOGSLxClD7kcLVWxPWNO37GNJpnVjy8Pbb0Ee7csz9cJOwmCKgjZeyqwkLvq5RHTlC4u0veZ
 DTaVGQArMh2rZAOiKSyag3NbemYIb6c2JHe451VJ8Pt0UjaPUxF3vXUs5NGPRXIcDYxNemUTxCv
 2Lsl/k243rDBq1Z/j3U8smcznTLGYwtCbkuYBOQGSX52s6/i5Xih21gZ/wq1SKE9OyNhm+9EgFl xjTJBfyCGFJiWDA==
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
unsigned wrap-around sanitizer[2] in the future.

Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
Link: https://github.com/KSPP/linux/issues/26 [2]
Link: https://github.com/KSPP/linux/issues/27 [3]
Link: https://github.com/KSPP/linux/issues/344 [4]
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: Du Cheng <ducheng2@gmail.com>
Cc: netdev@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/ethernet/sun/niu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/sun/niu.c b/drivers/net/ethernet/sun/niu.c
index 21431f43e4c2..a4de07c6e618 100644
--- a/drivers/net/ethernet/sun/niu.c
+++ b/drivers/net/ethernet/sun/niu.c
@@ -6877,15 +6877,16 @@ static int niu_get_eeprom(struct net_device *dev,
 {
 	struct niu *np = netdev_priv(dev);
 	u32 offset, len, val;
+	u32 sum;
 
 	offset = eeprom->offset;
 	len = eeprom->len;
 
-	if (offset + len < offset)
+	if (check_add_overflow(offset, len, &sum))
 		return -EINVAL;
 	if (offset >= np->eeprom_len)
 		return -EINVAL;
-	if (offset + len > np->eeprom_len)
+	if (sum > np->eeprom_len)
 		len = eeprom->len = np->eeprom_len - offset;
 
 	if (offset & 3) {
-- 
2.34.1

