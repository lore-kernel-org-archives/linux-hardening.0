Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6580E204013
	for <linux-hardening@vger.kernel.org>; Tue, 29 Oct 2024 13:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730208149; cv=none; b=V4q/kHSZDqhGozfnVJbAjC0PKs9ymMrxJYCd291j4ntjlH5Y/mt4Yfi5/cvK9HdyCRVla+vy0TnEfsM7jdBoET42kypxXxyvW15FA23P13ckMkNZ8oG5/5FoDs80oUIEThxz/cSu4PKMG3wWJbjqWEQ2eHQ3bFOo7lu/4f2gGMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730208149; c=relaxed/simple;
	bh=ChSlnsIaEJyE5TQiMvP4Xs35+QG7nfcXjtPvtlTkbVk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=DDl+WFF3Rk97Zqjilr1UGH0YEsr69m25E9I63DyfxKIgSqUyoXzBd4chYO8svS4/mvoHEfXgmib5cXRAzCiL1s5jGCWrrnp/Gm/dTOjlr79u9e6YI6sPR2E0a3gQ9YZzSO1Yf+mmREBu1a34HbBrW4nBSXANPIAVemZH9CqQ3eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yEsamKzE; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yEsamKzE"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37d4ba20075so3730138f8f.0
        for <linux-hardening@vger.kernel.org>; Tue, 29 Oct 2024 06:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730208146; x=1730812946; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TmivirZP7oi5XcfMsLlW/n+BvvctncTBddPvnaQEmE8=;
        b=yEsamKzEo/YD9AMmpZ00ZVkOmRdiIb1hx08l4mx3ZBXaN5gGQ+R90Kbv7cqE86fTs7
         SH2w7cgspOWsNEOxir7whZIzFZNrTphRokCpPxQ3AO+0iCnnqDu6TJx5KldBNPNyqLHp
         5cyRhBNV2Eh4JNx95dL/MeW81uiKdpLfjXJPmqvdlKYbgDgsbKxfzX2f/ziFkEbTjxXA
         a7lWk8aUEWqjFWh7g5yWpM0Y5ejQ2WWvAUJENBSKXQaPLODljCATwJ0p2tmlvrPOG+Xs
         AfQ2ctzDIkH2z2ji2giXr4fWgmMHShoUdDNmlPN1p8ojj5Crk6gEiG2kNa18VHF4Qc3k
         KRZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730208146; x=1730812946;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TmivirZP7oi5XcfMsLlW/n+BvvctncTBddPvnaQEmE8=;
        b=Wym58cgw7QnYpOUOoZ7TQwueUA/QQ9s9+HAclQDe3y50m6nRXJvLLmDGTya6TLO50S
         T5xHWvPUYh2w4fa9vHu+aabGBoUxNvxig/q2+RGOKTbLiA6uBaYq+vI1aja/HHcgZf33
         jU0uyIu2L0alc04jo0OsGKSahQ3kIYfMAdVF7XADpHmW6XfjLCh5tagGt2J6OaA3FS2Q
         1+Mo78WjCr05cOmUShv6HjlZ8Tco0R2+6x0/B0zFv6yqHVc0Shw/0WHE0rzN5M/+HERM
         gkJYNh/kLUwIlqm0Kmx60RyvRWQRkBABN5RVYZdwMHr5s+Hknj3SE0H3Xvw81pYSTYvu
         n9sw==
X-Forwarded-Encrypted: i=1; AJvYcCXH+vinFyIz02LAmIqNKfq+OGb4trjfT/l5Eh/3xvoe8mR+EO3gFaCQ6DSu+PHtz1zZfjnHtQcghpc3xo2oO5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YypsHYjLcqYnMtS7x69o7Hqn5vtA6v4wKHRa4DfbL1EVPwV8bF6
	mZqPZ/TogVTu1Im9IjASe0zKj678oVw0xoVtjVzizgwhMQBQsek3KVvrBRxGOA==
X-Google-Smtp-Source: AGHT+IFNju1UNn9Y+9Asqmg8PGyztzLGMJa4AE6L7cP0Oa7tzLJFgRDefug/KVTmU2scx5IEYk1I7A==
X-Received: by 2002:adf:fb48:0:b0:37c:d276:f04 with SMTP id ffacd0b85a97d-3806120086cmr8303886f8f.45.1730208145659;
        Tue, 29 Oct 2024 06:22:25 -0700 (PDT)
