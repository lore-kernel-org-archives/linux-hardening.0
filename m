Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5658B192D98
	for <linux-hardening@vger.kernel.org>; Fri, 30 Aug 2024 16:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725036600; cv=none; b=ESX8XbMa+HvjJ8Pegqka9wcB4D480NnrjjZFPlwKrR3faHxBiKt384Qc1LbtKiXeWiEfiIdVtjIJtxW2aR1LgYvWcB63YiqSSUFSYhMYZKR3Ixtdog69iycyo9TEuXLsat7VAfahGC4YoKpQBj3Am+iRKXepkrSZgy+6tUpcLg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725036600; c=relaxed/simple;
	bh=lrlNIF9WdimAsN6kBCmQgiO59m2L6o8gvGS5OgtlvNE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mogZKktFfdnmfNElc73nzZAFYTNKeO1Xp+T3otNdZINN/SmvTXTDgpjWo0YYNIelw7TCVuActR/2J21Jii2vfUg6qARPEdQT+o4qyRjy7Wf1oxuIcBg0svsAgq9y+FAu3lCT13VL2gC0kGcFjS0aZXkfJOF8iUj6rw8+BpSrKw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=0IhsJLVd; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="0IhsJLVd"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42bafd879aeso2834995e9.2
        for <linux-hardening@vger.kernel.org>; Fri, 30 Aug 2024 09:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1725036597; x=1725641397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LxeqqbczVIAQ0z8tAayFbvj/rLvPdhZbbzHN6wdCAB0=;
        b=0IhsJLVdfTvA9VUY6D03spMLrDwmsD9cZ6mWVehJTrTUTUF95T2B3lYn6uAKhMJh69
         Hm2oWPlr+2Kzog8L+Ka+CNNsvye4o+QreOXadmNeWQobz7p1ne6MOQXYpGulXOT3eoAe
         ag6Y2fKDXQFyl5oAyZk7Zk+CSaV40pw84Bmr9o7wLVedpRvgmkj2jfK4DujA1aDLOYp7
         Pa8hCKcPEYeXZVVWZvAwXisocp1dJ/b4InyFqJiF8bCVUtU3vS1PCa2imwMB+iOk1m4W
         kYYOkPET/KxnkcjgS6x5DLwXItwH+IMpZLwKaP0xqrjyFutxPbTYkPphIXlpQJ0eNEjh
         gQwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725036597; x=1725641397;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LxeqqbczVIAQ0z8tAayFbvj/rLvPdhZbbzHN6wdCAB0=;
        b=bsxyvCj9Y3cW/6rvfdU9B0QbgRxp5CDvo1jMPZn0PhKUgF7prS5pClvcBk2LkAhl9K
         crxQ1p6B990QSZaRvbV0X51K21cjmFliZTDXBzMBnMbXKZVcu4oi8/1aWW1szbYHdnq8
         zz4aiYObmI+vH4jzQYYWivGHbq9kcXvM/No1k6bF+GSgdArSnYBZgHzajN10VzrQ8SLI
         4kDjcXSll9OVv0JwkZKTTcQ3zfpWv4ho77Ovs3l3STmVaXqyWjT01/6PEjw2tGl51rwo
         PKBaiM2Lc3HRFi7aIb6PjujJ6D80zu2yay0VE3YnfI5F224lyU3+5ZLk+BrRVHWRQ2cB
         pfmg==
X-Forwarded-Encrypted: i=1; AJvYcCXBxlLqjNWQ0liO17eVYOTm1CMdT1V0YE0dPWvhae3+1K/MLLbw9EMSp7JTTAaSHLKX9yUmMmkdKfn3/aYd3UQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjbjRWivQV9C/1JLWD1OxP/2zgq/ZRe+YXKl7CGuOlov7+Y3Ck
	FvsAuw/HHb+N/L1l8v1OXU9RqWBW11YAsPQqPitNGASxH0zulTEy+JkpUfUMCkw=
X-Google-Smtp-Source: AGHT+IHVpIRujWjY8Uin/hP/ps2qq/oyP8IvmuiAvN5GTMctBy9RS3M0uk0uyECJzYkFe9vWMq5KxQ==
X-Received: by 2002:a05:600c:1554:b0:425:6962:4253 with SMTP id 5b1f17b1804b1-42bbb43d5e4mr12224585e9.4.1725036597441;
        Fri, 30 Aug 2024 09:49:57 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-228.dynamic.mnet-online.de. [82.135.80.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ba6425811sm87276285e9.40.2024.08.30.09.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 09:49:56 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: jack@suse.cz,
	kees@kernel.org,
	gustavoars@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] isofs: Annotate struct SL_component with __counted_by()
Date: Fri, 30 Aug 2024 18:49:03 +0200
Message-ID: <20240830164902.112682-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the __counted_by compiler attribute to the flexible array member
text to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
CONFIG_FORTIFY_SOURCE.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 fs/isofs/rock.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/isofs/rock.h b/fs/isofs/rock.h
index ee9660e9671c..7755e587f778 100644
--- a/fs/isofs/rock.h
+++ b/fs/isofs/rock.h
@@ -44,7 +44,7 @@ struct RR_PN_s {
 struct SL_component {
 	__u8 flags;
 	__u8 len;
-	__u8 text[];
+	__u8 text[] __counted_by(len);
 } __attribute__ ((packed));
 
 struct RR_SL_s {
-- 
2.46.0

