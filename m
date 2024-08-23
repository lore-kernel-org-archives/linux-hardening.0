Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D240B1428E3
	for <linux-hardening@vger.kernel.org>; Fri, 23 Aug 2024 11:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724413712; cv=none; b=SKz4GszjSFZ7V6ch2YoY4GeUL+jEsueGS4VVe1r17zNF/VoG/pF3IUjPz+WsTFB6ytLZo3IjKNb6w+87qf42eVzskc3lJ2eyjeQ7ZZpZbv1lMw1TfeiYFIyqRp62qJiD1Exzb4PTjTnhIbslSFOZ454h037YEx4dwbwAFES4VTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724413712; c=relaxed/simple;
	bh=11ILqV9sSgq0vkEVufLxFfVQ6nYnNN8UZZN3WnBLcD4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mpGfa5O9LbbdxfLG9+OyI8fCfGaf6E1O4bhM56fQ6GZit/9p/mu2ZnukS0wQEoUXrPWp3nryvbKFmppVkbLw4hpIrrRBDnGRQ0GWgqcNX53a1QjS+dglVHk1Ii+WOQPq2kVdAzlSlfqX8DieUqFR8GHUMGVbmtEnUWmDJT4wj0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=AZKkonMy; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="AZKkonMy"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-368633ca4ffso297215f8f.0
        for <linux-hardening@vger.kernel.org>; Fri, 23 Aug 2024 04:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1724413709; x=1725018509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ygPOJ3kbG5t8D2/jn0UHkCqAj6NFUwKnva9LPsAtkzU=;
        b=AZKkonMy8i7PFqtuiKOUTjeaJRBrsfID0OJh+zautkDij5nLwE/czWsj4clZxcIvz/
         35GZqKE3ejs5s7g2o3VVXcU3Mt3/xxShkTuZGCgor9VCci9opqvKD6djTNXxz+6HK9jA
         nrRkOiYyfhSjWsP6CxgiGywu+AvOitqMVlCpw82H6BBZjqpFhXcY6rt+89eCvSbbPvZx
         vPUPdrx7YXfV8ddpkM6wx3M6wok1wpxv7uZEFKJrCM76gbsX9ngTT4lZA3xkAbKxlMbW
         RDZleCG1iZLsBYscwALlgznuNwgfTx7kyZuj6Y8A6hXlxaXn2FLZKcPAddQC5R7yGa1l
         zRDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724413709; x=1725018509;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ygPOJ3kbG5t8D2/jn0UHkCqAj6NFUwKnva9LPsAtkzU=;
        b=c9wxcX2gMyhTJ6koVqYf/BGejTZnAJaOzZHACUzyaaxOyp88RU9OaGW3ziU+KFGXvC
         QaFVbvd3GjACWyhHOeMaM364R/hcZjNcHiqtrSXHTVC+r8YDodMTmHyBKW05LLiSCYqn
         TdxLFIk7ar9WJM9ZlHQotbQwJJXT32oKynwWHuVrohKFThjnhBm6Sz+K4IuR/heBIOWz
         gh5/8mKUtPKKNrSzGcMxD7ehBd4R3SehUFEsX67jZJotvmv7bEeFlzAj1seuvbQEmLT1
         OgSbE4l9xPIaMvETJZlJ1R4aKsiFtySDah3AXBW2Y7hZeUfc1rTX/FtOvWyFl3UMToI9
         vU8A==
X-Forwarded-Encrypted: i=1; AJvYcCVrKxY04nS8SerLPxYG+Hc4J4ZxpdiUc5fHgM/UdC9tnz+qb+ni8QiY2dWvzB3M1zQL6p9BA/isJBx1FCZB8DA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3cDtRF6QD5MuZ1iQRW0eLWJBlNQVAibRiVkYWikuQJnjp1bDM
	6dpwoJYlzCwpD+DjEmz78iVuLgV/dHzSYshp3zejQMIZbK4lYoU6N58zjWLAAv8=
X-Google-Smtp-Source: AGHT+IFvhMPt4pZpbccUkBs0Hi2KJQJSJKqluPpvVcpUWiDsTdhGl+ARhILSf+az3WKIMMtfz04o9g==
X-Received: by 2002:a05:6000:1788:b0:368:5bf:82ab with SMTP id ffacd0b85a97d-3731192c2a5mr558203f8f.10.1724413708910;
        Fri, 23 Aug 2024 04:48:28 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-228.dynamic.mnet-online.de. [82.135.80.228])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f299d8fsm248894366b.62.2024.08.23.04.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 04:48:28 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: linkinjeon@kernel.org,
	sfrench@samba.org,
	senozhatsky@chromium.org,
	tom@talpey.com,
	kees@kernel.org,
	gustavoars@kernel.org
Cc: linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] smb: Annotate struct xattr_smb_acl with __counted_by()
Date: Fri, 23 Aug 2024 13:47:05 +0200
Message-ID: <20240823114704.36967-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the __counted_by compiler attribute to the flexible array member
entries to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
CONFIG_FORTIFY_SOURCE.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 fs/smb/server/xattr.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/server/xattr.h b/fs/smb/server/xattr.h
index 16499ca5c82d..fa3e27d6971b 100644
--- a/fs/smb/server/xattr.h
+++ b/fs/smb/server/xattr.h
@@ -76,7 +76,7 @@ struct xattr_acl_entry {
 struct xattr_smb_acl {
 	int count;
 	int next;
-	struct xattr_acl_entry entries[];
+	struct xattr_acl_entry entries[] __counted_by(count);
 };
 
 /* 64bytes hash in xattr_ntacl is computed with sha256 */
-- 
2.46.0

