Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B128940DFD7
	for <linux-hardening@vger.kernel.org>; Thu, 30 Apr 2026 06:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777531285; cv=none; b=GjE5rnKS3gdcqMtGcVDNZDodkZazGVyeU4XtNhxMJduUfZLvXcqFeOAUg2/Y5BvGsP5zBO/7SGG1OZXLpMNhbAWgiBuQgVwQje71fTE+5G0ej2lL49RtGDQE49Di8U+ndPk8VFFG2uX9KBEP9XVvT5Say/738x0UnYu0LN/cKWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777531285; c=relaxed/simple;
	bh=QvM44coDCiE/6KuuvCilgZQbqsDLNKhW24e27HlQbcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N/qzNpfQN5VzfEPF3sS7tW6TwvVjQXwpmfpvX1Nebxbxm/XwReFm60cvTWojrl0NfIDiSbIngJLL3ZSMW+YO5DE/HzKj8oPOz4BScK4HPTfVK5R7kkO3UMPz0YiJLim7nCSFxez18LfVqru3SBGJXx9W/9B/81iaITPiVu36OeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d30M1BL4; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d30M1BL4"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-35da9692ec3so634255a91.1
        for <linux-hardening@vger.kernel.org>; Wed, 29 Apr 2026 23:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777531284; x=1778136084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IhD1C3uz6NMu1mvhhagoK2LXd5s8MLTPkZLVKzU+A8k=;
        b=d30M1BL4pVSxo+98onoxQnmYyAUAnjWG/mKBsJMwyIX8kt42ixUbzeea3VPEXOPEPb
         OhGOipvuoLbZ6n7/A6pPuUPstXmRH4dbpiDM5mgwBErUzE8j9YNgC5kK7/g06Z7rutcT
         aX0/nVEyPDb03S9slOzzm1BH7NWGLQ3QVPG0PhSwt/jB+zzJjP/5eYm6Zs/PxjEJHf0D
         UOxVaderFz7cZLNX7Z3eqTF99V9JrOb9Tkbub4fFTsOCEYkziPpJj1UQqM5EeY1CkIXu
         eoTTqSF5UVUmXouRHmEJ5Xg4unJt59nE/BJiyUisLUzdLVT/JM9T7gKT+mmm3UPxsY2V
         ONjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777531284; x=1778136084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IhD1C3uz6NMu1mvhhagoK2LXd5s8MLTPkZLVKzU+A8k=;
        b=cLP2EO/c+a47Xg1XpW8M7QmHOcCGlrK0Lb3ckThSK6qkl9AcekxHKGFae+RgWabqbM
         d3mvX2rvd05GcVPYWnPEH6cF7pXwneZLdG81X02r/6R8e3yYGlzdQu3zxIXtedEBXaCC
         iodGBZr2rJOCKQCD2vRa2ZFynId+hMWbs5unmDs+kboHNG9rYUk7dp6l/4IMvTmm+tnA
         S0WQx5xrsQkdStCfOZrgPa3qD8OEPMzYYja4fp65AqlUJVewBaZbJMff8h5ZUsrxx9FE
         7zYzvM5iQBc2/xx7NmIkr5oFZ0RM4+8pKJR8ufwHAXuziGGAhdMLGeMtl0wtIlsqF5rw
         ch7g==
X-Forwarded-Encrypted: i=1; AFNElJ8HC5fEKYXOg4Op+cI8tKqF5V9gTeDGZkbb+WeDZ1R2WjU3iYAzOd9aBduGo5mkQZYZJVSBnfdky+Y3zgHexFU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1UCtxn2PnJdsF29ZjBMrBewN/dIjpwTSsX4IxldBt75Shh3O5
	4MfBzicHNwcJIQ2JIgbS1ui95GaRSbX7eBb370fh2MM+W5fJOgYkFag3Vj0sU79q
X-Gm-Gg: AeBDieutncv6hOUUwv+uVvCpUe4CwOl8gc9i1q76YHKosKfAUt8oaJ1tkbyD800OOzN
	W+/YkyvtSoA6geQn86hfmLhMUAoBRNvkRLkYN2AbtKcaEhdpG9ZTXOqWwVtAtSVfvq0SkKdN9DJ
	elvEa/YdNBcdq2e40rH6euAAVvrZIWXMzs3jNT3Lk0dLHeS6UH/mdlz3PSKeZWeeoOLBuNhl3L6
	xP8TT8P1CrlRVWEyABLO6YuqkZFtsl00ZyGbiMvqJTXwLCKg3SSkF/BioMVu0cKXJkk+g84l4Ck
	UwPAVa4HcJzM9LsFPi4gehn6y+CnmgnnEamtdTi/Mwy7N5MJdZna9m0KKoLY616vpX6S6nFg0Bj
	zEw3H9XZBc2qES5CgrxnSXaCLTOa1AEo3754jikO6ECgNHtqn24XwJAW5AIxpFAugcqPSN8ds5t
	0hvA4EBR2CdGVInxIy0p2dHur4SjWLjjRqU8lq5s2s
X-Received: by 2002:a05:6a20:6f05:b0:3a2:dfb2:f03d with SMTP id adf61e73a8af0-3a3cf8f6271mr1978893637.56.1777531284012;
        Wed, 29 Apr 2026 23:41:24 -0700 (PDT)
Received: from localhost ([103.74.250.37])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7fd606a079sm3775958a12.12.2026.04.29.23.41.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Apr 2026 23:41:23 -0700 (PDT)
From: Jiazi Li <jqqlijiazi@gmail.com>
To: Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>
Cc: Jiazi Li <jqqlijiazi@gmail.com>,
	linux-hardening@vger.kernel.org,
	"mingzhu.wang" <mingzhu.wang@transsion.com>
Subject: [PATCH v2 1/2] lib/string_choices: Add str_alloc_free() helper
Date: Thu, 30 Apr 2026 14:40:24 +0800
Message-ID: <ff9cd26fe84bf581f83a560a8f043437b31f8b79.1777529232.git.jqqlijiazi@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1777529232.git.jqqlijiazi@gmail.com>
References: <cover.1777529232.git.jqqlijiazi@gmail.com>
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

Suggested-by: Andy Shevchenko <andy@kernel.org>
Tested-by: mingzhu.wang <mingzhu.wang@transsion.com>
Signed-off-by: Jiazi Li <jqqlijiazi@gmail.com>
---
V2: Sorted function alphabetically.
---
 include/linux/string_choices.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/string_choices.h b/include/linux/string_choices.h
index ee84087d4b26..65f346db95ba 100644
--- a/include/linux/string_choices.h
+++ b/include/linux/string_choices.h
@@ -17,6 +17,12 @@
 
 #include <linux/types.h>
 
+static inline const char *str_alloc_free(bool v)
+{
+	return v ? "alloc" : "free";
+}
+#define str_free_alloc(v)		str_alloc_free(!(v))
+
 static inline const char *str_assert_deassert(bool v)
 {
 	return v ? "assert" : "deassert";
-- 
2.49.0

