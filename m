Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1D33F0763
	for <linux-hardening@vger.kernel.org>; Wed, 29 Apr 2026 11:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777461843; cv=none; b=H7n97GSxf4LnRA5ydsfCKAg1ZQKQeEfFrsQeXO84jZ3paADa9PmMaotU6sp/xsxCil7wZr7o3VaBv1apZVOPaTZa2H4dZ5vxrFVdzFlG+EIShCE29lma2Jn/3ZmS5kZXgcqYjfHBB5+TRSxfRExpL3r99tap4NaJkrQdVwLJZjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777461843; c=relaxed/simple;
	bh=2YZ/cRpHt3ope+JTx+HynMq8iFxHFWBkgo26bbHR9ho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o0RoXGp4onx3v8e8SRXl8JBmxnv1B3FdRbxDDpyT5+pnx+NzWaqwo7P7vGgtWAt4SYH9geBNkqAcgYmLtuFeDgqyrLdaBluwC2Hw2TB1rJPw9VBjE/8QyLDlQXClfyKW0pQh6TISYv6cbIvmD0AoUTO+RMUufZ5aVbNVghcX/io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CrJToEJL; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CrJToEJL"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2adbfab4501so57861575ad.2
        for <linux-hardening@vger.kernel.org>; Wed, 29 Apr 2026 04:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777461840; x=1778066640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=olg4dmq/jQK5itvsv6fO1lBfXgDhVSBq6zAhV4OCT2s=;
        b=CrJToEJL/QqgXdlowp+2ZKfOKymc3oTJ4jaEgpAtFGvkyS6kSnA6fgfjfmZRQgNXfM
         /v9Kv/0rK4tUf29gCI2HwS62YZ5p4bKR0o6XY9xT3ojzKAbXNnHuu3gXQl4/30Xa5I8a
         ytUK9j4YhpOBDvmpjKKafq6bqbYHwUDoU8fz76hDKNowf0W4G+NG/aKzw9th0K5B1jA9
         n4n25aDkYbbMLBRSDEMa1L+ZRIcuyiU6Jc3wvbLEn41eB4nSyVeTSWPt9Hd4u6weSMDR
         VqctVY52UJypucs0EFnw1p6WMPIqOgj++sQxg4KZCmi1fdi39ixbACTU7PpzRn8FFrZW
         y/tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777461840; x=1778066640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=olg4dmq/jQK5itvsv6fO1lBfXgDhVSBq6zAhV4OCT2s=;
        b=JEX2WO82DeO5WTRi13ezouUw2efRX3Wkav+KwXSnUv/lQUE/4bGtKgN9TeV2+78P15
         wu4Ir1dtUHP0L2eDpU8AvVTpLL4kIWDEY+T5mMCa4+XroekHHjC4JGSCNzgVWAH1w5GE
         NIiopMVYpECYKhkigdCuIA2NcztO8CW8EbxgOY/fVfpZLSIcgLQQiy9JPi5NZQvFviqi
         vU/GlhuJHnrui69ib1bNim9DZSF3TzGd+NRuZupsBLzHZUDBXlkQuzREx2gNSTPXzk+l
         w3g8anN6WZdbY/z1jcW4mWvAWQ+CdPlsC9dWDmDlNXm9pHUrogOCO63fjtcrYY+S0ng9
         Mz1w==
X-Forwarded-Encrypted: i=1; AFNElJ8K9oAKn2OavP9NA1wg7X1wPR/EI5GWULSkXj/kI7GXGTtOH7qbai2Eh3dMuqOREZjXhsLBhVdUaPlSxGyWpUo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1Y3YQNr9qiF10kpkxaw5ve4qhUm2Tobh4QlAH4vBmm649PaaS
	mNvaI0DS5L886FDmobMvAfjV2APJrxeGWl+pvxJrV4m//Q5YJLZxo9iN
X-Gm-Gg: AeBDies6o45HcOq6YMcOXQxcHjTU2WtcKJA4+tIoCu2O3ULAjUBqYCl28tuFoawq/Wn
	5b5vtqWk1nmqO9YbvGGNySYqmS6gd+HkxYqt1jYjv0SpevcDPHeWVFxDzM+t8j3ostMz7V3p0M/
	XwW8C5Y8NdbG6i0N83hFlkK23UyLT9B+LaJEDzWL+WOhhemWnocsLtJvfOgTPT4D4D9EUGbu7QQ
	CKrGMP1d8tbGgULVo71AoaWuSAWLtLntymEneWsgGwft1BtErMw6N3XGQtGLD6AvQ7bMGw010C7
	TzLu0Lc4aAFyvydIzKakriNRen7skagWKGp1ogVnam4OymiQwjXxdpggFUpiH0dTQFf2piG7+6W
	XfToDLBwQvLsqUNvyqaFfKeVBZy3K+H//9FE7hNozTBlZbty858pQ6kQFTcGwiCk3mZyQjnaQBe
	kBKSJhqXa/qX8Jr93W4PLLeamOMnQTJI7NlHFZ/eSv
X-Received: by 2002:a17:903:189:b0:2b7:8a56:7cda with SMTP id d9443c01a7336-2b97c3cb634mr70840165ad.4.1777461840254;
        Wed, 29 Apr 2026 04:24:00 -0700 (PDT)
Received: from localhost ([103.74.250.37])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b98893f1d1sm19613475ad.48.2026.04.29.04.23.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Apr 2026 04:23:59 -0700 (PDT)
From: Jiazi Li <jqqlijiazi@gmail.com>
To: Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>
Cc: Jiazi Li <jqqlijiazi@gmail.com>,
	linux-hardening@vger.kernel.org,
	"mingzhu.wang" <mingzhu.wang@transsion.com>
Subject: [PATCH 1/2] lib/string_choices: Add str_alloc_free() helper
Date: Wed, 29 Apr 2026 19:23:01 +0800
Message-ID: <0765e025b80f8299e4c1f92332929b6a385465d1.1777369070.git.jqqlijiazi@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1777369070.git.jqqlijiazi@gmail.com>
References: <cover.1777369070.git.jqqlijiazi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add str_alloc_free() helper to return "alloc" or "free"
string literal depending on the boolean argument. Also add the
inversed variant str_free_alloc().

Signed-off-by: Jiazi Li <jqqlijiazi@gmail.com>
Tested-by: mingzhu.wang <mingzhu.wang@transsion.com>
---
 include/linux/string_choices.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/string_choices.h b/include/linux/string_choices.h
index ee84087d4b26..9150ac47f70b 100644
--- a/include/linux/string_choices.h
+++ b/include/linux/string_choices.h
@@ -83,6 +83,12 @@ static inline const char *str_yes_no(bool v)
 }
 #define str_no_yes(v)		str_yes_no(!(v))
 
+static inline const char *str_alloc_free(bool v)
+{
+	return v ? "alloc" : "free";
+}
+#define str_free_alloc(v)		str_alloc_free(!(v))
+
 /**
  * str_plural - Return the simple pluralization based on English counts
  * @num: Number used for deciding pluralization
-- 
2.49.0

