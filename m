Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06ADC161338
	for <linux-hardening@vger.kernel.org>; Wed, 24 Apr 2024 16:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713976064; cv=none; b=h42s4Kd0E2S6XQ5sCIYDQ2cbOLP1+BEPvUnDOi3/ZdQ3/WfqIbaCS2/55SZY0qEgPz5KHPswZYEuRtJ4sHeBalhYPSBjqSTBiqdzbmpZ7ng9OI5m449f3x+WeIcoAHUDOYIhYdgJFUntjoDZBcmUkcM0Occ6wytSxSh1xdRcrkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713976064; c=relaxed/simple;
	bh=GEZVzNOkB+uh4/dxLc6pmPztMxbGqhWXyqveAW752b8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K2rw6QZDoC4MPSyhrB90AGHrZaOTWXJ12sYt6UXLQBglPcb1rVYOIMKZRvSVUushk5DUiB8EYxc+mvnYEM52wCdNGO3wQMjechXdNPXlL0eu0fJW39ZBb6h8jgnFAhDj2SyOmOM0J48er7VaOdjvizW1jgl6S3+eVrF8Hr5BjO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aiTeEowU; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aiTeEowU"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-36b146836d7so257055ab.3
        for <linux-hardening@vger.kernel.org>; Wed, 24 Apr 2024 09:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713976062; x=1714580862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NJ24k+/qZiSqDjoeEMQOGzQq3ctUR4NA3Oy/Wx9fzCA=;
        b=aiTeEowU6z9LwF+oow/2ydzxmgXiWd2pDucrRMcEt/tL8oInpCfq3hrbvhDMNTkQw9
         M+KbDu2Trz5mn0uRn43qYxMk7EqHohYtergvjR1E9VdEUxzX2qC1obxvvXsby2R+bT9d
         /RU/EwuXm2ZWAbycyNZ8HFaQoApfm1SGZ/eYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713976062; x=1714580862;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NJ24k+/qZiSqDjoeEMQOGzQq3ctUR4NA3Oy/Wx9fzCA=;
        b=Bi67IXP9ShHd4ELfbMXZJkIAJ1l1vwVR8hrvLqVZSBqRX+n4x+a6x6DR8XhV4TbKDy
         jMdrmCYmIS8E1wn6HjIhlFshB9YmLtg7s3OYbPHTTkZAvMYCSfoNpbUppge8jRU7Nk7w
         HUfwhOng2SNarWdkIUpnaJOTg7T8M89vPzTByRPmcZFVVE6ZOPLr374g2W1kDDBlFVp2
         RrCjW07MLFxfAuHkOUUdMmSxmGBRXJ+AJ/8roFmS6j6RpeQnf8EL32eglYi/jfp/6e8s
         s82PyrmPzY/qrygZB0gnCcMrwL2S1lQ5dyhDvvhARsNA6uAiXmK5uVNBP0ZTW3yY2aYC
         eBog==
X-Forwarded-Encrypted: i=1; AJvYcCVKWkNhiw+grLlqZBKD8tij1ZspuFO0t7YCAwMa1cMJMzUUzLtRbF2xUAAZOSqktyUUzzILjL/w77pvHMCtYiPYB0ffT2esXvedF8QYnAst
X-Gm-Message-State: AOJu0YxiYjVmvOaGpDrjoanICGQQJ//zpSsIOxWP1HNBWzkqOQhW4jUH
	EU2w39LFreGJ3RLbBwe3QRNbGXBJzvFvtaeznt7Hp14t20EUcSJlo8sIdbA8Kw==
X-Google-Smtp-Source: AGHT+IFujxmRWPvW2lkO0rsroitXfE7K4ml/Ta21/l/tCLTdZaHyFkWSAQm0SfCotJPVXhhOoLi/Qg==
X-Received: by 2002:a05:6e02:1546:b0:36a:1f88:d73a with SMTP id j6-20020a056e02154600b0036a1f88d73amr3206319ilu.15.1713976062260;
        Wed, 24 Apr 2024 09:27:42 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s195-20020a6377cc000000b005f807af5156sm8550559pgc.41.2024.04.24.09.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 09:27:41 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: "Gustavo A . R . Silva" <gustavoars@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	kasan-dev@googlegroups.com,
	linux-hardening@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ubsan: Remove 1-element array usage in debug reporting
Date: Wed, 24 Apr 2024 09:27:39 -0700
Message-Id: <20240424162739.work.492-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=870; i=keescook@chromium.org;
 h=from:subject:message-id; bh=GEZVzNOkB+uh4/dxLc6pmPztMxbGqhWXyqveAW752b8=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmKTL7qVV+POqCFN5Rg5p5AzaXPsrUUStXl0AY0
 2/iCDgk8fyJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZiky+wAKCRCJcvTf3G3A
 JgZ6EAC1YjVsmehwoEeiwKbZH8CtHwwDua3KkjoeAjnsa4JmT7FMyssqFdeYvghQLki1LEFQiJL
 mh+ewYa7wqJrHiNFUNAArgaFSXfav0zG0N7Li4WkqyIMyzK3O//6ZLfupr8H+KeORJgutmWoYUX
 Sr80DS2sinwNvIceHPt4KoMM8kzjmKavQSWB8hcUXfgW1TiFqYtuZ4dWh40UZZbRZYa1KrdyLwM
 vQ6GDVlVabhwqM9Aue0rPDePcMIHe+P9ta34JQgNs7sBZIBMz6XGus87lAr3W1BFXeSEIqTYACR
 tTUE32k877NlLRBgX0sKixZgtggKOxdq5y9ZgTegc4FWD3abPH1eV0rS0G/v9D1MKoAb4gWXNxT
 k9jqLyabuU69r55bgnMDS+XIK/EoO8MBA40PznF1o255GhHJNy0G8ZI5E0mRSmOqr+T5x4oWdUR
 /ozw9paaPxEasFkFubkgOZYA8O0AcyKfRiWxwoD9iYUSSbuchLX8AflMIVIJYVZdgviE0zkXv47
 6oYNTpPFaGfes3IfGsqSSbPscFym2MSl5CAqYonhrpSfj7N3YYly2u4uIYSvsf4fnMqBk5UzZLi
 /7z1cQ1+THvaMMuEHto0W1BAKlcdZAT9SwSDKgDppVnz4Wo2ZJrRwGO5R26+6lv/F8ZHx/5jaix
 B5cxn5f5 9FQsSKQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The "type_name" character array was still marked as a 1-element array.
While we don't validate strings used in format arguments yet, let's fix
this before it causes trouble some future day.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
Cc: Marco Elver <elver@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: kasan-dev@googlegroups.com
Cc: linux-hardening@vger.kernel.org
---
 lib/ubsan.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/ubsan.h b/lib/ubsan.h
index 0abbbac8700d..50ef50811b7c 100644
--- a/lib/ubsan.h
+++ b/lib/ubsan.h
@@ -43,7 +43,7 @@ enum {
 struct type_descriptor {
 	u16 type_kind;
 	u16 type_info;
-	char type_name[1];
+	char type_name[];
 };
 
 struct source_location {
-- 
2.34.1