Received: from localhost (65.0.187.35.bc.googleusercontent.com. [35.187.0.65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b49d20sm12407112f8f.62.2024.10.29.06.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 06:22:25 -0700 (PDT)
From: Aleksei Vetrov <vvvvvv@google.com>
Date: Tue, 29 Oct 2024 13:22:11 +0000
Subject: [PATCH v2] wifi: nl80211: fix bounds checker error in
 nl80211_parse_sched_scan
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241029-nl80211_parse_sched_scan-bounds-checker-fix-v2-1-c804b787341f@google.com>
X-B4-Tracking: v=1; b=H4sIAILhIGcC/52NQQ6CMBBFr0Jm7Zi2VmxccQ9DCC0DNGJLOko0h
 LtbOYKbn7y3+G8FpuSJ4VqskGjx7GPIoA4FuLENA6HvMoMSSkuhDIbJCCVlM7eJqWE3Upe3DWj
 jK3SMWbg7Jez9G93ZaNVraU15gvw4J8p6r93qzKPnZ0yfPb7In/2vs0iUaG2phSVB1l6qIcZho
 qOLD6i3bfsCJRP5IOcAAAA=
X-Change-ID: 20241028-nl80211_parse_sched_scan-bounds-checker-fix-c5842f41b863
To: Johannes Berg <johannes@sipsolutions.net>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Dmitry Antipov <dmantipov@yandex.ru>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, stable@vger.kernel.org, 
 Aleksei Vetrov <vvvvvv@google.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730208141; l=1602;
 i=vvvvvv@google.com; s=20241028; h=from:subject:message-id;
 bh=ChSlnsIaEJyE5TQiMvP4Xs35+QG7nfcXjtPvtlTkbVk=;
 b=Og5XeuaTfjSAXJ6W0QqYgXHvcHPaCDcuHiTceteHDnvKLY+bGPJ5jfBwN4DTbliVwXWzJBkkq
 W1Kr/9C8eyBDHA7V8zd4wg2QCycwQogpxb0L1dZtqCxkvYe13MLqh2t
X-Developer-Key: i=vvvvvv@google.com; a=ed25519;
 pk=b4c4Uc4EKDS3ie6P4xhkyobon88ZGFLMHyo8kw1IuM4=

The channels array in the cfg80211_scan_request has a __counted_by
attribute attached to it, which points to the n_channels variable. This
attribute is used in bounds checking, and if it is not set before the
array is filled, then the bounds sanitizer will issue a warning or a
kernel panic if CONFIG_UBSAN_TRAP is set.

This patch sets the size of allocated memory as the initial value for
n_channels. It is updated with the actual number of added elements after
the array is filled.

Fixes: aa4ec06c455d ("wifi: cfg80211: use __counted_by where appropriate")
Cc: stable@vger.kernel.org
Signed-off-by: Aleksei Vetrov <vvvvvv@google.com>
---
Changes in v2:
- Added Fixes tag and added stable to CC
- Link to v1: https://lore.kernel.org/r/20241028-nl80211_parse_sched_scan-bounds-checker-fix-v1-1-bb640be0ebb7@google.com
---
 net/wireless/nl80211.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index d7d099f7118ab5d5c745905abdea85d246c2b7b2..9b1b9dc5a7eb2a864da7b0212bc6a156b7757a9d 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -9776,6 +9776,7 @@ nl80211_parse_sched_scan(struct wiphy *wiphy, struct wireless_dev *wdev,
 	request = kzalloc(size, GFP_KERNEL);
 	if (!request)
 		return ERR_PTR(-ENOMEM);
+	request->n_channels = n_channels;
 
 	if (n_ssids)
 		request->ssids = (void *)request +

---
base-commit: 81983758430957d9a5cb3333fe324fd70cf63e7e
change-id: 20241028-nl80211_parse_sched_scan-bounds-checker-fix-c5842f41b863

Best regards,
-- 
Aleksei Vetrov <vvvvvv@google.com>

